# frozen_string_literal: true

class EncryptionWrapper
  def before_save(record)
    # record.credit_card_number = encrypt(record.credit_card_number)
    encrypt(record)
  end

  def after_save(record)
    # record.credit_card_number = decrypt(record.credit_card_number)
    decrypt(record)
  end

  # FIXME: 暗号化してない値を復号化しようとしてエラーが発生する
  def after_initialize(record)
    decrypt(record)
  rescue ActiveSupport::MessageEncryptor::InvalidMessage => e
    Rails.logger.error e.message
    Rails.logger.info 'Maybe column value is not encrypted?'
  end

  private

  # 暗号化・復号化のための鍵を生成して返す
  def crypt
    key_length = ActiveSupport::MessageEncryptor.key_len

    key =
      ActiveSupport::KeyGenerator.new(ENV['ENCRYPTION_SECRET'])
                                 .generate_key(ENV['ENCRYPTION_SALT'], key_length)

    ActiveSupport::MessageEncryptor.new(key, cipher: 'aes-256-gcm')
  end

  def encrypt(record)
    record.token = crypt.encrypt_and_sign(record.token)
    record.refresh_token = crypt.encrypt_and_sign(record.refresh_token)
  end

  def decrypt(record)
    record.token = crypt.decrypt_and_verify(record.token)
    record.refresh_token = crypt.decrypt_and_verify(record.refresh_token)
  end
end

# == Schema Information
#
# Table name: tokens
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  token         :string
#  expires_at    :datetime
#  refresh_token :string
#
class Token < ApplicationRecord
  belongs_to :user

  # データベースに保存する値は暗号化し、インスタンスが扱う値は復号化した値を用いる
  before_save EncryptionWrapper.new
  after_save EncryptionWrapper.new
  after_initialize EncryptionWrapper.new

  def token
    # Google Calendar API の OAuth 認証で得られる token が期限付き
    # 期限切れなら refresh_token を利用して token の更新を実行する
    renew_token! if expires_at.past?

    super
  end

  private

  def renew_token!
    credentials = GoogleCalendar.refresh_token(refresh_token)

    update!(
      refresh_token: credentials['refresh_token'],
      token: credentials['access_token'],
      expires_at: credentials['expires_at']
    )
  end
end

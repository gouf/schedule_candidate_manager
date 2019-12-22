# Google OAuth で得たアクセストークンを Google サービスの認証情報として API ライブラリに渡す
# Ref: https://github.com/googleapis/google-api-ruby-client/issues/296#issuecomment-148812548
class AccessToken
  attr_reader :token
  def initialize(token)
    @token = token
  end

  def apply!(headers)
    headers['Authorization'] = "Bearer #{@token}"
  end
end

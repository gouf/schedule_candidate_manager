class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules =
      Schedule.includes(:schedule_candidates)
              .where(user_id: current_user.id)
              .limit(30)
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    google_calendar =
      GoogleCalendar.new(
        current_user.tokens.last.token
      )

    respond_to do |format|
      if google_calendar.save_schedule_candidates(schedule_create_args)
        format.html { redirect_to schedules_path, notice: 'Schedule was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def schedule_params
    params.require(:schedule)
          .permit(:corporation_name, :description, :user_id)
  end

  # * Google Calendar API にイベントを作成するための情報
  # * Schedule, ScheduleCandidate モデル に/で レコードを保存するための情報
  def schedule_create_args
    {
      user_id: params['schedule']['user_id'],
      title: params['schedule'].fetch('title', '面談?'),
      corporation_name: params['schedule']['corporation_name'],
      description: params['schedule']['description'],
      start_datetime: params['start_datetime'],
      end_datetime: params['end_datetime']
    }
  end
end

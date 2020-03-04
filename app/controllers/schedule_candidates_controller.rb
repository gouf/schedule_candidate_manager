class ScheduleCandidatesController < ApplicationController
  before_action :set_schedule_candidate, only: [:show, :edit, :update, :destroy]

  # GET /schedule_candidates
  # GET /schedule_candidates.json
  def index
    @schedule_candidates =
      ScheduleCandidate.all
                       .includes(:schedule)
                       .joins(:schedule)
                       .reorder(start_datetime: :asc)
                       .limit(50)
  end

  # GET /schedule_candidates/1
  # GET /schedule_candidates/1.json
  def show
  end

  # GET /schedule_candidates/new
  def new
    @schedule_candidate = ScheduleCandidate.new
  end

  # GET /schedule_candidates/1/edit
  def edit
  end

  # POST /schedule_candidates
  # POST /schedule_candidates.json
  def create
    @schedule_candidate = ScheduleCandidate.new(schedule_candidate_params)

    respond_to do |format|
      if @schedule_candidate.save
        format.html { redirect_to @schedule_candidate, notice: 'Schedule candidate was successfully created.' }
        format.json { render :show, status: :created, location: @schedule_candidate }
      else
        format.html { render :new }
        format.json { render json: @schedule_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedule_candidates/1
  # PATCH/PUT /schedule_candidates/1.json
  def update
    respond_to do |format|
      if @schedule_candidate.update(schedule_candidate_params)
        format.html { redirect_to @schedule_candidate, notice: 'Schedule candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule_candidate }
      else
        format.html { render :edit }
        format.json { render json: @schedule_candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedule_candidates/1
  # DELETE /schedule_candidates/1.json
  def destroy
    @schedule_candidate.destroy
    respond_to do |format|
      format.html { redirect_to schedule_candidates_url, notice: 'Schedule candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule_candidate
      @schedule_candidate = ScheduleCandidate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_candidate_params
      params.require(:schedule_candidate).permit(:corporation_name, :description, :location)
    end
end

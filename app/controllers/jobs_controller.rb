class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = Job.active.includes(:maker, :owner).order(created_at: :desc)
  end

  def show
    @work_logs = @job.work_logs.includes(:user).order(started_at: :desc)
    @material_usages = @job.material_usages.includes(:material)
    @job_photos = @job.job_photos.order(sort_order: :asc)
    @job_histories = @job.job_histories.order(created_at: :desc)
  end

  def new
    @job = Job.new
    @makers = Maker.active.order(:name)
  end

  def create
    @job = Job.new(job_params)
    @job.owner = current_user

    if @job.save
      redirect_to @job, notice: "施工案件を作成しました。"
    else
      @makers = Maker.active.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @makers = Maker.active.order(:name)
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: "施工案件を更新しました。"
    else
      @makers = Maker.active.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job.soft_delete
    redirect_to jobs_url, notice: "施工案件を削除しました。"
  end

  private

  def set_job
    @job = Job.active.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:maker_id, :status, :vehicle_name, :vehicle_model, :car_year, :car_color,
                                 :customer_name, :customer_phone, :scheduled_at,
                                 :completed_at, :note)
  end
end

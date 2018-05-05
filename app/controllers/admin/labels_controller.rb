class Admin::LabelsController < Admin::BaseController
  def index
    @q = Label.includes(:tasks).search(params[:q])
    @labels = @q.result(distinct: true).page(params[:page])
  end
end

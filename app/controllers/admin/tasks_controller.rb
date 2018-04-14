class Admin::TasksController < Admin::BaseController
  before_action :logged_in_user
  
  def index
   @user = User.find(params[:user_id])
   @q = @user.tasks.search(params[:q] || {s: 'created_at desc'})
   @tasks = @q.result(distinct: true).page(params[:page])
  end
end

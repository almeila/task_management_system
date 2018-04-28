class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: [:edit, :destroy, :update]
  before_action :load_role, only: [:edit, :update]

  def index
    @q = User.includes(:tasks).search(params[:q])
    @users = @q.result(distinct: true).page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを作成しました。'
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name}を更新しました。"
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "ユーザーを削除しました。"
    else
      flash[:danger] = "#{@user.errors.full_messages}"
    end
    redirect_to action: 'index'
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def load_user
      @user = User.find(params[:id])
    end  

    def load_role
      @roles = User.admins.keys
    end  

end

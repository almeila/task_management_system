class Admin::HomeController < Admin::BaseController
  def index
    # 現状ダッシュボードは必要無いのでユーザー一覧へ
    redirect_to controller: 'admin/users', action: 'index'
  end
end

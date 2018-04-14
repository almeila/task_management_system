class Admin::BaseController < ApplicationController
  layout 'layouts/admin'
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = t('controller.application.please_login_message')
        redirect_to login_url
      end
    end
end

class Admin::ApplicationController < ApplicationController
    before_action :check_admin
    layout 'admin'

    private
    def check_admin
      #지금 접속한 계정이 관리자인지 판별 아닐경우 루트페이지로 보내기
      unless user_signed_in? && current_user.admin?
        redirect_to(root_path, alert: "관리자 계정 로그인이 필요합니다")
      end

    end
end

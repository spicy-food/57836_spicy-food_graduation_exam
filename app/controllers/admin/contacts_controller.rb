module Admin
  class ContactsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin
    layout 'admin'

    def index
      @contacts = Contact.order(created_at: :desc).page(params[:page])
    end

    def show
      @contact = Contact.find(params[:id])
      @contact.update(read: true) unless @contact.read?
    end

    private

    def check_admin
      return if current_user.admin?

      redirect_to root_path, alert: 'アクセス権限がありません'
    end
  end
end
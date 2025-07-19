class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    
    if @contact.save
      redirect_to contact_thanks_path, notice: 'お問い合わせを送信しました。ありがとうございます。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # 送信完了ページ
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message, :category)
  end
end
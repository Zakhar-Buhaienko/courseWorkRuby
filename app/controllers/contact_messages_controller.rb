class ContactMessagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :authorize_admin, only: [:index]

  # GET /contact
  def new
    @contact_message = ContactMessage.new
  end

  # POST /contact
  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      redirect_to contact_path, notice: 'Повідомлення успішно відправлено.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /contact_messages
  def index
    puts "ContactMessagesController#index викликано"
    @contact_messages = ContactMessage.all
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end

end

class ContactMessagesController < ApplicationController
    # GET /contact
    def new
      @contact_message = ContactMessage.new
    end
  
    # POST /contact
    def create
      @contact_message = ContactMessage.new(contact_message_params)
      if @contact_message.save
        # Тут можна викликати ActionMailer для відправлення повідомлення
        redirect_to contact_path, notice: 'Повідомлення успішно відправлено.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def contact_message_params
      params.require(:contact_message).permit(:name, :email, :message)
    end
  end
  
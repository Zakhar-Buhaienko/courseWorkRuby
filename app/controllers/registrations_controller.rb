class RegistrationsController < Devise::RegistrationsController
    def edit
      
      if current_user.admin?
        @contact_messages = ContactMessage.all # Отримуємо всі контактні повідомлення
        puts "Contact messages loaded: #{@contact_messages.inspect}"
      end
      super
    end
  end
  
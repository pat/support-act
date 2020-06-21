# frozen_string_literal: true

class DeviseMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/devise_mailer
  def confirmation
    Devise::Mailer.confirmation_instructions(Fan.first, SecureRandom.uuid)
  end
end

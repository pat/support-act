# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

class InvalidMimeTypeMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue ActionDispatch::Http::MimeNegotiation::InvalidType => error
    [406, {"Content-Type" => "text/plain"}, [error.message]]
  end
end

Rails.application.config.middleware.use InvalidMimeTypeMiddleware

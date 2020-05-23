# frozen_string_literal: true

class SuggestionsMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/suggestions/suggest
  def suggest
    SuggestionsMailer.suggest(Fan.first)
  end
end

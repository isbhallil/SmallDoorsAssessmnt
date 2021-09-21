require "application_service"

class GeneratedDecksRetreiver < ApplicationService
  def call
    file = File.open("previous_deck.json")
    previous_deck = JSON.parse(file.read)

    previous_deck
  end
end

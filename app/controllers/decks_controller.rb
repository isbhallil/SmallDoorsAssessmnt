require 'deck_generator'
require 'generated_decks_retreiver'

class DecksController < ApplicationController
  def new 
    cards_deck = DeckGenerator.call(params[:deck_type])
    File.write("previous_deck.json", cards_deck.to_json)
    
    render json: cards_deck
  end

  def previous
    previous_deck = GeneratedDecksRetreiver.call()

    render json: previous_deck
  end
end

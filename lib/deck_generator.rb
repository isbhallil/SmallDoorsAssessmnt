require "application_service"
require "pokemon_client"
require "utils"
require "pokemon_card_deck"

class DeckGenerator < ApplicationService
  include Utils

  def initialize( element_type )
    # binding.pry
    @deck_type = deck_element_type(element_type)
    @cards = []
    @cards.concat pokemon_cards()
    @cards.concat energy_cards()

    @cards.concat trainer_cards(60 - @cards.count)
  end

  def call
    PokemonCardDeck.new(@cards)
  end


  private


  def trainer_cards count
    draw_cards_to_go_on_deck(count, PokemonClient.trainer_cards)
  end

  def energy_cards
    energy_cards_count = 10
    draw_cards_to_go_on_deck(energy_cards_count, PokemonClient.energy_cards(@deck_type))
  end

  def pokemon_cards
    pokemon_cards_count = rand(12..16)
    draw_cards_to_go_on_deck(pokemon_cards_count, PokemonClient.pokemon_cards(@deck_type))
  end

  def deck_element_type type
    is_valid = PokemonClient.pokemon_types.include? type 
    unless is_valid
      raise "element #{type} not a valid type for a deck of cards !"
    end

    type
  end

  def draw_cards_to_go_on_deck card_count, cards_to_draw
    available_cards_to_draw = cards_to_draw

    list = []
    card_count.times do 
      selected_index = rand(0..( available_cards_to_draw.length - 1 ))
      selected_card = available_cards_to_draw[selected_index]
      list << selected_card

      if list.count(selected_card) == 4
        available_cards_to_draw.delete(selected_card)
      end
    end

    list
  end


end

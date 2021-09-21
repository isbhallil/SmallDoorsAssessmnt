require 'pokemon_tcg_sdk'
require 'utils'

class PokemonClient
  Pokemon.configure do |config|
    config.api_key = ENV["POKEMON_TCG_API_KEY"]
  end

  class << self
    include Utils

    def energy_cards type
      card_hash_from_request("#{type}_energy_cards.json", "energy") {
        Pokemon::Card.where(q: "supertype:energy name:#{type}*energy") 
      }
    end

    def trainer_cards
      card_hash_from_request("trainer_cards.json", "trainer") {
        Pokemon::Card.where(q: "supertype:trainer") 
      }
    end

    def pokemon_cards type
      card_hash_from_request("#{type}_pokemon_cards.json", "pokemon") {
        Pokemon::Card.where(q: "supertype:pokemon types:#{type}") 
      }
    end

    def pokemon_types
      file_or_request("card_types.json") { 
        Pokemon::Type.all.map(&:downcase)
      }
    end


    private


    def card_hash_from_request file, card_type, &block
      file_or_request("#{file}") { 
        block.call()
        .map do |card| 
          {
            id: card.id,
            name: card.name,
            image_url: card.images.small,
            type: card_type,  
          }
        end
      }
    end
  end
end

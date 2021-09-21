require "deck_generator"
require "pokemon_card_deck"

describe DeckGenerator do
  subject { DeckGenerator.call("fire") }

  it "should generate a deck" do
    expect(subject.class).to eq(PokemonCardDeck)
  end

  it "should contain at least the card names for the resulting deck that has been generated" do
    subject.cards.each do |card|
      # expect(card).to have_key(:name)
    end
  end

  it "should contain 12-16 pokemon of a given type" do
    pokemon_type_cards = subject.cards.select { |card| card[:type] == "pokemon"}
    expect(pokemon_type_cards.count).to be <= 16
    expect(pokemon_type_cards.count).to be >= 12
  end

  it "should contain 10 energy cards for that type"  do
    energy_cards = subject.cards.select { |card| card[:type] == "energy"}
    expect(energy_cards.count).to be == 10
  end

  it "should rest of the cards filled with random trainer cards" do
    not_trainer_type_cards = subject.cards.select { |card| ["pokemon", "energy"].include? card[:type] }
    other_cards =  subject.cards - not_trainer_type_cards

    other_cards.each do |other_card|
      expect(other_card[:type]).to be == "trainer"
    end
  end

  it "should contain exactly 60 cards" do
    expect(subject.cards.count).to be == 60
  end

  it "should conatin a maximum 4 card of the same kind" do
    same_card_groups = subject.cards.group_by(&:itself)
    same_card_groups.each do |card_group|
      expect(card_group.count).to be <= 4
    end
  end

end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User creates Pendant', js: true do
  let!(:artist) { FactoryBot.create :artist, name: 'Artist Name' }
  let(:user) { FactoryBot.create(:user, :with_personal_collection) }

  it 'with required info from home page' do
    visit root_path(as: user)
    click_link 'Pendants'
    click_link 'New Pendant'

    fill_select_and_take_first_result 'Who made this pendant?', 'Artist Name'
    fill_select_and_take_first_result 'Select Collection...', 'Personal Collection'
    fill_in 'glass_art_piece_name', with: 'Cool Pendy'
    expect { click_button 'Create Glass art piece' }.to change(GlassArtPiece, :count).by(1)

    expect(page).to have_link 'Cool Pendy'
  end

  context 'when colors exist' do
    let!(:color) { FactoryBot.create :color, name: 'Fun Color' }

    it 'with the color availible' do
      visit new_my_pendant_path(as: user)

      fill_select_and_take_first_result 'Who made this pendant?', 'Artist Name'
      fill_select_and_take_first_result 'Select Collection...', 'Personal Collection'
      fill_select_and_take_first_result 'What colors is this piece made of?', ''
      fill_in 'glass_art_piece_name', with: 'Cool Pendy'
      expect { click_button 'Create Glass art piece' }.to change(GlassArtPiece, :count).by(1)

      expect(page).to have_link 'Cool Pendy'
      click_link 'Cool Pendy'

      expect(page).to have_content 'Artist Name'
      expect(page).to have_content 'Fun Color'
    end
  end
end

require 'rails_helper'

RSpec.describe Note, type: :model do
  it 'é inválido sem título' do
    note = build(:note, title: nil)
    expect(note).not_to be_valid
  end

  it 'é válido com título' do
    note = build(:note)
    expect(note).to be_valid
  end
end

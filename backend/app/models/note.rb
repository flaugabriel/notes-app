class Note < ApplicationRecord
  extend ActiveModel::Translation

  validates :title, presence: true
end

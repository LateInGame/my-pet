class Pet < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name_and_species,
    against: [ :name, :species ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
}
end

class Lawyer < ApplicationRecord
  belongs_to :property
  has_many :documents, as: :documentable, dependent: :destroy
end

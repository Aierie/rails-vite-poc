class Property < ApplicationRecord
  has_many :contractors, dependent: :destroy
  has_many :lawyers, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy
end

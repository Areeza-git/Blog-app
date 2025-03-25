class Article < ApplicationRecord
    include Visible

    belongs_to :user
    has_many :comments, dependent: :destroy
    validates :title, presence: true
    validates :description, presence: true, length: {minimum: 20}
end

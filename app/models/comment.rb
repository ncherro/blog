class Comment < ActiveRecord::Base

  belongs_to :post

  validates :comment, :post, presence: true

  class << self
    def ordered
      order(:created_at)
    end
  end

end

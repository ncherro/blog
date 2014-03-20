class Comment < ActiveRecord::Base

  belongs_to :post

  validates :content, :post, presence: true

  class << self
    def ordered
      order(:created_at)
    end
  end

end

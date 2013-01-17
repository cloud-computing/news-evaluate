class Article < ActiveRecord::Base
  attr_accessible :content, :title, :reporter_ids, :reporters_attributes, :url
  has_and_belongs_to_many :reporters
  accepts_nested_attributes_for :reporters, allow_destroy: true
  has_many :reviews
  has_many :marker_comments, through: :reviews

  def score
    return 80 unless reviews.any?
    reviews.map(&:final_score).inject{|sum, el| sum + el}.to_f / reviews.count
  end
end

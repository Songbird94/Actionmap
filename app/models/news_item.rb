# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all


  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end

  def self.import_google_news_object(google_news_obj, representative, issue)
    NewsItem.new(
      title:          google_news_obj.title,
      link:           google_news_obj.url,
      description:    google_news_obj.description,
      representative: representative,
      issue:          issue
    )
  end
end

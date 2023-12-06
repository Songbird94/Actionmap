# frozen_string_literal: true

require 'news-api'

class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]
  before_action :set_issues_list, only: %i[new edit create update]

  def new
    redirect_to search_my_news_item_path(representative_id: @representative)
    @news_item = NewsItem.new
  end

  def edit; end

  def create
    selected_article_index = params[:article_index]
    @news_item = NewsItem.new(news_item_params)
    @news_item.title = params.dig('news_item', selected_article_index, 'title')
    @news_item.link = params.dig('news_item', selected_article_index, 'link')
    @news_item.description = params.dig('news_item', selected_article_index, 'description')
    @news_item.representative_id = params[:representative_id]
    @news_item.issue = params[:news_item][:issue]
    @news_item.rating = params[:rating]
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  def index
    render :search, error: 'An error occurred when searching for the news item.'
  end

  def search
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
    @issues_list = ['Free Speech', 'Immigration', 'Terrorism',
                    'Social Security and Medicare', 'Abortion', 'Student Loans', 'Gun Control',
                    'Unemployment', 'Climate Change', 'Homelessness', 'Racism', 'Tax Reform',
                    'Net Neutrality', 'Religious Freedom', 'Border Security', 'Minimum Wage',
                    'Equal Pay']
  end

  def show_articles
    @representative = Representative.find(params[:representative_id])
    @issue = params[:issue]

    newsapi = News.new(Rails.application.credentials[:NEWS_API_KEY])

    articles = newsapi.get_everything(
      q:        "#{@representative.name}+#{@issue}",
      sortBy:   'relevancy',
      page:     1,
      pageSize: 5
    )

    # @articles = articles['articles']
    @articles = articles
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def set_issues_list
    @issues_list = ['Free Speech', 'Immigration', 'Terrorism',
                    'Social Security and Medicare', 'Abortion', 'Student Loans', 'Gun Control',
                    'Unemployment', 'Climate Change', 'Homelessness', 'Racism', 'Tax Reform',
                    'Net Neutrality', 'Religious Freedom', 'Border Security', 'Minimum Wage',
                    'Equal Pay']
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id, :issue, :rating)
  end
end

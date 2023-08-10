# frozen_string_literal: true

# QueryObject for Books controller
# it will implement filter that will run on QueryObject
class BookQueryObject
  attr_reader :params

  def initialize(records, params)
    @records = records
    @params = params
  end

  def results
    filter_by_user_name if params[:name]
    filter_by_book_title if params[:title]
    filter_by_book_description if params[:description]
    filter_by_query if params[:query]

    @records
  end

  def filter_by_user_name
    @records = @records.search_by_users(fileter_by_user_ids(params[:name]))
  end

  def filter_by_book_title
    @records = @records.search_by_title(params[:title])
  end

  def filter_by_book_description
    @records = @records.search_by_description(params[:description])
  end

  def filter_by_query
    title_description_results = @records.search_by_title_description(params[:query])
    book_users_results = @records.search_by_users(fileter_by_user_ids(params[:query]))

    @records = title_description_results.or(book_users_results)
  end

  def fileter_by_user_ids(val)
    ::User.search_by_name(val).ids
  end
end

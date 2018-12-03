class SearchResult < AbstractTablelessModel
  self.table_name = :search_results
  attribute :searchable_type, :string, default: nil
  attribute :searchable_id, :integer, default: nil
  attribute :published_date, :datetime, default: nil

  belongs_to :searchable, polymorphic: true
  belongs_to :book, -> { where("search_results.searchable_type = 'Book'") }, foreign_key: 'searchable_id'
  belongs_to :user, -> { where("search_results.searchable_type = 'User'" ) }, foreign_key: 'searchable_id'
  belongs_to :post, -> { where("search_results.searchable_type = 'Post'" ) }, foreign_key: 'searchable_id'
  belongs_to :comment, -> { where("search_results.searchable_type = 'Comment'" ) }, foreign_key: 'searchable_id'

  def self.get_all
    sql = <<~SQL
    (
      (
        SELECT books.id AS searchable_id, 'Book' AS searchable_type,
               books.created_at AS created_at, books.title AS name
        FROM books
      ) UNION (
        SELECT users.id AS searchable_id, 'User' AS searchable_type,
               users.created_at AS created_at, users.name AS name
        FROM users
      ) UNION (
        SELECT posts.id AS searchable_id, 'Post' AS searchable_type,
               posts.created_at AS created_at, posts.title AS name
        FROM posts
      ) UNION (
        SELECT comments.id AS searchable_id, 'Comment' AS searchable_type,
               comments.created_at AS created_at, comments.body AS name
        FROM comments
      )
    ) AS search_results
    SQL
    SearchResult.from([Arel.sql(sql)])
  end

  def self.search(search_string)
    results = get_all
    cols_to_search = []

    results = results.left_outer_joins(book: { book_users: [:user], created_by: {}})
    cols_to_search += %w[title pdf_download_url].map { |c| "books.#{c}" }
    cols_to_search += %w[users.name users.email]
    cols_to_search += %w[created_bies_books.name created_bies_books.email]

    results = results.left_outer_joins(:user)
    cols_to_search += %w[name email].map { |c| "users_search_results.#{c}" }

    results = results.left_outer_joins(post: [:user])
    cols_to_search += %w[title body].map { |c| "posts.#{c}" }
    cols_to_search += %w[users_posts.name users_posts.email]

    results = results.left_outer_joins(comment: [:user])
    cols_to_search += %w[users_comments.name users_comments.email]
    cols_to_search += %w[body].map { |c| "comments.#{c}" }

    results = results
      .where(
        cols_to_search.map {|col_name| "#{col_name} ILIKE ?"}.join(' OR '),
        *["%#{search_string}%"] * cols_to_search.size
      ).distinct

    results
  end
end

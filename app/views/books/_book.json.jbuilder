json.extract! book, :id, :title, :pdf_download_url, :created_by_id, :created_at, :updated_at
json.url book_url(book, format: :json)

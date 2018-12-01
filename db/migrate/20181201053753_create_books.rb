class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :pdf_download_url
      t.references :created_by, foreign_key: true

      t.timestamps
    end
  end
end

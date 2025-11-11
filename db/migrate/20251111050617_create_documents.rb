class CreateDocuments < ActiveRecord::Migration[7.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.string :document_type
      t.references :documentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

class CreateDirectives < ActiveRecord::Migration
  def change
    create_table :directives do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end

    add_foreign_key :directives, :users
  end
end

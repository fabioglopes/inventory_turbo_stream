class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :sku
      t.string :status

      t.timestamps
    end
  end
end

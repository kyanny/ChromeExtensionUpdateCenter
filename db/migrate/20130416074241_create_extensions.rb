class CreateExtensions < ActiveRecord::Migration
  def change
    create_table :extensions do |t|
      t.string :name
      t.string :appid
      t.binary :pem
      t.binary :crx
      t.string :version
      t.boolean :release

      t.timestamps
    end
  end
end

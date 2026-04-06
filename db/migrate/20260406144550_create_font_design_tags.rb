class CreateFontDesignTags < ActiveRecord::Migration[7.2]
  def change
    create_table :font_design_tags do |t|
      t.references :font_design, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

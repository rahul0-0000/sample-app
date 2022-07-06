class CreateJwtDenylists < ActiveRecord::Migration[5.2]
  def change
    create_table :jwt_denylist do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
  
      t.timestamps
    end
  end
end

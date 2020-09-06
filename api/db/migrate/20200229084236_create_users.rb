class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string  :name, null: false
      t.string  :city, default: nil
      t.string  :wechat, default: nil
      t.string  :phone, default: nil
      t.string  :email, default: nil
      t.string  :gender, default: nil
      t.string  :images, array: true, default: []
      t.boolean :admin, default: false
      t.string  :wx_open_id, default: nil
      t.string  :wx_session_key, default: nil
      t.timestamps
    end
  end
end

class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :ownerId
      t.string :targetId
      t.boolean :isFollowed

      t.timestamps
    end
  end
end

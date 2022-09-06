class AddReferencesToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :room
  end
end

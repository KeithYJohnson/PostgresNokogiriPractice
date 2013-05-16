class AddWrongAnswersToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :wrong_answer_1, :string
    add_column :tracks, :wrong_answer_2, :string
  end
end

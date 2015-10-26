class Goal < ActiveRecord::Base
  validates :name, :description, :user_id, presence: true
  validates :private, inclusion: { in: [true, false] }

  belongs_to :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

end

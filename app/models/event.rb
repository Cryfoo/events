class Event < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :joined_users, through: :joins, source: :user
  validates :name, :date, :location, :state, presence: true

  def find_join_id current_user
  	Join.select(:id).where(user:current_user, event:self)[0].id
  end
end

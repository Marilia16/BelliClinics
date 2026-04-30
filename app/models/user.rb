class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :clinics, foreign_key: :user_id

  after_create :assign_default_role

  def assign_default_role
    self.add_role(:client) if self.roles.blank?
  end

end

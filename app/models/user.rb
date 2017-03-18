class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable

  belongs_to :secret_code
  validates :email, :secret_code, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :secret_code_id, uniqueness: true

  ROLES = %w[admin user].freeze
end

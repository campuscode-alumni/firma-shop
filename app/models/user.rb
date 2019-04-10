class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  belongs_to :company
  has_many :conversations, dependent: :nullify

  before_validation :set_company
  has_many :conversations, dependent: :destroy

  validates :name, presence: true

  def active?
    return false unless expiration_date

    expiration_date > Time.zone.now
  end

  def after_database_authentication
    update(confirmation_token: nil, confirmed_at: nil) unless active?
  end

  private

  def after_confirmation
    update(expiration_date: confirmed_at + 90.days)
  end

  def set_company
    self.company = find_or_create_company
  end

  def find_or_create_company
    # https://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-find_or_create_by
    company = Company.find_by(domain: user_domain)
    company = Company.create(domain: user_domain) if company.nil?
    company
  end

  def user_domain
    email.split('@').last
  end
end

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
  has_many :sales_ads, dependent: :destroy

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
    Company.create_with(name: company_name)
           .find_or_create_by(domain: user_domain)
  end

  def user_domain
    email.split('@').last
  end

  def company_name
    user_domain.split('.').first.capitalize
  end
end

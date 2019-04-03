class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  belongs_to :company

  before_validation :set_company

  validates :name, presence: true

  def expiration_date
    self.confirmed_at + 90.day
  end

  def active?
    expiration_date > Time.now
  end

  private

  def after_database_authentication
    if ! active?
      self.update(confirmation_token: nil, confirmed_at: nil)
    end
  end

  def after_confirmation
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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
  belongs_to :company

  before_validation :set_company

  private

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

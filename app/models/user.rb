class User < ActiveRecord::Base
  include TheRole::User
  before_create :set_default_role
  acts_as_tree order: "email"


  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subordinates, class_name: "User",
  		 foreign_key: "manager_id"
  belongs_to :manager, class_name: "User"


  has_many :orders, inverse_of: :user
  belongs_to :branch

  def to_s
  	if imie.blank? && nazwisko.blank?
      email
    else
      imie + ' ' + nazwisko
    end
  end

  private

  def set_default_role
    self.role ||= Role.with_name(:uzyt)
  end
end

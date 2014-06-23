class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include TheRole::User

  has_many :subordinates, class_name: "User",
  		 foreign_key: "manager_id"
  belongs_to :manager, class_name: "User"


  has_many :orders
  belongs_to :branch

  def to_s
  	if imie.blank? && nazwisko.blank?
      email
    else
      imie + ' ' + nazwisko
    end
  end
end

class User < ActiveRecord::Base
  include TheRole::User
  before_create :set_default_role

  acts_as_tree order: "email"
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :products
  has_many :subordinates, class_name: "User",
       foreign_key: "manager_id"
  
  belongs_to :manager, class_name: "User"
  belongs_to :branch


  def kord?
    role == Role.with_name(:kord)
  end

  def kier?
    role == Role.with_name(:kier)
  end

  def abi?
    role == Role.with_name(:abi)
  end

  def lokwl?
    role == Role.with_name(:lokalny_wlasciciel_danych)
  end

  def dyrektor?
    role == Role.with_name(:dyrektor)
  end

  def to_s
  	if imie.blank? || nazwisko.blank?
      email
    else
      imie + ' ' + nazwisko
    end
  end

  def nazwa
    imie + ' ' + nazwisko
  end



  private

  def set_default_role
    self.role ||= Role.with_name(:uzyt)
  end
end

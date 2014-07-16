class User < ActiveRecord::Base

  has_many :collaborations
  has_many :collab_wikis, class_name: "Wiki", source: :wiki, through: :collaborations
  has_many :wikis
  has_many :pages
  has_many :subpages
  has_one :subscription
  validates_uniqueness_of :username
  validates_uniqueness_of :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  enum role: [:free, :premium, :admin, :banned]
  after_initialize :set_default_role, :if => :new_record?

  mount_uploader :profilepic, ProfilepicUploader

  def set_default_role
    self.role ||= :free
  end

  def role?(base_role)
    role == base_role.to_s
  end

  def can_create_private_wiki?
    role?(:admin) || role?(:premium)
  end

  def self.search(query)
    where("email like ?", "%#{query}")
  end
end
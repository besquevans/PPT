class User < ApplicationRecord
  validates :account, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :board_masters
  has_many :boards, through: :board_masters
  has_many :posts 
  
  before_create :encrypt_password

  def self.login(options)
    if options[:account] && options[:password]
      find_by(account: options[:account], 
              password: Digest::SHA1.hexdigest("x#{options[:password]}y"))
    end
  end

  private 

  def encrypt_password
    self.password = bigbang(self.password)
  end

  def bigbang(string)
    string = "x#{string}y"
    Digest::SHA1.hexdigest(string)
  end
end

class User < ActiveRecord::Base
   has_many :user_stocks
  has_many :stocks, through: :user_stocks
  
   has_many :friendships
   has_many :friends, through: :friendship
  
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    "Anonymous"
  end
  
  def stock_already_added?(ticker_symbol)
    stock=Stock.find_by_ticker(ticker_symbol)
    return false unless stock
    user_stocks.where(stock_id:stock.id).exists?
  end
  
  def under_stock_limit?
    (user_stocks.count<10)
  end
  
  def can_stock_added?(ticker_symbol)
    !stock_already_added?(ticker_symbol) && under_stock_limit?
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

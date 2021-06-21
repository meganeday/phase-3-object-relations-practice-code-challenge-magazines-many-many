class Reader < ActiveRecord::Base

  has_many :subscriptions
  has_many :magazines, through: :subscriptions

  def total_subscription_price
    self.subscriptions.pluck(:price).sum()
  end

  def subscribe(magazine, price)
    self.subscriptions.create(magazine: magazine, price: price)
  end

  def cancel_subscription(magazine)
    potential_sub = self.subscriptions.find_by(magazine_id: magazine.id)
    if potential_sub.nil?
      "You are not subscribed to that magazine"
    else
      potential_sub.destroy
    end
  end
end
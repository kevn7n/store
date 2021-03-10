class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item_stocked)
    @inventory[item_stocked]
  end

  def stock(item_stocked, quantity)
    @inventory[item_stocked] += quantity
  end

  def potential_revenue
    @inventory.sum do |item, quantity|
      item.price * quantity
    end
  end

end

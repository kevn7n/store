class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor_added)
    @vendors << vendor_added
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item_sold)
    @vendors.find_all do |vendor|
      vendor.inventory[item_sold] >= 1
    end
  end

  def sorted_item_list
    list = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        list << item.name
      end
    end
    list.uniq.sort
  end

  def item_summary(item)
    summary = {}
    total = vendors_that_sell(item).sum do |vendor|
      vendor.check_stock(item)
    end
    summary[:quantity] = total
    summary[:vendors] = vendors_that_sell(item)
    summary
  end

  def total_inventory
    total = {}
    all_items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        all_items << item
      end
    end
    all_items.uniq.each do |item|
      total[item] = item_summary(item)
      # total[item] ||= {}
    end
    total
  end

  def overstocked_items
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        all_items << item
      end
    end
    all_items.uniq.find_all do |item|
      total_inventory[item][:quantity] > 50 && vendors_that_sell(item).size > 1
    end
  end
end

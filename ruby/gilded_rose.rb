class GildedRose

  def initialize(items)
    @items = items.map do | item | 
     getClassForItem(item).new(item)
    end
  end

  def getClassForItem(item)
    case item.name
    when "Aged Brie"
      Brie
    when "Backstage passes to a TAFKAL80ETC concert"
      BackstagePasses
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras
    else
      Normal
    end
  end

  def update_quality()
    @items.each do |item|
      item.update_quality
    end  
  end
  
end

class BackstagePasses
  attr_reader :item
  
  def initialize(item)
    @item = item
  end

  def update_quality
    item.quality = item.quality + 1 if item.sell_in > 10
    item.quality = item.quality + 2 if item.sell_in > 5 && item.sell_in <= 10
    item.quality = item.quality + 3 if item.sell_in < 6
    item.quality = 0 if item.sell_in < 1
    update_sell_in
  end

  def update_sell_in
    item.sell_in = item.sell_in - 1
  end
end

class Brie
  attr_reader :item
  
  def initialize(item)
    @item = item
  end

  def update_quality
    if item.sell_in < 0
      item.quality = item.quality + 2
    else
      item.quality = item.quality + 1
    end
    item.quality = 50 if item.quality > 50
    update_sell_in
  end

  def update_sell_in
    item.sell_in = item.sell_in - 1
  end
end

class Normal
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
    if item.sell_in < 0
      item.quality = item.quality - 2
    else
      item.quality = item.quality - 1 
    end
    item.quality = 0 if item.quality < 0
    update_sell_in
  end

  def update_sell_in
    item.sell_in = item.sell_in - 1
  end
end

class Sulfuras
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
  end

  def update_sell_in
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
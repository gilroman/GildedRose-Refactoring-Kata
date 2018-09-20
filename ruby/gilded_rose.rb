class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Aged Brie"
        return update_aged_brie(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_passes(item)
      when "normal"
        update_normal(item)
      when "Sulfuras, Hand of Ragnaros"
        update_sulfuras(item)
      end
    end
  end
  
  def update_aged_brie(item)
    @item = Brie.new(item)
    @item.update_quality 
  end

  def update_backstage_passes(item)
    @item = BackstagePasses.new(item)
    @item.update_quality
  end

  def update_normal(item)
    if item.sell_in < 0
      item.quality = item.quality - 2
    else
      item.quality = item.quality - 1 
    end
    item.quality = 0 if item.quality < 0
    item.sell_in = item.sell_in - 1
  end

  def update_sulfuras(item)
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
    item.sell_in = item.sell_in - 1
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
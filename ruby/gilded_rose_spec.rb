require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
    
    it "does not lower the quality of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 80
    end
  
    it "does not reduce the sell_in date of Sulfuras by 1" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].sell_in).to eq 0
    end
  
    it "increases the quality of brie by one if it's less than 50 and sell in is above 0" do
      items = [Item.new("Aged Brie", 3, 48)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 49
    end

    it "increases the quality of brie by two if sell_in is negative" do
      items = [Item.new("Aged Brie", -1, 48)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 50
    end

    it "decreases the sell in date of brie by one" do
      items = [Item.new("Aged Brie", -1, 1)]

      GildedRose.new(items).update_quality()

      expect(items[0].sell_in).to eq -2
    end

    it "doesn't increase the quality of brie past 50" do
      items = [Item.new("Aged Brie", -1, 49)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 50
    end

    it "decreases the quality of a normal item by one" do
      items = [Item.new("normal", 10, 50)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 49
    end

    it "decreases the quality of a normal item by two if sell in date passed" do
      items = [Item.new("normal", -1, 50)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 48
    end

    it "doesn't decrease the quality of a normal item to less than 0" do
      items = [Item.new("normal", -1, 1)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 0
    end

    it "decreases the sell in date of normal items by one" do
      items = [Item.new("normal", -1, 1)]

      GildedRose.new(items).update_quality()

      expect(items[0].sell_in).to eq -2
    end

    it "increases the quality of backstage passes by one if sell_in above 10 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 11
    end

    it "increases the quality of backstage passes by two if sell_in  below 11 but above 5 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 12
    end

    it "increases the quality of backstage passes by three if sell_in below 6 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 13
    end

    it "reduces the quality of backstage passes to zero if sell_in 0 days" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 0
    end

    it "decreases the sell in date of backstage passes by one" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 1)]

      GildedRose.new(items).update_quality()

      expect(items[0].sell_in).to eq -2
    end
    
    xit "decreases the quality of a conjured items by two" do
      items = [Item.new("Conjured", 10, 50)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 48
    end

    xit "decreases the quality of conjured items by four if sell in date passed" do
      items = [Item.new("Conjured", -1, 50)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 46
    end

    xit "doesn't decrease the quality of conjured items to less than 0" do
      items = [Item.new("Conjured", -1, 1)]
      
      GildedRose.new(items).update_quality()
      
      expect(items[0].quality).to eq 0
    end

    xit "decreases the sell in date of conjured items by one" do
      items = [Item.new("Conjured", -1, 1)]

      GildedRose.new(items).update_quality()

      expect(items[0].sell_in).to eq -2
    end

  end

end

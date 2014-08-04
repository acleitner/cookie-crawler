require 'nokogiri'
require 'open-uri'

class CookieCrawler
  def initialize(order_id, count, delay=1)
    @order_id = order_id
    @count = count
    @delay = delay
    @names = []
  end

  def crawl
    i = 0
    @count.times do
      id = @order_id - i
      @names << scrape(id)
      i += 1
      sleep(@delay)
    end
    p @names
  end

  def scrape(order_id)
    url = "http://insomniacookies.com/Tracker/index.php?orderID=#{order_id}"
    doc = Nokogiri::HTML(open(url))
    return scrape_customer_name(doc)
  end

  def scrape_customer_name(node)
    # return "" unless node.css('.customer-name').present?
    node.css('.customer-name').text
  end
end


require 'amazon'
require 'amazon/search'
require 'liquid'
require 'liquid/block'
require 'liquid/template'

module MephistoAmazon  
  
  Amazon_Dev_Token = "0Q5P1K6A3RR095AH9CR2" #replace with your own
  Amazon_Associate_id = "drvolkergerha-21" #leave this be
      
  base =  "#{RAILS_ROOT}/vendor/plugins/mephisto_amazon/views/"
  Products_View = "#{base}products.liquid"
  Product_View = "#{base}product.liquid"
  Test_Search_View ="../views/test_search_results.liquid"
  Error_View = "#{base}error.liquid"
  
  def rlogger() RAILS_DEFAULT_LOGGER end
    
end

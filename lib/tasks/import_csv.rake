require 'csv'

namespace :import do 
  desc "Import items from csv"
  task items: :environment do 
    filename = File.join Rails.root, "items.csv"
    counter = 0 

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      item = Item.new row.to_hash.slice(:item........., :)
      if 
    end
  end
end

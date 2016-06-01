require 'csv'

  desc "Import merchants from csv"
  task :import => [:environment] do 
    filename = "data/merchants.csv"

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      merchant = Merchant.create(id: row[:id], 
                                 name: row[:name], 
                                 created_at: row[:created_at],
                                 updated_at: row[:updated_at])
    end
  end

  desc "Import items from csv"
  task :import => [:environment] do 
    filename = "data/items.csv"

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      item = Item.create(id: row[:id], 
                         name: row[:name], 
                         description: row[:description], 
                         unit_price: row[:unit_price], 
                         merchant_id: row[:merchant_id],
                         created_at: row[:created_at],
                         updated_at: row[:updated_at])
    end
  end

  desc "Import customers from csv"
  task :import => [:environment] do 
    filename = "data/customers.csv"

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      item = Customer.create(id: row[:id], 
                             first_name: row[:first_name],
                             last_name: row[:last_name],
                             created_at: row[:created_at],
                             updated_at: row[:updated_at])
    end
  end


  desc "Import invoices from csv"
  task :import => [:environment] do 
    filename = "data/invoices.csv"

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      item = Invoice.create(id: row[:id], 
                            customer_id: row[:customer_id],
                            merchant_id: row[:merchant_id],
                            status: row[:status],
                            created_at: row[:created_at],
                            updated_at: row[:updated_at])
    end
  end

  desc "Import transactions from csv"
  task :import => [:environment] do 
    filename = "data/transactions.csv"

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      Transaction.create(id: row[:id], 
                         invoice_id: row[:invoice_id],
                         credit_card_number: row[:credit_card_number],
                         result: row[:result],
                         created_at: row[:created_at],
                         updated_at: row[:updated_at])
    end
  end

  desc "Import invoice_items from csv"
  task :import => [:environment] do 
    filename = "data/invoice_items.csv"

    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(id: row[:id], 
                         item_id: row[:item_id],
                         invoice_id: row[:invoice_id],
                         quantity: row[:quantity],
                         unit_price: row[:unit_price],
                         created_at: row[:created_at],
                         updated_at: row[:updated_at])
    end
  end

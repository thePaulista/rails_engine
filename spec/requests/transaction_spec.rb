require 'rails_helper'

describe "Transaction" do
  context "GET api/v1/transaction" do
    it "returns all the transaction." do
     transaction1, transaction2 = create_list(:transaction, 2)

      get "/api/v1/transactions"

      expect(response.status).to eq 200

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(2)
    end
  end

  it "returns one transactions" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    transaction = JSON.parse(response.body)

    expect(response.status).to eq 200

    expect(transaction["result"]).to eq "successfull"
  end

  it "returns transaction by status" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?result=successfull"

    expect(response.status).to eq 200

    transaction = JSON.parse(response.body)

    expect(transaction["result"]).to eq "successfull"
  end

  it "returns credit card number"  do
    transaction = create(:transaction, credit_card_number: "1117")

    get "/api/v1/transactions/find?credit_card_number=1117"

    expect(response.status).to eq 200

    transaction = JSON.parse(response.body)

    expect(transaction["credit_card_number"]).to eq "1117"
  end

  it "returns a random transaction" do
    transaction1, transaction2, transaction3 = create_list(:transaction, 3)
    transactions = [transaction1["id"], transaction2["id"], transaction3["id"]]

    get "/api/v1/transactions/random"

    random_transaction = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(transactions).to include(random_transaction[0]["id"])
  end

  it "returns all transaction by the same params" do
    transaction1 = create(:transaction, result: "successfull")
    transaction2 = create(:transaction, result: "pending")
    transaction3 = create(:transaction, result: "successfull")

    get "/api/v1/transactions/find_all?result=successfull"

    expect(response.status).to eq 200

    result = JSON.parse(response.body)

    expect(result.count).to eq 2
    expect(result.first["result"]).to eq "successfull"
    expect(result.last["result"]).to eq "successfull"
  end

  it "returns a collection of associated invoices" do
    customer1, customer2 = create_list(:customer, 2)
    merchant1, merchant2 = create_list(:merchant, 2)
    invoice1 = merchant1.invoices.create!(customer_id: customer1.id)
    invoice2 = merchant2.invoices.create!(customer_id: customer2.id)
    transaction1 = invoice1.transactions.create!(credit_card_number: "1234")
    transaction2 = invoice2.transactions.create!(credit_card_number: "2345")

    get "/api/v1/transactions/#{transaction2.id}/invoice"

    transaction2 = JSON.parse(response.body)
    expect(response.status).to eq 200
    #expect(transaction2[0]["id"]).to eq transaction2.id
  end

end

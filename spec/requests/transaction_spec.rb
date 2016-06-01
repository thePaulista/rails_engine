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

  it "returns transaction by name" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?result=successfull"

    expect(response.status).to eq 200

    transaction = JSON.parse(response.body)

    expect(transaction["result"]).to eq "successfull"
  end

  xit "returns name with case insensitive with spaces" do
    transaction = Transaction.create!(name: "Piper scout and Marty")

    get "/api/v1/transactions/find?name=Piper%20scout%20and%20Marty"

    expect(response.status).to eq 200

    transaction = JSON.parse(response.body)

    expect(transaction["name"]).to eq "Piper scout and Marty"
  end

  xit "returns a random transaction" do
    transaction1 = Transaction.create!(name: "Venice")
    transaction2 = Transaction.create!(name: "Piper")
    transaction3 = Transaction.create!(name: "Verona")
    transactions = [transaction1["id"], transaction2["id"], transaction3["id"]]

    get "/api/v1/transactions/random"

    random_transaction = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(transactions).to include(random_transaction[0]["id"])
  end

  xit "returns all transaction by the same params" do
    transaction1 = Transaction.create!(name: "Venice")
    transaction2 = Transaction.create!(name: "Piper scout and Marty")
    transaction3 = Transaction.create!(name: "Venice")

    get "/api/v1/transactions/find_all?name=Venice"

    expect(response.status).to eq 200

    result = JSON.parse(response.body)

    expect(result.count).to eq 2
    expect(result.first["name"]).to eq "Venice"
    expect(result.last["name"]).to eq "Venice"
  end
end

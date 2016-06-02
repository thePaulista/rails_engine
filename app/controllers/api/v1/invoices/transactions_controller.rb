module Api
  module V1
    class Invoices::TransactionsController < ApiController
      def index
        respond_with Invoice.find(params[:id]).transactions
      end
    end
  end
end

module Api
  module V1
    class Customers::InvoicesController < ApiController
      def index
        respond_with Customer.find(params[:id]).invoices
      end
    end
  end
end

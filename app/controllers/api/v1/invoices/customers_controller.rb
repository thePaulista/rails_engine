module Api
  module V1
    class Invoices::CustomersController < ApiController
      def show
        respond_with Invoice.find(params[:id]).customer
      end
    end
  end
end

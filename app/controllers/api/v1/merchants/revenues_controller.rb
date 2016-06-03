module Api
  module V1
    class Merchants::RevenuesController < ApiController
      def show
        respond_with Merchant.find(params[:id]).revenue
      end

      def favorite_customer_show
        respond_with Merchant.find(params[:id]).favorite_customer
      end

      def customers_with_pending_invoices_show
        respond_with Merchant.find(params[:id]).customers_with_pending_invoices
      end
    end
  end
end

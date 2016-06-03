module Api
  module V1
    class Merchants::RevenuesController < ApiController
      def show
        if params[:date]
          respond_with Merchant.find(params[:id]).revenue_by_date(params[:date])
        else
          respond_with Merchant.find(params[:id]).revenue
        end
      end

      def favorite_customer_show
        respond_with Merchant.find(params[:id]).favorite_customer
      end

      def customers_with_pending_invoices_show
        respond_with Merchant.find(params[:id]).customers_with_pending_invoices
      end

      def revenue_by_date_index
        respond_with Merchant.revenue(params[:quantity])
      end
    end
  end
end

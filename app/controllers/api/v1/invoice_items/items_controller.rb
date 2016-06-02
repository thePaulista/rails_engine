module Api
  module V1
    class InvoiceItems::ItemsController < ApiController
      def show
        respond_with InvoiceItem.find(params[:id]).item
      end
    end
  end
end

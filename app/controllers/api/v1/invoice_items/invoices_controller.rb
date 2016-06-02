module Api
  module V1
    class InvoiceItems::InvoicesController < ApiController
      def show
        respond_with InvoiceItem.find(params[:id]).invoice
      end
    end
  end
end

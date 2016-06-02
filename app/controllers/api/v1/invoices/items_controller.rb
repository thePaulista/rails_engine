module Api
  module V1
    class Invoices::ItemsController < ApiController
      respond_to :json

      def index
        respond_with Invoice.find(params[:id]).items
      end
    end
  end
end

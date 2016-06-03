module Api
  module V1
    class Merchants::ItemsController < ApiController
      def index
        respond_with Merchant.find(params[:id]).items
      end

      def most_items_index
        respond_with Merchant.most_items(params[:quantity])
      end
    end
  end
end

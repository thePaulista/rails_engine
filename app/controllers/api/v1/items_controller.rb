module Api
  module V1
    class ItemsController < ApiController
      respond_to  :json

      def index
        respond_with Item.all
      end

      def show
        respond_with Item.find(params[:id])
      end

      def find
        respond_with Item.find_by(item_params)
      end

      def find_all
        respond_with Item.where(item_params)
      end

      def random
        respond_with Item.limit(1).order("RANDOM()")
      end

      private

      def item_params
        params.permit(:id, :name, :description, :unit_price, :merchant_id, :updated_at, :created_at)
      end
    end
  end
end


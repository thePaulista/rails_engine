module Api
  module V1
    class Items::MerchantsController < ApiController
      def show
        respond_with Item.find(params[:id]).merchant
      end
    end
  end
end

module Api
  module V1
    class Customers::FavoriteMerchantsController < ApiController
      def show
        respond_with Customer.find(params[:id]).favorite_merchant
      end
    end
  end
end

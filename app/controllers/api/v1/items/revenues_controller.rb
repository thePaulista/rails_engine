module Api
  module V1
    class Items::RevenuesController < ApiController
      def index
        respond_with Item.most_revenue(params[:quantity])
      end

      def show
        respond_with Item.find(params[:id]).revenue
      end

      def best_day_show
        respond_with Item.find(params[:id]).best_day
      end
    end
  end
end

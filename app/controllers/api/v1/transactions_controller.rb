module Api
  module V1
    class TransactionsController < ApiController
      respond_to  :json

      def index
        respond_with Transaction.all
      end

      def show
        respond_with Transaction.find(params[:id])
      end

      def find
        respond_with Transaction.find_by(transaction_params)
      end

      def find_all
        respond_with Transaction.where(transaction_params)
      end

      def random
        respond_with Transaction.limit(1).order("RANDOM()")
      end

  private

      def transaction_params
        params.permit(:id, :credit_card_number, :credit_card_expiration_date, :result, :invoice_id, :created_at, :updated_at)
      end
    end
  end
end


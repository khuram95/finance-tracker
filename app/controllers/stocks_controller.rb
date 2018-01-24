class StocksController < ApplicationController
    def search
        if params[:stock].blank?
          flash.now[:danger] = "You have entered an empty search string"
        else
          @stock = Stock.new_from_lookup(params[:stock])  
            flash.now[:danger] = "You have entered an incorrect search string" unless @stock 
         # render json: @stock
        end
        render partial: 'users/result'
    end
end
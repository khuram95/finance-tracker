class UserStocksController < ApplicationController
    def create
       stock=Stock.find_by_ticker(params[:stock_ticker])
       if stock.blank?
           stock=Stock.new_from_lookup(params[:stock_ticker])
           stock.save
       end
       @user_stock=UserStock.create(user:current_user,stock:stock)
       flash[:success] = "your #{@user_stock.stock.name} added successfully"
       redirect_to my_portfolio_path
    end
    def destroy
      #  debugger
        stock=Stock.find(params[:id])
        stock_user=UserStock.where(user_id:current_user.id,stock_id:stock.id).first
        stock_user.destroy
        flash[:danger]="successfully deleted '#{stock.name}' stock from portfolio"
        redirect_to my_portfolio_path
    end
end
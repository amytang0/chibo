class PagesController < ApplicationController
  def show
    puts params[:id]
#if params[:id] == /browse|search/
#     render :partial => params[:id]
#   end
  end
end

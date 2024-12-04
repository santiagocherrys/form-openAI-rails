class FormsController < ApplicationController

  def new
    
  end

  def show
        
  end

  def index
    openaiService = OpenapiService.new("dime cuando es el dia de las velitas en Colombia")
    openaiService.askChat
  end
end

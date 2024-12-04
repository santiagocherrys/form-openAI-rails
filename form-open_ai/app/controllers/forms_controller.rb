class FormsController < ApplicationController

  def new
    @form = Form.new
  end

  def show
        
  end

  def index
    openaiService = OpenapiService.new("dime cuando es el dia de las velitas en Colombia")
    openaiService.askChat
  end

  def create
    @form = Form.new(form_params)
    puts "esto es description #{@form[:description]}"
    puts "Esto es form #{@form.inspect}"
    openaiService = OpenapiService.new(@form[:description])
    openaiService.askChat
  end
  

  private
  def form_params
    params.require(:form).permit(:name, :description, :processed_in_job)
  end
end

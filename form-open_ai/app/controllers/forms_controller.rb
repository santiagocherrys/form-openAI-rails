class FormsController < ApplicationController
  before_action :set_form, only: %i[ show]
  def new
    @form = Form.new
  end

  def show
        
  end

  def index
    @forms = Form.all
  end

  def create
    @form = Form.new(form_params)
    puts "esto es description #{@form[:description]}"
    puts "Esto es form #{@form.inspect}"
    #openaiService = OpenapiService.new(@form[:description])
    #openaiService.askChat
    
    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: "Event was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  

  private

  def set_form
    @form = Form.find(params[:id])
  end

  def form_params
    params.require(:form).permit(:name, :description, :processed_in_job)
  end
end

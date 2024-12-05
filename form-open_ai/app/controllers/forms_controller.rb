class FormsController < ApplicationController
  before_action :set_form, only: %i[ show]
  def new
    @form = Form.new
  end

  def show
        
  end

  def index
    @forms = Form.all
    puts "AQUI VA SIDEKIQ AAAAAAYYYYYYYYYYYYYYYYYYY"
    HelloJob.perform_in(1.minutes,'Jeff')
  end

  def create
    @form = Form.new(form_params)
    puts "esto es description #{@form[:description]}"
    puts "Esto es form #{@form.inspect}"

    respond_to do |format|
      if @form.save
        puts "Esto es el id de form generado #{@form.id}"
        #Encolado -> true
        #Hilo principal ->false
        if @form.processed_in_job == false
          puts "Hilo principal"
          openaiService = OpenapiService.new(@form[:description])
          responseChat = openaiService.askChat
          puts "THIS IS THE RESPONSE OF THE CHAT #{responseChat}"
          #Creation of the response
          #remember status: {pendiente: 0, completado: 1, fallido: 2}
          @response = ResponsesController.new
          @response.create(responseChat, 1, @form.id)
        else
          puts "encolado"
        end
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

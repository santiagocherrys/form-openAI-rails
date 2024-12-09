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

    @response = ResponsesController.new

    respond_to do |format|
      if @form.save
        puts "Esto es el id de form generado #{@form.id}"
        #Encolado -> true
        #Hilo principal ->false
        if @form.processed_in_job == false
          puts "Hilo principal"

          #trying apichat
          openaiService = OpenapiService.new(@form[:description])
          responseChat = openaiService.askChat
          
          puts "THIS IS THE RESPONSE OF THE CHAT #{responseChat}"
          @response.create(responseChat, 1, @form.id)
          
        else
          puts "encolado"
          #creation of response with pendiente state
          @respuesta = @response.create(nil, 0, @form.id)
          puts "ESTA ES LA RESPUESTA CON ID #{@respuesta.id}"
          QuequeChatJob.perform_in(1.minutes, @respuesta.id, @form[:description])

        end
        format.html { redirect_to @form, notice: "Response was successfully created." }
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

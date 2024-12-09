class QuequeChatJob
  include Sidekiq::Job

  def perform(id_response, question)
    openaiService = OpenapiService.new(question)
    responseChat = openaiService.askChat

    #Creation of the response
    #remember status: {pendiente: 0, completado: 1, fallido: 2}
    @response = Response.find(id_response)

    if responseChat != nil
      #completado
      puts "Respuesta correcta"
      #@response.update(id_response,responseChat, 1)
      @response.update(ai_response: responseChat, status: 1)
      #testing mail
      UserMailer.welcome_email("santiagocherrys@hotmail.com", "Ya tienes tu respuesta...", "This is your question: \n #{question} \n please view answer in the application").deliver_now
    else
      #@response.update(id_response,responseChat, 2)
      @response.update(ai_response: responseChat, status: 2)
      puts "Respuesta fallida"
    end
  end
end

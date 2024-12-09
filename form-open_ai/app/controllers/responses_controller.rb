class ResponsesController < ApplicationController

  def new
    @response = Response.new
  end

  def create(response, state, id)
    Response.create(ai_response: response, status: state, form_id: id)
  end

  def update(id,response, status)
    @response = Response.find(id)
    @response.update(ai_response: response, status: state)
  end



  private

  def response_params
    params.require(:response).permit(:ai_response, :status, :form_id)
  end
end

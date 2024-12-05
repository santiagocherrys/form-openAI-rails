class ResponsesController < ApplicationController

  def new
    @response = Response.new
  end

  def create(response, state, id)
    @response = Response.create(ai_response: response, status: state, form_id: id)
  end



  private

  def response_params
    params.require(:response).permit(:ai_response, :status, :form_id)
  end
end

# app/controllers/concerns/response.rb
module Response
  def json_response(object, status = :ok)
    render json: object, status: status, root: true
  end
end

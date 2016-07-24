module ResponseHelper

  def success(data)
    {success:true, result:data}.to_json
  end

  def error(data)
    {success:false, error:data}.to_json
  end

  def resolve(result)
    if result[:error] !=nil
      error(result[:error])
    else
      success(result[:data])
    end
  end

  def bind_body
    request.body.rewind
    JSON.parse(request.body.read)
  end

end
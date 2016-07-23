module ResponseHelper

  def success(data)
    {success:true, result:data}.to_json
  end

  def error(data)
    {success:false, error:data}.to_json
  end

end
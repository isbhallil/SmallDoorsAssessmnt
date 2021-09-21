module Utils


  private


  def file_or_request file_name, &request
    begin
      cards = File.open("#{file_name}").read
    rescue
      response = request.call
      cards = response.to_json
      File.write("#{file_name}", cards)
    end
    
    JSON.parse(cards, :symbolize_names => true)
  end
end

class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'K3WNXKJXT1EYX1WKDG3VCDU0SKFJGZMK3DYKBIKKZ4ESQ55S'
      req.params['client_secret'] = '5BIHM3DSMFLTDDWYFQ35IILYWNOSYDYRWHKXX4ZPJGZQZQYQ'
      req.params['v'] = '20180323'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)
  if @resp.success?
    @venues = body["response"]["venues"]
  else
    @error = body["meta"]["errorDetail"]
  end

rescue Faraday::ConnectionFailed
@error = "There was a timeout. Please try again."
end

    render 'search'
  end


end

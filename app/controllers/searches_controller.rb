class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'JXFIVSC1G24XIFJ3GRNJ33DTONSSUDRPS1KAVL4UWYFHLXJ2'
          req.params['client_secret'] = 'YVBLUTFUPFZCHHXZEMJXUPEX1XB1QN30ES2QQOI0FVPOLBTP'
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'coffee shop'
          # req.options.timeout = 0
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

#!/usr/bin/ruby

require 'net/http'
require 'json'
require 'uri'

class CodeForKids
  class McMyAdminAPI
    sessionID = ""

    def initialize(host, user, pass, port = '8080')
      url = URI.parse("#{host}:#{port}/data.json?Username=#{user}&Password=#{pass}&Token=&req=login&MCMASESSIONID=")
      http = Net::HTTP.new url.host, url.port
      response = http.get("#{url.path}?#{url.query.to_s}", {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
      data = response.body

      case response
      when Net::HTTPRedirection
        # repeat the request using response['Location']
      when Net::HTTPSuccess
        json_response = JSON.parse response.body
        sessionID = json_response['MCMASESSIONID']
      else
        # response code isn't a 200; raise an exception
        response.error!
      end

    end

  end
end

cfk_api = CodeForKids::McMyAdminAPI.new('host', 'username', 'password')
cfk_api.getStatus()

#!/usr/bin/ruby

require 'net/http'
require 'json'
require 'uri'

class CodeForKids
  class McMyAdminAPI
    sessionID = ""
    host = ""
    port = ""

    #initializes the connection. Sets the sessionID
    #host and port will be arguments for every function

    def initialize(host, user, pass, port = '8080')
      self.host = host
      self.port = port
      login(user, pass)
    end

    #AddGroupValue
    ##########
    # group - The group affected - string
    ##########
    # type - controls which info is changed - string
    # type takes one of the following:
    # groupslist (No group needs to be specified, used to add new groups)
    # groupmembers (Add the user in 'value' as a member)
    # groupcommands (Add the command in 'value' as a member)
    # Color
    # Inherits
    # CanBuild
    # CanInteract
    # Prefix
    # Suffix
    ##########
    # value - the value to be set by the method
    # CanBuild and CanInteract take boolean
    # the rest take string

    def add_group_value(group, type, value)
      request({ req: 'addgroupvalue', group: group, type: type, value: value })
    end

    # AddLicence
    ##########
    # newkey - String

    def add_licence(newkey)
      request({ req: 'addlicence', newkey: newkey})
    end

    # AddScheduleItem
    ##########
    # hours, mins - int32
    # TriggerEvent - TriggerEvents[Enum:Int32]
    # Type - EventType[Enum:Int32]
    # Param - *Optional* - String

    def add_schedule_item(hours, mins, trigger_event, type, param = '')
      request({ req: 'addscheduleitem', hours: hours, mins: mins, triggerevent: trigger_event, type: type, param: param})
    end

    # ChangePassword
    ##########
    # old_pass - string
    # new_pass - string

    def change_password(old_pass, new_pass)
      request({ req: 'changepassword', oldpassword: old_pass, newpassword: new_pass})
    end

    def change_user_password(user, pass)
      request({req: 'changeuserpassword', username: user, newpassword: pass})
    end

    private

    def request(params_hash)
      query_params = URI.encode_www_form hash(params_hash)
      url = URI.parse("#{@host}:#{@port}/data.json?#{query_params}")
      http = Net::HTTP.new url.host, url.port
      response = http.get("#{url.path}?#{url.query.to_s}", {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
      data = response.body

      when Net::HTTPSuccess
        response.body
      else
        # response code isn't a 200; raise an exception
        response.error!
      end
    end

    def login(user, pass)
      url = URI.parse("#{@host}:#{@port}/data.json?Username=#{user}&Password=#{pass}&Token=&req=login&MCMASESSIONID=")

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

cfk_api = CodeForKids::McMyAdminAPI.new('host', 'username', 'password')
cfk_api.getStatus()

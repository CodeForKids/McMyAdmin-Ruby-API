#!/usr/bin/ruby
require "McMyAdminAPI/version"
require 'net/http'
require 'json'
require 'uri'

module CodeForKids
  class McMyAdminAPI
    # initializes the connection. Sets the session_id
    # host and port will be saved for arguments for each request

    def initialize(host, port = '8080')
      @host = host
      @port = port
    end

    def login(user, pass)
      response = perform_request({req: 'Login', username: user, password: pass})
      json_response = JSON.parse response.body

      if json_response["success"]
        @session_id = json_response['MCMASESSIONID']
        json_response
      else
        result_hash(json_response['status'], "Could not authenticate user.")
      end
    end

    ############################
    ######Built in to API#######
    ############################

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

    def add_group_value(name, type, value)
      request({req: 'addgroupvalue', group: group, type: type, value: value})
    end

    # AddLicence
    ##########
    # newkey - String

    def add_licence(newkey)
      request({req: 'addlicence', newkey: newkey})
    end

    # AddScheduleItem
    ##########
    # hours, mins - int32
    # TriggerEvent - TriggerEvents[Enum:Int32]
    # Type - EventType[Enum:Int32]
    # Param - *Optional* - String

    def add_schedule_item(hours, mins, trigger_event, type, param = '')
      request({req: 'addscheduleitem', hours: hours, mins: mins, triggerevent: trigger_event, type: type, param: param})
    end

    # ChangePassword
    ##########
    # old_pass - string
    # new_pass - string

    def change_password(old_pass, new_pass)
      request({req: 'changepassword', oldpassword: old_pass, newpassword: new_pass})
    end

    # ChangeUserPassword
    ##########
    # user - string
    # pass - string

    def change_user_password(user, pass)
      request({req: 'changeuserpassword', username: user, newpassword: pass})
    end

    # CreateGroup
    ##########
    # name - string

    def create_group(name)
      request({req: 'creategroup', name: name})
    end

    # CreateUser
    ##########
    # username - string

    def create_user(username)
      request({req: 'createuser', newusername: username})
    end

    # DeleteBackup
    ##########
    # backup_ID - string

    def delete_backup(backup_ID)
      request({req: 'deletebackup', backupid: backup_ID})
    end

    # DeleteGroup
    ##########
    # name - string

    def delete_group(groupname)
      request({req: 'deletegroup', name: groupname})
    end

    # DeleteUser
    ##########
    # username - string

    def delete_user(name)
      request({req: 'deleteuser', username: name})
    end

    # DeleteWorld
    ##########
    # none

    def delete_world
      request({req: 'deleteworld'})
    end

    # DelScheduleItem
    ##########
    # index - int32

    def delete_schedule_item(index)
      request({req: 'delscheduleitem', index: index})
    end

    # DoDiagnositcs
    ##########
    # none

    def do_diagnostics
      request({req: 'dodiagnostics'})
    end

    # DownloadBukgetPluigin
    #########
    # PluginName - string

    def download_bukget_plugin(name)
      request({req: 'downloadbukgetplugin', pluginname: name})
    end

    # GetAllGroupInfo
    ##########
    # none

    def get_all_group_info
      request({req: 'getallgroupinfo'})
    end

    # GetAPISpec
    ##########
    # none

    def get_api_spec
      request({req: 'getapispec'})
    end

    # GetBackups
    ##########
    # none

    def get_backups
      request({req: 'getbackups'})
    end

    # GetBackupStatus
    #########
    # none

    def get_backup_status
      request({req: 'getbackupstatus'})
    end

    # GetBukgetCategories
    #########
    # none

    def get_bukget_categories
      request({req: 'getbukgetcategories'})
    end

    # GetBukgetPluginInfo
    #########
    # PluginName - string

    def get_bukget_plugin_info(name)
      request({req: 'getbukgetplugininfo', pluginname: name})
    end

    # GetBukgetPluginsCategory
    ##########
    # categoryname - string
    # start - int32

    def get_bukget_plugins_in_category(name, start)
      request({req: 'getbukgetpluginscategory', categoryname: name, start: start})
    end

    # GetChat
    #########
    # since - int64

    def get_chat(since)
      request({req: 'getchat', since: since})
    end

    # GetConfig
    ##########
    # key - string

    def get_config(key)
      request({req: 'getconfig', key: key})
    end

    # GetDeleteStatus
    ##########
    # none

    def get_delete_status
      request({req: 'getdeletestatus'})
    end

    # GetDirListing
    #########
    # file_path - string

    def get_dir_listing(file_path)
      request({req: 'getdirlisting', path: file_path})
    end

    # GetExtensions
    ##########
    # none

    def get_extensions
      request({req: 'getextensions'})
    end

    # GetFileChunk
    ##########
    # file_path - string
    # start_point - int64
    # size - int32
    # this call has no page on the wiki, I have no idea what it does.

    def get_file_chunk(file_path, start_point, size)
      request({req: 'getfilechunk', path: file_path, start: start_point, length: size})
    end

    # GetFullConfig
    ##########
    # none

    def get_full_config
      request({req: 'getfullconfig'})
    end

    # GetGroupInfo
    ##########
    # group_name - string

    def get_group_info(group_name)
      request({req: 'getgroupinfo', group: group_name})
    end

    # GetGroupList
    ##########
    # none

    def get_group_list
      request({req: 'getgrouplist'})
    end

    # GetGroupWarnings
    #########
    # none

    def get_group_warnings
      request({req: 'getgroupwarnings'})
    end

    # GetMCMAUsers
    ##########
    # none

    def get_mcma_users
      request({req: 'getmcmausers'})
    end

    # GetPlugins
    ##########
    # none

    def get_plugins
      request({req: 'getplugins'})
    end

    # GetProductCaps
    ##########
    # none

    def get_product_caps
      request({req: 'getproductcaps'})
    end

    # GetProviderInfo
    ##########
    # none

    def get_provider_info
      request({req: 'getproviderinfo'})
    end

    # GetRas
    ##########
    # none

    def get_ras
      request({req: 'getras'})
    end

    # GetSchedule
    ##########
    # none

    def get_schedule
      request({req: 'getschedule'})
    end

    # GetServerInfo
    ##########
    # none

    def get_server_info
      request({req: 'getserverinfo'})
    end

    # GetStatus
    ##########
    # none

    def get_status
      request({req: 'GetStatus'})
    end

    # GetTip
    ##########
    # fedora
    # (actually none)

    def get_tip
      request({ req: 'gettip'})
    end

    # GetTokenAuth
    ##########
    # name - string

    def get_token_auth(name)
      request({req: 'gettokenauth', username: name})
    end

    # GetUpdateStatus
    ##########
    # none

    def get_update_status
      request({req: 'getupdatestatus'})
    end

    # Getversions
    ##########
    # none

    def get_versions
      request({req: 'getversions'})
    end

    # GetWorlds
    ##########
    # none

    def get_worlds
      request({req: 'getworlds'})
    end

    # KillServer
    #########
    # none

    def kill_server
      request({req: 'killserver'})
    end

    # Logout
    ########
    # none

    def logout
      request({req: 'logout'})
    end

    # MigrateLegacyLisence
    ##########
    # new_email

    def migrate_legacy_licence(new_email)
      request({req: 'migratelegacylicence', newemailaddress: new_email})
    end

    # Reload
    ##########
    # none
    def reload
      request({req: 'reload'})
    end

    # RemoveGroupValue
    ##########
    # same variables and usage as add_group_value

    def remove_group_value(name, type, value)
      request({req: 'removegroupvalue', group: group, type: type, value: value})
    end

    # RenameGroup
    ##########
    # group_name - string
    # new_name - string

    def rename_group(group_name, new_name)
      request({req: 'renamegroup', group: group_name, newname: new_name})
    end

    # RestartServer
    ##########
    # none

    def restart_server
      request({req: 'restartserver'})
    end

    # RestoreBackup
    ##########
    # backup_id - string
    # restore_worlds - bool
    # restore_plugin_config - bool
    # restore_plugins - bool
    # restore_server - bool
    # restore_permissions - bool

    def restore_backup(backup_id, restore_worlds, restore_plugin_config, restore_plugins, restore_server, restore_permissions)
      request({req: 'restorebackup', backupid: backup_id, restoreworlds: restore_worlds, restorepluginconfig: restore_plugin_config, restoreplugins: restore_plugins, restoreserver: restore_server, restorepermissions: restore_permissions})
    end

    # RunScheduleItem
    ########
    # index - int32

    def runscheduleitem(index)
      request({req: 'runscheduleitem', index: index})
    end

    # ScanPlugins
    ##########
    # none

    def scan_plugins
      request({req: 'scanplugins'})
    end

    # ScanWorlds
    ##########
    # none

    def scan_worlds
      request({req: 'scanworlds'})
    end

    # SearchBukget
    ##########
    # query - string

    def search_bukget(query)
      request({req: 'searchbukget', query: query})
    end

    # SendChat
    ##########
    # message - string

    def send_chat(message)
      request({req: 'sendchat', message: message})
    end

    # SendRASConfigChange
    ##########
    # key - string
    # value - string

    def send_ras_config_change(key, value)
      request({req: 'sendrasconfigchange', key: key, value: value})
    end

    # SendRASCursor
    ##########
    # x - int32
    # y - int32

    def send_ras_cursor(x, y)
      request({req: 'sendrascursor', x: x, y: y})
    end

    # SendRASViewChange
    ##########
    # view - string

    def send_ras_view_change(view)
      request({req: 'sendrasviewchange', view: view})
    end

    # SetConfig
    ########
    # key - string
    # value - string

    def set_config(key, value)
      request({req: 'setconfig', key: key, value: value})
    end

    # SetGroupDefaults
    ##########
    # none

    def set_group_defaults
      request({req: 'setgroupdefaults'})
    end

    # setMCMAUserAuthMask
    ##########
    # user - string
    # mask - uint32

    def set_mcma_user_auth_mask(user, mask)
      request({req: 'setmcmauserauthmask', user: user, mask: mask})
    end

    # setMCMAUserSettingMask
    ##########
    # user - string
    # mask - uint32

    def set_mcma_user_setting_mask(user, mask)
      request({req: 'setmcmausersettingmask', user: user, mask: mask})
    end

    # SetPluginState
    ##########
    # plugin - string
    # state - boolean

    def set_plugin_state(plugin, state)
      request({req: 'setpluginstate', plugin: plugin, state: state})
    end

    # SetScheduleDefaults
    ##########
    # none

    def set_schedule_defaults
      request({req: 'setscheduledefaults'})
    end

    # SetThreadWake
    ##########
    # DEBUGMETHOD
    # thread_id - int32
    # awake - boolean

    def set_thread_wake(thread_id, awake)
      request({req: 'setthreadwake', threadid: thread_id, awake: awake})
    end

    # SetWorldBackup
    ##########
    # world_id - string
    # included - boolean

    def set_world_backup(world_id, included)
      request({req: 'setworldbackup', worldid: world_id, included: included})
    end

    # SleepServer
    ##########
    # none

    def sleep_server
      request({req: 'sleepserver'})
    end

    # StartServer
    ##########
    # none

    def start_server
      request({req: 'startserver'})
    end

    # StopServer
    ##########
    # none

    def stop_server
      request({req: 'stopserver'})
    end

    # TakeBackup
    ##########
    # label - string
    # Include_Permissions - boolean
    # Include_Plugins - boolean
    # Include_Config - boolean
    # Include_Server - boolean
    # Include_Worlds - boolean, optional, defaults true

    def take_backup(label, include_permissions, include_config, include_server, include_worlds = true)
      reqest({req: 'takebackup', label: label, includepermissions: include_permissions, includeconfig: include_config, includeserver: include_server, includeworlds: include_worlds})
    end

    # UnsetMCMAUserAuthMask
    ##########
    # user - string
    # mask - uint64

    def unset_mcma_user_auth_mask(user, mask)
      request({req: 'unsetmcmauserauthmask', user: user, mask: mask})
    end

    # UnsetMCMAUserSettingMask
    ##########
    # user - string
    # mask - string

    def unset_mcma_user_setting_mask(user, mask)
      request({req: 'unsetmcmausersettingmask', user: user, mask: mask})
    end

    # updatemc
    ##########
    # none

    def update_mc
      request({req: 'updatemc'})
    end

    # updatemcma
    ##########
    # none

    def update_mcma
      request({req: 'updatemcma'})
    end

    # UploadBackup
    ##########
    # none

    # TODO: This. Figuring out POSTing

    # WriteFileChunk
    ##########
    # path -string
    # start - int64
    # data - string

    def write_file_chunk(path, start, data)
      request({req: 'writefilechunk', start: start, data: data})
    end

    # WrtieThreadStats
    ##########
    # DEBUG METHOD
    # none

    def write_thread_stats
      request({req: 'writethreadstats'})
    end


    ########################
    #####New  Functions#####
    ########################

    # add_user_to_group
    ##########
    # groupname, string
    # username - string

    def add_user_to_group(groupname, username)
      add_group_value(groupname, 'groupmembers', username)
      if get_group_info(groupname)['info']['Members'].include?(username)
        result_hash(200, "Successfully added #{username} to the #{groupname} group.")
      else
        result_hash(404, "Did not Successfully added #{username} to the #{groupname} group, check with the group list to be certain.")
      end
    end

    # Whitelist a User
    ##########
    # username - string

    def whitelist(username)
      send_chat("/whitelist add #{username}")

      sleep 0.5 # Give server time to add to whitelist

      if is_maybe_whitelisted?(username)
        result_hash(200, "Successfully added #{username} to whitelist.")
      else
        result_hash(404, "May not have added #{username} to whitelist, please manually check with the whitelist_list command")
      end
    end

    # Delete a user from whitelist
    ##########
    # username - string

    def remove_whitelist(username)
      send_chat("/whitelist remove #{username}")
    end

    private

    attr_accessor :session_id, :host, :port

    def result_hash(status, message)
      {status: status, message: message}
    end

    def request(params_hash)
      return result_hash(401, "Please login first") if @session_id.nil?

      response = perform_request(params_hash)
      json_response = JSON.parse(response.body)

      case response
      when Net::HTTPSuccess
        json_response
      else
        result_hash(json_response["status"], response.body)
      end
    end

    def perform_request(params_hash)
      params_hash = params_hash.merge({Token: '', MCMASESSIONID: @session_id})
      query_params = URI.encode_www_form(params_hash)

      url = URI.parse("http://#{@host}:#{@port}/data.json?#{query_params}")
      http = Net::HTTP.new(url.host, url.port)
      response = http.get("#{url.path}?#{url.query.to_s}", {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
    end

    def is_maybe_whitelisted?(username)
      # There is no sure fire way to check if whitelisting passed
      # Instead, we check the last little bit of logs (after a small sleep)
      # Then we check if the message includes the whitelisted success phrase
      # If it does not, the server could just be slow.
      # BE WARNED.
      chat_data = get_chat(1)["chatdata"]
      last_message = chat_data.last['message']
      last_message.include?("Added #{username} to white-list")
    end

  end
end

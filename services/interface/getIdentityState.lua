operation.solution_id = nil

local identityState = Device2.getIdentityState(operation)
if identityState.code ~= nil then
  return identityState
end

local configIO = require("configIO")
local configIOData = configIO.get()

if configIOData.config ~= "" then
  identityState.config_io = {
    timestamp = configIOData.timestamp,
    set = configIOData.config,
    reported = configIOData.config
  }
end

local transform = require("vendor.transform")
if transform ~= nil and transform.convertIdentityState ~= nil then
  identityState = transform.convertIdentityState(identityState)
end

return identityState

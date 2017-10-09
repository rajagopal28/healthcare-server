json.array! @user_vital_summary do |uvs|
  json.extract! uvs, :user_vital_log, :pressure_status, :sugar_status, :temperature_status, :pulse_status
end

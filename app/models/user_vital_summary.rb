class UserVitalSummary
  include ActiveModel::Model
  attr_accessor :user_vital_log, :pressure_status, :sugar_status, :temperature_status, :pulse_status
  def attributes
    {'user_vital_log' => nil, 'pressure_status' => nil, 'sugar_status' => nil, 'temperature_status' => nil, 'pulse_status' => nil}
  end
end

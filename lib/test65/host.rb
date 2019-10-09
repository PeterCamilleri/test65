# Is this program running on a Windows host?

module Test65

  # Are we running under Windows?
  def self.windows?

    #What operating platform is in use?
    @host_system_type ||=
    case RbConfig::CONFIG['host_os']
    when /mswin|msys|mingw|bccwin|wince|emc/
      :windows
    else
      :not_windows
    end

    @host_system_type == :windows
  end

end

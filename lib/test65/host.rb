# Is this program running on a Windows host?

module Test65

  # Are we running under Windows?
  def self.windows?
    # Is this a Windows based system
    @win ||= RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw|bccwin|wince|emc/
  end

end

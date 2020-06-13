# Is this program running on a Windows host?

class Object

private

  # Are we running under Windows?
  def windows?
    # Is this a Windows based system
    @win ||= RbConfig::CONFIG['host_os'] =~ /mswin|msys|mingw|bccwin|wince|emc/
  end

end

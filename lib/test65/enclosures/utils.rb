# Utility methods

class TestScript

  # Create a file name with a new extension.
  def change_type(file, new_ext)
    file.gsub(/\...?.?\z/, new_ext)
  end

  #Construct a series of arguments.
  def build_args(prefix = nil, args)
    p = prefix ? prefix + " " : ""
    args.inject("") {|s,a| s << p + a + " "}
  end

end

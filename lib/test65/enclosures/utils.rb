# Utility methods

class TestScript

  # Create a file name with a new extension.
  def change_type(file, new_ext)
    file.gsub(/\...?.?\z/, new_ext)
  end

  # Construct a series of arguments.
  def build_args(prefix = nil, args)
    pre = prefix ? prefix + " " : ""
    args.inject("") {|str, arg| str << pre + arg + " "}
  end

  # Append to an option.
  def append_option(key, *value)
    @options[key] = ((@options[key] || []) + [value]).flatten
  end
end

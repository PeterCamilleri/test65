# Utility methods

class TestScript

  # Create a file name with a new extension.
  def change_type(file, new_ext)
    file.gsub(/\...?.?\z/, new_ext)
  end

end

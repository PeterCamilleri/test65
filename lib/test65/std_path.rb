# Portable path handling methods for the Test65 program.

class String

  # Convert a path into standard form.
  def standardize_path
    self.gsub("\\", "/")
  end

  # Convert a path string into local system form.
  def localize_path
    windows? ? self.gsub("/", "\\") : self
  end

end

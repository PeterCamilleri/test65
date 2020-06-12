# Portable path handling methods for the Test65 program.

class Object

  private

  # Convert a path into standard form.
  def standardize_path(path)
    path.gsub("\\", "/")
  end

  # Convert a path string into local system form.
  def localize_path(path)
    windows? ? path.gsub("/", "\\") : path
  end

end

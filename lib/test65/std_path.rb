# Portable path handling methods for the Test65 program.

module Test65

  # Convert a path into standard form.
  def self.std_path(path)
    path.gsub("\\", "/")
  end

  # Convert a path string into local system form.
  def self.local_path(path)
    windows? ? path.gsub("/", "\\") : path
  end

end

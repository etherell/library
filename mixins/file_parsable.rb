# frozen_string_literal: true

# Contains methods to parse files
module FileParsable
  # Returns array with all instances of current class
  def all
    folder_name = name.downcase.pluralize
    permitted_classes = [Author, Book, Library, Order, Reader, Date]
    objects_arr = []

    Dir.glob("./data/#{folder_name}/*.yaml") do |filename|
      objects_arr << YAML.safe_load(File.read(filename), permitted_classes: permitted_classes)
    end
    objects_arr
  end
end

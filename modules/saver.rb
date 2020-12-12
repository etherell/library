module Saver
  # First checks checks validations and then saves data to yaml
  def save(yaml_file_name)
    yield
    save_object_to_yaml(yaml_file_name)
  rescue StandardError => e
    print_exception(e)
  end

  private

  def print_exception(exception)
    puts "#{exception.class}: #{exception.message}"
    puts exception.backtrace.join("\n")
  end

  def save_object_to_yaml(yaml_file_name)
    folder_path = "data/#{self.class.to_s.downcase.pluralize}"
    file_name = "#{yaml_file_name.split(' ').join('_').downcase}.yaml"
    file_path = File.join(folder_path, file_name)

    Dir.mkdir(folder_path) unless Dir.exist?(folder_path)
    File.open(file_path, 'w') { |file| file.write(to_yaml) }
  end
end

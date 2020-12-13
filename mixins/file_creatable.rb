# frozen_string_literal: true

# Contains methods to create files with information about objects
module FileCreatable
  # First checks validations and then saves data to yaml
  def save_to_file(yaml_file_name)
    save_object_to_yaml(yaml_file_name)
  end

  private

  def save_object_to_yaml(yaml_file_name)
    folder_path = "data/#{self.class.to_s.downcase.pluralize}"
    # Replaces spaces with '_' and all sybmols with empty string then convert to downcase
    file_name = "#{yaml_file_name.tr(' ', '_').gsub(/[.,!?']/, '').downcase}.yaml"
    file_path = File.join(folder_path, file_name)

    create_necessary_folders(folder_path)
    File.open(file_path, 'w') { |file| file.write(to_yaml) }
    puts "#{self.class} successfully saved to #{file_name}"
  end

  # Creates folders for data if they don't exist
  def create_necessary_folders(folder_path)
    Dir.mkdir('data') unless Dir.exist?('data')
    Dir.mkdir(folder_path) unless Dir.exist?(folder_path)
  end
end

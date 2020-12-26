module YamlFilesManipulator
  DATA_PATH = './data/library.yaml'.freeze
  DIR_NAME = 'data'.freeze

  module Parsable
    def all
      property_name = name.downcase.en.plural
      permitted_classes = [Author, Book, Library, Order, Reader, Date]

      library = YAML.safe_load(File.read(DATA_PATH), permitted_classes: permitted_classes, aliases: true)
      library.public_send(property_name)
    end
  end

  module Savable
    def save_to_file
      Dir.mkdir(DIR_NAME) unless Dir.exist?(DIR_NAME)

      File.open(DATA_PATH, 'w+') do |file|
        file.write(to_yaml)
      end
    end
  end
end

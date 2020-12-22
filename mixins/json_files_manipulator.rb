module JsonFilesManipulator
  DATA_PATH = './data/library.json'.freeze
  DIR_NAME = 'data'.freeze

  module Parsable
    def all
      property_name = name.downcase.en.plural

      data = File.read(DATA_PATH)
      library = Oj.load(data)
      library.public_send(property_name)
    end
  end

  module Savable
    private

    def save_to_file
      Dir.mkdir(DIR_NAME) unless Dir.exist?(DIR_NAME)

      File.open(DATA_PATH, 'w+') do |file|
        file.write(Oj.dump(self))
      end
    end
  end
end

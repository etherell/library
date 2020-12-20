# frozen_string_literal: true

module JsonFilesManipulator
  # Gives ability to parse data from json file
  module Parsable
    def all
      property_name = name.downcase.pluralize

      data = File.read('./data/library.json')
      library = Oj.load(data)
      library.public_send(property_name)
    end
  end

  # Gives ability to save data to json file
  module Savable
    def save_to_file
      Dir.mkdir('data') unless Dir.exist?('data')

      File.open('./data/library.json', 'w+') do |f|
        f.write(Oj.dump(self))
      end
    end
  end
end

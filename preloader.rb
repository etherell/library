# frozen_string_literal: true

# Extensions
require 'pry-byebug'
require 'date'
require 'yaml'
require 'active_support/inflector'
require 'faker'
require 'fileutils'
require 'singleton'
require 'oj'

# Mixins
require './mixins/property_validatable'
require './mixins/json_files_manipulator'

# Classes
require './classes/author'
require './classes/book'
require './classes/order'
require './classes/reader'
require './classes/library'

# Factories
require './factories/random_factory'

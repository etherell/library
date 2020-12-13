# frozen_string_literal: true

# Extensions
require 'pry-byebug'
require 'date'
require 'yaml'
require 'active_support/inflector'
require 'faker'
require 'fileutils'
require 'singleton'

# Mixins
require './mixins/property_validatable'
require './mixins/file_creatable'
require './mixins/file_parsable'

# Classes
require './classes/author'
require './classes/book'
require './classes/order'
require './classes/reader'
require './classes/library'

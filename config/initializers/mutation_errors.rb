# frozen_string_literal: true

module Mutations

  # Offers a non-localized, english only, non configurable way to get error messages.  This probably isnt good enough for users as-is.
  class CustomErrorMessageCreator < DefaultErrorMessageCreator

    MESSAGES = Hash.new("is invalid").tap do |h|
      h.merge!(
        # General
        :nils => "can't be empty",
        :required => "is required",

        # Datatypes
        :string => "isn't a string",
        :integer => "isn't an integer",
        :boolean => "isn't a boolean",
        :hash => "isn't a hash",
        :array => "isn't an array",
        :model => "isn't the right class",

        # Date
        :date => "date doesn't exist",
        :before => "isn't before given date",
        :after => "isn't after given date",

        # String
        :empty => "can't be blank",
        :max_length => "is too long",
        :min_length => "is too short",
        :matches => "isn't in the right format",
        :in => "isn't an option",

        # Array
        :class => "isn't the right class",

        # Integer
        :min => "is too small",
        :max => "is too big",

        # Model
        :new_records => "isn't a saved model"
      )
    end

    def message(key, error_symbol, options = {})
      if options[:index]
        "#{titleize(key || 'array')}[#{options[:index]}] #{MESSAGES[error_symbol]}"
      else
        "#{titleize(key)} #{MESSAGES[error_symbol]}"
      end
    end
  end
end

Mutations.error_message_creator = Mutations::CustomErrorMessageCreator.new

class ExternalRecord < ApplicationRecord
  self.abstract_class = true
  establish_connection :database_external
end

class SitePlantship < ApplicationRecord
  belongs_to :site
  belongs_to :plant
end

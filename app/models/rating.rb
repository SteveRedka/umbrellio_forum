class Rating < ApplicationRecord
  belongs_to :post, counter_cache: true
end

class Code < ActiveRecord::Base
  belongs_to :state
  # :has_one_and_belongs_to_many :cities # this should be experimented with
end


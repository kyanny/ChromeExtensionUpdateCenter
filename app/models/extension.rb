class Extension < ActiveRecord::Base
  attr_accessible :appid, :crx, :name, :pem, :release, :version
end

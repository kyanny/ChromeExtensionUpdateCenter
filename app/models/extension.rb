require 'tmpdir'
require 'json'

class Extension < ActiveRecord::Base
  attr_accessible :appid, :crx, :name, :pem, :release, :version

  validates :name, presence: true
  validates :appid, presence: true
  validates :version, presence: true, uniqueness: { scope: :appid }
  validates :crx, presence: true

  def store_binary_data
    self.crx = crx.read if crx
    self.pem = pem.read if pem
  end

  def unpack_crx
    return unless crx
    Dir.mktmpdir do |tmpdir|
      CrxUnpack.unpack_contents(crx, tmpdir)
      manifest = JSON.parse(open(File.join(tmpdir, 'manifest.json')).read)
      self.name = manifest['name']
      self.version = manifest['version']
    end
  rescue => e
    Rails.logger.error("#{e.class} #{e.message}")
    self.errors.add(:crx, "Invalid crx format")
  end

  def calculate_appid
    return unless pem
    self.appid = CrxAppid.calculate(pem)
  rescue => e
    Rails.logger.error("#{e.class} #{e.message}")
    self.errors.add(:pem, "Invalid pem format")
  end

  def self.latest_versions
    self.pluck(:appid).uniq.map{ |appid|
      self.where(appid: appid).order('version DESC').first
    }
  end
end

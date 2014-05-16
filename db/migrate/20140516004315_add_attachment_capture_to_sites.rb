class AddAttachmentCaptureToSites < ActiveRecord::Migration
  def self.up
    change_table :sites do |t|
      t.attachment :capture
    end
  end

  def self.down
    drop_attached_file :sites, :capture
  end
end

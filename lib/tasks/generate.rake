namespace :generate do
  desc 'gif generate'
  task gif: :environment do
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.info 'start'
    Site.where(capture_file_name: nil).find_in_batches do |sites|
      sites.each do |site|
        begin
          site.generate_gif
          Rails.logger.info "ok id: #{site.id} title: #{site.title}"
        rescue => e
          Rails.logger.warn "error id: #{site.id} title: #{site.title} message: #{e.message}"
        end
      end
    end
    Rails.logger.info 'finish'
  end

end

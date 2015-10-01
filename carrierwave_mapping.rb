#encoding: UTF-8

  desc "Prints the CarrierWave uploaders and their versions"

  task :print_uploaders_and_versions => :environment do
    class CarrierWave::Uploader::Base
      def self.descendants
        ObjectSpace.each_object(Class).select { |klass| klass < self }
      end
    end

    CarrierWave::Uploader::Base.descendants.uniq.select { |u| u.to_s.exclude? "::"}.each do |uploader|
      p "Uploader:"
      p uploader
      if uploader.versions.any?
        p "Versions:"
        uploader.versions.each do |version|
          p version[0].to_s
        end
      else
        p "Doesn't have versions"
      end
    end
  end

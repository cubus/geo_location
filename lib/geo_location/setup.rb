module GeoLocation
  @@use = :hostip
  @@key = nil
  @@dev = nil
  @@dev_ip = nil
  @@timezones = {}
  @@countries = {}
  @@maxmind_url = Proc.new { |ip| "http://geoip3.maxmind.com/b?l=#{GeoLocation::key}&i=#{ip}" }
  @@hostip_url  = Proc.new { |ip| "http://api.hostip.info/?ip=#{ip}" }


  [:use, :key, :dev, :dev_ip, :countries, :maxmind_url, :hostip_url].each do |sym|
    class_eval <<-EOS, __FILE__, __LINE__
      def self.#{sym}
        if defined?(#{sym.to_s.upcase})
          #{sym.to_s.upcase}
        else
          @@#{sym}
        end
      end

      def self.#{sym}=(obj)
        @@#{sym} = obj
      end
    EOS
  end
  
  GeoLocation.build_countries
  #GeoLocation.build_timezones
  
end

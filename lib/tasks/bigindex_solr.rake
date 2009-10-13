namespace :bigindex do
  namespace :solr do

    desc 'Starts Solr. Options accepted: RAILS_ENV=your_env, PORT=XX. Defaults to development if none.'
    task :start do
      require 'net/http'
      
      unless defined?(BigindexSolr)
        require File.join(File.dirname(__FILE__), "..", "bigindex-solr")
      end

      begin
        n = Net::HTTP.new('127.0.0.1', BigindexSolr::PORT)
        n.request_head('/').value

      rescue Net::HTTPServerException #responding
        puts "Port #{BigindexSolr::PORT} in use" and return

      rescue Errno::ECONNREFUSED #not responding
        Dir.chdir(BigindexSolr::SOLR_PATH) do
          pid = fork do
            exec "java #{BigindexSolr::JVM_OPTIONS} -Dsolr.data.dir=#{BigindexSolr::DATA_PATH} -Djetty.logs=#{BigindexSolr::LOGS_PATH} -Djetty.port=#{BigindexSolr::PORT} -jar start.jar"
          end
          Process.detach(pid)
          sleep(5)
          File.open("#{BigindexSolr::PID_PATH}/#{BigindexSolr::ENVIRONMENT}_pid", "w"){ |f| f << pid}
          puts "[#{BigindexSolr::ENVIRONMENT}] Solr started successfully on #{BigindexSolr::PORT}, pid: #{pid}."
        end
      end
    end

    desc 'Stops Solr. Specify the environment by using: RAILS_ENV=your_env. Defaults to development if none.'
    task :stop do
      unless defined?(BigindexSolr)
        require File.join(File.dirname(__FILE__), "..", "bigindex-solr")
      end

      file_path = "#{BigindexSolr::PID_PATH}/#{BigindexSolr::ENVIRONMENT}_pid"
      if File.exists?(file_path)
        pid = File.open(file_path, "r").readline.to_i
        Process.kill("TERM", pid)
        sleep(2)
        File.unlink(file_path)
        puts "[#{BigindexSolr::ENVIRONMENT}] Solr shutdown successfully."
      else
        puts "PID file not found at #{file_path}. Either Solr is not running or no PID file was written."
      end
    end

  end # namespace :solr
end # namespace :bigindex

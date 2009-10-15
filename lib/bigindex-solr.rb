require 'uri'
require 'fileutils'

module BigindexSolr

  ENVIRONMENT = (ENV['RAILS_ENV'] || 'development').dup

  PID_PATH = File.join(RAILS_ROOT, "tmp", "pids")
  LOGS_PATH = File.join(RAILS_ROOT, "log")
  DATA_PATH = File.join(RAILS_ROOT, "solr", ENVIRONMENT)
  SOLR_PATH = File.join(File.dirname(__FILE__), "..", "solr")

  FileUtils.mkdir_p(DATA_PATH)

  CONFIG_PATH = File.join(RAILS_ROOT, "config", "bigindex.yml")

  begin
    CONFIG = YAML::load_file(CONFIG_PATH)
  rescue Errno::ENOENT
    raise LoadError, "[Bigindex-Solr] Could not read config file: #{CONFIG_PATH}. Please check that it exists!"
    CONFIG = {}
  end

  raise LoadError, "[Bigindex-Solr] The adapter defined for environment: #{ENVIRONMENT} is not solr" unless CONFIG[ENVIRONMENT]['adapter'] == "solr"

  unless CONFIG.empty? || CONFIG[ENVIRONMENT].nil?
    URL = CONFIG[ENVIRONMENT]['solr_url']
    PORT = URI.parse(URL).port
    JVM_OPTIONS = CONFIG[ENVIRONMENT]['jvm_options'] || ""
  end

end # module BigindexSolr

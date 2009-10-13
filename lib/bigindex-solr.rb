ENV['RAILS_ENV']  = (ENV['RAILS_ENV'] || 'development').dup
SOLR_PATH = "#{File.dirname(File.expand_path(__FILE__))}/../solr" unless defined? SOLR_PATH

if RAILS_ROOT

end
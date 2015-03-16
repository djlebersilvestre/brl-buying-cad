require 'class_finder'

class MutantRunner
  def run
    find_classes.each do |klass|
      cmd = [cmd_bundle, cmd_options, klass].join(' ')
      fail "#{klass} is not passing mutant validation" if system(cmd)
    end
  end

  private

  def find_classes
    find_files.map do |file|
      ClassFinder.extract_class_from_path(file)
    end
  end

  def find_files
    path = File.expand_path(File.dirname(__FILE__))
    Dir["#{path}/../app/**/*.rb"]
  end

  def cmd_bundle
    'RAILS_ENV=test bundle exec mutant'
  end

  def cmd_options
    '-r ./config/environment --use rspec'
  end
end

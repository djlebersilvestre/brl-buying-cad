module Overcommit
  module Hook
    module PreCommit
      class Rspec < Base
        def run
          success = system("#{rspec_command}")

          return :fail, 'Error running specs' unless success

          :pass
        end

        private

        def rspec_command
          'bundle exec rspec -f progress'
        end
      end
    end
  end
end
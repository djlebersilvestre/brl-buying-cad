module Overcommit
  module Hook
    module PreCommit
      class Rspec < Base
        def run
          success = system("#{rspec_command}")
          puts ">>>>>>>>>>>>>>>>>>>>>#{success}<<<<<<<<<<<"

          return :fail, 'Error running specs' unless success

          :pass
        end

        private

        def rspec_command
          'bundle exec rspec'
        end
      end
    end
  end
end

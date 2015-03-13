module Overcommit
  module Hook
    module PreCommit
      class Rspec < Base
        def run
          system('pwd')
          system('tail -2 README.md')
          success = system("#{rspec_command}")

          return :fail, 'Error running specs' unless success

          :pass
        end

        private

        def rspec_command
          'bundle exec rspec spec/ > /dev/null'
        end
      end
    end
  end
end

module Overcommit
  module Hook
    module PreCommit
      class Rspec < Base
        def run
          # We wanna run tests over the master codebase
          system('git stash pop --index --quiet')
          # Tests
          success = system('bundle exec rspec > /dev/null')
          # Restoring the original status for overcommit
          system('git stash save --keep-index --quiet')

          return :fail, 'Error running specs' unless success

          :pass
        end
      end
    end
  end
end

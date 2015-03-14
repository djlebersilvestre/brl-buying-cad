module Overcommit
  module Hook
    module PreCommit
      class Rubycritic < Base
        def run
          path = './tmp/rubycritic'

          # We wanna run the critics over the master codebase
          # system('git stash pop --index --quiet')
          # Runs the critics
          system("bundle exec rubycritic app/ lib/ --path #{path} > /dev/null")
          # Analysis
          error = analysis(path)
          # Restoring the original status for overcommit
          # system('git stash save --keep-index --quiet')

          return :fail, error if error

          :pass
        end

        private

        def analysis(path)
          rates = parse_rates(path)
          error = nil

          unless valid?(rates)
            error = [
              rates.to_s,
              ' - Error - Low quality detected'
            ].join
          end

          error
        end

        def valid?(rates)
          undesired = rates.keys.select { |rate| rate >= 'C' }
          undesired.empty?
        end

        def read_code_index(path)
          File.read("#{path}/code_index.html")
        end

        def parse_rates(path)
          rates_file = read_code_index(path)
          rates = rates_file.scan(/>([A-F])<\/span>/).flatten.sort
          rates.each_with_object(Hash.new(0)) do |rate, counts|
            counts[rate] += 1
          end
        end
      end
    end
  end
end

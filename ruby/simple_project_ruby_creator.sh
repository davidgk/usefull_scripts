#bash 

mkdir $1

cd $1

PROJECT_LOCATION=$(PWD)


mkdir $PROJECT_LOCATION/lib;
mkdir $PROJECT_LOCATION/spec;

echo "# Gemfile
source 'https://rubygems.org'

git_source(:github) {|repo_name| \"https://github.com/#{repo_name}\" }

gem 'rspec'" >> Gemfile

bundle --path ".bundle"

echo "
# .gitignore
.bundle
.idea
" >> .gitignore

cd $PROJECT_LOCATION/spec

echo "# Example rspec

require '../lib/rspec_example'

describe 'RspecExample' do
  describe '#suma' do
    context 'if I send 1 + 1' do
      it 'should result 2' do
          expect(RspecExample.new().suma(1,1)).to eq(2)
      end
    end
  end
end" >> rspec_example_spec.rb

cd $PROJECT_LOCATION/lib

echo "# Example rspec

class RspecExample
	def suma (valueA, valueB)
		valueA + valueB
	end
end" >> rspec_example.rb

cd $PROJECT_LOCATION/spec

bundle exec rspec rspec_example_spec.rb

git init 


# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :extension do
    release true
  end

  factory :hello_extension, parent: :extension do
    name "Hello"
    appid "kifmmjimfiihjapngpjdcceapgijkjdo"
    crx { read_fixture_files('hello.crx') }
    pem { read_fixture_files('hello.pem') }
    version "1.0"
  end

  factory :goodbye_extension, parent: :extension do
    name "Goodbye"
    appid "bbfldlgmpmcgefcjkjjmkpfeebbplhad"
    crx { read_fixture_files('goodbye.crx') }
    pem { read_fixture_files('goodbye.pem') }
    version "1.0"
  end
end

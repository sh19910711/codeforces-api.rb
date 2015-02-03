require "bundler/setup"

if ENV["TRAVIS"] == "true"
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require "codeforces"

require "vcr"
VCR.configure do |conf|
  conf.cassette_library_dir = "spec/api_fixtures"
  conf.hook_into :webmock
  conf.configure_rspec_metadata!
  conf.preserve_exact_body_bytes { true }
  conf.default_cassette_options = {
    :serialize_with => :psych,
  }
  conf.ignore_hosts "codeclimate.com"
end

require "webmock"
RSpec.configure do |conf|

  conf.before do
    ::WebMock.stub_request(
      :get,
      "http://codeforces.com/api/user.ratedList",
    ).to_return(
      :status => 200,
      :body => '{"status":"OK","result":[{"handle":"tourist","firstName":"Gennady","lastName":"Korotkevich","country":"Belarus","city":"Gomel","organization":"NRU ITMO","contribution":33,"rank":"international grandmaster","rating":3254,"maxRank":"international grandmaster","maxRating":3299,"lastOnlineTimeSeconds":1422146844,"registrationTimeSeconds":1265987288},{"handle":"Petr","firstName":"Petr","lastName":"Mitrichev","country":"Russia","city":"Moscow","organization":"Google","contribution":143,"rank":"international grandmaster","rating":2893,"maxRank":"international grandmaster","maxRating":3002,"lastOnlineTimeSeconds":1422429465,"registrationTimeSeconds":1267103024},{"handle":"yeputons","firstName":"Egor","lastName":"Suvorov","country":"Russia","city":"Saint Petersburg","organization":"Saint-Petersburg SU","contribution":114,"rank":"international grandmaster","rating":2742,"maxRank":"international grandmaster","maxRating":2773,"lastOnlineTimeSeconds":1422572943,"registrationTimeSeconds":1270712095},{"handle":"subscriber","firstName":"Adam","lastName":"Bardashevich","country":"Belarus","city":"BLR","organization":"NRU ITMO","contribution":35,"rank":"international grandmaster","rating":2685,"maxRank":"international grandmaster","maxRating":2685,"lastOnlineTimeSeconds":1422600030,"registrationTimeSeconds":1270566853}]}',
      :headers => {
        "Content-Type" => "application/json",
      },
    )
  end

end

if ENV["CODEFORCES_DEBUG"] === "yes"
  require "byebug"
end


require "spec_helper"

describe Codeforces::Client, :vcr do

  let!(:client) { Codeforces::Client.new }
  # before { client.logger.level = ::Logger::DEBUG }
  
  describe "#contest.hacks" do

    context "hacks 374" do
      subject! { client.api.contest.hacks 374 }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(subject.map &:id).to include 88042 }
    end

  end

  describe "#contest.list" do

    context "list" do
      subject! { client.api.contest.list }
      it { should be_a Array }
      it { expect(client.last_response.status).to eq 200 }
    end

  end # contest.list

  describe "#contest.standings" do

    context "standings 374" do
      subject! { client.api.contest.standings 374 }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.length).to eq ::Codeforces::Client::DEFAULT_PAGE_COUNT }
      it { expect(subject.map &:rank).to include 1 }
      it { expect(subject.map &:rank).to include 50 }
      it { expect(subject.map &:rank).to_not include 51 }
    end

    context "standings 374, :offset => 1" do
      subject! { client.api.contest.standings 374, :offset => 1 }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.length).to eq ::Codeforces::Client::DEFAULT_PAGE_COUNT }
      it { expect(subject.map &:rank).to_not include 1 }
      it { expect(subject.map &:rank).to_not include 50 }
      it { expect(subject.map &:rank).to include 51 }
    end

  end # contest.standings

  describe "#contest.status" do

    context "status 374" do
      subject! { client.api.contest.status 374 }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.map { |status| status.author.participantType }).to include 'PRACTICE' }
      it { expect(subject.length).to eq ::Codeforces::Client::DEFAULT_PAGE_COUNT }
    end

    context "status 374, :offset => 1" do
      subject! { client.api.contest.status 374, :offset => 1 }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.map &:id).to_not include 9823801 }
      it { expect(subject.length).to eq ::Codeforces::Client::DEFAULT_PAGE_COUNT }
    end

  end # contest.status

  describe "#problemset.problems" do

    context "problems" do
      subject! { client.api.problemset.problems }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.map &:name).to include "Spreadsheet" }
      it { expect(subject.map &:name).to include "Tic-tac-toe" }
    end

  end # problemset.problems

  describe "#problemset.problem_statices" do

    context "problem_statistics" do
      subject! { client.api.problemset.problem_statistics }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.select {|x| x.contestId === 1 && x.index === "B" }.first.solvedCount).to be > 4000 }
    end

    context "problem_statistics :query => { :tags => [dp] }" do
      subject! { client.api.problemset.problem_statistics :query => { :tags => ["dp"] } }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.select {|x| x.contestId === 1 && x.index === "B" }).to be_empty }
      it { expect(subject.select {|x| x.contestId === 507 && x.index === "D" }.first.solvedCount).to be > 400 }
    end

    context "problem_statistics :query => { :tags => [dp, implementation] }" do
      subject! { client.api.problemset.problem_statistics :query => { :tags => ["dp", "implementation"] } }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.select {|x| x.contestId === 1 && x.index === "B" }).to be_empty }
      it { expect(subject.select {|x| x.contestId === 507 && x.index === "D" }.first.solvedCount).to be > 400 }
    end

  end # problemset.problems

  describe "#problemset.recent_status" do

    context "recent_status" do
      subject! { client.api.problemset.recent_status }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.length).to eq ::Codeforces::Client::DEFAULT_PAGE_COUNT }
    end

  end # problemset.recent_status

  describe "#user.info" do

    context "info test_tarou" do
      subject! { client.api.user.info "test_tarou" }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.length).to eq 1 }
      it { expect(subject.first.handle).to eq "test_tarou" }
    end

    context "rated_list" do
      subject! { client.api.user.rated_list }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.map &:handle).to include "tourist" }
      it { expect(subject.map &:handle).to_not include "test_tarou" }
    end

  end # user.info

  describe "#user.rating" do

    context "rating Fefer_Ivan" do
      subject! { client.api.user.rating "Fefer_Ivan" }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.map &:contestName).to include "Codeforces Round #109 (Div. 1)" }
    end

  end

  describe "#user.status" do

    context "status Fefer_Ivan" do
      subject! { client.api.user.status "Fefer_Ivan" }
      it { should be_a Array }
      it { should_not be_empty }
      it { expect(client.last_response.status).to eq 200 }
      it { expect(subject.length).to eq ::Codeforces::Client::DEFAULT_PAGE_COUNT }
    end

  end

end # Codeforces::Client

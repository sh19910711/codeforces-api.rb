require "spec_helper"

describe Codeforces::Helper, :vcr => true do

  let!(:client) { Codeforces::Client.new }

  describe "#users" do

    context "users" do
      subject! { client.users }
      it { should_not be_empty }
    end

    context "users.grep :country => Russia" do
      subject! { client.users.grep :country => "Russia" }
      it { expect(subject.map &:handle).to include "Petr" }
      it { expect(subject.map &:handle).to_not include "tourist" }
    end

    context "users.grep :country => /Russia/" do
      subject! { client.users.grep :country => /^Russia$/ }
      it { expect(subject.map &:handle).to include "Petr" }
      it { expect(subject.map &:handle).to_not include "tourist" }
    end

    context "users.grep :country => Belarus" do
      subject! { client.users.grep :country => "Belarus" }
      it { expect(subject.map &:handle).to_not include "Petr" }
      it { expect(subject.map &:handle).to include "tourist" }
    end

    context "users.grep :country => /Belarus/" do
      subject! { client.users.grep :country => /^Belarus$/ }
      it { expect(subject.map &:handle).to_not include "Petr" }
      it { expect(subject.map &:handle).to include "tourist" }
    end

    context "users.grep :organization => Google" do
      subject! { client.users.grep :organization => "Google" }
      it { expect(subject.map &:handle).to include "Petr" }
      it { expect(subject.map &:handle).to_not include "tourist" }
    end

  end # users

  describe "#each_contest" do

    example "it is called 450 or more times" do
      cnt = 0
      client.each_contest { cnt += 1 }
      expect(cnt).to be > 450
    end

    it { expect(client.each_contest.map &:name).to include "Codeforces Beta Round #2" }

  end # each_contest

  describe "#user" do

    context "user(DmitriyH).rating" do
      subject! { client.user("DmitriyH").rating }
      it { should eq 1941 }
    end

    context "user(DmitriyH).country" do
      subject! { client.user("DmitriyH").country }
      it { should eq "Russia" }
    end

    context "user(DmitriyH).submissions" do
      subject! { client.user("DmitriyH").submissions }
      it { should be_a Array }
    end

  end # user

  describe "#each_status" do

    example "it is called #{::Codeforces::Client::DEFAULT_PAGE_COUNT} times" do
      cnt = 0
      client.each_status { cnt += 1 }
      expect(cnt).to eq ::Codeforces::Client::DEFAULT_PAGE_COUNT
    end

    context "first user" do
      it { expect(client.each_status.first.user.handle).to be_a(String) }
    end

  end

end

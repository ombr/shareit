require 'spec_helper'

describe Facebook, focus: true do

  let(:user) { FactoryGirl.create :user, :with_facebook }

  describe '#import' do
    it 'request facebook for friendlist' do
      Facebook.should_receive(:request)
        .with(user, 'me/friendlists')
        .and_yield([{"id"=>"10908559384516564", "name"=>"Super_List", "list_type"=>"user_created"}])

      Facebook.should_receive(:import_group).with(user, '10908559384516564', 'Super_List')
        .and_return
      Facebook.import user
    end
  end

  describe '#import_member' do
    let(:group) { FactoryGirl.create :group, user: user }
    let(:membership) { FactoryGirl.create :membership, user: user, group: group }

    it 'create a group member' do
      Facebook.import_member(group, '877460424', 'Super User')
      group.users.should include User.where(uid: 877460424.to_s).first
    end

    it 'does not create a group member if user is member' do
      membership
      user.update!(uid: '877460424')
      expect {
        Facebook.import_member(group, '877460424', 'Super User')
      }.to_not change{Membership.count}
    end

    it 'create a user' do
      group
      expect {
        Facebook.import_member(group, '877460424', 'Super User')
      }.to change{User.count}.by(1)
    end

    it 'does not try change email if already defined', focus: true do
      group
      user.update!(uid: '877460424')
      expect {
        Facebook.import_member(group, '877460424', 'Super User')
      }.to_not change{user.reload.unconfirmed_email}
    end

    it 'does not change password if already defined', focus: true do
      group
      user.update!(uid: '877460424')
      expect {
        Facebook.import_member(group, '877460424', 'Super User')
      }.to_not change{user.reload.encrypted_password}
    end

  end

  describe '#import_group' do
    it 'creates a group' do
      Facebook.should_receive(:request)
        .with(user, '10908559384516564/members')
        .and_yield([{"id"=>"877460424", "name"=>"Super User"}])
      expect{
        Facebook.import_group(user, 10908559384516564, 'Super_List')
      }.to change{Group.count}.by(1)
    end

    it 'request facebook for the members' do
      Facebook.should_receive(:request)
        .with(user, '10908559384516564/members')
        .and_yield([{"id"=>"877460424", "name"=>"Super User"}])
      Facebook.import_group(user, 10908559384516564, 'Super_List')
    end

    it '#import the members' do
      Facebook.should_receive(:import_member)
      Facebook.should_receive(:request)
        .with(user, '10908559384516564/members')
        .and_yield([{"id"=>"877460424", "name"=>"Super User"}])
      Facebook.import_group(user, 10908559384516564, 'Super_List')
    end
  end

  describe '#request' do
    it 'send other request for paging'
    it 'uses HTTPParty to send a request' do
      HTTParty.should_receive(:get).with("https://graph.facebook.com/me/friendlists?access_token=super_token").and_return('{"data":[]}')
      Facebook.request(user, 'me/friendlists') do |lists|
        lists.length.should == 0
      end
    end
  end
end

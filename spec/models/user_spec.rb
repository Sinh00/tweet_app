require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    context '何も入力しなかった場合' do
      subject { User.create }
      it { expect(subject).to_not be_valid }
      it { expect(subject.errors[:name].size).to eq 1 }
      it { expect(subject.errors[:email].size).to eq 2 }
      it { expect(subject.errors[:password].size).to eq 1 }
    end

    context '名前が文字数をオーバーしている場合' do
      subject { User.create(name: 'aaaaabbbbbcccccddddde', email: 'test@test.com', password: 'password') }
      it { expect(subject).to_not be_valid }
      it { expect(subject.errors[:name].size).to eq 1 }
      it { expect(subject.errors[:email].size).to eq 0 }
      it { expect(subject.errors[:password].size).to eq 0 }
    end
    
    context 'メールアドレスのフォーマットが不正な場合' do
      subject { User.create(name: 'tarou', email: '@test.com', password: 'password') }
      it { expect(subject).to_not be_valid }
      it { expect(subject.errors[:name].size).to eq 0 }
      it { expect(subject.errors[:email].size).to eq 1 }
      it { expect(subject.errors[:password].size).to eq 0 }
    end

    context '正しい入力の場合' do
      subject { User.create(name: 'tarou', email: 'test@test.com', password: 'password') }
      it { expect(subject).to be_valid }
      it { expect(subject.errors[:name].size).to eq 0 }
      it { expect(subject.errors[:email].size).to eq 0 }
      it { expect(subject.errors[:password].size).to eq 0 }
    end
  end
end
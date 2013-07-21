require 'spec_helper'

describe 'netrc' do
  let(:title)    { 'example.com' }
  let(:user)     { 'root' }
  let(:password) { 'yolo' }

  let(:params) {{
    :user     => user,
    :password => password,
  }}

  it do
    should contain_augeas('Add example.com netrc entry').
      with :lens => 'Netrc',
           :incl => '/home/root/.netrc',
           :context => '/files/home/root/.netrc',
           :changes => [
             "set *[machine = 'example.com']/machine example.com",
             "set *[machine = 'example.com']/login root",
             "set *[machine = 'example.com']/password yolo",
           ]
  end

end

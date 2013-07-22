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
    should contain_augeas("Add #{title} netrc entry for #{user}").
      with :lens => 'Netrc.lns',
           :incl => '/home/root/.netrc',
           :context => '/files/home/root/.netrc',
           :changes => [
             "ins #{title} after *[last()]",
             "set #{title}/login #{user}",
             "set #{title}/password #{password}",
           ]
  end

end

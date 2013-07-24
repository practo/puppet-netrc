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
    should contain_augeas("Set #{title} netrc login for #{user}").
      with :lens    => 'Netrc.lns',
           :incl    => '/home/root/.netrc',
           :context => '/files/home/root/.netrc',
           :changes => "set #{title}/login #{user}",
           :onlyif  => "match #{title}[login='#{user}']/login size == 0",
           :before  => "File[/home/root/.netrc]"

    should contain_augeas("Set #{title} netrc password for #{user}").
      with :lens    => 'Netrc.lns',
           :incl    => '/home/root/.netrc',
           :context => '/files/home/root/.netrc',
           :changes => "set #{title}/password #{password}",
           :onlyif  => "match #{title}[password='#{password}']/password size == 0",
           :before  => "File[/home/root/.netrc]"

    should contain_file("/home/root/.netrc").
      with :mode  => '0600',
           :owner => 'root',
           :group => 'root'
  end

end

require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe 'With a mocked client' do

  before(:all) do
    WebMock.enable!
    require 'algolia/webmock'
    # reset session objects
    app_id = Algolia.client.application_id
    Thread.current["algolia_hosts_#{app_id}"] = nil
    Thread.current["algolia_search_hosts_#{app_id}"] = nil
    Thread.current["algolia_host_index_#{app_id}"] = nil
    Thread.current["algolia_search_host_index_#{app_id}"] = nil
  end

  it "should add a simple object" do
    index = Algolia::Index.new("friends")
    index.add_object!({ :name => "John Doe", :email => "john@doe.org" })
    index.search('').should == { "hits" => [ { "objectID" => 42 } ], "page" => 1, "hitsPerPage" => 1 } # mocked
    index.list_api_keys
    index.browse
    index.clear
    index.delete
  end

  after(:all) do
    WebMock.disable!
  end

end

module SecondLife
  require 'xmlrpc/client'

  class Client
    def perform(rpc_key)
      server = XMLRPC::Client.new("xmlrpc.secondlife.com","/cgi-bin/xmlrpc.cgi")

      result = server.call('llRemoteData', {
        'Channel' => rpc_key,
        'StringValue' => 'DELETE'
      })
    end
  end

  def self.delete_object(rpc_key)
    client = Client.new
    client.perform(rpc_key)
  end

end 

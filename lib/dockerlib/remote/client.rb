module Dockerlib
  module Remote
    class Client
      def initialize(socket: nil)
        @socket = socket || '/var/run/docker.sock'
      end

      def inspect_container(name)
        resp = connection.request(method: :get, path: "/containers/#{name}/json")
        if resp.status == 200
          {d: load_body(resp)}
        elsif resp.status == 404
          {code: :no_such_container}
        else
          to_server_error resp
        end
      end

      protected

      def connection
        Excon.new('unix:///', socket: @socket)
      end
                                                                                                                        
      def load_body(resp)
        JSON.load(resp.body)
      end

      def to_server_error(resp)
        {error: :server_error, d: {http_status: resp.status,
                                   http_body: resp.body}}
      end
    end # Client
  end # Remote
end # Dockerlib

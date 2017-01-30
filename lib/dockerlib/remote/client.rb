module Dockerlib
  module Remote
    class Client
      def initialize(socket: nil)
        @socket = socket || '/var/run/docker.sock'
      end

      def inspect_image(name)
        resp = connection.request(method: :get, path: "/images/#{name}/json")
        if resp.status == 200
          {data: load_body(resp)}
        elsif resp.status == 404
          {code: :no_such_image}
        else
          to_server_error resp
        end
      end

      def inspect_container(name)
        resp = connection.request(method: :get, path: "/containers/#{name}/json")
        if resp.status == 200
          {data: load_body(resp)}
        elsif resp.status == 404
          {code: :no_such_container}
        else
          to_server_error resp
        end
      end

      def containers
        get('/containers/json')
      end

      def get(path)
        resp = connection.request(method: :get, path: path)
        if resp.status == 200
          {data: load_body(resp)}
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
        {error: :server_error, data: {http_status: resp.status,
                                      http_body: resp.body}}
      end
    end # Client
  end # Remote
end # Dockerlib

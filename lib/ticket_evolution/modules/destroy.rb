module TicketEvolution
  module Modules
    module Destroy
      def self.included(klass)
        Class.new{extend SingularClass}.singular_class(klass.name).send(:include, Module.new{
          def destroy
            response = endpoint.try(:destroy)
            if response === true
              self.freeze
            end

            response
          end

          alias :delete :destroy
        })
      end

      def destroy(&handler)
        ensure_id
        handler ||= method(:build_for_destroy)
        request(:DELETE, nil, nil, &handler)
      end

      def build_for_destroy(response)
        response.body
      end
    end
  end
end


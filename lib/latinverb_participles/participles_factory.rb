module Linguistics
  module Latin
    module Verb
      class LatinVerb
        class ParticiplesFactory
          extend Forwardable
          def_delegators :@verb, :irregular?, :deponent?, :semideponent?, :original_string

          def initialize(verb)
            @verb = verb
          end

          def participles
            return irregular if irregular?
            if deponent? || semideponent?
              deponent
            else
              standard
            end
          end

          def irregular
            Linguistics::Latin::Verb::LatinVerb::IrregularParticiplesRetriever.new(@verb.original_string).retrieve
          end

          def deponent
            DeponentParticipler.new(@verb)
          end

          def standard
            Participler.new(@verb)
          end
        end
      end
    end
  end
end

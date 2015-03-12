require 'logger'
require 'openssl'

require 'scep/version'

module SCEP
  autoload :Endpoint,       'scep/endpoint'
  autoload :PKIOperation,   'scep/pki_operation'
  autoload :PKCS7CertOnly,  'scep/pkcs7_cert_only'
  autoload :Keypair,        'scep/keypair'
  autoload :ASN1,           'scep/asn1'

  # Allows backwards-compatibility between ruby 1.8.7 and newer versions
  # @return [OpenSSL::PKCS7]
  PKCS7 = defined?(OpenSSL::PKCS7::PKCS7) ? OpenSSL::PKCS7::PKCS7 : OpenSSL::PKCS7

  class << self

    # Allows you to set the SCEP logger
    # @example
    #   SCEP.logger = Rails.logger
    attr_writer :logger

    # Gets the logger that the SCEP library will use
    # @return [Logger]
    def logger
      @logger ||= default_logger
    end

    protected

    def default_logger
      defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
    end
  end

  module Loggable
    def logger
      SCEP.logger
    end
  end
end

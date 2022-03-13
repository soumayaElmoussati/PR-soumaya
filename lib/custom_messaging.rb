if defined?(Slackistrano::Messaging)
  module Slackistrano
    class CustomMessaging < Messaging::Base
      # Suppress updating message.
      def payload_for_updating
          {
              text: "#{deployer} requested a deployment of #{branch} to #{stage}."
          }
      end

      # Suppress reverting message.
      def payload_for_reverting
        nil
      end

      # Fancy updated message.
      # See https://api.slack.com/docs/message-attachments
      def payload_for_updated
          {
              attachments: [{
                  color: 'good',
                  fields: [{
                      title: 'Environment',
                      value: stage,
                      short: true
                  }, {
                      title: 'Branch',
                      value: branch,
                      short: true
                  }, {
                      title: 'Deployer',
                      value: deployer,
                      short: true
                  }, {
                      title: 'Time',
                      value: elapsed_time,
                      short: true
                  }],
                  fallback: super[:text]
              }],
              text: ":white_check_mark: The #{stage} deployment was successful."
          }
      end

      # Default reverted message.  Alternatively simply do not redefine this
      # method.
      def payload_for_reverted
          nil
      end

      # Slightly tweaked failed message.
      # See https://api.slack.com/docs/message-formatting
      def payload_for_failed
          {
              attachments: [{
                  color: 'danger',
                  fields: [{
                      title: 'Environment',
                      value: stage,
                      short: true
                  }, {
                      title: 'Branch',
                      value: branch,
                      short: true
                  }, {
                      title: 'Deployer',
                      value: deployer,
                      short: true
                  }, {
                      title: 'Time',
                      value: elapsed_time,
                      short: true
                  }],
                  fallback: super[:text]
              }],
              text: ":warning: The #{stage} deployment failed."
          }
      end

      # Override the deployer helper to pull the best name available (git, password file, env vars).
      # See https://github.com/phallstrom/slackistrano/blob/master/lib/slackistrano/messaging/helpers.rb
      def deployer
          name = `git config user.name`.strip || ENV['USER'] || ENV['USERNAME']
          name = name.dup.force_encoding("UTF-8")
          name = "AgriVillage" if name.empty?
          name
      end
    end
  end
end

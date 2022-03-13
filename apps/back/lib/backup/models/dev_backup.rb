# encoding: utf-8

##
# Backup Generated: dev_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t dev_backup [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:dev_backup, 'Backup dev database') do
  database PostgreSQL do |db|
    db.name               = "back_development"
    db.username           = "postgres"
    db.password           = ""
    db.host               = "localhost"
    db.port               = 5432
    db.additional_options = []
  end

  store_with Local do |local|
    local.path       = "~/backups/"
    local.keep       = 10
  end

  notify_by Slack do |slack|
    slack.on_success = true
    slack.on_warning = true
    slack.on_failure = true
  
    # The integration token
    slack.webhook_url = 'https://hooks.slack.com/services/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'
  
    slack.username = 'Backup'
    slack.icon_emoji = ':rocket:'
    #
    # Change default notifier message.
    # See https://github.com/backup/backup/pull/698 for more information.
    # slack.message = lambda do |model, data|
    #   "[#{data[:status][:message]}] #{model.label} (#{model.trigger})"
    # end
  end
end

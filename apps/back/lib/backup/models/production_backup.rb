Model.new(:production_backup, 'Backup prod database') do
  database PostgreSQL do |db|
    db.name               = "back_production"
    db.username           = "postgres"
    db.password           = ""
    db.host               = "localhost"
    db.port               = 5432
    db.additional_options = []
  end

  store_with S3 do |s3|
    s3.access_key_id     = "PGFZDEDHVTTIMRC4FWVI"
    s3.secret_access_key = "Zm2Sy6R6p0Y8pCQb8X+payUVwvxzqD48tNuOhrnaUEM"
    s3.region            = "nyc3"
    s3.bucket            = "agrivillage-backup"
    s3.path              = "/root/backups"
    s3.fog_options       = {
      endpoint: "https://sfo2.digitaloceanspaces.com",
      aws_signature_version: 2
    }
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
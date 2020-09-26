unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: 'AKIAXOIN7M3YZGK4VNWX',
        aws_secret_access_key: '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',
        region: 'ap-northeast-1'
    }

    config.fog_directory  = 'rails-photo-123'
    config.cache_storage = :fog
  end
end
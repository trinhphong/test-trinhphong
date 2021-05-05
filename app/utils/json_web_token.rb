class JsonWebToken
  SECRET_KEY = '261b7875c79405249d42a31d00a19fdbd8fc1cc98e354ccdc960dfd9e2b7d7b6992275e55cb7a4b1ac8457d3b5151a31231cd9854487515ecba0e1c4ddb94202'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
class SecretCode < ApplicationRecord
  has_one :user
  validates :code, uniqueness: true

  def self.create_unique_identifiers(n)
    n.times do
      begin
        code = SecureRandom.hex(5) # or whatever you chose like UUID tools
      end while SecretCode.exists?(:code => code)
      SecretCode.create(code: code)
    end
  end
end

class User < ApplicationRecord
    enum role: [ :worker, :admin ]
    has_secure_password
end

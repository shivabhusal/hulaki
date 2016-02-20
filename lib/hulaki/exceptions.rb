module Hulaki
  class InvalidPhoneNumber < StandardError
  end

  class InvalidEmail < StandardError
  end

  class InvalidSmsGateway < StandardError
  end

  class InvalidMessageBody < StandardError
  end
end

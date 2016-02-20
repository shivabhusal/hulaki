class Hulaki::EmailValidator

  def initializer(email)
    @email = email
  end

  def valid_email?
    is_present?
  end
  def valid_message?
    
  end
  private

  def is_present?
    @email.nil?
  end
  def valid_format?

  end
end

module EmailValidatorsHelper
  def fetch_full_name(email_validator)
    "#{email_validator.first_name} #{email_validator.last_name}"
  end
end

class EmailValidatorsController < ApplicationController
  # GET /email_validators
  def index
    @email_validators = EmailValidator.all
  end

  # POST /email_validators
  def create
    @email_validator = EmailValidator.new(email_validator_params)
    @email_validator.email = generate_verified_email
    if @email_validator.email.present? && @email_validator.save
      flash[:notice] = "Email varified successfully"
    else
      flash[:error] = "Email not varified for give information"
    end
    redirect_to root_path
  end

  private

  # Only allow a list of trusted parameters through.
  def email_validator_params
    params.require(:email_validator).permit(:first_name, :last_name, :url)
  end

  def generate_verified_email
    first_name = email_validator_params[:first_name].downcase
    last_name  = email_validator_params[:last_name].downcase
    url = email_validator_params[:url].downcase
    verified_email = nil
    (1..6).each do |val|
      email = fetch_email_combination(val, first_name, last_name, url)
      puts "email: #{email}"
      response = MailBoxService.new.varify_email(email)
      if response["format_valid"] && response["mx_found"] && response["smtp_check"] && !response["catch_all"]
        verified_email = email
        break
      end
    end
    verified_email
  end

  def fetch_email_combination(index, first_name, last_name, url)
    username = case index
               when 1
                 "#{first_name}.#{last_name}"
               when 2
                 first_name
               when 3
                 first_name + last_name
               when 4
                 "#{last_name}.#{first_name}"
               when 5
                 "#{first_name.chars.first}.#{last_name}"
               when 6
                 first_name.chars.first + last_name.chars.first
               end
    username + "@#{url}"
  end
end

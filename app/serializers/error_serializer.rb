class ErrorSerializer
  def self.format_error(error)
    if error.include?("Couldn't find Subscriptio")
      return {
        message: "Subscription not found!",
        status: 404
      }
    else
      return {
        message: error.message,
        status: error.status_code
      }
    end
  end
end
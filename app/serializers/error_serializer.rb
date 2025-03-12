class ErrorSerializer
  def self.format_error(error)
    if error.include?("Couldn't find")
      return {
        message: "Subscription not found!",
        status: 404
      }
    else
      return {
        message: error[:message],
        status: error[:status]
      }
    end
  end
end
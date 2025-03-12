class ErrorSerializer
  def self.format_error(error)
    {
      message: error.message,
      status: error.status_code
    }
  end
end
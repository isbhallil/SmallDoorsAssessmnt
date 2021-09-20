class ApplicationService
  def self.call(*args)
    new(*args).call(*args)
  end
end

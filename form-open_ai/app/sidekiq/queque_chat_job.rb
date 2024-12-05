class QuequeChatJob
  include Sidekiq::Job

  def perform(name)
    puts "HOLA #{name}"
  end
end

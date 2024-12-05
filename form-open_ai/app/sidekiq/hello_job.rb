class HelloJob
  include Sidekiq::Job

  def perform(name)
      puts "HELLOOOOOOOOOOOOOOOOOOOOOOOOO, #{name}!"
  end
end

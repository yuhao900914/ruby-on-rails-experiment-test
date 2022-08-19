require 'amplitude-experiment'
require 'securerandom'

class ArticlesController < ApplicationController
  def index
    puts "in the article controller"
    api_key = 'server-qz35UwzJ5akieoAdIgzM4m9MIiOLXLoz'.freeze

    experiment = AmplitudeExperiment.init_local(api_key)
    experiment.start
    user = AmplitudeExperiment::User.new(user_id: 'test-user')
    variants = experiment.evaluate(user)
    variant = variants["sdk-local-evaluation-ci-test"]
    unless variant.nil?
      if variant.value == 'on'
        puts "variant.value == 'on'"
        # Flag is on
      else
        # Flag is off
        puts "variant.value == 'off'"
      end
    end
    puts variants

  end
end

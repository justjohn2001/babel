class QuestionsController < ApplicationController
  def show
    question = Question.includes(:answers, :user).find(params[:id])
    
    output = question.to_json

    question.answers.each do |answer|
      output = output + "<br>" + answer.to_json
    end
    render :html => output 

  end
end

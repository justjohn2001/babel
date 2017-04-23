class QuestionsController < ApplicationController
  def show
    question = Question.includes(:answers, :user).find(params[:id])
    
    output = question.as_json
    output["user_name"] = question.user.name

    output["answers"] = []

    question.answers.each do |answer|
      answer_hash = answer.as_json
      answer_hash["user_name"] = answer.user.name
      output["answers"].push(answer_hash)
    end
    render :json => output 

  end
end

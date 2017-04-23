class QuestionsController < ApplicationController
  def show
    question = Question.includes(:answers, :user).where("id = ? and private = ?", params[:id], false).take
    
    output = question.as_json
    if question
      output["user_name"] = question.user.name

      output["answers"] = []

      question.answers.each do |answer|
        answer_hash = answer.as_json
        answer_hash["user_name"] = answer.user.name
        output["answers"].push(answer_hash)
      end
    end
    render :json => output 

  end
end

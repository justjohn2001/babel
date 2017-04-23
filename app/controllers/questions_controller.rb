class QuestionsController < ApplicationController
  def show
    return if !get_tenant

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

  private 
    def get_tenant
      # would probably be used in other request types, so factor it out
      if !params[:key]
        render :status => 403, :text => "Missing API Key"
        return
      end
      
      tenant = Tenant.where(:api_key => params[:key]).take
      if !tenant
        render :status => 403, :text => "Bad API Key"
        return
      end
      return tenant
    end
end

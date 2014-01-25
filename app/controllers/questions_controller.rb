class QuestionsController < ApplicationController
   before_filter :authenticate_user!

  def select_subject
    $level = params[:lev]
	$semester = params[:sem]
    @subjects = Subject.where("level = :level and semester = :semester " , level: $level , semester: $semester)
   end
   
   def all_questions
     $selected_subject_id = params[:sub_id]
	 $selected_subject_name = params[:sub_name]
     @questions = Question.where("subject_id = :selected_subject_id ", selected_subject_id: $selected_subject_id).order("created_at DESC")
   end
   
   def all_answers
     $selected_question_id = params[:question_id]
	 $selected_question_array_id = params[:question_array_id]
	 
	 @question_start = Question.find($selected_question_id)
     $selected_question_asked_user = User.find(@question_start.user_id)
  
     @answers = Answer.where("question_id = :selected_question_id ", selected_question_id: $selected_question_id).order("created_at DESC")
	 #@answers = Answer.where("question_id = :selected_question_id ", selected_question_id: $selected_question_id).joins('questions ON questions.id = answers.question_id')
	 
   end
   
   def new 
     @question = Question.new
   end
   
   def create 
       @question = Question.new(params[:question].permit(:question_content, :subject_id,:user_id))

		if @question.save
		  redirect_to questions_all_questions_path(:sub_id => @question.subject_id) , notice: "Your question has been created."
		else
		   render 'new'
		end
    end
	
	def create_answer 
	  @answer = Answer.new(params[:answer].permit(:answer_content, :question_id, :user_id))
	  if @answer.answer_content.blank?
	    redirect_to questions_all_answers_path( :question_id => $selected_question_id) , alert: "The answer can't be blank"
	  else
			if @answer.save
			  redirect_to questions_all_answers_path( :question_id => $selected_question_id) , notice: "Your answer is added"
			else
			  redirect_to questions_all_answers_path( :question_id => $selected_question_id) , notice: "Something wrong"
			end
	  end
	  #render text: "hello"
	end
	
	def create_reply 
	  @reply = Reply.new(params[:reply].permit(:reply_content, :answer_id, :user_id))
	  if @reply.reply_content.blank?
	    redirect_to questions_all_answers_path( :question_id => $selected_question_id) , alert: "The reply can't be blank"
	  else
			if @reply.save
			  redirect_to questions_all_answers_path( :question_id => $selected_question_id) , notice: "Your reply is added"
			else
			  redirect_to questions_all_answers_path( :question_id => $selected_question_id) , notice: "Something wrong"
			end
	  end
	  #render text: "hello"
	end
	
	def delete_reply
		@reply = Reply.find(params[:id])
		@reply.destroy
		redirect_to questions_all_answers_path( :question_id => $selected_question_id) , notice:  "Your reply has been deleted."
    end
  
  def delete_answer
		@answer = Answer.find(params[:id])
		@answer.destroy
		redirect_to questions_all_answers_path( :question_id => $selected_question_id) , notice:  "Your answer has been deleted."
  end
  
  def delete_question
		@question = Question.find(params[:id])
		@question.destroy
		redirect_to questions_all_questions_path( :sub_id => $selected_subject_id) , notice:  "Your question has been deleted."
  end
  
   
end

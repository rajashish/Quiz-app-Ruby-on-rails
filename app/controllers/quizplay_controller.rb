class QuizplayController < ApplicationController
 before_action :authenticate_user!
 def index
 	if current_user.presentquizid==0
 		@questions = Question.all
 		@genres = Genre.all
 		@subgenres = Subgenre.all 
 	else
 		redirect_to quizplay_continue_path
 	end
 end

 def continue
 	if current_user.presentquizid==0
 		redirect_to quizplay_path
 	end
 end

 def continuepost
 	if params[:arr]["contopt"] !="Yes"
 		current_user.presentquizid = 0
 		current_user.presentquizqueid = 0
 		current_user.cqscore = 0
 		current_user.save
 		redirect_to quizplay_path
 	else
 		redirect_to quiz_play_by_ques_path(current_user.presentquizid, current_user.presentquizqueid)
 	end
 end

def show
	@subarr = current_user.subgenre_ids

	if @subarr.include?(params[:id].to_i)
		redirect_to quizplay_path, notice: 'This quiz has already been taken.'
	elsif !(Subgenre.find(params[:id]).questions.first)
		redirect_to quizplay_path, notice: 'Quiz is empty'
	else
		current_user.presentquizid=params[:id].to_i
		current_user.cqscore = 0
		current_user.presentquizqueid = Subgenre.find(params[:id]).questions.first.id
		current_user.save
		redirect_to quiz_play_by_ques_path(params[:id], current_user.presentquizqueid)
	end
end

def ques
	@subgenre = Subgenre.find(params[:id])
	if @subgenre.id == current_user.presentquizid
		@subgenques = @subgenre.questions
		@question = @subgenques.find(params[:ques])
		if @question
			@last = false
			current_user.presentquizqueid = @question.id
			current_user.save
			if @question == @subgenre.questions.last
				@last = true
			end
		else
			redirect_to quizplay_path
		end
	else
		redirect_to quizplay_path
	end
end


def next
	@subgenre = Subgenre.find(params[:id])
    @question = Question.find(params[:ques])

	@check= false
	@chkr = 1

	if (@question.check1) and (@chkr==1)
		if params[:arr]['1'].to_i == 0
			@chkr=0
		end
	end
	if (!@question.check1) and (@chkr==1)
		if params[:arr]['1'].to_i == 1
			@chkr=0
		end
	end


	if (@question.check2) and (@chkr==1)
		if params[:arr]['2'].to_i == 0
			@chkr=0
		end
	end

	if (!@question.check2) and (@chkr==1)
		if params[:arr]['2'].to_i == 1
			@chkr=0
		end
	end

	if (@question.check3) and (@chkr==1)
		if params[:arr]['3'].to_i == 0
			@chkr=0
		end
	end
	if (!@question.check3) and (@chkr==1)
		if params[:arr]['3'].to_i == 1
			@chkr=0
		end
	end


	if (@question.check4) and (@chkr==1)
		if params[:arr]['4'].to_i == 0
			@chkr=0
		end
	end
	if (!@question.check4) and (@chkr==1)
		if params[:arr]['4'].to_i == 1
			@chkr=0
		end
	end

	if @chkr==1
		@check = true
	end

	if @check
		current_user.cqscore= current_user.cqscore+10
	end
	current_user.presentquizqueid = @question.id
	current_user.save
	@subgenre = Subgenre.find(params[:id])
    @nextquestion = @subgenre.questions.where("id > ?", params[:ques]).first
    if !@nextquestion
    	@subarr = current_user.subgenre_ids
    	if @subarr.include?(params[:id].to_i)
    		redirect_to quizplay_path, notice: 'This quiz has already been taken.'
    	end
    	@quizcompleted=UserQuiz.new
    	@quizcompleted.subgenre_id=params[:id].to_i
        @quizcompleted.user_id=current_user.id
        @quizcompleted.score=current_user.cqscore
        @quizcompleted.save
        current_user.cqscore=0
        current_user.presentquizqueid=0
        current_user.presentquizid=0
        current_user.save
        redirect_to dashboard_index_path, notice: 'Quiz Completed.'

    else 
    	redirect_to quiz_play_by_ques_path(params[:id], @nextquestion.id)
    end
end
end






			



			




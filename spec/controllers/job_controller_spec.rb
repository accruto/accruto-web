require 'spec_helper'

describe JobsController do
	describe 'GET #index' do
		it "populates an array of jobs" do
			job = create(:job)
			get :index
			expect(assigns(:jobs)).to match_array [job]
		end

		it "renders the :index view" do
			get :index
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		it "assigns the requested job to @job" do
			job = create(:job)
			get :show, id: job
			expect(assigns(:job)).to eq job
		end

		it "renders the :show template" do
			job = create(:job)
			get :show, id: job
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		it "assigns a new Job to @job" do
			get :new
			expect(assigns(:job)).to be_a_new(Job)
		end

		it "renders the :new template" do
			get :new
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do
		it "assigns the requested job to @job" do
			job = create(:job)
			get :edit, id: job
			expect(assigns(:job)).to eq job
		end

		it "renders the :edit template" do
			job = create(:job)
			get :edit, id: job
			expect(response).to render_template :edit
		end
	end

	describe "POST #create" do
		context "with valid attributes" do
			it "saves the new job in the database" do
				expect {
					post :create,
					job: attributes_for(:job)
				}.to change(Job, :count).by(1)
			end

			it "redirects to the jobs index page" do
				post :create, job: attributes_for(:job)
				expect(response).to redirect_to jobs_path
			end
		end
		context "with invalid attributes" do
			it "does not save the new job in the database" do
				expect {
					post :create,
					job: attributes_for(:job, title: nil)
				}.to_not change(Job, :count)
			end

			it "re-renders the :new template" do
				post :create, job: attributes_for(:job, title: nil)
				expect(response).to render_template :new
			end
		end
	end

	describe 'PUT #update' do
		before :each do
			@job = create(:job)
		end

		it "locates the requested @job" do
			put :update, id: @job, job: attributes_for(:job)
			expect(assigns(:job)).to eq(@job)
		end

		context "with valid attributes" do
			it "changes @job's attributes" do
				put :update, id: @job, job: attributes_for(:job, title: "Secretary")
				@job.reload
				expect(@job.title).to eq("Secretary")
			end

			it "redirects to the updated job" do
				put :update, id: @job, job: attributes_for(:job)
				expect(response).to redirect_to @job
			end
		end
		context "with invalid attributes" do
			it "does not change @job's attributes" do
				put :update, id: @job, job: attributes_for(:job, title: "Secratary", external_link: nil)
				@job.reload
				expect(@job.title).to_not eq("Not this title")
			end

			it "re-renders the #edit template" do
				put :update, id: @job, job: attributes_for(:job, title: "Secratary", external_link: nil)
				expect(response).to render_template :edit
			end
		end
	end

	describe 'DELETE #destroy' do
		before :each do
			@job = create(:job)
		end

		it "deletes the job from the database" do
			expect {
				delete :destroy, id: @job
			}.to change(Job, :count).by(-1)
		end

		it "redirects to the home page" do
			delete :destroy, id: @job
			expect(response).to redirect_to jobs_path
		end
	end
end
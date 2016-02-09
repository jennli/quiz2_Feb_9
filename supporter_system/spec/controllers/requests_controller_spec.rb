require 'rails_helper'

RSpec.describe RequestsController, type: :controller do

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end


    it "instantiates a new Request object and sets it to @request" do
      get :new
      # be_a_new is called a matcher
      expect(assigns(:request)).to be_a_new(Request)
    end

  end

  describe "#create" do

    context "with valid attributes" do
      it "creates a record in the database" do
        request_count_before = Request.count
        post :create, request: {name: "some valid name",
          department: "some valid department",
          message: "this is a message"
        }
        request_count_after = Request.count
        expect(request_count_after - request_count_before).to eq(1)
      end

      # it "redirects to the request show page"
    end

    context "with invalid attributes" do
      # it "doesn't create a record in the database"
      it "renders the new template" do
        post :create, request: {name: "some valid name"
        }
        expect(response).to render_template( :new)
      end
      # it "sets a flash alert message"
    end
  end

  describe "#show" do
    before do
      #GIVEN:assuming starting from clean, create a campaign object
      @myrequest = Request.create ({name: "valid name",
        department: "marketing",
        message: "some message"})
        # when
        get :show, id: @myrequest.id
      end

      it "finds the object by its id and sets to @request variable" do
        # then
        expect(assigns(:request)).to eq(@myrequest)
      end

      it "renders the show template" do
        # then
        expect(response).to render_template(:show)
      end
    end

    describe "#edit" do
      before do
        @myrequest = Request.create ({name: "valid name",
          department: "marketing",
          message: "some message"})

        get :edit, id: @myrequest.id
      end

      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end

      it "finds the request by id and sets it to the @request instance variable" do
        expect(assigns(:request)).to eq(@myrequest)
      end
    end

    describe "#destroy" do
      before do
        @myrequest = Request.create ({name: "valid name",
          department: "marketing",
          message: "some message"})

        get :edit, id: @myrequest.id
      end

      it "removes the request from the database" do

        count_before = Request.count
        delete :destroy, id:@myrequest.id
        expect(count_before - Request.count).to eq(1)
      end

      it "redirects to the request index page" do
        delete :destroy, id:@myrequest.id
        expect(response).to redirect_to(requests_path)
      end

      it "displays a notice" do
        delete :destroy, id:@myrequest.id
        expect(flash[:notice]).to be
      end
    end
  end

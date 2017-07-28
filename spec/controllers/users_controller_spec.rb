require 'rails_helper'

describe UsersController do

  describe "get users/new " do
    it "responds 200" do
      get :new
      expect(response.status).to eq(200)
    end

    it "sends to account creation page" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "post developers" do
    context "valid params" do
      before(:each) do
        post :create, params: { user: {first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        user_type: 'dev',
        email: Faker::Internet.safe_email,
        password: Faker::Internet.password,
        website: Faker::Internet.domain_name,
        description: Faker::StarWars.quote,
        phone: Faker::PhoneNumber.cell_phone
        }
      }
      end
      it "responds 302" do
        expect(response).to have_http_status(302)
      end

      it "creates a new developer in the database" do
        expect{post :create, params: { user: {first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.domain_name,
          description: Faker::StarWars.quote,
          phone: Faker::PhoneNumber.cell_phone
          }
         }
        }.to change{User.where(user_type:'dev').count}.by(1)
      end

      it "assigns the newly created developer as @developer" do
        expect(assigns[:user]).to eq User.last
      end

      it "redirects to root" do
        expect(response).to redirect_to root_path
      end
    end
    context "invalid params" do
      before(:each) do
        post :create, params: { user: {first_name: '',
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.domain_name,
          description: Faker::StarWars.quote,
          phone: Faker::PhoneNumber.cell_phone
          }
        }
      end

      it "responds with status 422" do
        expect(response).to have_http_status(422)
      end

      it "does not create a new developer in database" do
        expect{post :create, params: { user: {first_name: '',
          last_name: Faker::Name.last_name,
          user_type: 'dev',
          email: Faker::Internet.safe_email,
          password: Faker::Internet.password,
          website: Faker::Internet.domain_name,
          description: Faker::StarWars.quote,
          phone: Faker::PhoneNumber.cell_phone
          }
         }
       }.not_to change{User.where(user_type:'dev').count}
      end

      it "assigns the unsaved developer as @user" do
        expect(assigns[:user]).to be_a_new(User)
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end
end

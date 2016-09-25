require "sinatra"
require "sinatra/content_for"
require "sequel"
require "omniauth-github"
require "warden"

DB = Sequel.sqlite("data/sciencevessel.db")
require_relative "models/user"
require_relative "models/paper"
require_relative "models/new"

use Rack::Session::Cookie, secret: ENV["SESSION_SECRET"]
use OmniAuth::Builder do
  provider :github, ENV["GITHUB_CLIENT_KEY"], ENV["GITHUB_CLIENT_SECRET"], scope: "user:email"
end
Warden::Strategies.add(:github) do
  def authenticate!
    redirect!("/auth/github")
  end
end
use Warden::Manager do |manager|
    manager.default_strategies :github
end
Warden::Manager.serialize_into_session do |user|
  user.githubid
end

Warden::Manager.serialize_from_session do |id|
  User[id]
end

get "/" do
  slim :index
end

post "/news" do
  env["warden"].authenticate!
  New.create(title: params[:title], subtitle: params[:subtitle], text: params[:text], url: params[:url], owner: env["warden"].user)
  redirect to("/")
end

get "/news/:id/delete" do
  env["warden"].authenticate!
  news = New[params[:id]]
  news.delete if env["warden"].user.admin
  redirect to("/")
end

get "/papers" do
  slim :papers
end

post "/paper" do
  env["warden"].authenticate!
  Paper.create(title: params[:title], authors: params[:authors], url: params[:url], year: params[:year], book: params[:book], tags: params[:tags], owner: env["warden"].user)
  redirect to("/papers")
end

get "/paper/:id/delete" do
  env["warden"].authenticate!
  paper = Paper[params[:id]]
  paper.delete if env["warden"].user.own?(paper)
  redirect to("/papers")
end

get "/tools" do
  slim :tools
end

get "/auth/github/callback" do
  auth = env["omniauth.auth"]
  user = User[auth["uid"]]
  if user.nil?
    user = User.new(nickname: auth["info"]["nickname"], email: auth["info"]["email"])
    user.githubid = auth["uid"]
    user.save
  end
  env["warden"].set_user(user)
  redirect to("/")
end

get "/auth/signout" do
  env["warden"].logout
  redirect to("/")
end
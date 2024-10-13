require 'sinatra'
require 'sinatra/json'
require 'sinatra/respond_with'
require 'sequel'
require 'digest'
require 'securerandom'
require 'rack/cors'


DB = Sequel.connect("mysql2://debian-sys-maint:deHHTI9x2urEIZFW@127.0.0.1/dbms_lab")

get '/status' do
  status 201 
  body json({
    status: "up"
  })
end

use Rack::Cors do
  allow do
    origins 'http://localhost:5173' # Adjust this to the origin of your frontend
    resource '*', 
      headers: :any, 
      methods: [:get, :post, :put, :delete, :options], 
      expose: ['Authorization'], # Add any headers you want to expose
      max_age: 600
  end
end

# af15436047424786fbd9

post '/users' do 
  request.body.rewind
  data = JSON.parse request.body.read
  token = data["_token"]
  if not DB[:tokens].where(token: token).first
    status 401
    return body json({
      status: 401,
      message: "Invalid email or password"
    })
  end

  dataset = DB[:users].select(:user_id, :name, :email, :score).all
  data = dataset.map do |user|
    completed_courses = DB[:courses].join(:user_course, course_id: :course_id).where(user_id: user[:user_id]).all
    courses = {
      completed_courses: completed_courses,
      courses_to_complete: DB[:courses].exclude(course_id: (1..completed_courses.count)).all
    }
    user.merge(courses)
  end
  json(data)
end

post "/register" do
  request.body.rewind
  data = JSON.parse request.body.read
  name = data["name"]
  email = data["email"]
  password = Digest::SHA256.hexdigest data["password"]

  data_id = DB[:users].insert(name: name, email: email, hashed_password: password)
  data = DB[:users].where(user_id: data_id).first
  courses = DB[:courses].all

  status 201

  body json({
    user: {
      user_id: data[:user_id],
      name: data[:name],
      email: data[:email],
      score: data[:score],
      completed_courses: {},
      courses_to_complete: courses
    }
  })
end

post "/login" do 
  request.body.rewind
  data = JSON.parse request.body.read
  email = data["email"]
  password = Digest::SHA256.hexdigest data["password"]

  data = DB[:users].where(email: email).first
  if not data or data[:hashed_password] != password
    status 401
    return body json({
      status: 401,
      message: "Invalid email or password"
    })
  end

  completed_courses = DB[:courses].join(:user_course, course_id: :course_id).where(user_id: data[:user_id]).all
  courses_to_complete = DB[:courses].exclude(course_id: (1..completed_courses.count)).all

  status 201
  body json({
    user: {
      user_id: data[:user_id],
      name: data[:name],
      email: data[:email],
      score: data[:score],
      completed_courses: completed_courses,
      courses_to_complete: courses_to_complete
    }
  })
end

post "/admin-login" do 
  request.body.rewind
  data = JSON.parse request.body.read
  email = data["email"]
  password = data["password"]

  if email != "admin@example.com" or password != "password"
    status 401
    return body json({
      status: 401,
      message: "Invalid email or password"
    })
  end

  token = SecureRandom.hex(10)
  DB[:tokens].insert(token: token)

  status 201
  body json({
    user: {
      user_id: 0,
      name: "admin",
      email: "admin@example.com"
    },
    token: token
  })  

end

post '/add/:user_id/course/:course_id' do
  params => {user_id: , course_id:}

  request.body.rewind
  data = JSON.parse request.body.read
  token = data["_token"]
  if not DB[:tokens].where(token: token).first
    status 401
    return body json({
      status: 401,
      message: "Unauthorised Access"
    })
  end

  DB[:user_course].insert(user_id: user_id, course_id: course_id)

  user = DB[:users].where(user_id: user_id).first
  course = DB[:courses].where(course_id: course_id).first

  score = user[:score] + course[:score]

  DB[:users].where(user_id: user_id).update(score: score)

  dataset = DB[:users].select(:user_id, :name, :email, :score).all
  data = dataset.map do |user|
    completed_courses = DB[:courses].join(:user_course, course_id: :course_id).where(user_id: user[:user_id]).all
    courses = {
      completed_courses: completed_courses,
      courses_to_complete: DB[:courses].exclude(course_id: (1..completed_courses.count)).all
    }
    user.merge(courses)
  end
  json(data)
end


get "/delete-user" do 
  dataset = DB[:users]
  dataset.delete
end

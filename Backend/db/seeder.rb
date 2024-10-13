require 'sequel'
require 'digest'

DB = Sequel.connect("mysql2://debian-sys-maint:deHHTI9x2urEIZFW@127.0.0.1/dbms_lab")

# inserting users
password = Digest::SHA256.hexdigest "password"
DB[:users].insert(name: "Benison", email: "benison@example.com", hashed_password: password, score: 200)

# inserting courses
DB[:courses].insert(name: "Basics of Git and Github", link: "https://www.coursera.org/learn/introduction-git-github", taught_by: "Coursera - Google", type: "video", score: 200)

DB[:courses].insert(name: "Introduction to Github Codespaces", link: "https://docs.github.com/en/codespaces/overview", taught_by: "Github", type: "docs", score: 200)

DB[:courses].insert(name: "Linux Command Line Basics", link: "https://www.freecodecamp.org/news/linux-command-line-tutorial/", taught_by: "Freecodecamp", type: "docs", score: 200)

DB[:courses].insert(name: "Introduction to HTML, CSS, and JavaScript", link: "https://www.coursera.org/learn/html-css-javascript-for-web-developers", taught_by: "Coursera", type: "video", score: 1400)

DB[:courses].insert(name: "Learn Vue 3 Step by Step", link: "https://laracasts.com/series/learn-vue-3-step-by-step", taught_by: "Laracast", type: "video", score: 1200)

DB[:courses].insert(name: "Introduction to Ruby", link: "https://courses.bigbinaryacademy.com/learn-ruby/", taught_by: "Big Binary Academy", type: "docs", score: 1200)

DB[:courses].insert(name: "Sinatra - A Ruby Minimalist Frameword", link: "https://sinatrarb.com/", taught_by: "Team Sinatra", type: "docs", score: 1500)

DB[:courses].insert(name: "Build this Project", link: "https://github.com/NoSineB/learning-ruby", taught_by: "Benison Abraham", type: "docs", score: 3000)


# inserting completed_courses
DB[:user_course].insert(user_id: 1, course_id: 1)
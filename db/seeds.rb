puts "========= Creating default user ========="
User.create!({
  first_name: "ltianosouzal",
  last_name: "ltianosouzal",
  username: "ltianosouzal",
  email: "ltianosouzal@exercise.com",
  password: "1234567890000",
  password_confirmation: "1234567890000",
  role: "Admin"
})
puts "========= User created! ========="

puts "========= Generating token for default user ========="

user = User.find_by(username: "ltianosouzal")
application_controller = ApplicationController.new
token = application_controller.encode_token(user_id: user.id)

puts "Token for #{user.username}: #{token} generated!"


puts "========= Generating Equipaments ========="

equipaments = [ "Barbell", "Body weight", "Cable", 
                "Dumbbell", "EZ Barbell", "Leverage machine", 
                "Sled machine" ,"Smith machine", "Weighted", 
                "Assisted", "Band", "Battling Rope", "Bosu ball", 
                "Hammer", "Kettlebell", "Medicine Ball", "Olympic barbell", 
                "Power Sled", "Resistance Band", "Roll", "Rollball", "Rope", 
                "Stability ball", "Stick", "Suspension", "Trap bar", 
                "Vibrate Plate", "Wheel roller" 
              ]

equipaments.each do |equipament|
  Equipament.create!(
    name: equipament
  )
end

puts "========= successful ========="

puts "========= Generating BodyParts ========="

body_parts = [  "Thighs", "Chest", "Hips", "Back", 
                "Upper Arms", "Shoulders", "Forearms", 
                "Calves", "Neck", "Cardio", "Full body", 
                "Waist", "Plyometrics", "Weightlifting", 
                "Yoga", "Stretching", "Biceps", "Triceps", 
                "Quadriceps", "Hamstrings"
              ]

body_parts.each do |body_part|
  BodyPart.create!(
    name: body_part
  )
end

puts "========= successful ========="

# puts "========= Creating default user ========="
# User.create!({
#   first_name: "userdefault",
#   last_name: "userdefault",
#   username: "userdefault",
#   email: "userdefault@exercise.com",
#   password: "1234567890000",
#   password_confirmation: "1234567890000",
#   role: "Admin"
# })
# puts "========= User created! ========="

# puts "========= Generating token for default user ========="

# user = User.find_by(username: "userdefault")
# application_controller = ApplicationController.new
# token = application_controller.encode_token(user_id: user.id)

# puts "Token for #{user.username}: #{token} generated!"

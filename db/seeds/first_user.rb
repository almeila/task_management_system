user = User.create(name: '管理人A', email: 'testmail@first.com', password: 'password')

Task.where(user_id: nil).each do |task|
  task.update_attribute(:user_id, user.id)
end
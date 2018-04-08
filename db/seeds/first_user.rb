user = User.create(name: '最初のテストユーザー', email: 'testmail@xxxxx.com')

Task.where(user_id: nil).each do |task|
  task.update_attribute(:user_id, user.id)
end
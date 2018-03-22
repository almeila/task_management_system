RSpec.describe 'タスクのValidation', type: :model do
  it '必須項目の入力チェック' do
    task = Task.new()
    task.valid?
    expect(task.errors.messages[:title]).to include('を入力してください')
    expect(task.errors.messages[:content]).to include('を入力してください')
    expect(task.errors.messages[:end_period]).to include('を入力してください')
  end

  it '最大文字数のチェック' do
    task = Task.new(title: 'x'*31, content: 'x'*501)
    task.valid?
    expect(task.errors.messages[:title]).to include('は30文字以内で入力してください')
    expect(task.errors.messages[:content]).to include('は500文字以内で入力してください')
  end  
end
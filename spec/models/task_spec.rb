RSpec.describe 'タスクのValidation', type: :model do
  
  context '必須項目の入力チェック' do
    task = Task.new()
    task.valid?

    it 'タイトル' do expect(task.errors.messages[:title]).to include('を入力してください') end  
    it '内容' do expect(task.errors.messages[:content]).to include('を入力してください') end
    it '終了日時' do expect(task.errors.messages[:end_period]).to include('を入力してください') end
  end  

  context '最大文字数のチェック' do
    task = Task.new(title: 'x'*31, content: 'x'*501)
    task.valid?

    it 'タイトル' do expect(task.errors.messages[:title]).to include('は30文字以内で入力してください') end
    it '内容' do expect(task.errors.messages[:content]).to include('は500文字以内で入力してください') end  
  end  
  
  context 'ステータス遷移ルールのチェック' do
    task = Task.new(title: 'x'*30, content: 'x'*500, end_period: Time.now.tomorrow)
    context '未着手状態' do
      it '完了に遷移できない' do expect{task.complete}.to raise_error(AASM::InvalidTransition) end
      task.work
      # TODO 成功しない、原因要調査
      xit '着手中に遷移ができる' do expect(task.status).to eq 'working' end
    end

    context '着手中状態' do
      task.complete
      it '完了に遷移ができる' do expect(task.status).to eq 'completed' end
    end

    context '完了状態' do
      it '着手中に遷移できない' do expect{task.work}.to raise_error(AASM::InvalidTransition) end
    end
  end

  context '検索' do
    FactoryGirl.create_list(:task, 20)
    Task.limit(5).each do |task|
      task.work
      task.save!
    end

    title_count = Task.ransack(title_cont: '2').result.count
    it 'タイトル' do expect(title_count).to eq 3 end

    status_count = Task.ransack(status_eq: 'working').result.count
    it 'ステータス' do expect(status_count).to eq 5 end

    end_period_count = Task.ransack(end_period_gteq: Time.current.next_year.since(1.days) , end_period_lteq: Time.current.next_year.since(6.days)).result.count
    it '予定終了期間' do expect(end_period_count).to eq 5 end
  end
end
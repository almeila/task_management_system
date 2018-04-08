require 'rails_helper'

describe 'タスク機能', type: :feature do

  before do
    visit root_path
    click_on '新規作成'

    # 必要項目を入力
    @test_title = 'テストタイトル'
    fill_in 'タイトル', with: @test_title
    fill_in '内容', with: 'テストをする。'
    select '2018', from: 'task[end_period(1i)]'
    select '11月', from: 'task[end_period(2i)]'
    select '25', from: 'task[end_period(3i)]'
    select '中', from: 'task[priority]'

    click_on '登録'
  end

  it '登録' do
    expect(current_path).to eq root_path
    expect(page).to have_content "#{@test_title}を登録しました。"
    expect(page).to have_content @test_title
  end

  it '編集' do
    edit_test_title = '編集後タイトル'
    click_on '編集'
    fill_in 'タイトル', with: edit_test_title
    click_on '登録'

    expect(current_path).to eq root_path
    expect(page).to have_content "#{edit_test_title}を更新しました。"
    expect(page).to have_content edit_test_title
  end

  it '削除' do
    expect(page).to have_content @test_title
    click_on '削除'
    expect(current_path).to eq root_path
    expect(page).to have_content '削除しました。'
    expect(page).not_to have_content @test_title
  end

  context '一覧' do
    it 'タスクが作成日順に表示されている事を確認' do
      FactoryBot.create_list(:task, 5)
      # FactoryBotで一括登録するとcreated_atが同時刻になってしまうのでランダム値で更新する
      Task.all.each do |task|
        task.update_column(:created_at, Random.rand(Time.current .. Time.current.next_year))
      end  

      visit current_path
      titles = page.all('.task_title')

      Task.order(created_at: 'DESC').limit(10).each_with_index do |task, i|
        expect(titles[i].text).to eq task.title
      end  
    end

    it '終了期間順にソートできる事を確認' do
      FactoryBot.create_list(:task, 5)
      visit current_path
      click_on '予定終了期間'
      titles = page.all('.task_title')
      
      Task.all.order(:end_period).limit(5).each_with_index do |task, i|
        expect(titles[i].text).to eq task.title
      end  
    end

    it '優先度順にソートできる事を確認' do
      FactoryBot.create_list(:task, 5)
      visit current_path
      click_on '優先度'
      titles = page.all('.task_title')
      
      Task.all.order(:priority).limit(5).each_with_index do |task, i|
        expect(titles[i].text).to eq task.title
      end  
    end

    it 'タイトル検索' do
      expected_value = 'MyString'
      FactoryBot.create_list(:task, 5)
      visit current_path
      fill_in 'タイトル', with: expected_value
      click_on '検索'
      page.all('.task_title').each do |title|
        expect(title.text).to include expected_value
      end
    end  

    it 'ステータス検索' do
      expected_value = '未着手'
      FactoryBot.create_list(:task, 5)
      visit current_path
      select expected_value, from: 'q[status_eq]'
      click_on '検索'
      page.all('.task_status').each do |state|
        expect(state.text.split.first).to eq expected_value
      end
    end  

    it '予定終了期間検索' do
      expected_value_s = Time.current.next_year.since(1.days)
      expected_value_e = Time.current.next_year.since(3.days)
      FactoryBot.create_list(:task, 5)
      visit current_path

      select expected_value_s.year, from: 'q[end_period_gteq(1i)]'
      select expected_value_s.month, from: 'q[end_period_gteq(2i)]'
      select expected_value_s.day, from: 'q[end_period_gteq(3i)]'
      select expected_value_e.year, from: 'q[end_period_lteq(1i)]'
      select expected_value_e.month, from: 'q[end_period_lteq(2i)]'
      select expected_value_e.day, from: 'q[end_period_lteq(3i)]'
      click_on '検索'
      
      page.all('.task_end_period').each do |end_period|
        expect(end_period.text).to be_within(expected_value_s).of(expected_value_e)
      end
    end  
  end

end
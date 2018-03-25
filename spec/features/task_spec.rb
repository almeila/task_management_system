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

  it '一覧ページにてタスクが作成日順に表示されている事を確認' do
    FactoryGirl.create_list(:task, 5)
    visit current_path
    titles = page.all('.task_title')

    expect(titles[0].text).to eq "MyString5" 
    expect(titles[1].text).to eq "MyString4" 
    expect(titles[2].text).to eq "MyString3" 
    expect(titles[3].text).to eq "MyString2" 
    expect(titles[4].text).to eq "MyString1" 
    
  end

  it '一覧ページにて終了期間順にソートできる事を確認' do
    FactoryGirl.create_list(:task, 5)
    visit current_path
    click_on '予定終了期間'
    titles = page.all('.task_title')
    
    Task.all.order(:end_period).limit(5).each_with_index do |task, idx|
      expect(titles[idx].text).to eq task.title
    end  
  end

end
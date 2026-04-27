require 'rails_helper'

RSpec.describe 'Tasks', type: :system do
  let!(:uncompleted_tasks) { create_list(:task, 3) }
  let!(:completed_tasks) { create_list(:task, 3, completed: true) }

  before do
    visit root_path
  end

  describe '一覧表示機能' do
    it 'タスク一覧が表示される' do
      within(:css, '.uncompleted_task_list') do
        expect(page).to have_content uncompleted_tasks[0][:title]
        expect(page).to have_content uncompleted_tasks[1][:title]
        expect(page).to have_content uncompleted_tasks[2][:title]
      end
      within(:css, '.completed_task_list') do
        expect(page).to have_content completed_tasks[0][:title]
        expect(page).to have_content completed_tasks[1][:title]
        expect(page).to have_content completed_tasks[2][:title]
      end
    end
  end

  describe '新規作成機能' do
    it '作成したタスクが表示される' do
      fill_in 'task_title', with: 'テスト用タスク'
      find('#task_title').send_keys :return
      expect(page).to have_content 'テスト用タスク'
      expect(page).to have_css('.task_card', count: 7)
    end
  end

  describe 'タスク詳細モーダル表示' do
    before do
      click_link(uncompleted_tasks[0][:title])
    end
    it 'タスク詳細モーダルが表示される' do
      within(:css, '#modal') do
        expect(page).to have_field('task_title', with: uncompleted_tasks[0][:title])
        expect(page).to have_field('task_deadline', with: uncompleted_tasks[0][:deadline].strftime('%Y-%m-%d'))
        expect(page).to have_field('task_content', with: uncompleted_tasks[0][:content])
      end
    end

    describe '編集機能' do

      context '入力値が正常な場合' do
        it 'タスクの編集ができる' do
          within(:css, '#modal') do
            fill_in 'task_title', with: 'タイトル更新（テスト）'
            click_button '更新'
          end
          within(:css, '#flash') do
            expect(page).to have_content 'タスクを更新しました'
          end
          within(:css, '#modal') do
            expect(page).to have_field('task_title', with: 'タイトル更新（テスト）')
          end
          within(:css, '.uncompleted_task_list') do
            expect(page).to have_content 'タイトル更新（テスト）'
          end
        end
      end

      context '入力値が異常な場合' do
        it 'エラーメッセージが表示される' do
          within(:css, '#modal') do
            fill_in 'task_title', with: ''
            click_button '更新'
          end
          within(:css, '#modal') do
            expect(page).to have_content 'タイトルを入力してください'
          end
        end
      end
    end

    describe '削除機能' do
      it 'タスクの削除ができる' do
        within(:css, '#modal') do
          accept_alert do
            click_link 'task-delete'
          end
        end
        within(:css, '#modal') do
          expect(page).to have_no_css('.modal')
        end
        within(:css, '#flash') do
          expect(page).to have_content 'タスクを削除しました'
        end
        within(:css, '.uncompleted_task_list') do
          expect(page).to have_no_content uncompleted_tasks[0][:title]
        end
      end
    end
  end
end

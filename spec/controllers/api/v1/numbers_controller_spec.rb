require 'rails_helper'
require 'spec_helper'


describe Api::V1::NumbersController, :type => :request do
  before do
    @base_path    = '/api/v1/projects/'
    @project_name = 'popa'
    @resource     = 'numbers.json'
    @user = 'ta_kondoh@actis.co.jp'

    @path = "#{@base_path}/#{@project_name}/#{@resource}"

    @header_params = {
      'CONTENT_TYPE'     => 'application/json',
      'ACCEPT'           => 'application/json'
    }
  end

  let(:data) do
    {
      user: @user,
      mark: {
        label: 'hoge',
        description: 'hoge desc'
      }
    }
  end

  describe 'API採番、採番' do
    it '正常' do
      number_count_before = Project.find_by(name: @project_name).numbers.count

      path = @path
      post @path, data.to_json, @header_params

      expect(response).to have_http_status 200
      expect(response.header['Content-Type']).to include 'application/json'

      number_count_after = Project.find_by(name: @project_name).numbers.count
      expect(number_count_after).to eq number_count_before+1
    end

    it 'プロジェクト名登録なし/ユーザ登録なし' do
      number_count_before = Project.find_by(name: @project_name).numbers.count

      path = "#{@base_path}/hogeeeeeeeeeeeeee/#{@resource}"
      post path, data.to_json, @header_params

      expect(response).to have_http_status 400
      expect(response.header['Content-Type']).to include 'application/json'

      number_count_after = Project.find_by(name: @project_name).numbers.count
      expect(number_count_after).to eq number_count_before
    end
  end

  describe 'API採番、採番時のマーク付与' do
    def marks
      User.find_by(email: @user).marks
    end

    def mark_count
      marks.count
    end


    it '正常、マーク未登録、labelあり、descriptionあり' do
      mark_count_before = mark_count
      
      data[:mark][:label]       = "mark#{"%04d"%rand(9999)}"
      data[:mark][:description] = "mark#{"%04d"%rand(9999)}"

      path = @path
      post path, data.to_json, @header_params

      expect(response).to have_http_status 200
      expect(response.header['Content-Type']).to include 'application/json'

      mark = Mark.find_by(label: data[:mark][:label], description: data[:mark][:description])
      expect(mark).not_to be_nil
      expect(mark.label).not_to be_nil
      expect(mark.description).not_to be_nil

      expect(mark_count).to eq mark_count_before + 1
    end

    it '正常、マーク未登録、labelあり、descriptionなし' do
      mark_count_before = mark_count

      data[:mark][:label] = "mark#{"%04d"%rand(9999)}"
      data[:mark].delete(:description)

      path = @path
      post path, data.to_json, @header_params

      expect(response).to have_http_status 200
      expect(response.header['Content-Type']).to include 'application/json'

      mark = Mark.find_by(label: data[:mark][:label])
      expect(mark).not_to be_nil
      expect(mark.description).to be_nil

      expect(mark_count).to eq mark_count_before + 1
    end

    it '正常、マーク登録済み、labelあり、descriptionあり' do
      mark_count_before = mark_count

      mark = marks.first
      data[:mark][:label]         = mark.label
      data[:mark][:description]   = mark.description

      path = @path
      post path, data.to_json, @header_params

      expect(response).to have_http_status 200
      expect(response.header['Content-Type']).to include 'application/json'

      expect(mark_count).to eq mark_count_before
    end
  end

end


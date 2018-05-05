class LabelsController < ApplicationController
  before_action :load_color_and_labels, only: [:index, :create]

  def index
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      flash[:success] = 'ラベルを作成しました。'
      redirect_to labels_path
    else
      render :index
    end
  end

  def destroy
    Label.find(params[:id]).destroy
    flash[:success] = 'ラベルを削除しました。'
    redirect_to action: 'index'
  end

  private
    def label_params
      params.require(:label).permit(:name, :color)
    end

    def load_color_and_labels
      @colors = Label.colors.keys
      @labels = Label.all
    end
end

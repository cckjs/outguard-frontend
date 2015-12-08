class FilterWordsController < ApplicationController

  layout "app"

  def index
    @filter_words = FilterWord.page params[:page]
  end

  def new
    @filter_word = FilterWord.new
  end

  def create
    @filter_word = FilterWord.new resource_params
    @filter_word.save
    respond_with @filter_word, location: -> { ok_url_or_default filter_words_path }
  end

  def edit
    @filter_word = FilterWord.find_by(id: params[:id]) if  params[:id]
    respond_with @filter_word, location: -> { ok_url_or_default filter_words_path } unless @filter_word
  end

  def update
    @filter_word = FilterWord.find_by(id: params[:id]) if params[:id]
    @filter_word.update resource_params
    respond_with @filter_word, location: -> { ok_url_or_default filter_words_path }
  end

  def destroy
    @filter_word = FilterWord.find_by(id: params[:id]) if params[:id]
    @filter_word.destroy
    respond_with @filter_word, location: -> { ok_url_or_default filter_words_path }
  end

protected
  def resource_params
    params[:filter_word].permit(:word) if params[:filter_word]
  end
end

class UrlWeightRulesController < ApplicationController
  layout "app"
  before_action :set_url_weight_rule, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @url_weight_rules = UrlWeightRule.all
    respond_with(@url_weight_rules)
  end

  def show
    respond_with(@url_weight_rule)
  end

  def new
    @url_weight_rule = UrlWeightRule.new
    respond_with(@url_weight_rule)
  end

  def edit
  end

  def create
    @url_weight_rule = UrlWeightRule.new(url_weight_rule_params)
    @url_weight_rule.save
    respond_with(@url_weight_rule)
  end

  def update
    @url_weight_rule.update(url_weight_rule_params)
    respond_with(@url_weight_rule)
  end

  def destroy
    @url_weight_rule.destroy
    respond_with(@url_weight_rule)
  end

  private
  def set_url_weight_rule
    @url_weight_rule = UrlWeightRule.find(params[:id])
  end

  def url_weight_rule_params
    params.require(:url_weight_rule).permit(:url, :weight, :source, :channel)
  end
end

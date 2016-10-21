class ContentsController < ApplicationController

  def index
    @content = Content.new(check_latency_time: Time.zone.now)
  end

  # TODO パスワード実装
  def update
    @content = Content.where(_id: content_params[:id]).first || Content.new

    @content.state              = content_params[:state]
    @content.user_id            = @current_user._id
    @content.updated_at         = Time.zone.now
    @content.latency_time       = content_params[:state] == '0' ? content_params[:latency_time] : nil
    @content.check_latency_time = Time.parse("#{content_params[:hour]}:#{content_params[:minute]}")

    unless @content.save
      render :index and return
    end

    push_to_twitter

    flash[:notice] = '更新しました'
    redirect_to contents_path and return
  end

  private

    def content_params
      params.require(:content).permit(:id, :name_ja, :state, :latency_time, :hour, :minute, :check_latency_time, :image, :event_id, :hour, :twitter)
    end

    def push_to_twitter
      return unless content_params[:twitter] == '1'

      check_latency_time = nil

      hour   = sprintf("%02d", content_params[:hour])
      minute = sprintf("%02d", content_params[:minute])
      check_latency_time = "#{hour}:#{minute}"

      twitter = TwitterController.new()
      twitter.create(@content.name_ja, @content.state, @content.latency_time, check_latency_time)
    end

end

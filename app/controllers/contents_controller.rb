class ContentsController < ApplicationController

  def index
    @content = Content.new(check_latency_time: Time.zone.now)
  end

  def update
    content_name               = nil
    content_status             = nil
    content_latency_time       = nil
    content_check_latency_time = nil

    content = Content.where(_id: content_params[:id]).first

    # TODO バリデーション実装
    # TODO ログアウト機能実装
    # TODO パスワード実装
    content.state              = content_params[:state]
    content.user_id            = @current_user._id
    content.updated_at         = Time.zone.now
    content_name               = content.name_ja
    content.latency_time       = nil

    content_status = content_params[:state].to_i

    # TODO パラメータがnilだったらエラーとする
    content.check_latency_time = Time.parse("#{content_params[:hour]}:#{content_params[:minute]}")

    hour = content_params[:hour].to_i     == 0 ? "00" : content_params[:hour]
    minute = content_params[:minute].to_i == 0 ? "00" : content_params[:minute]
    content_check_latency_time = "#{hour}:#{minute}"

    # ステータスが「通常」かどうか
    if content_params[:state] == '0'
      content.latency_time = content_params[:latency_time]
      content_latency_time = content_params[:latency_time]
    end

    content.save!

    # Twitter投稿可否判定
    if content_params[:twitter] == '1'
      twitter = TwitterController.new()
      twitter.create(content_name, content_status, content_latency_time, content_check_latency_time)
    end

    @content = Content.new(check_latency_time: Time.zone.now)
    render :index, status: :ok, location: @content and return
  end

 private

    def content_params
      params.require(:content).permit(:id, :name_ja, :state, :latency_time, :hour, :minute, :check_latency_time, :image, :event_id, :hour, :twitter)
    end
end

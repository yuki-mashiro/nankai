class ContentsController < ApplicationController

  def index
  end

  def update
    content_name               = nil
    content_status             = nil
    content_latency_time       = nil
    content_check_latency_time = nil

    content = Content.where(_id: content_params[:id]).first

    # TODO MongoDB側statusカラム名をstateに変更
    # TODO MongoDB側の時刻表示が変。ISODate("2016-10-03T11:58:37.355Z" rails でみても2016-10-03 11:58:37 UTCとなっている
    content.status             = content_params[:status]
    content_status             = content_params[:status].to_i
    content.user_id            = @current_user._id
    content.updated_at         = Time.now
    content_name               = content.name
    content.latency_time       = nil
    content.check_latency_time = nil

    # ステータスが「通常」かどうか
    if content_params[:status] == '0'
      content.latency_time = content_params[:latency_time]
      content_latency_time = content_params[:latency_time]

      # TODO パラメータがnilだったらエラーとする
      content.check_latency_time = Time.parse("#{content_params[:hour]}:#{content_params[:minute]}")

      hour = content_params[:hour].to_i     == 0 ? "00" : content_params[:hour]
      minute = content_params[:minute].to_i == 0 ? "00" : content_params[:minute]
      content_check_latency_time = "#{hour}:#{minute}"
    end

    content.save!

    # Twitter投稿可否判定
    if content_params[:twitter] == '1'
      twitter = TwitterController.new()
      twitter.create(content_name, content_status, content_latency_time, content_check_latency_time)
    end

    @content = Content.new
    render :new, status: :ok, location: @content and return
  end

 private

    def content_params
      params.require(:content).permit(:id, :name, :status, :latency_time, :hour, :minute, :check_latency_time, :image, :event_id, :hour, :twitter)
    end
end

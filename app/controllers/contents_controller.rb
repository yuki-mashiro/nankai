class ContentsController < ApplicationController

  def index
  end

  def update
    # TODO ログインユーザIDを一緒に更新する。
    # TODO 通常時以外の場合のif文を作成。
    content_name               = nil
    content_status             = nil
    content_latency_time       = nil
    content_check_latency_time = nil

    # TODO パラメータがnilだったらエラーとする
    content_check_latency_time = Time.parse("#{content_params[:hour]}:#{content_params[:minute]}")

    content = Content.where(_id: content_params[:id]).first
    # TODO MongoDB側statusカラム名をstateに変更
    content.status = content_params[:status]
    content.latency_time = content_params[:latency_time]
    content.check_latency_time = content_check_latency_time
    content.updated_at = Time.now
    content.user_id = 0

    content_name               = content.name
    content_status             = content_params[:status].to_i
    content_latency_time       = content_params[:latency_time]

    hour = content_params[:hour].to_i == 0 ? "00" : content_params[:hour]
    minute = content_params[:minute].to_i == 0 ? "00" : content_params[:minute]

    content_check_latency_time = "#{hour}:#{minute}"
    content.save!

    twitter = TwitterController.new()
    twitter.create(content_name, content_status, content_latency_time, content_check_latency_time)

    @content = Content.new
    render :new, status: :ok, location: @content and return
  end

 private

    def content_params
      params.require(:content).permit(:id, :name, :status, :latency_time, :hour, :minute, :check_latency_time, :image, :event_id, :hour)
    end
end

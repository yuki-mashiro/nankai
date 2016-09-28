class ContentsController < ApplicationController
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  # GET /contents
  # GET /contents.json
  def index
    @contents = Content.all
  end

  # GET /contents/1
  # GET /contents/1.json
  def show
  end

  # GET /contents/new
  def new
    @content = Content.new
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  # POST /contents.json
  def create
    @content = Content.new(content_params)
    respond_to do |format|
      if @content.save
        format.html { redirect_to @content, notice: 'Content was successfully created.' }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  # PATCH/PUT /contents/1.json
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

  # DELETE /contents/1
  # DELETE /contents/1.json
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to contents_url, notice: 'Content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:id, :name, :status, :latency_time, :hour, :minute, :check_latency_time, :image, :event_id, :hour)
    end
end

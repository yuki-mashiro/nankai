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
    binding.pry
    # TODO 本来はDBから取ってくるべきデータ[会場情報、ステータス、イベントID]は今回はベタ書きとする。
    # TODO ログインユーザIDを一緒に更新する。
    # TODO ストロングパラメータを解決してnameをidに変更
    # TODO ステータスをクラスで管理

    content_name               = nil
    content_status             = nil
    content_latency_time       = nil
    content_check_latency_time = nil
    status_hash = { 0 => "通常", 1 => "一時休止中", 2 => "休止", 3 => "準備中" }

    content = Content.where(_id: content_params[:name]).first
    content.status = content_params[:status]
    content.latency_time = content_params[:latency_time]
    content.check_latency_time = content_params[:check_latency_time]
    content.updated_at = Time.now
    content.user_id = 0

    content_name = content.name
    content_status = status_hash[content_params[:status].to_i]
    content_latency_time = content_params[:latency_time]
    content_check_latency_time = content_params[:check_latency_time]
    content.save!

    twitter = TwitterController.new()
    twitter.create(content_name, content_status, content_latency_time, content_check_latency_time)
    render :show, status: :ok, location: @content
    #respond_to do |format|
    #  if @content.update(content_params)
    #    format.html { redirect_to @content, notice: 'Content was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @content }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @content.errors, status: :unprocessable_entity }
    #  end
    #end
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
    redirect_to action: update
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_params
      params.require(:content).permit(:name, :status, :latency_time, :check_latency_time, :image, :event_id)
    end
end

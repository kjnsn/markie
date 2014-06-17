require 'mechanize'

class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.where(:user => current_user)
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end

  # GET /bookmarks/1/edit
  def edit
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new
    @bookmark.url = URI.split(request.url)[5].reverse.chop.reverse.gsub("http:/", "http://") # extracts path

    # skip saving if it already exists
    if Bookmark.where(:url => @bookmark.url).empty?
      @bookmark.user = current_user

      doc = Mechanize.new.get(@bookmark.url)
      @bookmark.title = doc.title
      @bookmark.title ||= @bookmark.url #if we can't get a title off the web, just use the URL

      if @bookmark.save
        redirect_to bookmarks_url, notice: 'Bookmark was successfully created.'
      else
        response.status = 400
        render :new
      end
    else
      redirect_to bookmarks_url
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to @bookmark, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { redirect_to bookmarks_url, notice: 'Bookmark not found.' }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    ::Kernel.print @bookmark
    if @bookmark
      @bookmark.destroy
      respond_to do |format|
        format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to bookmarks_url, notice: 'Bookmark not found.' }
        format.json { render json: {:error => "Bookmark not found"}, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.where(:id => params[:id], :user_id => current_user.id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:url, :title, :all)
    end
end

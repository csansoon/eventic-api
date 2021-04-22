class EventTagsController < ApplicationController
  before_action :set_event_tag, only: [:show, :update, :destroy]
  before_action :set_event_id, only: [:show_tags]

  # GET /event_tags
  def index
    @event_tags = EventTag.all

    render json: @event_tags
  end

  # GET /event_tags/1
  def show
    render json: @event_tag
  end

  #GET /eventotag/id
  #GET /eventotag/id.json
  def show_tags
    @tags_evento = EventTag.where(event_id: params[:id])
    @tags_evento.each do |tag_evento| 
      @tag_nom += Tag.where(:id => @tag_evento.tag_id).tag_name
    end
    render json: @tag_nom
  end

  # POST /event_tags
  def create
    @event_tag = EventTag.new(event_tag_params)
    
    if @event_tag.save
      render json: @event_tag, status: :created, location: @event_tag
    else
      render json: @event_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /event_tags/1
  def update
    if @event_tag.update(event_tag_params)
      render json: @event_tag
    else
      render json: @event_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /event_tags/1
  def destroy
    @event_tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_tag
      @event_tag = EventTag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_tag_params
      params.require(:event_tag).permit(:event_id, :tag_id)
    end

    def set_event_id
      @id_evento = params[:id]
    end
end

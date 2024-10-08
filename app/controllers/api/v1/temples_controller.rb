class Api::V1::TemplesController < ApiBaseController
  before_action :load_resource!, only: %i[show edit destroy update]

  def index
    @temples = Temple.all.order(created_at: :desc)
    render_listing_success_response(@temples, TempleSerializer, {}, 200,"Temples fetched successfully")
  end

  def create
    @temple = Temple.new(temple_params)
    if @temple.save
      render_show_success_response(@temple, TempleSerializer, {}, 201,"Temple created successfully")
    else
      respond_with_error(@temple.errors.full_messages.join(", "), 422)
    end
  end

  def show
    render_show_success_response(@temple, TempleSerializer, {}, 200,"Temple fetched successfully")
  end

  def edit
    render_show_success_response(@temple, TempleSerializer, {}, 200,"Temple fetched successfully")
  end

  def update
    if @temple.update(temple_params.except(:images))
      if params[:temple][:images].present?
        params[:temple][:images].values.each do |image|
          @temple.images.attach(image)
        end
      end
      render_show_success_response(@temple, TempleSerializer, {}, 200, "Temple updated successfully")
    else
      respond_with_error(@temple.errors.full_messages.join(", "), 422)
    end
  end

  def destroy
     if @temple&.destroy
      respond_success_message("temple deleted", 201)
    else
      respond_with_error(@temple.errors.full_messages.join(", "), 422)
    end
  end

  private

  def load_resource!
    @temple = Temple.find_by(id: params[:id])
    render json: { error: "Temple not found" }, status: 404 if @temple.blank? 
  end

  def temple_params
    params.require(:temple).permit(:name, :location, :description, :latitude, :longitude, :founding_date, :deity, images: [])
  end
end

class RequestsController < ApplicationController
  before_action :find_request, only: [:show, :destroy, :edit, :update, :update_status]

  def index
    # @requests = Request.all
    #
    # byebug
    if params[:search]
      @requests = Request.search(params[:search]).paginate(:page=>params[:page]).order("status DESC")
    else
      @requests = Request.all.paginate(:page=>params[:page]).order("status DESC")
    end
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params
    @request.status = "undone"

    # byebug
    if   @request.save
      redirect_to request_path(@request), notice: "post created successfully"
    else
      flash[:alert] = "Error creating this request!"
      # render :text => params.inspect
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    @request.update request_params
    redirect_to request_path(@request), notice: "Request updated successfully"
  end

  def destroy
    @request.destroy
    redirect_to requests_path, notice: "Request deleted successfully"
  end

  def update_status
    # byebug
    if @request.status.downcase == "undone"
      @request.update status: "Done!"
    else
      @request.update status: "undone"
    end
    redirect_to requests_path, notice: "Status for request #{@request.id} updated successfully"
  end

  private

  def find_request
    @request = Request.find params[:id]
  end

  def request_params
    params.require(:request).permit([:name,:email, :department, :message, :status])
  end

end

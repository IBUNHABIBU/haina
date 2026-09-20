class ReturnsController < ApplicationController
  before_action :set_return, only: %i[ show edit update destroy ]

  # GET /returns or /returns.json
  def index
    @returns = Return.all
  end

  # GET /returns/1 or /returns/1.json
  def show
  end

  # GET /returns/new
  def new
    @return = Return.new
  end

  # GET /returns/1/edit
  def edit
  end

  # POST /returns or /returns.json
  def create
    @return = Return.new(return_params)

    respond_to do |format|
      if @return.save
        format.html { redirect_to @return, notice: "Return was successfully created." }
        format.json { render :show, status: :created, location: @return }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /returns/1 or /returns/1.json
  def update
    respond_to do |format|
      if @return.update(return_params)
        format.html { redirect_to @return, notice: "Return was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @return }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @return.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /returns/1 or /returns/1.json
  def destroy
    @return.destroy!

    respond_to do |format|
      format.html { redirect_to returns_path, notice: "Return was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_return
      @return = Return.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def return_params
      params.expect(return: [ :repair_job_id, :reason, :remarks ])
    end
end

class TatizosController < ApplicationController
  before_action :set_tatizo, only: %i[ show edit update destroy ]

  # GET /tatizos or /tatizos.json
  def index
    @tatizos = Tatizo.all
  end

  # GET /tatizos/1 or /tatizos/1.json
  def show
  end

  # GET /tatizos/new
  def new
    @tatizo = Tatizo.new
  end

  # GET /tatizos/1/edit
  def edit
  end

  # POST /tatizos or /tatizos.json
  def create
    @tatizo = Tatizo.new(tatizo_params)

    respond_to do |format|
      if @tatizo.save
        format.html { redirect_to @tatizo, notice: "Tatizo was successfully created." }
        format.json { render :show, status: :created, location: @tatizo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tatizo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tatizos/1 or /tatizos/1.json
  def update
    respond_to do |format|
      if @tatizo.update(tatizo_params)
        format.html { redirect_to @tatizo, notice: "Tatizo was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tatizo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tatizo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tatizos/1 or /tatizos/1.json
  def destroy
    @tatizo.destroy!

    respond_to do |format|
      format.html { redirect_to tatizos_path, notice: "Tatizo was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tatizo
      @tatizo = Tatizo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tatizo_params
      params.expect(tatizo: [ :name ])
    end
end

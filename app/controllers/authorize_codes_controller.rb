# == Schema Information
#
# Table name: authorize_codes
#
#  id         :integer          not null, primary key
#  code       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AuthorizeCodesController < ApplicationController
  before_action :set_authorize_code, only: [:show, :edit, :update, :destroy]

  # GET /authorize_codes
  # GET /authorize_codes.json
  def index
    @authorize_codes = AuthorizeCode.all
  end

  # GET /authorize_codes/1
  # GET /authorize_codes/1.json
  def show
  end

  # GET /authorize_codes/new
  def new
    @authorize_code = AuthorizeCode.new
  end

  # GET /authorize_codes/1/edit
  def edit
  end

  # POST /authorize_codes
  # POST /authorize_codes.json
  def create
    @authorize_code = AuthorizeCode.new(authorize_code_params)

    respond_to do |format|
      if @authorize_code.save
        format.html { redirect_to @authorize_code, notice: 'Authorize code was successfully created.' }
        format.json { render :show, status: :created, location: @authorize_code }
      else
        format.html { render :new }
        format.json { render json: @authorize_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authorize_codes/1
  # PATCH/PUT /authorize_codes/1.json
  def update
    respond_to do |format|
      if @authorize_code.update(authorize_code_params)
        format.html { redirect_to @authorize_code, notice: 'Authorize code was successfully updated.' }
        format.json { render :show, status: :ok, location: @authorize_code }
      else
        format.html { render :edit }
        format.json { render json: @authorize_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authorize_codes/1
  # DELETE /authorize_codes/1.json
  def destroy
    @authorize_code.destroy
    respond_to do |format|
      format.html { redirect_to authorize_codes_url, notice: 'Authorize code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authorize_code
      @authorize_code = AuthorizeCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def authorize_code_params
      params.require(:authorize_code).permit(:code)
    end
end

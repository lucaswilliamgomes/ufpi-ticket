class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show update destroy qr_code add_credits use_credit ]

  # GET /students
  def index
    @students = Student.all

    render json: @students
  end

  # GET /students/1
  def show
    render json: @student
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      render json: @student, status: :created, location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @student.destroy!
  end

  def qr_code
    qr = RQRCode::QRCode.new(@student.registration)
    svg = qr.as_svg()

    render json: { qrcode: svg }
  end

  def add_credits
    unless params[:credits].to_i.positive?
      return render json: { error: 'Credits must be a positive integer' }, status: :unprocessable_entity 
    end

    @student.credits += params[:credits]
    @student.save
  end

  def use_credit
    unless @student.credits.positive?
      render json: { error: 'Student does not have any credits' }, status: :unprocessable_entity
      return
    end

    @student.credits -= 1
    @student.save

    render json: { message: 'Credit used', credits: @student.credits }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      puts params[:registration]
      @student = Student.find_by(registration: params[:registration])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :registration, :email)
    end
end

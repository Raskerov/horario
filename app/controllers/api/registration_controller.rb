module Api
  class RegistrationController < ActionController::Base
    def create
      @company = Company.new(company_params)
      if @company.save!
        # Create owner uesr
      end
    end


    def update
      @company = Company.find(params[:id])
      @company.update!(company_params)

      head :ok
    end

    def show
      @company = Company.find(params[:id])
      render json: @company
    end

    def destroy
      @company = Company.find(params[:id])
      @company.destroy

      head :ok
    end

    private

    def company_params
      params.permit(:name)
    end
  end
end

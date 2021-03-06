# frozen_string_literal: true

module My
  class AccountsController < My::ApplicationController
    expose(:fan) { Fan.find current_fan.id }

    def update
      if fan.update fan_params
        redirect_to my_account_path, :notice => "New details have been saved."
      else
        flash[:alert] = "Supplied details are not valid."
        render :show
      end
    end

    def destroy
      Purchase.where(:fan => current_fan).delete_all
      current_fan.destroy

      redirect_to "/", :notice => "Your account has been deleted."
    end

    private

    def fan_params
      params.fetch(:fan).permit(:email, :password, :password_confirmation)
    end
  end
end

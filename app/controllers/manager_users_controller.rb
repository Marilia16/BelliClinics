class ManagerUsersController < ApplicationController
    before_action :require_admin!
    before_action :set_user, only: %i[edit update]

    ALLOWED_ROLES = %w[doctor attendent client admin].freeze

    def index
      @users = User.all
    end

    def edit
      set_user unless defined?(@user) && @user.present?
    end

    def update
      selected = Array(params.dig(:user, :role_names)).map(&:to_s)
      selected &= ALLOWED_ROLES
      current = @user.roles.pluck(:name)
      (selected - current).each { |r| @user.add_role(r) }
      (current - selected).each { |r| @user.remove_role(r) }
      @user.add_role(:client) if @user.roles.blank?
      redirect_to manager_users_path, notice: "Roles atualizadas com sucesso."
    end

    private
    def set_user
      @user = User.find(params[:id])
    end
    
    def require_admin!
      return if current_user&.has_role?(:admin)
      redirect_to clinics_path, alert: "Acesso negado."
    end
  end
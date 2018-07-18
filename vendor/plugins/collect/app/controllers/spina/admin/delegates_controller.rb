module Spina
  module Admin
    class DelegatesController < AdminController
      before_action :set_breadcrumbs

      def index
        @delegates = Delegate.all
      end

      def new
        @delegate = Delegate.new
        add_breadcrumb I18n.t('spina.delegates.new')
      end

      def edit
        @delegate = Delegate.find(params[:id])
        add_breadcrumb "#{@delegate.first_name} #{@delegate.last_name}"
      end

      def create
        @delegate = Delegate.new(delegate_params)
        add_breadcrumb I18n.t('spina.delegates.new')
        if @delegate.save
          redirect_to admin_delegates_path
        else
          render :new
        end
      end

      def update
        @delegate = Delegate.find(params[:id])
        add_breadcrumb "#{@delegate.first_name} #{@delegate.last_name}"
        if @delegate.update(delegate_params)
          redirect_to admin_delegates_path
        else
          render :edit
        end
      end

      def destroy
        @delegate = Delegate.find(params[:id])
        @delegate.destroy
        redirect_to admin_delegates_path
      end

      private

      def set_breadcrumbs
        add_breadcrumb I18n.t('spina.website.delegates'), admin_delegates_path
      end

      def delegate_params
        params.require(:delegate).permit(:first_name, :last_name, :email_address, :url, :institution, conference_ids: [], presentation_ids: [])
      end

    end
  end
end

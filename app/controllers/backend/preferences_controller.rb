class Backend::PreferencesController < Backend::ApplicationController

  def edit
  end

  def update
    params[:preferences].each do |p|
      ActsAsTenant.current_tenant.write_preference(p[0], p[1])
    end
    respond_with([:edit, :backend,  :preferences])
  end

end

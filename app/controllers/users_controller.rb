class UsersController < ApplicationController
  def index
    @users = User.all
    @daily_record = DailyRecord.last
    template = File.read(Rails.root.join('app', 'views', 'users', 'index.html.erb'))
    liquid = Liquid::Template.parse(template)
    rendered_template = liquid.render(
        'users' => @users.as_json,
        'daily_record' => @daily_record.as_json
    )
    render html: rendered_template.html_safe
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to users_path
  end
end

class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find_by(id: params[:id])
    redirect_to repositories_path unless @repository.present?
    @issues = @repository.issues.order(id: :desc).limit(5)
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(post_params)
    if @repository.save
      redirect_to repositories_path, notice: '保存しました'
    else
      render :new
    end
  end

  def destroy
    @repository = Repository.find_by(id: params[:id])
    @repository.destroy if @repository.present?
    redirect_to repositories_path
  end

  def reload
    @repository = Repository.find_by(id: params[:id])
    redirect_to repositories_path unless @repository.present?
    csv = Github.get_issues("https://api.github.com/repos/#{@repository.owner}/#{@repository.repository}/issues")
    issues = []
    issue_strs = csv.split("\n")
    issue_strs.reverse.each do |issue_str|
      i = issue_str.split("','")
      if i.size == 3
        issues << Issue.new(
          repository_id: params[:id],
          title: i[0],
          body: i[1],
          html_url: i[2]
        )
      end
    end
    issues.each do |i|
      unless Issue.find_by(html_url: i.html_url)
        i.save
      end
    end
    redirect_to repository_path(params[:id])
  end

  private
    def post_params
      params.require(:repository).permit(:owner, :repository)
    end
end

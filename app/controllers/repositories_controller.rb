class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
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

  private
    def post_params
      params.require(:repository).permit(:owner, :repository)
    end
end

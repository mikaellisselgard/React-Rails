class ChecklistsController < ApplicationController
  def index
    @checklists = Checklist.all
  end

  def create
    @checklist = Checklist.new(checklist_params)

    if @checklist.save
      render json: @checklist
    else
      render json: @checklist.errors, status: :unprocessable_entity
    end
  end

  def update
    @checklist = Checklist.find(params[:id])
    if @checklist.update(checklist_params)
      render json: @checklist
    else
      render json: @checklist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @checklist = Checklist.find(params[:id])
    @checklist.destroy
    head :no_content
  end

  private

  def checklist_params
    params.require(:checklist).permit(:title, :done)
  end
end

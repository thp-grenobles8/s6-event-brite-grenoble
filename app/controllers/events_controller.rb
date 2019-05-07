class EventsController < ApplicationController
  before_action :authenticate_user, only: [:create, :new]
  def index
    @events = Event.all
  end
  def show
    @event = Event.find(params[:id])
    @event_end = @event.start_date + (@event.duration*60)
  end
  def new
  end
  def create
    @event = Event.new(title:params[:title],description:params[:description],duration:params[:duration],start_date:Time.now + 1,price:params[:price],location:params[:location],administrator_id:current_user.id)
    if @event.save
      flash[:success] = "Ton event a été ajouté !"
      redirect_to :root
    else
      flash[:danger] = "Ton event n'est pas valide !"
      render :new
    end
  end



  private

  def authenticate_user
    unless current_user
      flash[:danger] = "Tu dois te connecter pour créer un Event"
      redirect_to :root
    end
  end

end

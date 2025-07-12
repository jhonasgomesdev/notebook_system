class ColaboradoresController < ApplicationController
  before_action :set_colaborador, only: [ :show, :edit, :update, :destroy ]

  def index
    @colaboradores = Colaborador.all
  end

  def show
  end

  def new
    @colaborador = Colaborador.new
  end

  def create
    @colaborador = Colaborador.new(colaborador_params)
    if @colaborador.save
      redirect_to @colaborador, notice: "Colaborador criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @colaborador.update(colaborador_params)
      redirect_to @colaborador, notice: "Colaborador atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @colaborador.destroy
    redirect_to colaboradores_url, notice: "Colaborador excluído com sucesso."
  end

  private

  def set_colaborador
    @colaborador = Colaborador.find(params[:id])
  end

  def colaborador_params
    params.require(:colaborador).permit(:nome, :setor)
  end
end

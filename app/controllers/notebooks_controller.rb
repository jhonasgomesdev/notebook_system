class NotebooksController < ApplicationController
  def index
    @notebooks = Notebook.all
  end

  def show
    @notebook = Notebook.find(params[:id])
  end

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = Notebook.new(notebook_params)
    @notebook.estado = "disponível" # Define o estado padrão como 'Disponível'
    if @notebook.save
      redirect_to @notebook, notice: "Notebook cadastrado com sucesso!."
    else
      render :new, status: :unprocessable_entity
    end
  end

    def edit
    @notebook = Notebook.find(params[:id])
  end

  def update
    @notebook = Notebook.find(params[:id])
    if @notebook.update(notebook_params)
      redirect_to @notebook, notice: "Notebook atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @notebook = Notebook.find(params[:id])

    if @notebook.estado == "disponível" && !@notebook.foi_emprestado
      @notebook.destroy
      redirect_to notebooks_path, notice: "Notebook excluído com sucesso."
    else
      redirect_to @notebook, alert: "Este notebook não pode ser excluído, pois não está 'disponível' ou já foi emprestado anteriormente."
    end
  end

  private
  def notebook_params
    params.require(:notebook).permit(
      :marca, :modelo, :numero_patrimonio, :numero_serie,
      :identificacao_equipamento, :data_compra, :data_fabricacao,
      :descricao, :estado, :foi_emprestado
    )
  end
end

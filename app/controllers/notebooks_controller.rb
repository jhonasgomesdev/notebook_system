class NotebooksController < ApplicationController
  def index
    @notebooks = Notebook.includes(:emprestimos, :colaboradores)

    if params[:query].present?
      @notebooks = @notebooks.buscar(params[:query])
    end

    if params[:estado].present?
      @notebooks = @notebooks.where(estado: params[:estado])
    end

    if params[:colaborador_id].present?
      @notebooks = @notebooks.joins(:emprestimos).where(emprestimos: { colaborador_id: params[:colaborador_id] }).distinct
    end

    if params[:setor].present?
      @notebooks = @notebooks.joins(emprestimos: :colaboradores).where(colaboradores: { setor: params[:setor] }).distinct
    end

    if params[:data_compra_de].present?
      @notebooks = @notebooks.where("notebooks.data_compra >= ?", params[:data_compra_de])
    end

    if params[:data_compra_ate].present?
      @notebooks = @notebooks.where("notebooks.data_compra <= ?", params[:data_compra_ate])
    end
  end

  def show
    @notebook = Notebook.find(params[:id])
  end

  def new
    @notebook = Notebook.new
  end

  def create
    @notebook = Notebook.new(notebook_params)
    @notebook.estado = :disponivel # Define o estado padrão como 'Disponível'
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

    if @notebook.disponivel? && !@notebook.foi_emprestado
      @notebook.destroy
      redirect_to notebooks_path, notice: "Notebook excluído com sucesso."
    else
      redirect_to @notebook, alert: "Este notebook não pode ser excluído, pois não está 'disponível' ou já foi emprestado anteriormente."
    end
  end

  def baixa
    @notebook = Notebook.find(params[:id])
  end

  def realizar_baixa
    @notebook = Notebook.find(params[:id])

    if @notebook.update(notebook_params.merge(estado: "indisponivel"))
      redirect_to @notebook, notice: "Notebook baixado com sucesso!"
    else
      render :baixa, status: :unprocessable_entity
    end
  end

  private
  def notebook_params
    params.require(:notebook).permit(
      :marca, :modelo, :numero_patrimonio, :numero_serie,
      :identificacao_equipamento, :data_compra, :data_fabricacao,
      :descricao, :estado, :foi_emprestado,
      :data_baixa, :justificativa_baixa
    )
  end
end

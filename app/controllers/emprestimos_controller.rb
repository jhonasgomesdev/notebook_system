class EmprestimosController < ApplicationController
  before_action :set_notebook

  def new
    @emprestimo = @notebook.emprestimos.new
  end

  def create
    colaborador = Colaborador.find_or_create_by(nome: emprestimo_params[:nome_colaborador], setor: emprestimo_params[:setor])

    @emprestimo = @notebook.emprestimos.new(data_emprestimo: emprestimo_params[:data_emprestimo], colaborador: colaborador)

    ActiveRecord::Base.transaction do
      @emprestimo.save!
      @notebook.emprestado!
    end

    redirect_to @notebook, notice: "Empréstimo realizado com sucesso!"

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Erro ao realizar empréstimo: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  def edit
    @emprestimo = @notebook.emprestimos.find(params[:id])
  end

  def update
    @emprestimo = @notebook.emprestimos.find(params[:id])

    ActiveRecord::Base.transaction do
      @emprestimo.update!(devolucao_params)
      @notebook.disponivel!
    end

    redirect_to @notebook, notice: "Devolução registrada com sucesso!"

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Erro ao registrar devolução: #{e.message}"
    render :edit, status: :unprocessable_entity
  end

  private
  def set_notebook
    @notebook = Notebook.find(params[:notebook_id])
  end

  def emprestimo_params
    params.require(:emprestimo).permit(:data_emprestimo, :nome_colaborador, :setor)
  end

  def devolucao_params
    params.require(:emprestimo).permit(:data_devolucao, :motivo_devolucao)
  end
end

export interface LivroDTO {
    id_livro?: number,
    titulo: string,
    autor: string,
    editora: string,
    ano_publicacao: Date,
    isbn: number,
    quant_total: number,
    quant_disponivel: number,
    valor_aquisicao: number,
    status_livro_emprestado: string,
    situacao?: boolean
}
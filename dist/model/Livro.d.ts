import type { LivroDTO } from "../interface/LivroDTO.js";
declare class Livro {
    private id_livro;
    private titulo;
    private autor;
    private editora;
    private ano_publicacao;
    private isbn;
    private quant_total;
    private quant_disponivel;
    private valor_aquisicao;
    private status_livro_emprestado;
    constructor(_titulo: string, _autor: string, _editora: string, _ano_publicacao: Date, _isbn: number, _quant_total: number, _quant_disponivel: number, _valor_aquisicao: number, _status_livro_emprestado: string);
    getIdLivro(): number;
    setIdLivro(_id_livro: number): void;
    getTitulo(): string;
    setTitulo(_titulo: string): void;
    getAutor(): string;
    setAutor(_autor: string): void;
    getEditora(): string;
    setEditora(_editora: string): void;
    getAnoPublicacao(): Date;
    setAnoPublicacao(_ano_publicacao: Date): void;
    getIsbn(): number;
    setIsbn(_isbn: number): void;
    getQuantidadeTotal(): number;
    setQuantidadeTotal(_quant_total: number): void;
    getQuantidadeDisponivel(): number;
    setQuantidadeDisponivel(_quant_disponivel: number): void;
    getValorAquisicao(): number;
    setValorAquisicao(_valor_aquisicao: number): void;
    getStatus(): string;
    setStatus(_status_livro_emprestado: string): void;
    static cadastrarLivro(livro: LivroDTO): Promise<boolean>;
    static listarLivros(): Promise<Array<Livro> | null>;
}
export default Livro;
//# sourceMappingURL=Livro.d.ts.map
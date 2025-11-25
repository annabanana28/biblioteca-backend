import { DatabaseModel } from "./DatabaseModel.js";
import type { LivroDTO } from "../interface/LivroDTO.js";

const database = new DatabaseModel().pool;

class Livro {
  private id_livro: number = 0;
  private titulo: string;
  private autor: string;
  private editora: string;
  private ano_publicacao: Date;
  private isbn: number;
  private quant_total: number;
  private quant_disponivel: number;
  private valor_aquisicao: number;
  private status_livro_emprestado: string;

  constructor(
    _titulo: string,
    _autor: string,
    _editora: string,
    _ano_publicacao: Date,
    _isbn: number,
    _quant_total: number,
    _quant_disponivel: number,
    _valor_aquisicao: number,
    _status_livro_emprestado: string,
  ) {
    this.titulo = _titulo;
    this.autor = _autor;
    this.editora = _editora;
    this.ano_publicacao = _ano_publicacao;
    this.isbn = _isbn;
    this.quant_total = _quant_total;
    this.quant_disponivel = _quant_disponivel;
    this.valor_aquisicao = _valor_aquisicao;
    this.status_livro_emprestado = _status_livro_emprestado;
  }


  public getIdLivro(): number {
    return this.id_livro;
  }

  public setIdLivro(_id_livro: number): void {
    this.id_livro = _id_livro;
  }

  public getTitulo(): string {
    return this.titulo;
  }

  public setTitulo(_titulo: string): void {
    this.titulo = _titulo;
  }

  public getAutor(): string {
    return this.autor;
  }

  public setAutor(_autor: string): void {
    this.autor = _autor;
  }

  public getEditora(): string {
    return this.editora;
  }

  public setEditora(_editora: string): void {
    this.editora = _editora;
  }

  public getAnoPublicacao(): Date {
    return this.ano_publicacao;
  }

  public setAnoPublicacao(_ano_publicacao: Date): void {
    this.ano_publicacao = _ano_publicacao;
  }

  public getIsbn(): number {
    return this.isbn;
  }

  public setIsbn(_isbn: number): void {
    this.isbn = _isbn;
  }

  public getQuantidadeTotal(): number {
    return this.quant_total;
  }

  public setQuantidadeTotal(_quant_total: number): void {
    this.quant_total = _quant_total;
  }

  public getQuantidadeDisponivel(): number {
    return this.quant_disponivel;
  }

  public setQuantidadeDisponivel(_quant_disponivel: number): void {
    this.quant_disponivel = _quant_disponivel;
  }

  public getValorAquisicao(): number {
    return this.valor_aquisicao;
  }

  public setValorAquisicao(_valor_aquisicao: number): void {
    this.valor_aquisicao = _valor_aquisicao;
  }

  public getStatus(): string {
    return this.status_livro_emprestado;
  }

  public setStatus(_status_livro_emprestado: string): void {
    this.status_livro_emprestado = _status_livro_emprestado;
  }


  static async cadastrarLivro(livro: LivroDTO): Promise<boolean> {
    try {
      const queryInsertLivro = `
                INSERT INTO livro (
                    titulo, autor, editora, ano_publicacao, isbn,
                    quant_total, quant_disponivel, valor_aquisicao, status_livro_emprestado
                )
                VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)
                RETURNING id_livro;
            `;

      const respostaBD = await database.query(queryInsertLivro, [
        livro.titulo.toUpperCase(),
        livro.autor.toUpperCase(),
        livro.editora.toUpperCase(),
        livro.ano_publicacao,
        livro.isbn,
        livro.quant_total,
        livro.quant_disponivel,
        livro.valor_aquisicao,
        livro.status_livro_emprestado
      ]);

      if (respostaBD.rows.length > 0) {
        console.info(`Livro cadastrado com sucesso. ID: ${respostaBD.rows[0].id_livro}`);
        return true;
      }
      return false;

    } catch (error) {
      console.error(`Erro ao cadastrar livro: ${error}`);
      return false;
    }
  }


  static async listarLivros(): Promise<Array<Livro> | null> {
    try {
      const listaDeLivro: Array<Livro> = [];
      const querySelectLivro = `SELECT * FROM livro;`;

      const respostaBD = await database.query(querySelectLivro);

      respostaBD.rows.forEach((livroBD) => {
        const novoLivro = new Livro(
          livroBD.titulo,
          livroBD.autor,
          livroBD.editora,
          livroBD.ano_publicacao,
          livroBD.isbn,
          livroBD.quant_total,
          livroBD.quant_disponivel,
          livroBD.valor_aquisicao,
          livroBD.status_livro_emprestado
        );

        novoLivro.setIdLivro(livroBD.id_livro);

        listaDeLivro.push(novoLivro);
      });

      return listaDeLivro;

    } catch (error) {
      console.error(`Erro ao listar livros: ${error}`);
      return null;
    }
  }
}

export default Livro;

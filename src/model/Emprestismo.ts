import { DatabaseModel } from "./DatabaseModel.js";
import type { EmprestimoDTO } from "../interface/EmprestimoDTO.js";

const database = new DatabaseModel().pool;

class Emprestimo {
    private id_emprestimo: number = 0;
    private id_aluno: number;
    private id_livro: number;
    private data_emprestimo: Date;
    private data_devolucao: Date;
    private status_emprestimo: string;

    constructor(
        _id_aluno: number,
        _id_livro: number,
        _data_emprestimo: Date,
        _data_devolucao: Date,
        _status_emprestimo: string
    ) {
        this.id_aluno = _id_aluno;
        this.id_livro = _id_livro;
        this.data_emprestimo = _data_emprestimo;
        this.data_devolucao = _data_devolucao;
        this.status_emprestimo = _status_emprestimo;
    }

    public getIdEmprestimo(): number {
        return this.id_emprestimo;
    }

    public setIdEmprestimo(_id_emprestimo: number): void {
        this.id_emprestimo = _id_emprestimo;
    }

    public getIdAluno(): number {
        return this.id_aluno;
    }

    public setIdAluno(_id_aluno: number): void {
        this.id_aluno = _id_aluno;
    }

    public getIdLivro(): number {
        return this.id_livro;
    }

    public setIdLivro(_id_livro: number): void {
        this.id_livro = _id_livro;
    }

    public getDataEmprestimo(): Date {
        return this.data_emprestimo;
    }

    public setDataEmprestimo(_data_emprestimo: Date): void {
        this.data_emprestimo = _data_emprestimo;
    }

    public getDataDevolucao(): Date {
        return this.data_devolucao;
    }

    public setDataDevolucao(_data_devolucao: Date): void {
        this.data_devolucao = _data_devolucao;
    }

    public getStatusEmprestimo(): string {
        return this.status_emprestimo;
    }

    public setStatusEmprestimo(_status_emprestimo: string): void {
        this.status_emprestimo = _status_emprestimo;
    }


    static async listarEmprestimo(): Promise<any[] | null> {
        try {
            const query = `
                SELECT 
                    e.id_emprestimo,
                    e.data_emprestimo,
                    e.data_devolucao,
                    e.status_emprestimo,

                    a.id_aluno,
                    a.nome AS aluno_nome,
                    a.email AS aluno_email,

                    l.id_livro,
                    l.titulo AS livro_titulo,
                    l.autor AS livro_autor

                FROM emprestimo e
                INNER JOIN aluno a ON a.id_aluno = e.id_aluno
                INNER JOIN livro l ON l.id_livro = e.id_livro;
            `;

            const respostaBD = await database.query(query);

            const lista = respostaBD.rows.map((row) => ({
                id_emprestimo: row.id_emprestimo,
                data_emprestimo: row.data_emprestimo,
                data_devolucao: row.data_devolucao,
                status_emprestimo: row.status_emprestimo,

                aluno: {
                    id: row.id_aluno,
                    nome: row.aluno_nome,
                    email: row.aluno_email
                },

                livro: {
                    id: row.id_livro,
                    titulo: row.livro_titulo,
                    autor: row.livro_autor
                }
            }));

            return lista;

        } catch (error) {
            console.error(`Erro ao listar empréstimos: ${error}`);
            return null;
        }
    }
}

export default Emprestimo;

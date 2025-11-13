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

        static async listarEmprestimo(): Promise<Array<Emprestimo> | null> {
        try {
            let listaDeEmprestimo: Array<Emprestimo> = [];
            const querySelectEmprestimo = `SELECT * FROM emprestimo;`;
            const respostaBD = await database.query(querySelectEmprestimo);

            respostaBD.rows.forEach((emprestimoBD) => {
                const novoEmprestimo: Emprestimo = new Emprestimo(
                    emprestimoBD.id_aluno,
                    emprestimoBD.id_livro,
                    emprestimoBD.data_emprestimo,
                    emprestimoBD.data_devolucao,
                    emprestimoBD.status_emprestimo
                );

                novoEmprestimo.setIdLivro(emprestimoBD.id_emprestimo);

                listaDeEmprestimo.push(novoEmprestimo);
            });

            return listaDeEmprestimo;
        } catch (error) {
            console.error(`Erro na consulta ao banco de dados. ${error}`);


            return null;
        }
    }
}

export default Emprestimo;
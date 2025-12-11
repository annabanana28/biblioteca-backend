import { DatabaseModel } from "./DatabaseModel.js";

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

    public setIdEmprestimo(_id_emprestimo: number): void {
        this.id_emprestimo = _id_emprestimo;
    }

    // 🔥 AGORA SEGUINDO O PADRÃO: listar()
    static async listar(): Promise<any[] | null> {
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
                INNER JOIN livro l ON l.id_livro = e.id_livro
                ORDER BY e.id_emprestimo ASC;
            `;

            const respostaBD = await database.query(query);

            return respostaBD.rows;

        } catch (error) {
            console.error("Erro ao listar empréstimos:", error);
            return null;
        }
    }
}

export default Emprestimo;

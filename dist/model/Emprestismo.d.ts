declare class Emprestimo {
    private id_emprestimo;
    private id_aluno;
    private id_livro;
    private data_emprestimo;
    private data_devolucao;
    private status_emprestimo;
    constructor(_id_aluno: number, _id_livro: number, _data_emprestimo: Date, _data_devolucao: Date, _status_emprestimo: string);
    getIdEmprestimo(): number;
    setIdEmprestimo(_id_emprestimo: number): void;
    getIdAluno(): number;
    setIdAluno(_id_aluno: number): void;
    getIdLivro(): number;
    setIdLivro(_id_livro: number): void;
    getDataEmprestimo(): Date;
    setDataEmprestimo(_data_emprestimo: Date): void;
    getDataDevolucao(): Date;
    setDataDevolucao(_data_devolucao: Date): void;
    getStatusEmprestimo(): string;
    setStatusEmprestimo(_status_emprestimo: string): void;
    static listarEmprestimo(): Promise<any[] | null>;
}
export default Emprestimo;
//# sourceMappingURL=Emprestismo.d.ts.map
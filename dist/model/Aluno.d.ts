import type { AlunoDTO } from "../interface/AlunoDTO.js";
declare class Aluno {
    private id_aluno;
    private ra;
    private nome;
    private sobrenome;
    private data_nascimento;
    private endereco;
    private email;
    private celular;
    constructor(_ra: string, _nome: string, _sobrenome: string, _data_nascimento: Date, _endereco: string, _email: string, _celular: number);
    getIdAluno(): number;
    setIdAluno(_id_aluno: number): void;
    getRa(): string;
    setRa(_ra: string): void;
    getNome(): string;
    setNome(_nome: string): void;
    getSobrenome(): string;
    setSobrenome(_sobrenome: string): void;
    getDataNascimento(): Date;
    setDataNascimento(_data_nascimento: Date): void;
    getEndereco(): string;
    setEndereco(_endereco: string): void;
    getEmail(): string;
    setEmail(_email: string): void;
    getCelular(): number;
    setCelular(_celular: number): void;
    static cadastrarAluno(aluno: AlunoDTO): Promise<boolean>;
    static listarAluno(): Promise<Array<Aluno> | null>;
}
export default Aluno;
//# sourceMappingURL=Aluno.d.ts.map
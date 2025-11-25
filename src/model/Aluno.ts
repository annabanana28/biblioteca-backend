import { DatabaseModel } from "./DatabaseModel.js";
import type { AlunoDTO } from "../interface/AlunoDTO.js";

const database = new DatabaseModel().pool;

class Aluno {
    private id_aluno: number = 0;
    private ra: string;
    private nome: string;
    private sobrenome: string;
    private data_nascimento: Date;
    private endereco: string;
    private email: string;
    private celular: number;

    constructor(
        _ra: string,
        _nome: string,
        _sobrenome: string,
        _data_nascimento: Date,
        _endereco: string,
        _email: string,
        _celular: number
    ) {
        this.ra = _ra;
        this.nome = _nome;
        this.sobrenome = _sobrenome;
        this.data_nascimento = _data_nascimento;
        this.endereco = _endereco;
        this.email = _email;
        this.celular = _celular;
    }

    public getIdAluno(): number {
        return this.id_aluno;
    }

    public setIdAluno(_id_aluno: number): void {
        this.id_aluno = _id_aluno;
    }

    public getRa(): string {
        return this.ra;
    }

    public setRa(_ra: string): void {
        this.ra = _ra;
    }

    public getNome(): string {
        return this.nome;
    }

    public setNome(_nome: string): void {
        this.nome = _nome;
    }

    public getSobrenome(): string {
        return this.sobrenome;
    }

    public setSobrenome(_sobrenome: string): void {
        this.sobrenome = _sobrenome;
    }

    public getDataNascimento(): Date {
        return this.data_nascimento;
    }

    public setDataNascimento(_data_nascimento: Date): void {
        this.data_nascimento = _data_nascimento;
    }

    public getEndereco(): string {
        return this.endereco;
    }

    public setEndereco(_endereco: string): void {
        this.endereco = _endereco;
    }

    public getEmail(): string {
        return this.email;
    }

    public setEmail(_email: string): void {
        this.email = _email;
    }

    public getCelular(): number {
        return this.celular;
    }

    public setCelular(_celular: number): void {
        this.celular = _celular;
    }


    static async cadastrarAluno(aluno: AlunoDTO): Promise<boolean> {
        try {
            const queryInsertAluno = `
                INSERT INTO aluno 
                (ra, nome, sobrenome, data_nascimento, endereco, email, celular)
                VALUES ($1, $2, $3, $4, $5, $6, $7)
                RETURNING id_aluno;
            `;

            const respostaBD = await database.query(queryInsertAluno, [
                aluno.ra,
                aluno.nome.toUpperCase(),
                aluno.sobrenome.toUpperCase(),
                aluno.data_nascimento,
                aluno.endereco.toUpperCase(), //* CORRIGIDO
                aluno.email.toUpperCase(),    //* CORRIGIDO
                aluno.celular
            ]);

            if (respostaBD.rows.length > 0) {
                console.info(
                    `Aluno cadastrado. ID: ${respostaBD.rows[0].id_aluno}`
                );
                return true;
            }

            return false;

        } catch (error) {
            console.error(`Erro na consulta ao banco de dados. ${error}`);
            return false;
        }
    }


    static async listarAlunos(): Promise<Array<Aluno> | null> {
        try {
            const listaDeAluno: Array<Aluno> = [];
            const querySelectAluno = `SELECT * FROM aluno;`;
            const respostaBD = await database.query(querySelectAluno);

            respostaBD.rows.forEach((alunoBD: any) => {
                const novoAluno = new Aluno(
                    alunoBD.ra,
                    alunoBD.nome,
                    alunoBD.sobrenome,
                    alunoBD.data_nascimento,
                    alunoBD.endereco,
                    alunoBD.email,
                    alunoBD.celular
                );

                novoAluno.setIdAluno(alunoBD.id_aluno);
                listaDeAluno.push(novoAluno);
            });

            return listaDeAluno;

        } catch (error) {
            console.error(`Erro na consulta ao banco de dados. ${error}`);
            return null;
        }
    }
}

export default Aluno;

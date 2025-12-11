import { Request, Response } from "express";
import Emprestimo from "../model/Emprestismo.js";

class EmprestimoController {

    static async todos(req: Request, res: Response) {
        try {
            const listaEmprestimos = await Emprestimo.listar();
            return res.status(200).json(listaEmprestimos);
        } catch (error: any) {
            console.error("Erro ao listar empréstimos:", error?.message);
            return res.status(500).json({ erro: "Erro ao listar empréstimos" });
        }
    }

}

export default EmprestimoController;

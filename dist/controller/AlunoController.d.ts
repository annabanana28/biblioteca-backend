import Aluno from "../model/Aluno.js";
import type { Request, Response } from "express";
declare class AlunoController extends Aluno {
    static todos(req: Request, res: Response): Promise<Response>;
    static novo(req: Request, res: Response): Promise<Response>;
}
export default AlunoController;
//# sourceMappingURL=AlunoController.d.ts.map
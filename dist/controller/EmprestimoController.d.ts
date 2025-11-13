import Emprestimo from "../model/Emprestismo.js";
import type { Request, Response } from "express";
declare class EmprestimoController extends Emprestimo {
    static todos(req: Request, res: Response): Promise<Response>;
}
export default EmprestimoController;
//# sourceMappingURL=EmprestimoController.d.ts.map
export declare class DatabaseModel {
    private _config;
    private _pool;
    private _client;
    constructor();
    testeConexao(): Promise<boolean>;
    get pool(): import("pg").Pool;
}
//# sourceMappingURL=DatabaseModel.d.ts.map
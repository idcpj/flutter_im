
interface IDbStore {
    close(): void;

    saveDatabase(): Promise<void>;

    loadDatabase(): Promise<void>;


    clearDatabase(): void;

    migration(): Promise<void>;
}

// localstorage 存储数据库
class LocalStorageStore implements IDbStore {
    private userid: string;
    private saasid: string;
    private Dbcon: Connection;


    constructor(Dbcon: Connection, userid: string, saasid: string) {
        this.Dbcon = Dbcon;
        this.userid = userid;
        this.saasid = saasid;

    }

    close(): void {

    }

    async saveDatabase(): Promise<void> {
        try {
            await this.Dbcon?.sqljsManager.saveDatabase(this.database_name())
        } catch (error) {
            console.error('[数据库]保存到本地存储出错:', error);
            throw error;
        }
    }

    clearDatabase(): void {
        try {
            localStorage.removeItem(this.database_name());
        } catch (error) {
            console.error('[数据库]清除本地存储数据库出错:', error);
            throw error;
        }
    }

    database_name(): string {
        return `${this.userid}_${this.saasid}_database`;
    }


    async loadDatabase(): Promise<void> {
        await this.Dbcon.sqljsManager.loadDatabase(this.database_name())
    }

    async migration(): Promise<void> {

        this.Dbcon.migrations.push(new Recent_1711520943611())
        await this.Dbcon.runMigrations();
    }
}

class IndexDbStore implements IDbStore {
    private Dbcon: Connection;
    // private userid: string;
    // private saasid: string;
    private database: string;
    private table: string;
    private table_key: string;
    private dbConnection: IDBDatabase | null = null;

    constructor(Dbcon: Connection, userid: string, saasid: string) {
        this.Dbcon = Dbcon;
        this.database = saasid;
        this.table = userid;
        this.table_key = 'bigant_data';
    }

    async saveDatabase(): Promise<void> {
        try {
            const data = this.Dbcon?.sqljsManager.exportDatabase();
            if(data.length==0){
                return;
            }

            const db = await this.getDbConnection();
            

            return await new Promise((resolve, reject) => {
                if (!db.objectStoreNames.contains(this.table)) {
                    console.warn(`[数据库]表 ${this.table} 不存在`);
                    return resolve();
                }
                const transaction = db.transaction([this.table], 'readwrite');
                const store = transaction.objectStore(this.table);
                const saveRequest = store.put(data, this.table_key);


                saveRequest.onsuccess = () => resolve();
                saveRequest.onerror = () => reject(saveRequest.error);
            });
        } catch (error) {
            console.error('[数据库]保存到IndexDB出错:', error);
            throw error;
        }
    }
    

    async loadDatabase(): Promise<void> {
        try {
            const db = await this.getDbConnection();

            return new Promise<void>((resolve, reject) => {
                try {
                    if (!db.objectStoreNames.contains(this.table)) {
                        console.warn(`表 ${this.table} 不存在`);
                        return resolve();
                    }
                    const transaction = db.transaction([this.table], 'readonly');
                    const store = transaction.objectStore(this.table);
                    const getRequest = store.get(this.table_key);

                    getRequest.onsuccess = async () => {
                        const data = getRequest.result;
                        if (data) {
                            await this.Dbcon.sqljsManager.loadDatabase(data);
                        } else {
                            console.log("[数据库]indexdb 数据库数据不存在");
                        }
                        resolve();
                    };

                    getRequest.onerror = () => {
                        console.error('读取数据失败:', getRequest.error);
                        reject(getRequest.error);
                    };
                } catch (error) {
                    console.error('[数据库]创建事务失败:', error);
                    reject(error);
                }
            });
        } catch (error) {
            console.error('[数据库]从IndexDB加载出错:', error);
        }
    }

    clearDatabase(): void {
        try {

            indexedDB.deleteDatabase(this.database);
        } catch (error) {
            console.error('[数据库]清除出错:', error);
            throw error;
        }
    }

    close(): void {
        try {
          
            if (this.dbConnection) {
                this.dbConnection.close();
                this.dbConnection = null;
            }
        } catch (error) {
            console.error('[数据库]关闭出错:', error);
            throw error;
        }
    }

    async migration(): Promise<void> {
        console.log("进行数据库迁移");
        this.Dbcon.migrations.push(new Recent_1711520943611());
        await this.Dbcon.runMigrations();
    }

    private async getDbConnection(): Promise<IDBDatabase> {
        if (this.dbConnection) {
            return this.dbConnection;
        }

        return new Promise<IDBDatabase>((resolve, reject) => {
            // 通过设置每次版本都是时间戳,让触发
            const request = indexedDB.open(this.database, Date.now());
            // 数据库打开失败的处理函数
            request.onerror = () => {
                console.error('[数据库]打开失败:', request.error);
                reject(request.error);
            };

            // 数据库需要升级时的处理函数
            request.onupgradeneeded = (event) => {
                console.log('[数据库]个人数据库创建成功');
                const db = request.result;
                // 检查是否存在 database store，不存在则创建
                if (!db.objectStoreNames.contains(this.table)) {
                    // 创建一个新的对象存储空间
                    db.createObjectStore(this.table);
                }
            };

            // 数据库打开成功的处理函数
            request.onsuccess = () => {
                console.log("[数据库]创建成功");
                // 保存数据库连接
                this.dbConnection = request.result;
                // 返回数据库连接对象
                resolve(request.result);
            };
        });
    }
}


export class DbService {
    // 对象数据库
    private Dbcon: DataSource;
    private isClear: boolean;
    private dbStore: IDbStore;
    private saveTimer: NodeJS.Timeout | null;


    set_clear(b: boolean) {
        this.isClear = b;
    }

    async connect(userid: string, saasid: string) {

        if (!this.Dbcon?.isInitialized) {
            this.Dbcon = await createConnection({
                type: "sqljs", // 使用 sql.js 驱动
                // location: ":memory:", // 存储位置为内存中
                entities: [
                    UserModel,
                    ConfigModel,
                    DeptModel,
                    AddinModel,
                    GroupModel,
                    UserTreeModel,
                    MsgModel,
                    AttachModel,
                    GroupMsgModel,
                    GroupMemberModel,
                    RecentMsgModel,
                    FriendModel,
                    FriendGroupModel,
                    MsgReadModel,
                ],
                synchronize: true, // 用于指示在应用程序启动时自动创建数据库表结构
                logging: false,
            })
        }

        // 初始化本地存储
        this.dbStore = new IndexDbStore(this.Dbcon, userid, saasid);

        console.log("[数据库]初始化完成", this.Dbcon.isInitialized);


        if (this.isClear) {
            console.log("[数据库]清空数据库");
            this.dbStore.clearDatabase();
        } else {
            console.log("[数据库]加载数据库");
            try {
                await this.dbStore.loadDatabase()
            } catch (error: any) {
                console.error("[数据库]加载数据库失败", error)
            }
        }
        //  暂时隐藏迁移
        // await this.dbStroe.migration();

        // 开启一个定时器,每1分钟保存一次
        this.saveTimer = setInterval(async () => {
            if (this.Dbcon.isConnected) {
                await this.saveDatabase();
                console.log("[数据库]定时保存完成");
            }
        }, 60000);
        // }, 5000);


    }



    async close() {
        if (this.Dbcon?.isConnected) {
            await this.saveDatabase();

            // 需要添加一个判断,可能需要关闭时,数据库已经关闭了
            if (this.Dbcon.isConnected) {
                await this.Dbcon?.close();
            }
        }

        if (this.saveTimer) {
            clearInterval(this.saveTimer);
            this.saveTimer = null;
        }
    }

    async saveDatabase() {

        const count = await UserTreeRepository.count();
        // 小于3000 就不保存历史记录了
        if (count <= 3000) {
            await this.dbStore.saveDatabase()
        } else {
            console.log("[数据库]人数大于3000,不缓存数据");
        }

    }

    async clearDatabase() {
        this.dbStore.clearDatabase()
    }


}
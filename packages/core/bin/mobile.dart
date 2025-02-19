

export interface IClient {

    listen(name: CmdCode, callback: CMD_CALLBACK, once?: boolean): void;

    isLogin(): boolean;

    send(msg: Message): void;

    userName(): string

    userId(): string

    saasId(): string

    MsgService(): MsgService

    RecentService(): RecentMsgService

    UserService(): UserService

    AddinService(): AddinService

    FileService(): FileService

    CacheService(): CacheService

    GroupService(): GroupService

    SystemService(): SystemService

    FriendService(): FriendService

    DbService(): DbService

    ApiService(): ApiService

    EventManager(): SubscribeEvent


    close(): void


    getVersion(): string;


    getWebSocketUrl(): string
}
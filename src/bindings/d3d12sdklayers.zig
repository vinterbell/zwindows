const windows = @import("windows.zig");
const IUnknown = windows.IUnknown;
const HRESULT = windows.HRESULT;
const WINAPI = windows.WINAPI;
const GUID = windows.GUID;
const UINT = windows.UINT;
const BOOL = windows.BOOL;

pub const GPU_BASED_VALIDATION_FLAGS = packed struct(UINT) {
    DISABLE_STATE_TRACKING: bool = false,
    __unused: u31 = 0,
};

pub const IDebug = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const EnableDebugLayer = _Methods.EnableDebugLayer;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn EnableDebugLayer(self: *T) void {
                @as(*const IDebug.VTable, @ptrCast(self.__v)).EnableDebugLayer(@as(*IDebug, @ptrCast(self)));
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        EnableDebugLayer: *const fn (*IDebug) callconv(WINAPI) void,
    };
};

pub const IDebug1 = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const EnableDebugLayer = _Methods.EnableDebugLayer;
    pub const SetEnableGPUBasedValidation = _Methods.SetEnableGPUBasedValidation;
    pub const SetEnableSynchronizedCommandQueueValidation = _Methods.SetEnableSynchronizedCommandQueueValidation;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn EnableDebugLayer(self: *T) void {
                @as(*const IDebug1.VTable, @ptrCast(self.__v)).EnableDebugLayer(@as(*IDebug1, @ptrCast(self)));
            }
            pub inline fn SetEnableGPUBasedValidation(self: *T, enable: BOOL) void {
                @as(*const IDebug1.VTable, @ptrCast(self.__v))
                    .SetEnableGPUBasedValidation(@as(*IDebug1, @ptrCast(self)), enable);
            }
            pub inline fn SetEnableSynchronizedCommandQueueValidation(self: *T, enable: BOOL) void {
                @as(*const IDebug1.VTable, @ptrCast(self.__v))
                    .SetEnableSynchronizedCommandQueueValidation(@as(*IDebug1, @ptrCast(self)), enable);
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        EnableDebugLayer: *const fn (*IDebug1) callconv(WINAPI) void,
        SetEnableGPUBasedValidation: *const fn (*IDebug1, BOOL) callconv(WINAPI) void,
        SetEnableSynchronizedCommandQueueValidation: *const fn (*IDebug1, BOOL) callconv(WINAPI) void,
    };
};

pub const IDebug2 = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const SetGPUBasedValidationFlags = _Methods.SetGPUBasedValidationFlags;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn SetGPUBasedValidationFlags(self: *T, flags: GPU_BASED_VALIDATION_FLAGS) void {
                @as(*const IDebug2.VTable, @ptrCast(self.__v))
                    .SetGPUBasedValidationFlags(@as(*IDebug2, @ptrCast(self)), flags);
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        SetGPUBasedValidationFlags: *const fn (*IDebug2, GPU_BASED_VALIDATION_FLAGS) callconv(WINAPI) void,
    };
};

pub const IDebug3 = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const EnableDebugLayer = _Methods.EnableDebugLayer;

    pub const SetEnableGPUBasedValidation = _Methods.SetEnableGPUBasedValidation;
    pub const SetEnableSynchronizedCommandQueueValidation = _Methods.SetEnableSynchronizedCommandQueueValidation;
    pub const SetGPUBasedValidationFlags = _Methods.SetGPUBasedValidationFlags;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub const IDebug_Methods = IDebug.Methods(T);
            pub const QueryInterface = IDebug_Methods.QueryInterface;
            pub const AddRef = IDebug_Methods.AddRef;
            pub const Release = IDebug_Methods.Release;
            pub const EnableDebugLayer = IDebug_Methods.EnableDebugLayer;

            pub inline fn SetEnableGPUBasedValidation(self: *T, enable: BOOL) void {
                @as(*const IDebug3.VTable, @ptrCast(self.__v))
                    .SetEnableGPUBasedValidation(@as(*IDebug3, @ptrCast(self)), enable);
            }
            pub inline fn SetEnableSynchronizedCommandQueueValidation(self: *T, enable: BOOL) void {
                @as(*const IDebug3.VTable, @ptrCast(self.__v))
                    .SetEnableSynchronizedCommandQueueValidation(@as(*IDebug3, @ptrCast(self)), enable);
            }
            pub inline fn SetGPUBasedValidationFlags(self: *T, flags: GPU_BASED_VALIDATION_FLAGS) void {
                @as(*const IDebug3.VTable, @ptrCast(self.__v))
                    .SetGPUBasedValidationFlags(@as(*IDebug3, @ptrCast(self)), flags);
            }
        };
    }

    pub const VTable = extern struct {
        base: IDebug.VTable,
        SetEnableGPUBasedValidation: *const fn (*IDebug3, BOOL) callconv(WINAPI) void,
        SetEnableSynchronizedCommandQueueValidation: *const fn (*IDebug3, BOOL) callconv(WINAPI) void,
        SetGPUBasedValidationFlags: *const fn (*IDebug3, GPU_BASED_VALIDATION_FLAGS) callconv(WINAPI) void,
    };
};

pub const IDebug4 = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const EnableDebugLayer = _Methods.EnableDebugLayer;
    pub const SetEnableGPUBasedValidation = _Methods.SetEnableGPUBasedValidation;
    pub const SetEnableSynchronizedCommandQueueValidation = _Methods.SetEnableSynchronizedCommandQueueValidation;
    pub const SetGPUBasedValidationFlags = _Methods.SetGPUBasedValidationFlags;

    pub const DisableDebugLayer = _Methods.DisableDebugLayer;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub const IDebug3_Methods = IDebug3.Methods(T);
            pub const QueryInterface = IDebug3_Methods.QueryInterface;
            pub const AddRef = IDebug3_Methods.AddRef;
            pub const Release = IDebug3_Methods.Release;
            pub const EnableDebugLayer = IDebug3_Methods.EnableDebugLayer;
            pub const SetEnableGPUBasedValidation = IDebug3_Methods.SetEnableGPUBasedValidation;
            pub const SetEnableSynchronizedCommandQueueValidation = IDebug3_Methods.SetEnableSynchronizedCommandQueueValidation;
            pub const SetGPUBasedValidationFlags = IDebug3_Methods.SetGPUBasedValidationFlags;

            pub inline fn DisableDebugLayer(self: *T) void {
                @as(*const IDebug4.VTable, @ptrCast(self.__v)).DisableDebugLayer(@as(*IDebug4, @ptrCast(self)));
            }
        };
    }

    pub const VTable = extern struct {
        base: IDebug3.VTable,
        DisableDebugLayer: *const fn (*IDebug4) callconv(WINAPI) void,
    };
};

pub const IDebug5 = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const EnableDebugLayer = _Methods.EnableDebugLayer;
    pub const SetEnableGPUBasedValidation = _Methods.SetEnableGPUBasedValidation;
    pub const SetEnableSynchronizedCommandQueueValidation = _Methods.SetEnableSynchronizedCommandQueueValidation;
    pub const SetGPUBasedValidationFlags = _Methods.SetGPUBasedValidationFlags;

    pub const DisableDebugLayer = _Methods.DisableDebugLayer;
    pub const SetEnableAutoName = _Methods.SetEnableAutoName;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub const IDebug4_Methods = IDebug4.Methods(T);
            pub const QueryInterface = IDebug4_Methods.QueryInterface;
            pub const AddRef = IDebug4_Methods.AddRef;
            pub const Release = IDebug4_Methods.Release;
            pub const EnableDebugLayer = IDebug4_Methods.EnableDebugLayer;
            pub const SetEnableGPUBasedValidation = IDebug4_Methods.SetEnableGPUBasedValidation;
            pub const SetEnableSynchronizedCommandQueueValidation = IDebug4_Methods.SetEnableSynchronizedCommandQueueValidation;
            pub const SetGPUBasedValidationFlags = IDebug4_Methods.SetGPUBasedValidationFlags;

            pub inline fn DisableDebugLayer(self: *T) void {
                @as(*const IDebug4.VTable, @ptrCast(self.__v)).DisableDebugLayer(@as(*IDebug4, @ptrCast(self)));
            }

            pub inline fn SetEnableAutoName(self: *T, enable: BOOL) void {
                @as(*const IDebug5.VTable, @ptrCast(self.__v)).SetEnableAutoName(@as(*IDebug5, @ptrCast(self)), enable);
            }
        };
    }

    pub const VTable = extern struct {
        base: IDebug4.VTable,
        SetEnableAutoName: *const fn (*IDebug5, BOOL) callconv(WINAPI) void,
    };
};

pub const MESSAGE_CATEGORY = enum(UINT) {
    APPLICATION_DEFINED = 0,
    MISCELLANEOUS = 1,
    INITIALIZATION = 2,
    CLEANUP = 3,
    COMPILATION = 4,
    STATE_CREATION = 5,
    STATE_SETTING = 6,
    STATE_GETTING = 7,
    RESOURCE_MANIPULATION = 8,
    EXECUTION = 9,
    SHADER = 10,
};

pub const MESSAGE_SEVERITY = enum(UINT) {
    CORRUPTION = 0,
    ERROR = 1,
    WARNING = 2,
    INFO = 3,
    MESSAGE = 4,
};

pub const MESSAGE_ID = enum(UINT) {
    CLEARRENDERTARGETVIEW_MISMATCHINGCLEARVALUE = 820,
    COMMAND_LIST_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL = 209,
    CREATEGRAPHICSPIPELINESTATE_DEPTHSTENCILVIEW_NOT_SET = 680,
};

pub const INFO_QUEUE_FILTER_DESC = extern struct {
    NumCategories: u32,
    pCategoryList: ?[*]MESSAGE_CATEGORY,
    NumSeverities: u32,
    pSeverityList: ?[*]MESSAGE_SEVERITY,
    NumIDs: u32,
    pIDList: ?[*]MESSAGE_ID,
};

pub const INFO_QUEUE_FILTER = extern struct {
    AllowList: INFO_QUEUE_FILTER_DESC,
    DenyList: INFO_QUEUE_FILTER_DESC,
};

pub const IInfoQueue = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const AddStorageFilterEntries = _Methods.AddStorageFilterEntries;
    pub const PushStorageFilter = _Methods.PushStorageFilter;
    pub const PopStorageFilter = _Methods.PopStorageFilter;
    pub const SetMuteDebugOutput = _Methods.SetMuteDebugOutput;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            pub const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn AddStorageFilterEntries(self: *T, filter: *INFO_QUEUE_FILTER) HRESULT {
                return @as(*const IInfoQueue.VTable, @ptrCast(self.__v))
                    .AddStorageFilterEntries(@as(*IInfoQueue, @ptrCast(self)), filter);
            }
            pub inline fn PushStorageFilter(self: *T, filter: *INFO_QUEUE_FILTER) HRESULT {
                return @as(*const IInfoQueue.VTable, @ptrCast(self.__v))
                    .PushStorageFilter(@as(*IInfoQueue, @ptrCast(self)), filter);
            }
            pub inline fn PopStorageFilter(self: *T) void {
                @as(*const IInfoQueue.VTable, @ptrCast(self.__v)).PopStorageFilter(@as(*IInfoQueue, @ptrCast(self)));
            }
            pub inline fn SetMuteDebugOutput(self: *T, mute: BOOL) void {
                @as(*const IInfoQueue.VTable, @ptrCast(self.__v)).SetMuteDebugOutput(@as(*IInfoQueue, @ptrCast(self)), mute);
            }
        };
    }

    pub const VTable = extern struct {
        const T = IInfoQueue;
        base: IUnknown.VTable,
        SetMessageCountLimit: *anyopaque,
        ClearStoredMessages: *anyopaque,
        GetMessage: *anyopaque,
        GetNumMessagesAllowedByStorageFilter: *anyopaque,
        GetNumMessagesDeniedByStorageFilter: *anyopaque,
        GetNumStoredMessages: *anyopaque,
        GetNumStoredMessagesAllowedByRetrievalFilter: *anyopaque,
        GetNumMessagesDiscardedByMessageCountLimit: *anyopaque,
        GetMessageCountLimit: *anyopaque,
        AddStorageFilterEntries: *const fn (*T, *INFO_QUEUE_FILTER) callconv(WINAPI) HRESULT,
        GetStorageFilter: *anyopaque,
        ClearStorageFilter: *anyopaque,
        PushEmptyStorageFilter: *anyopaque,
        PushCopyOfStorageFilter: *anyopaque,
        PushStorageFilter: *const fn (*T, *INFO_QUEUE_FILTER) callconv(WINAPI) HRESULT,
        PopStorageFilter: *const fn (*T) callconv(WINAPI) void,
        GetStorageFilterStackSize: *anyopaque,
        AddRetrievalFilterEntries: *anyopaque,
        GetRetrievalFilter: *anyopaque,
        ClearRetrievalFilter: *anyopaque,
        PushEmptyRetrievalFilter: *anyopaque,
        PushCopyOfRetrievalFilter: *anyopaque,
        PushRetrievalFilter: *anyopaque,
        PopRetrievalFilter: *anyopaque,
        GetRetrievalFilterStackSize: *anyopaque,
        AddMessage: *anyopaque,
        AddApplicationMessage: *anyopaque,
        SetBreakOnCategory: *anyopaque,
        SetBreakOnSeverity: *anyopaque,
        SetBreakOnID: *anyopaque,
        GetBreakOnCategory: *anyopaque,
        GetBreakOnSeverity: *anyopaque,
        GetBreakOnID: *anyopaque,
        SetMuteDebugOutput: *const fn (*T, BOOL) callconv(WINAPI) void,
        GetMuteDebugOutput: *anyopaque,
    };
};

pub const IID_IDebug = GUID{
    .Data1 = 0x344488b7,
    .Data2 = 0x6846,
    .Data3 = 0x474b,
    .Data4 = .{ 0xb9, 0x89, 0xf0, 0x27, 0x44, 0x82, 0x45, 0xe0 },
};
pub const IID_IDebug1 = GUID{
    .Data1 = 0xaffaa4ca,
    .Data2 = 0x63fe,
    .Data3 = 0x4d8e,
    .Data4 = .{ 0xb8, 0xad, 0x15, 0x90, 0x00, 0xaf, 0x43, 0x04 },
};
pub const IID_IDebug2 = GUID{
    .Data1 = 0x93a665c4,
    .Data2 = 0xa3b2,
    .Data3 = 0x4e5d,
    .Data4 = .{ 0xb6, 0x92, 0xa2, 0x6a, 0xe1, 0x4e, 0x33, 0x74 },
};
pub const IID_IDebug3 = GUID{
    .Data1 = 0x5cf4e58f,
    .Data2 = 0xf671,
    .Data3 = 0x4ff0,
    .Data4 = .{ 0xa5, 0x42, 0x36, 0x86, 0xe3, 0xd1, 0x53, 0xd1 },
};
pub const IID_IDebug4 = GUID{
    .Data1 = 0x014b816e,
    .Data2 = 0x9ec5,
    .Data3 = 0x4a2f,
    .Data4 = .{ 0xa8, 0x45, 0xff, 0xbe, 0x44, 0x1c, 0xe1, 0x3a },
};
pub const IID_IDebug5 = GUID{
    .Data1 = 0x548d6b12,
    .Data2 = 0x09fa,
    .Data3 = 0x40e0,
    .Data4 = .{ 0x90, 0x69, 0x5d, 0xcd, 0x58, 0x9a, 0x52, 0xc9 },
};
pub const IID_IInfoQueue = GUID{
    .Data1 = 0x0742a90b,
    .Data2 = 0xc387,
    .Data3 = 0x483f,
    .Data4 = .{ 0xb9, 0x46, 0x30, 0xa7, 0xe4, 0xe6, 0x14, 0x58 },
};

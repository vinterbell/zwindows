const std = @import("std");
const windows = @import("windows.zig");
const IUnknown = windows.IUnknown;
const UINT = windows.UINT;
const WINAPI = windows.WINAPI;
const GUID = windows.GUID;
const HRESULT = windows.HRESULT;
const d3d = @import("d3dcommon.zig");

pub const arg_debug = "-Zi";
pub const arg_skip_validation = "-Vd";
pub const arg_skip_optimizations = "-Od";
pub const arg_pack_matrix_row_major = "-Zpr";
pub const arg_pack_matrix_column_major = "-Zpc";
pub const arg_avoid_flow_control = "-Gfa";
pub const arg_prefer_flow_control = "-Gfp";
pub const arg_enable_strictness = "-Ges";
pub const arg_enable_backwards_compatibility = "-Gec";
pub const arg_ieee_strictness = "-Gis";
pub const arg_optimization_level0 = "-O0";
pub const arg_optimization_level1 = "-O1";
pub const arg_optimization_level2 = "-O2";
pub const arg_optimization_level3 = "-O3";
pub const arg_warnings_are_errors = "-WX";
pub const arg_resources_may_alias = "-res_may_alias";
pub const arg_all_resources_bound = "-all_resources_bound";
pub const arg_debug_name_for_source = "-Zss";
pub const arg_debug_name_for_binary = "-Zsb";

pub extern "dxcompiler" fn DxcCreateInstance(
    rclsid: *const GUID,
    riid: *const GUID,
    ppv: ?*?*anyopaque,
) callconv(WINAPI) HRESULT;

pub extern "dxcompiler" fn DxcCreateInstance2(
    pMalloc: ?*IMalloc,
    rclsid: *const GUID,
    riid: *const GUID,
    ppv: ?*?*anyopaque,
) callconv(WINAPI) HRESULT;

pub const CreateInstanceProc = *const fn (
    rclsid: *const GUID,
    riid: *const GUID,
    ppv: ?*?*anyopaque,
) callconv(WINAPI) HRESULT;
pub const CreateInstance2Proc = *const fn (
    pMalloc: ?*IMalloc,
    rclsid: *const GUID,
    riid: *const GUID,
    ppv: ?*?*anyopaque,
) callconv(WINAPI) HRESULT;

pub const CreateInstanceProcName = "DxcCreateInstance";
pub const CreateInstance2ProcName = "DxcCreateInstance2";

pub const IID_IBlob = d3d.IID_IBlob;
pub const IBlob = d3d.IBlob;

pub const IID_IBlobEncoding = GUID.parse("{7241d424-2646-4191-97c0-98e96e42fc68}");
pub const IBlobEncoding = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const GetBufferPointer = _Methods.GetBufferPointer;
    pub const GetBufferSize = _Methods.GetBufferSize;
    pub const GetEncoding = _Methods.GetEncoding;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IBlob_Methods = IBlob.Methods(T);
            pub const QueryInterface = IBlob_Methods.QueryInterface;
            pub const AddRef = IBlob_Methods.AddRef;
            pub const Release = IBlob_Methods.Release;
            pub const GetBufferPointer = IBlob_Methods.GetBufferPointer;
            pub const GetBufferSize = IBlob_Methods.GetBufferSize;

            pub inline fn GetEncoding(self: *T, encoding: *windows.UINT32) HRESULT {
                return @as(*const IBlobEncoding.VTable, @ptrCast(self.__v))
                    .GetEncoding(@as(*IBlobEncoding, @ptrCast(self)), encoding);
            }
        };
    }

    pub const VTable = extern struct {
        base: IBlob.VTable,
        GetEncoding: *const fn (*IBlobEncoding, *windows.UINT32) callconv(WINAPI) HRESULT,
    };
};

pub const IID_IBlobWide = GUID.parse("{a3f84eab-0faa-497e-a39c-ee6ed60b2d84}");
pub const IBlobWide = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const GetBufferPointer = _Methods.GetBufferPointer;
    pub const GetBufferSize = _Methods.GetBufferSize;
    pub const GetEncoding = _Methods.GetEncoding;
    pub const GetStringPointer = _Methods.GetStringPointer;
    pub const GetStringLength = _Methods.GetStringLength;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IBlob_Methods = IBlobEncoding.Methods(T);
            pub const QueryInterface = IBlob_Methods.QueryInterface;
            pub const AddRef = IBlob_Methods.AddRef;
            pub const Release = IBlob_Methods.Release;
            pub const GetBufferPointer = IBlob_Methods.GetBufferPointer;
            pub const GetBufferSize = IBlob_Methods.GetBufferSize;
            pub const GetEncoding = IBlob_Methods.GetEncoding;

            pub inline fn GetStringPointer(self: *T) windows.LPCWSTR {
                return @as(*const IBlobWide.VTable, @ptrCast(self.__v))
                    .GetStringPointer(@as(*IBlobWide, @ptrCast(self)));
            }

            pub inline fn GetStringLength(self: *T) windows.SIZE_T {
                return @as(*const IBlobWide.VTable, @ptrCast(self.__v))
                    .GetStringLength(@as(*IBlobWide, @ptrCast(self)));
            }

            pub inline fn GetString(self: *T) [:0]const u16 {
                const str_ptr = self.GetStringPointer();
                const str_len = self.GetStringLength();
                return (str_ptr)[0..@intCast(str_len)];
            }
        };
    }

    pub const VTable = extern struct {
        base: IBlobEncoding.VTable,
        GetStringPointer: *const fn (*IBlobWide) callconv(WINAPI) windows.LPCWSTR,
        GetStringLength: *const fn (*IBlobWide) callconv(WINAPI) windows.SIZE_T,
    };
};

pub const IID_IBlobUtf8 = GUID.parse("{3da636c9-ba71-4024-a301-30cbf125305b}");
pub const IBlobUtf8 = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;
    pub const GetBufferPointer = _Methods.GetBufferPointer;
    pub const GetBufferSize = _Methods.GetBufferSize;
    pub const GetEncoding = _Methods.GetEncoding;
    pub const GetStringPointer = _Methods.GetStringPointer;
    pub const GetStringLength = _Methods.GetStringLength;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IBlob_Methods = IBlobEncoding.Methods(T);
            pub const QueryInterface = IBlob_Methods.QueryInterface;
            pub const AddRef = IBlob_Methods.AddRef;
            pub const Release = IBlob_Methods.Release;
            pub const GetBufferPointer = IBlob_Methods.GetBufferPointer;
            pub const GetBufferSize = IBlob_Methods.GetBufferSize;
            pub const GetEncoding = IBlob_Methods.GetEncoding;

            pub inline fn GetStringPointer(self: *T) windows.LPCSTR {
                return @as(*const IBlobUtf8.VTable, @ptrCast(self.__v))
                    .GetStringPointer(@as(*IBlobUtf8, @ptrCast(self)));
            }

            pub inline fn GetStringLength(self: *T) windows.SIZE_T {
                return @as(*const IBlobUtf8.VTable, @ptrCast(self.__v))
                    .GetStringLength(@as(*IBlobUtf8, @ptrCast(self)));
            }

            pub inline fn GetString(self: *T) [:0]const u8 {
                const str_ptr = self.GetStringPointer();
                const str_len = self.GetStringLength();
                return (str_ptr)[0..@intCast(str_len)];
            }
        };
    }

    pub const VTable = extern struct {
        base: IBlobEncoding.VTable,
        GetStringPointer: *const fn (*IBlobUtf8) callconv(WINAPI) windows.LPCSTR,
        GetStringLength: *const fn (*IBlobUtf8) callconv(WINAPI) windows.SIZE_T,
    };
};

pub const IID_IIncludeHandler = GUID.parse("{7f61fc7d-950d-467f-b3e3-3c02fb49187c}");
pub const IIncludeHandler = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const LoadSource = _Methods.LoadSource;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn LoadSource(self: *T, filename: windows.LPCWSTR, include_source: ?*?*IBlob) HRESULT {
                return @as(*const IIncludeHandler.VTable, @ptrCast(self.__v))
                    .LoadSource(@as(*IIncludeHandler, @ptrCast(self)), filename, include_source);
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        LoadSource: *const fn (*IIncludeHandler, windows.LPCWSTR, ?*?*IBlob) callconv(WINAPI) HRESULT,
    };
};

pub const Buffer = extern struct {
    Ptr: windows.LPCVOID,
    Size: windows.SIZE_T,
    Encoding: windows.UINT,
};
pub const Text = Buffer;

pub const Define = extern struct {
    Name: windows.LPCWSTR,
    Value: ?windows.LPCWSTR,
};

pub const IID_IOperationResult = GUID.parse("{cedb484a-d4e9-445a-b991-ca21ca157dc2}");
pub const IOperationResult = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const GetStatus = _Methods.GetStatus;
    pub const GetResult = _Methods.GetResult;
    pub const GetErrorBuffer = _Methods.GetErrorBuffer;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn GetStatus(self: *T, pStatus: *HRESULT) HRESULT {
                return @as(*const IOperationResult.VTable, @ptrCast(self.__v))
                    .GetStatus(@as(*IOperationResult, @ptrCast(self)), pStatus);
            }

            pub inline fn GetResult(self: *T, ppResult: **IBlob) HRESULT {
                return @as(*const IOperationResult.VTable, @ptrCast(self.__v))
                    .GetResult(@as(*IOperationResult, @ptrCast(self)), ppResult);
            }

            pub inline fn GetErrorBuffer(self: *T, ppErrors: **IBlobEncoding) HRESULT {
                return @as(*const IOperationResult.VTable, @ptrCast(self.__v))
                    .GetErrorBuffer(@as(*IOperationResult, @ptrCast(self)), ppErrors);
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetStatus: *const fn (*IOperationResult, pStatus: *HRESULT) callconv(WINAPI) HRESULT,
        GetResult: *const fn (*IOperationResult, ppResult: **IBlob) callconv(WINAPI) HRESULT,
        GetErrorBuffer: *const fn (*IOperationResult, ppErrors: **IBlobEncoding) callconv(WINAPI) HRESULT,
    };
};

pub const IID_ICompilerArgs = GUID.parse("{73effe2a-70dc-45f8-9690-eff64c02429d}");
pub const ICompilerArgs = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const GetArguments = _Methods.GetArguments;
    pub const GetCount = _Methods.GetCount;
    pub const AddArguments = _Methods.AddArguments;
    pub const AddArgumentsUTF8 = _Methods.AddArgumentsUTF8;
    pub const AddDefines = _Methods.AddDefines;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn GetArguments(self: *T) ?[*:null]const ?windows.LPCWSTR {
                return @as(*const ICompilerArgs.VTable, @ptrCast(self.__v))
                    .GetArguments(@as(*ICompilerArgs, @ptrCast(self)));
            }

            pub inline fn GetCount(self: *T) windows.UINT32 {
                return @as(*const ICompilerArgs.VTable, @ptrCast(self.__v))
                    .GetCount(@as(*ICompilerArgs, @ptrCast(self)));
            }

            pub inline fn AddArguments(
                self: *T,
                args: ?[*]const ?windows.LPCWSTR,
                count: windows.UINT32,
            ) HRESULT {
                return @as(*const ICompilerArgs.VTable, @ptrCast(self.__v))
                    .AddArguments(@as(*ICompilerArgs, @ptrCast(self)), args, count);
            }

            pub inline fn AddArgumentsUTF8(
                self: *T,
                args: ?[*]const ?windows.LPCSTR,
                count: windows.UINT32,
            ) HRESULT {
                return @as(*const ICompilerArgs.VTable, @ptrCast(self.__v))
                    .AddArgumentsUTF8(@as(*ICompilerArgs, @ptrCast(self)), args, count);
            }

            pub inline fn AddDefines(self: *T, defines: ?[*]const Define, count: windows.UINT32) HRESULT {
                return @as(*const ICompilerArgs.VTable, @ptrCast(self.__v))
                    .AddDefines(@as(*ICompilerArgs, @ptrCast(self)), defines, count);
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetArguments: *const fn (*ICompilerArgs) callconv(WINAPI) [*:null]const ?windows.LPCWSTR,
        GetCount: *const fn (*ICompilerArgs) callconv(WINAPI) windows.UINT32,
        AddArguments: *const fn (*ICompilerArgs, ?[*]const ?windows.LPCWSTR, windows.UINT32) callconv(WINAPI) HRESULT,
        AddArgumentsUTF8: *const fn (*ICompilerArgs, ?[*]const ?windows.LPCSTR, windows.UINT32) callconv(WINAPI) HRESULT,
        AddDefines: *const fn (*ICompilerArgs, ?[*]const Define, windows.UINT32) callconv(WINAPI) HRESULT,
    };
};

pub const IID_IUtils = GUID.parse("{4605c4cb-2019-492a-ada4-65f20bb7d67f}");
pub const IUtils = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn CreateBlobFromBlob(
                self: *T,
                pBlob: ?*const IBlob,
                offset: windows.UINT32,
                length: windows.UINT32,
                ppResult: ?*?*IBlob,
            ) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .CreateBlobFromBlob(@as(*IUtils, @ptrCast(self)), pBlob, offset, length, ppResult);
            }

            pub inline fn CreateBlobFromPinned(
                self: *T,
                pData: windows.LPCVOID,
                size: windows.SIZE_T,
                codePage: windows.UINT32,
                ppBlobEncoding: ?*?*IBlobEncoding,
            ) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .CreateBlobFromPinned(@as(*IUtils, @ptrCast(self)), pData, size, codePage, ppBlobEncoding);
            }

            pub inline fn MoveToBlob(
                self: *T,
                pData: windows.LPCVOID,
                pIMalloc: ?*IMalloc,
                size: windows.UINT32,
                codePage: windows.UINT32,
                ppBlobEncoding: ?*?*IBlobEncoding,
            ) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .MoveToBlob(@as(*IUtils, @ptrCast(self)), pData, pIMalloc, size, codePage, ppBlobEncoding);
            }

            pub inline fn CreateBlob(
                self: *T,
                pData: windows.LPCVOID,
                size: windows.SIZE_T,
                codePage: windows.UINT32,
                ppBlobEncoding: ?*?*IBlobEncoding,
            ) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .CreateBlob(@as(*IUtils, @ptrCast(self)), pData, size, codePage, ppBlobEncoding);
            }

            pub inline fn LoadFile(
                self: *T,
                filename: windows.LPCWSTR,
                pCodePage: ?*windows.UINT32,
                ppBlob: ?*?*IBlob,
            ) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .LoadFile(@as(*IUtils, @ptrCast(self)), filename, pCodePage, ppBlob);
            }

            pub inline fn CreateDefaultIncludeHandler(self: *T, ppIncludeHandler: ?*?*IIncludeHandler) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .CreateDefaultIncludeHandler(@as(*IUtils, @ptrCast(self)), ppIncludeHandler);
            }

            pub inline fn GetBlobAsUtf8(self: *T, pBlob: ?*const IBlob, ppBlobUtf8: ?*?*IBlobUtf8) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .GetBlobAsUtf8(@as(*IUtils, @ptrCast(self)), pBlob, ppBlobUtf8);
            }

            pub inline fn GetBlobAsWide(self: *T, pBlob: ?*const IBlob, ppBlobWide: ?*?*IBlobWide) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .GetBlobAsWide(@as(*IUtils, @ptrCast(self)), pBlob, ppBlobWide);
            }

            pub inline fn BuildArguments(
                self: *T,
                pSourceName: ?windows.LPCWSTR,
                pEntryPoint: windows.LPCWSTR,
                pTargetProfile: windows.LPCWSTR,
                pArguments: ?[*]const ?windows.LPCWSTR,
                argCount: windows.UINT32,
                pDefines: ?[*]const Define,
                defineCount: windows.UINT32,
                ppArgs: ?*?*ICompilerArgs,
            ) HRESULT {
                return @as(*const IUtils.VTable, @ptrCast(self.__v))
                    .BuildArguments(
                    @as(*IUtils, @ptrCast(self)),
                    pSourceName,
                    pEntryPoint,
                    pTargetProfile,
                    pArguments,
                    argCount,
                    pDefines,
                    defineCount,
                    ppArgs,
                );
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        CreateBlobFromBlob: *const fn (
            *IUtils,
            ?*const IBlob,
            offset: windows.UINT32,
            length: windows.UINT32,
            ppResult: ?*?*IBlob,
        ) callconv(WINAPI) HRESULT,
        CreateBlobFromPinned: *const fn (
            *IUtils,
            pData: windows.LPCVOID,
            size: windows.SIZE_T,
            codePage: windows.UINT32,
            ppBlobEncoding: ?*?*IBlobEncoding,
        ) callconv(WINAPI) HRESULT,
        MoveToBlob: *const fn (
            *IUtils,
            pData: windows.LPCVOID,
            pIMalloc: ?*IMalloc,
            size: windows.UINT32,
            codePage: windows.UINT32,
            ppBlobEncoding: ?*?*IBlobEncoding,
        ) callconv(WINAPI) HRESULT,
        CreateBlob: *const fn (
            *IUtils,
            pData: windows.LPCVOID,
            size: windows.SIZE_T,
            codePage: windows.UINT32,
            ppBlobEncoding: ?*?*IBlobEncoding,
        ) callconv(WINAPI) HRESULT,
        LoadFile: *const fn (
            *IUtils,
            filename: windows.LPCWSTR,
            pCodePage: ?*windows.UINT32,
            ppBlob: ?*?*IBlob,
        ) callconv(WINAPI) HRESULT,
        CreateReadonlyStreamFromBlob: *anyopaque,
        // CreateReadOnlyStreamFromBlob: *const fn (
        //     *IUtils,
        //     pBlob: ?*const IBlob,
        //     ppStream: ?*?*IStream,
        // ) callconv(WINAPI) HRESULT,
        CreateDefaultIncludeHandler: *const fn (
            *IUtils,
            ppIncludeHandler: ?*?*IIncludeHandler,
        ) callconv(WINAPI) HRESULT,
        GetBlobAsUtf8: *const fn (
            *IUtils,
            pBlob: ?*const IBlob,
            ppBlobUtf8: ?*?*IBlobUtf8,
        ) callconv(WINAPI) HRESULT,
        GetBlobAsWide: *const fn (
            *IUtils,
            pBlob: ?*const IBlob,
            ppBlobWide: ?*?*IBlobWide,
        ) callconv(WINAPI) HRESULT,
        GetDxilContainerPart: *anyopaque,
        CreateReflection: *anyopaque,
        BuildArguments: *const fn (
            *IUtils,
            pSourceName: ?windows.LPCWSTR,
            pEntryPoint: windows.LPCWSTR,
            pTargetProfile: windows.LPCWSTR,
            pArguments: ?[*]const ?windows.LPCWSTR,
            argCount: windows.UINT32,
            pDefines: ?[*]const Define,
            defineCount: windows.UINT32,
            ppArgs: ?*?*ICompilerArgs,
        ) callconv(WINAPI) HRESULT,
        GetPDBContents: *anyopaque,
    };
};

pub const OUT_KIND = enum(u32) {
    /// No output
    DXC_OUT_NONE = 0,
    /// IDxcBlob - Shader or library object.
    DXC_OUT_OBJECT = 1,
    /// IDxcBlobUtf8 or IDxcBlobWide.
    DXC_OUT_ERRORS = 2,
    /// IDxcBlob.
    DXC_OUT_PDB = 3,
    /// IDxcBlob - DxcShaderHash of shader or shader
    /// with source info (-Zsb/-Zss).
    DXC_OUT_SHADER_HASH = 4,

    /// IDxcBlobUtf8 or IDxcBlobWide - from Disassemble.
    DXC_OUT_DISASSEMBLY = 5,
    /// IDxcBlobUtf8 or IDxcBlobWide - from Preprocessor or Rewriter.
    DXC_OUT_HLSL = 6,
    /// IDxcBlobUtf8 or IDxcBlobWide - other text, such as
    /// -ast-dump or -Odump.
    DXC_OUT_TEXT = 7,

    /// IDxcBlob - RDAT part with reflection data.
    DXC_OUT_REFLECTION = 8,
    /// IDxcBlob - Serialized root signature output.
    DXC_OUT_ROOT_SIGNATURE = 9,
    /// IDxcExtraOutputs - Extra outputs.
    DXC_OUT_EXTRA_OUTPUTS = 10,
    /// IDxcBlobUtf8 or IDxcBlobWide - text directed at stdout.
    DXC_OUT_REMARKS = 11,
    /// IDxcBlobUtf8 or IDxcBlobWide - text directed at stdout.
    DXC_OUT_TIME_REPORT = 12,
    /// IDxcBlobUtf8 or IDxcBlobWide - text directed at stdout.
    DXC_OUT_TIME_TRACE = 13,
};

pub const IID_IResult = GUID.parse("{58346cda-dde7-4497-9461-6f87af5e0659}");
pub const IResult = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const GetStatus = _Methods.GetStatus;
    pub const GetResult = _Methods.GetResult;
    pub const GetErrorBuffer = _Methods.GetErrorBuffer;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IOperationResult_Methods = IOperationResult.Methods(T);
            pub const QueryInterface = IOperationResult_Methods.QueryInterface;
            pub const AddRef = IOperationResult_Methods.AddRef;
            pub const Release = IOperationResult_Methods.Release;
            pub const GetStatus = IOperationResult_Methods.GetStatus;
            pub const GetResult = IOperationResult_Methods.GetResult;
            pub const GetErrorBuffer = IOperationResult_Methods.GetErrorBuffer;

            pub inline fn HasOutput(self: *T, kind: OUT_KIND) windows.BOOL {
                return @as(*const IResult.VTable, @ptrCast(self.__v))
                    .HasOutput(@as(*IResult, @ptrCast(self)), kind);
            }

            pub inline fn GetOutput(
                self: *T,
                kind: OUT_KIND,
                iid: *const GUID,
                ppv: ?*?*anyopaque,
                ppOutputName: ?*?*IBlobWide,
            ) HRESULT {
                return @as(*const IResult.VTable, @ptrCast(self.__v))
                    .GetOutput(@as(*IResult, @ptrCast(self)), kind, iid, ppv, ppOutputName);
            }

            pub inline fn GetNumOutputs(self: *T) windows.UINT32 {
                return @as(*const IResult.VTable, @ptrCast(self.__v))
                    .GetNumOutputs(@as(*IResult, @ptrCast(self)));
            }

            pub inline fn GetOutputByIndex(self: *T, index: windows.UINT32) OUT_KIND {
                return @as(*const IResult.VTable, @ptrCast(self.__v))
                    .GetOutputByIndex(@as(*IResult, @ptrCast(self)), index);
            }

            pub inline fn PrimaryOutput(self: *T) OUT_KIND {
                return @as(*const IResult.VTable, @ptrCast(self.__v))
                    .PrimaryOutput(@as(*IResult, @ptrCast(self)));
            }
        };
    }

    pub const VTable = extern struct {
        base: IOperationResult.VTable,
        HasOutput: *const fn (*IResult, kind: OUT_KIND) callconv(WINAPI) windows.BOOL,
        GetOutput: *const fn (
            *IResult,
            kind: OUT_KIND,
            iid: *const GUID,
            ppv: ?*?*anyopaque,
            ppOutputName: ?*?*IBlobWide,
        ) callconv(WINAPI) HRESULT,
        GetNumOutputs: *const fn (*IResult) callconv(WINAPI) windows.UINT32,
        GetOutputByIndex: *const fn (
            *IResult,
            index: windows.UINT32,
        ) callconv(WINAPI) OUT_KIND,
        PrimaryOutput: *const fn (
            *IResult,
        ) callconv(WINAPI) OUT_KIND,
    };
};

pub const extra_output_name_stdout = "*stdout*";
pub const extra_output_name_stderr = "*stderr*";

pub const IID_ICompiler3 = GUID.parse("{228b4687-5a6a-4730-900c-9702b2203f54}");
pub const ICompiler3 = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const Compile = _Methods.Compile;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn Compile(
                self: *T,
                pSource: *const Buffer,
                pArguments: ?[*]const ?windows.LPCWSTR,
                argCount: windows.UINT32,
                pIncludeHandler: ?*IIncludeHandler,
                riid: *const GUID,
                ppResult: ?*?*IResult,
            ) HRESULT {
                return @as(*const ICompiler3.VTable, @ptrCast(self.__v))
                    .Compile(@as(*ICompiler3, @ptrCast(self)), pSource, pArguments, argCount, pIncludeHandler, riid, ppResult);
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        Compile: *const fn (
            *ICompiler3,
            pSource: *const Buffer,
            pArguments: ?[*]const ?windows.LPCWSTR,
            argCount: windows.UINT32,
            pIncludeHandler: ?*IIncludeHandler,
            riid: *const GUID,
            ppResult: ?*?*IResult,
        ) callconv(WINAPI) HRESULT,
        Disassemble: *anyopaque,
    };
};

pub const IMalloc = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const Alloc = _Methods.Alloc;
    pub const Realloc = _Methods.Realloc;
    pub const Free = _Methods.Free;
    pub const GetSize = _Methods.GetSize;
    pub const DidAlloc = _Methods.DidAlloc;
    pub const HeapMinimize = _Methods.HeapMinimize;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn Alloc(self: *T, size: windows.SIZE_T) [*]u8 {
                return @ptrCast(@as(*const IMalloc.VTable, @ptrCast(self.__v)).Alloc(@as(*IMalloc, @ptrCast(self)), size));
            }

            pub inline fn Realloc(self: *T, ptr: *anyopaque, size: windows.SIZE_T) [*]u8 {
                return @ptrCast(@as(*const IMalloc.VTable, @ptrCast(self.__v)).Realloc(@as(*IMalloc, @ptrCast(self)), ptr, size));
            }

            pub inline fn Free(self: *T, ptr: *anyopaque) void {
                @as(*const IMalloc.VTable, @ptrCast(self.__v)).Free(@as(*IMalloc, @ptrCast(self)), ptr);
            }

            pub inline fn GetSize(self: *T, ptr: *anyopaque) windows.SIZE_T {
                return @as(*const IMalloc.VTable, @ptrCast(self.__v)).GetSize(@as(*IMalloc, @ptrCast(self)), ptr);
            }

            pub inline fn DidAlloc(self: *T, ptr: *anyopaque) UINT {
                return @as(*const IMalloc.VTable, @ptrCast(self.__v)).DidAlloc(@as(*IMalloc, @ptrCast(self)), ptr);
            }

            pub inline fn HeapMinimize(self: *T) void {
                @as(*const IMalloc.VTable, @ptrCast(self.__v)).HeapMinimize(@as(*IMalloc, @ptrCast(self)));
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        Alloc: *const fn (*IMalloc, windows.SIZE_T) callconv(WINAPI) *anyopaque,
        Realloc: *const fn (*IMalloc, *anyopaque, windows.SIZE_T) callconv(WINAPI) *anyopaque,
        Free: *const fn (*IMalloc, *anyopaque) callconv(WINAPI) void,
        GetSize: *const fn (*IMalloc, *anyopaque) callconv(WINAPI) windows.SIZE_T,
        DidAlloc: *const fn (*IMalloc, *anyopaque) callconv(WINAPI) UINT,
        HeapMinimize: *const fn (*IMalloc) callconv(WINAPI) void,
    };
};

inline fn makeFourCC(ch0: u8, ch1: u8, ch2: u8, ch3: u8) u32 {
    return (@as(u32, @intCast(ch0))) | (@as(u32, @intCast(ch1)) << 8) | (@as(u32, @intCast(ch2)) << 16) | (@as(u32, @intCast(ch3)) << 24);
}

pub const CLSID_Compiler: GUID = .{
    .Data1 = 0x73e22d93,
    .Data2 = 0xe6ce,
    .Data3 = 0x47f3,
    .Data4 = .{
        0xb5, 0xbf, 0xf0, 0x66, 0x4f, 0x39, 0xc1, 0xb0,
    },
};

pub const CLSID_Linker: GUID = .{
    .Data1 = 0xef6a8087,
    .Data2 = 0xb0ea,
    .Data3 = 0x4d56,
    .Data4 = .{
        0x9e, 0x45, 0xd0, 0x7e, 0x1a, 0x8b, 0x78, 0x6,
    },
};

pub const CLSID_DiaDataSource: GUID = .{
    .Data1 = 0xcd1f6b73,
    .Data2 = 0x2ab0,
    .Data3 = 0x484d,
    .Data4 = .{
        0x8e, 0xdc, 0xeb, 0xe7, 0xa4, 0x3c, 0xa0, 0x9f,
    },
};

pub const CLSID_CompilerArgs: GUID = .{
    .Data1 = 0x3e56ae82,
    .Data2 = 0x224d,
    .Data3 = 0x470f,
    .Data4 = .{
        0xa1, 0xa1, 0xfe, 0x30, 0x16, 0xee, 0x9f, 0x9d,
    },
};

pub const CLSID_Library: GUID = .{
    .Data1 = 0x6245d6af,
    .Data2 = 0x66e0,
    .Data3 = 0x48fd,
    .Data4 = .{
        0x80, 0xb4, 0x4d, 0x27, 0x17, 0x96, 0x74, 0x8c,
    },
};

pub const CLSID_Utils: GUID = CLSID_Library;

pub const CLSID_Validator: GUID = .{
    .Data1 = 0x8ca3e215,
    .Data2 = 0xf728,
    .Data3 = 0x4cf3,
    .Data4 = .{
        0x8c, 0xdd, 0x88, 0xaf, 0x91, 0x75, 0x87, 0xa1,
    },
};

pub const CLSID_Assembler: GUID = .{
    .Data1 = 0xd728db68,
    .Data2 = 0xf903,
    .Data3 = 0x4f80,
    .Data4 = .{
        0x94, 0xcd, 0xdc, 0xcf, 0x76, 0xec, 0x71, 0x51,
    },
};

pub const CLSID_ContainerReflection: GUID = .{
    .Data1 = 0xb9f54489,
    .Data2 = 0x55b8,
    .Data3 = 0x400c,
    .Data4 = .{
        0xba, 0x3a, 0x16, 0x75, 0xe4, 0x72, 0x8b, 0x91,
    },
};

pub const CLSID_Optimizer: GUID = .{
    .Data1 = 0xae2cd79f,
    .Data2 = 0xcc22,
    .Data3 = 0x453f,
    .Data4 = .{
        0x9b, 0x6b, 0xb1, 0x24, 0xe7, 0xa5, 0x20, 0x4c,
    },
};

pub const CLSID_ContainerBuilder: GUID = .{
    .Data1 = 0x94134294,
    .Data2 = 0x411f,
    .Data3 = 0x4574,
    .Data4 = .{
        0xb4, 0xd0, 0x87, 0x41, 0xe2, 0x52, 0x40, 0xd2,
    },
};

pub const CLSID_PdbUtils: GUID = .{
    .Data1 = 0x54621dfb,
    .Data2 = 0xf2ce,
    .Data3 = 0x457e,
    .Data4 = .{
        0xae, 0x8c, 0xec, 0x35, 0x5f, 0xae, 0xec, 0x7c,
    },
};

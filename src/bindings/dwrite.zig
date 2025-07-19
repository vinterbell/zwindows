const windows = @import("windows.zig");
const UINT = windows.UINT;
const IUnknown = windows.IUnknown;
const GUID = windows.GUID;
const HRESULT = windows.HRESULT;
const WINAPI = windows.WINAPI;
const LPCWSTR = windows.LPCWSTR;
const FLOAT = windows.FLOAT;

pub const MEASURING_MODE = enum(UINT) {
    NATURAL = 0,
    GDI_CLASSIC = 1,
    GDI_NATURAL = 2,
};

pub const FONT_WEIGHT = enum(UINT) {
    THIN = 100,
    EXTRA_LIGHT = 200,
    LIGHT = 300,
    SEMI_LIGHT = 350,
    NORMAL = 400,
    MEDIUM = 500,
    SEMI_BOLD = 600,
    BOLD = 700,
    EXTRA_BOLD = 800,
    HEAVY = 900,
    ULTRA_BLACK = 950,
};

pub const FONT_STRETCH = enum(UINT) {
    UNDEFINED = 0,
    ULTRA_CONDENSED = 1,
    EXTRA_CONDENSED = 2,
    CONDENSED = 3,
    SEMI_CONDENSED = 4,
    NORMAL = 5,
    SEMI_EXPANDED = 6,
    EXPANDED = 7,
    EXTRA_EXPANDED = 8,
    ULTRA_EXPANDED = 9,
};

pub const FONT_STYLE = enum(UINT) {
    NORMAL = 0,
    OBLIQUE = 1,
    ITALIC = 2,
};

pub const FACTORY_TYPE = enum(UINT) {
    SHARED = 0,
    ISOLATED = 1,
};

pub const TEXT_ALIGNMENT = enum(UINT) {
    LEADING = 0,
    TRAILING = 1,
    CENTER = 2,
    JUSTIFIED = 3,
};

pub const PARAGRAPH_ALIGNMENT = enum(UINT) {
    NEAR = 0,
    FAR = 1,
    CENTER = 2,
};

pub const IFontCollection = extern struct {
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
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetFontFamilyCount: *anyopaque,
        GetFontFamily: *anyopaque,
        FindFamilyName: *anyopaque,
        GetFontFromFontFace: *anyopaque,
    };
};

pub const ITextFormat = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const SetTextAlignment = _Methods.SetTextAlignment;
    pub const SetParagraphAlignment = _Methods.SetParagraphAlignment;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn SetTextAlignment(self: *T, alignment: TEXT_ALIGNMENT) HRESULT {
                return @as(*const ITextFormat.VTable, @ptrCast(self.__v))
                    .SetTextAlignment(@as(*ITextFormat, @ptrCast(self)), alignment);
            }
            pub inline fn SetParagraphAlignment(self: *T, alignment: PARAGRAPH_ALIGNMENT) HRESULT {
                return @as(*const ITextFormat.VTable, @ptrCast(self.__v))
                    .SetParagraphAlignment(@as(*ITextFormat, @ptrCast(self)), alignment);
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        SetTextAlignment: *const fn (*ITextFormat, TEXT_ALIGNMENT) callconv(WINAPI) HRESULT,
        SetParagraphAlignment: *const fn (*ITextFormat, PARAGRAPH_ALIGNMENT) callconv(WINAPI) HRESULT,
        SetWordWrapping: *anyopaque,
        SetReadingDirection: *anyopaque,
        SetFlowDirection: *anyopaque,
        SetIncrementalTabStop: *anyopaque,
        SetTrimming: *anyopaque,
        SetLineSpacing: *anyopaque,
        GetTextAlignment: *anyopaque,
        GetParagraphAlignment: *anyopaque,
        GetWordWrapping: *anyopaque,
        GetReadingDirection: *anyopaque,
        GetFlowDirection: *anyopaque,
        GetIncrementalTabStop: *anyopaque,
        GetTrimming: *anyopaque,
        GetLineSpacing: *anyopaque,
        GetFontCollection: *anyopaque,
        GetFontFamilyNameLength: *anyopaque,
        GetFontFamilyName: *anyopaque,
        GetFontWeight: *anyopaque,
        GetFontStyle: *anyopaque,
        GetFontStretch: *anyopaque,
        GetFontSize: *anyopaque,
        GetLocaleNameLength: *anyopaque,
        GetLocaleName: *anyopaque,
    };
};

pub const IFactory = extern struct {
    __v: *const VTable,

    const _Methods = Methods(@This());
    pub const QueryInterface = _Methods.QueryInterface;
    pub const AddRef = _Methods.AddRef;
    pub const Release = _Methods.Release;

    pub const CreateTextFormat = _Methods.CreateTextFormat;

    pub fn Methods(comptime T: type) type {
        return extern struct {
            const IUnknown_Methods = IUnknown.Methods(T);
            pub const QueryInterface = IUnknown_Methods.QueryInterface;
            pub const AddRef = IUnknown_Methods.AddRef;
            pub const Release = IUnknown_Methods.Release;

            pub inline fn CreateTextFormat(
                self: *T,
                font_family_name: LPCWSTR,
                font_collection: ?*IFontCollection,
                font_weight: FONT_WEIGHT,
                font_style: FONT_STYLE,
                font_stretch: FONT_STRETCH,
                font_size: FLOAT,
                locale_name: LPCWSTR,
                text_format: *?*ITextFormat,
            ) HRESULT {
                return @as(*const IFactory.VTable, @ptrCast(self.__v)).CreateTextFormat(
                    @as(*IFactory, @ptrCast(self)),
                    font_family_name,
                    font_collection,
                    font_weight,
                    font_style,
                    font_stretch,
                    font_size,
                    locale_name,
                    text_format,
                );
            }
        };
    }

    pub const VTable = extern struct {
        base: IUnknown.VTable,
        GetSystemFontCollection: *anyopaque,
        CreateCustomFontCollection: *anyopaque,
        RegisterFontCollectionLoader: *anyopaque,
        UnregisterFontCollectionLoader: *anyopaque,
        CreateFontFileReference: *anyopaque,
        CreateCustomFontFileReference: *anyopaque,
        CreateFontFace: *anyopaque,
        CreateRenderingParams: *anyopaque,
        CreateMonitorRenderingParams: *anyopaque,
        CreateCustomRenderingParams: *anyopaque,
        RegisterFontFileLoader: *anyopaque,
        UnregisterFontFileLoader: *anyopaque,
        CreateTextFormat: *const fn (
            *IFactory,
            LPCWSTR,
            ?*IFontCollection,
            FONT_WEIGHT,
            FONT_STYLE,
            FONT_STRETCH,
            FLOAT,
            LPCWSTR,
            *?*ITextFormat,
        ) callconv(WINAPI) HRESULT,
        CreateTypography: *anyopaque,
        GetGdiInterop: *anyopaque,
        CreateTextLayout: *anyopaque,
        CreateGdiCompatibleTextLayout: *anyopaque,
        CreateEllipsisTrimmingSign: *anyopaque,
        CreateTextAnalyzer: *anyopaque,
        CreateNumberSubstitution: *anyopaque,
        CreateGlyphRunAnalysis: *anyopaque,
    };
};

pub const IID_IFactory = GUID{
    .Data1 = 0xb859ee5a,
    .Data2 = 0xd838,
    .Data3 = 0x4b5b,
    .Data4 = .{ 0xa2, 0xe8, 0x1a, 0xdc, 0x7d, 0x93, 0xdb, 0x48 },
};

pub extern "dwrite" fn DWriteCreateFactory(
    factory_type: FACTORY_TYPE,
    guid: *const GUID,
    factory: *?*anyopaque,
) callconv(WINAPI) HRESULT;

pub const E_FILEFORMAT = @as(HRESULT, @bitCast(@as(c_ulong, 0x88985000)));

pub const Error = error{
    E_FILEFORMAT,
};

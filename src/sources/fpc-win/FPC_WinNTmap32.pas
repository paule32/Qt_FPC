// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// Win32 Error Codes:
//
// All Win32 error codes MUST be in the range 0x0000 to 0xFFFF, although Win32
// error codes can be used both in 16-bit fields (such as within the HRESULT
// as well as 32-bit fields.
// Most values also have a default message defined, which can be used to map
// the value to a human-readable text message; when this is done, the Win32
// error code is also known as a message identifier.
//
// The following table specifies the values and corresponding meanings of the
// Win32 error codes. Vendors SHOULD NOT assign other meanings to these values
// to avoid the risk of a collision in the future.
// ---------------------------------------------------------------------------
const ERROR_SUCCESS = $00000000;
const NOERR_SUCCESS = $00000000;

const ERROR_INVALID_FUNCTION        = $00000001;
const ERROR_FILE_NOT_FOUND          = $00000002;
const ERROR_PATH_NOT_FOUND          = $00000003;
const ERROR_TOO_MANY_OPEN_FILES     = $00000004;
const ERROR_ACCESS_DENIED           = $00000005;
const ERROR_INVALID_HANDLE          = $00000006;
const ERROR_ARENA_TRASHED           = $00000007;
const ERROR_NOT_ENOUGH_MEMORY       = $00000008;
const ERROR_INVALID_BLOCK           = $00000009;
const ERROR_BAD_ENVIRONMENT         = $0000000A;
const ERROR_BAD_FORMAT              = $0000000B;
const ERROR_INVALID_ACCESS          = $0000000C;
const ERROR_INVALID_DATA            = $0000000D;
const ERROR_OUTOFMEMORY             = $0000000E;

resourcestring
RES_ERROR_SUCCESS                   = 'The operation completed successfully.';
RES_ERROR_NOERR_SUCCESS             = 'The operation completed successfully.';
RES_ERROR_INVALID_FUNCTION          = 'Incorrect function.';
RES_ERROR_FILE_NOT_FOUND            = 'The system cannot find the file specified.';
RES_ERROR_PATH_NOT_FOUND            = 'The system cannot find the path specified.';
RES_ERROR_TOO_MANY_OPEN_FILES       = 'The system cannot open the file.';
RES_ERROR_ACCESS_DENIED             = 'Access is denied.';
RES_ERROR_INVALID_HANDLE            = 'The handle is invalid.';
RES_ERROR_ARENA_TRASHED             = 'The storage control blocks were destroyed.';
RES_ERROR_NOT_ENOUGH_MEMORY         = 'Not enough storage is available to process this command.';
RES_ERROR_INVALID_BLOCK             = 'The storage control block address is invalid.';
RES_ERROR_BAD_ENVIRONMENT           = 'The environment is incorrect.';
RES_ERROR_BAD_FORMAT                = 'An attempt was made to load a program with an incorrect format.';
RES_ERROR_INVALID_ACCESS            = 'The access code is invalid.';
RES_ERROR_INVALID_DATA              = 'The data is invalid.';
RES_ERROR_OUTOFMEMORY               = 'Not enough storage is available to complete this operation.';


// WINDOWS NT STATUS CODE               WIN32 ERROR CODE
{------------------------------------------------------------------}
;const STATUS_ACCESS_VIOLATION                               = ERROR_NOACCESS
;const STATUS_FT_MISSING_MEMBER     = ERROR_IO_DEVICE
;const STATUS_VARIABLE_NOT_FOUND     = ERROR_ENVVAR_NOT_FOUND
;const STATUS_OBJECT_PATH_NOT_FOUND     = ERROR_PATH_NOT_FOUND
;const STATUS_DFS_UNAVAILABLE     = ERROR_CONNECTION_UNAVAIL
;const STATUS_DATA_OVERRUN     = ERROR_IO_DEVICE
;const STATUS_DATA_ERROR     = ERROR_CRC
;const STATUS_SHARING_VIOLATION     = ERROR_SHARING_VIOLATION
;const STATUS_QUOTA_EXCEEDED     = ERROR_NOT_ENOUGH_QUOTA
;const STATUS_SEMAPHORE_LIMIT_EXCEEDED     = ERROR_TOO_MANY_POSTS
;const STATUS_LOCK_NOT_GRANTED     = ERROR_LOCK_VIOLATION
;const STATUS_NOT_A_DIRECTORY     = ERROR_DIRECTORY
;const STATUS_INVALID_OWNER     = ERROR_INVALID_OWNER
;const STATUS_NO_IMPERSONATION_TOKEN     = ERROR_NO_IMPERSONATION_TOKEN
;const STATUS_MEMBER_IN_GROUP     = ERROR_MEMBER_IN_GROUP
;const STATUS_LAST_ADMIN     = ERROR_LAST_ADMIN
;const STATUS_WRONG_PASSWORD     = ERROR_INVALID_PASSWORD
;const STATUS_ILL_FORMED_PASSWORD     = ERROR_ILL_FORMED_PASSWORD
;const STATUS_PASSWORD_RESTRICTION     = ERROR_PASSWORD_RESTRICTION
;const STATUS_ACCOUNT_DISABLED     = ERROR_ACCOUNT_DISABLED
;const STATUS_NONE_MAPPED     = ERROR_NONE_MAPPED
;const STATUS_INVALID_ACL     = ERROR_INVALID_ACL,
;const STATUS_PROCEDURE_NOT_FOUND     = ERROR_PROC_NOT_FOUND
;const STATUS_BAD_INITIAL_PC     = ERROR_BAD_EXE_FORMAT
;const STATUS_NO_TOKEN     = ERROR_NO_TOKEN
;const STATUS_SERVER_DISABLED     = ERROR_SERVER_DISABLED
;const STATUS_INVALID_ID_AUTHORITY     = ERROR_INVALID_ID_AUTHORITY
;const STATUS_FILE_INVALID     = ERROR_FILE_INVALID
;const STATUS_DEVICE_PAPER_EMPTY     = ERROR_OUT_OF_PAPER
;const STATUS_DEVICE_POWERED_OFF     = ERROR_NOT_READY
;const STATUS_DEVICE_DATA_ERROR     = ERROR_CRC
;const STATUS_DEVICE_POWER_FAILURE     = ERROR_NOT_READY
;const STATUS_NO_MATCH     = ERROR_NO_MATCH
;const STATUS_FREE_VM_NOT_AT_BASE     = ERROR_INVALID_ADDRESS
;const STATUS_NOT_SAME_DEVICE     = ERROR_NOT_SAME_DEVICE
;const STATUS_REMOTE_NOT_LISTENING     = ERROR_REM_NOT_LIST
;const STATUS_EA_LIST_INCONSISTENT                                = ERROR_EA_LIST_INCONSISTENT
;const STATUS_EAS_NOT_SUPPORTED                                   = ERROR_EAS_NOT_SUPPORTED
;const STATUS_FILE_CORRUPT_ERROR                                  = ERROR_FILE_CORRUPT
;const STATUS_NOT_A_REPARSE_POINT                                 = ERROR_NOT_A_REPARSE_POINT
;const STATUS_IO_REPARSE_TAG_INVALID                              = ERROR_REPARSE_TAG_INVALID
;const STATUS_IO_REPARSE_TAG_NOT_HANDLED                          = ERROR_CANT_ACCESS_FILE
;const STATUS_DIRECTORY_IS_A_REPARSE_POINT                        = ERROR_BAD_PATHNAME
;const STATUS_REMOTE_STORAGE_NOT_ACTIVE                           = ERROR_REMOTE_STORAGE_NOT_ACTIVE
;const STATUS_NO_TRACKING_SERVICE                                 = ERROR_NO_TRACKING_SERVICE
;const STATUS_JOURNAL_DELETE_IN_PROGRESS                          = ERROR_JOURNAL_DELETE_IN_PROGRESS
;const STATUS_INVALID_NETWORK_RESPONSE                            = ERROR_BAD_NET_RESP
;const STATUS_USER_SESSION_DELETED                                = ERROR_UNEXP_NET_ERR
;const STATUS_BAD_REMOTE_ADAPTER                                  = ERROR_BAD_REM_ADAP
;const STATUS_NETWORK_NAME_DELETED                                = ERROR_NETNAME_DELETED
;const STATUS_BAD_DEVICE_TYPE                                     = ERROR_BAD_DEV_TYPE
;const STATUS_TOO_MANY_NAMES                                      = ERROR_TOO_MANY_NAMES
;const STATUS_SHARING_PAUSED                                      = ERROR_SHARING_PAUSED
;const STATUS_INVALID_PIPE_STATE                                  = ERROR_BAD_PIPE
;const STATUS_PIPE_CLOSING                                        = ERROR_NO_DATA
;const STATUS_PIPE_CONNECTED                                      = ERROR_PIPE_CONNECTED
;const STATUS_PIPE_BROKEN                                         = ERROR_BROKEN_PIPE
;const STATUS_UNABLE_TO_LOCK_MEDIA                                = ERROR_UNABLE_TO_LOCK_MEDIA
;const STATUS_UNMAPPABLE_CHARACTER                                = ERROR_NO_UNICODE_TRANSLATION
;const STATUS_BAD_VALIDATION_CLASS                                = ERROR_BAD_VALIDATION_CLASS
;const STATUS_BAD_MASTER_BOOT_RECORD                              = ERROR_INVALID_PARAMETER
;const STATUS_INVALID_SERVER_STATE                                = ERROR_INVALID_SERVER_STATE
;const STATUS_NO_SUCH_DOMAIN                                      = ERROR_NO_SUCH_DOMAIN
;const STATUS_DOMAIN_EXISTS                                       = ERROR_DOMAIN_EXISTS
;const STATUS_OPLOCK_NOT_GRANTED                                  = ERROR_OPLOCK_NOT_GRANTED
;const STATUS_INTERNAL_DB_CORRUPTION                              = ERROR_INTERNAL_DB_CORRUPTION
;const STATUS_GENERIC_NOT_MAPPED                                  = ERROR_GENERIC_NOT_MAPPED
;const STATUS_RXACT_INVALID_STATE                                 = ERROR_RXACT_INVALID_STATE
;const STATUS_SPECIAL_ACCOUNT                                     = ERROR_SPECIAL_ACCOUNT
;const STATUS_MEMBERS_PRIMARY_GROUP                               = ERROR_MEMBERS_PRIMARY_GROUP
;const STATUS_MEMBER_NOT_IN_ALIAS                                 = ERROR_MEMBER_NOT_IN_ALIAS
;const STATUS_ALIAS_EXISTS                                        = ERROR_ALIAS_EXISTS
;const STATUS_LOCAL_DISCONNECT                                    = ERROR_NETNAME_DELETED
;const STATUS_REMOTE_RESOURCES                                    = ERROR_REM_NOT_LIST
;const STATUS_LINK_FAILED                                         = ERROR_UNEXP_NET_ERR
;const STATUS_IO_DEVICE_ERROR                                     = ERROR_IO_DEVICE
;const STATUS_INVALID_DEVICE_STATE                                = ERROR_BAD_COMMAND
;const STATUS_REINITIALIZATION_NEEDED                             = ERROR_DEVICE_REINITIALIZATION_NEEDED
;const STATUS_TRANSPORT_FULL                                      = ERROR_TRANSPORT_FULL
;const STATUS_ENCRYPTION_FAILED                                   = ERROR_ACCESS_DENIED
;const STATUS_FILE_NOT_ENCRYPTED                                  = ERROR_FILE_NOT_ENCRYPTED
;const STATUS_FLOPPY_ID_MARK_NOT_FOUND                            = ERROR_FLOPPY_ID_MARK_NOT_FOUND
;const STATUS_DISK_RECALIBRATE_FAILED                             = ERROR_DISK_RECALIBRATE_FAILED
;const STATUS_EVENTLOG_FILE_CORRUPT                               = ERROR_EVENTLOG_FILE_CORRUPT
;const STATUS_NETLOGON_NOT_STARTED                                = ERROR_NETLOGON_NOT_STARTED
;const STATUS_INVALID_BUFFER_SIZE                                 = ERROR_INVALID_USER_BUFFER
;const STATUS_ADDRESS_ALREADY_EXISTS                              = ERROR_DUP_NAME
;const STATUS_ADDRESS_CLOSED                                      = ERROR_NETNAME_DELETED   
;const STATUS_TRANSACTION_ABORTED                                 = ERROR_UNEXP_NET_ERR   
;const STATUS_NOT_SERVER_SESSION                                  = ERROR_NOT_SUPPORTED   
;const STATUS_USER_MAPPED_FILE                                    = ERROR_USER_MAPPED_FILE   
;const STATUS_COPY_PROTECTION_FAILURE                        = STG_E_STATUS_COPY_PROTECTION_FAILURE 
;const RPC_NT_SERVER_UNAVAILABLE                                 = RPC_SERVER_UNAVAILABLE   
;const EPT_NT_INVALID_ENTRY                                  = EPT_S_INVALID_ENTRY   
;const RPC_NT_NOTHING_TO_EXPORT                                  = RPC_NOTHING_TO_EXPORT   
;const RPC_NT_SS_CONTEXT_MISMATCH                                 = ERROR_INVALID_HANDLE   
;const RPC_NT_SS_CONTEXT_DAMAGED                                 = RPC_SS_CONTEXT_DAMAGED   
;const RPC_NT_INVALID_OBJECT                                     = RPC_INVALID_OBJECT   
;const STATUS_NO_TRUST_LSA_SECRET                                 = ERROR_NO_TRUST_LSA_SECRET   
;const STATUS_TRUSTED_DOMAIN_FAILURE                              = ERROR_TRUSTED_DOMAIN_FAILURE   
;const STATUS_TRUST_FAILURE                                       = ERROR_TRUST_FAILURE   
;const RPC_NT_CALL_IN_PROGRESS                                   = RPC_CALL_IN_PROGRESS   
;const STATUS_LOG_FILE_FULL                                       = ERROR_LOG_FILE_FULL   
;const RPC_NT_GROUP_MEMBER_NOT_FOUND                             = RPC_GROUP_MEMBER_NOT_FOUND   
;const RPC_NT_INVALID_ES_ACTION                                  = RPC_INVALID_ES_ACTION   
;const EPT_NT_CANT_CREATE                                    = EPT_S_CANT_CREATE   
;const RPC_NT_PIPE_CLOSED                                        = RPC_PIPE_CLOSED   
;const STATUS_NO_BROWSER_SERVERS_FOUND                            = ERROR_NO_BROWSER_SERVERS_FOUND   
;const STATUS_DUPLICATE_OBJECTID                             = STATUS_DUPLICATE_OBJECTID   
;const STATUS_OBJECTID_NOT_FOUND                                  = ERROR_FILE_NOT_FOUND   
;const SEC_E_INSUFFICIENT_MEMORY                                  = ERROR_NO_SYSTEM_RESOURCES   
;const STATUS_BAD_BINDINGS                                   = SEC_E_BAD_BINDINGS   
;const TRUST_E_CERT_SIGNATURE                                     = ERROR_MUTUAL_AUTH_FAILED   
;const STATUS_SHUTDOWN_IN_PROGRESS                                = ERROR_SHUTDOWN_IN_PROGRESS   
;const STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY                     = ERROR_DS_MEMBERSHIP_EVALUATED_LOCALLY
;const STATUS_DIRECTORY_SERVICE_REQUIRED                          = ERROR_DS_DS_REQUIRED   
;const STATUS_SAM_INIT_FAILURE                                    = ERROR_SAM_INIT_FAILURE   
;const STATUS_DS_SENSITIVE_GROUP_VIOLATION                        = ERROR_DS_SENSITIVE_GROUP_VIOLATION  
;const STATUS_SAM_NEED_BOOTKEY_PASSWORD                           = ERROR_DS_SAM_NEED_BOOTKEY_PASSWORD  
;const STATUS_DS_INIT_FAILURE_CONSOLE                             = ERROR_DS_INIT_FAILURE_CONSOLE   
;const STATUS_UNFINISHED_CONTEXT_DELETED                         = SEC_E_UNFINISHED_CONTEXT_DELETED   
;const STATUS_KDC_INVALID_REQUEST                                = SEC_E_KDC_INVALID_REQUEST   
;const STATUS_UNSUPPORTED_PREAUTH                                = SEC_E_UNSUPPORTED_PREAUTH   
;const STATUS_SHARED_POLICY                                       = ERROR_SHARED_POLICY   
;const STATUS_POLICY_OBJECT_NOT_FOUND                             = ERROR_POLICY_OBJECT_NOT_FOUND   
;const STATUS_DEVICE_REMOVED                                      = ERROR_DEVICE_REMOVED   
;const STATUS_DRIVER_BLOCKED_CRITICAL                             = ERROR_DRIVER_BLOCKED   
;const STATUS_PRENT4_MACHINE_ACCOUNT                              = ERROR_DS_MACHINE_ACCOUNT_CREATED_PRENT4   
;const STATUS_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER                    = ERROR_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER   
;const STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT                   = ERROR_ACCESS_DISABLED_BY_POLICY   
;const STATUS_ACCESS_DISABLED_BY_POLICY_PATH                      = ERROR_ACCESS_DISABLED_BY_POLICY   
;const STATUS_FAIL_CHECK                                          = ERROR_INVALID_PARAMETER   
;const STATUS_CTX_CLOSE_PENDING                                   = ERROR_CTX_CLOSE_PENDING   
;const STATUS_LPC_REPLY_LOST                                      = ERROR_CONNECTION_ABORTED   
;const STATUS_CTX_WINSTATION_NAME_INVALID                         = ERROR_CTX_WINSTATION_NAME_INVALID   
;const STATUS_LICENSE_VIOLATION                                   = ERROR_CTX_LICENSE_NOT_AVAILABLE   
;const STATUS_ENDPOINT_CLOSED                                     = ERROR_DEV_NOT_EXIST   
;const STATUS_FILES_OPEN                                          = ERROR_OPEN_FILES   
;const STATUS_SXS_SECTION_NOT_FOUND                               = ERROR_SXS_SECTION_NOT_FOUND   
;const STATUS_REDIRECTOR_STARTED                                  = ERROR_SERVICE_ALREADY_RUNNING   
;const STATUS_CLUSTER_NODE_ALREADY_UP                             = ERROR_CLUSTER_NODE_ALREADY_UP   
*)

{$endif}
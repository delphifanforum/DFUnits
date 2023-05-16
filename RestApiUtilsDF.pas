unit RestApiUtilsDF;

interface

uses
  System.SysUtils, System.Net.HttpClient, System.Net.HttpClientComponent;

function ExecuteGetRequest(const AURL: string): string;
function ExecutePostRequest(const AURL: string; const ARequestBody: string): string;
function ExecutePutRequest(const AURL: string; const ARequestBody: string): string;
function ExecuteDeleteRequest(const AURL: string): string;
function FormatQueryString(const AParams: array of string): string;
function CreateUrlWithQueryParams(const AURL: string; const AParams: array of string): string;
function GetJsonField(const AJson: string; const AFieldName: string): string;
function ParseJsonArray(const AJson: string): TArray<string>;
procedure SetBearerToken(const AClient: TNetHttpClient; const AToken: string);
function GenerateBasicAuthHeader(const AUsername, APassword: string): string;

implementation

function ExecuteGetRequest(const AURL: string): string;
var
  Client: TNetHttpClient;
begin
  Client := TNetHttpClient.Create(nil);
  try
    Result := Client.Get(AURL).ContentAsString;
  finally
    Client.Free;
  end;
end;

function ExecutePostRequest(const AURL: string; const ARequestBody: string): string;
var
  Client: TNetHttpClient;
begin
  Client := TNetHttpClient.Create(nil);
  try
    Result := Client.Post(AURL, TStringStream.Create(ARequestBody)).ContentAsString;
  finally
    Client.Free;
  end;
end;

function ExecutePutRequest(const AURL: string; const ARequestBody: string): string;
var
  Client: TNetHttpClient;
begin
  Client := TNetHttpClient.Create(nil);
  try
    Result := Client.Put(AURL, TStringStream.Create(ARequestBody)).ContentAsString;
  finally
    Client.Free;
  end;
end;

function ExecuteDeleteRequest(const AURL: string): string;
var
  Client: TNetHttpClient;
begin
  Client := TNetHttpClient.Create(nil);
  try
    Result := Client.Delete(AURL).ContentAsString;
  finally
    Client.Free;
  end;
end;

function FormatQueryString(const AParams: array of string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(AParams) do
  begin
    Result := Result + AParams;
    if I < High(AParams) then
      Result := Result + '&';
  end;
end;

function CreateUrlWithQueryParams(const AURL: string; const AParams: array of string): string;
begin
  Result := AURL;
  if Length(AParams) > 0 then
  begin
    if Pos('?', Result) > 0 then
      Result := Result + '&'
    else
      Result := Result + '?';
    Result := Result + FormatQueryString(AParams);
  end;
end;

function GetJsonField(const AJson: string; const AFieldName: string): string;
begin
  Result := Copy(AJson, Pos(AFieldName, AJson) + Length(AFieldName) + 2);
  Result := Copy(Result, 1, Pos('"', Result) - 1);
end;

function ParseJsonArray(const AJson: string): TArray<string>;
var
  StartIndex, EndIndex: Integer;
  JsonValue: string;
  JsonArray: TArray<string>;
begin
  StartIndex := Pos('[', AJson) + 1;
  EndIndex := Pos(']', AJson) - 1;
  JsonValue := Copy(AJson, StartIndex, EndIndex - StartIndex + 1);
JsonArray := JsonValue.Split([',']);
Result := JsonArray;
end;

procedure SetBearerToken(const AClient: TNetHttpClient; const AToken: string);
begin
AClient.CustomHeaders['Authorization'] := 'Bearer ' + AToken;
end;

function GenerateBasicAuthHeader(const AUsername, APassword: string): string;
var
AuthString: string;
begin
AuthString := AUsername + ':' + APassword;
Result := 'Basic ' + TNetEncoding.Base64.EncodeBytesToString(TEncoding.UTF8.GetBytes(AuthString));
end;

end.
unit WebServiceUtilsDF;

interface

uses
  System.SysUtils, System.Net.HttpClient, System.Net.HttpClientComponent;

function ExecuteWebService(const AURL: string; const ARequestMethod: string; const ARequestData: string = ''): string;
function FormatXMLRequest(const ARequestData: string): string;
function FormatJSONRequest(const ARequestData: string): string;
function ExtractXMLValue(const AResponseData, ANodePath: string): string;
function ExtractJSONValue(const AResponseData, AFieldName: string): string;
function GetHTTPStatusCode(const AURL: string; const ARequestMethod: string): Integer;
function SetRequestHeaders(const AClient: TNetHttpClient; const AHeaders: array of string): TNetHttpClient;

implementation

function ExecuteWebService(const AURL: string; const ARequestMethod: string; const ARequestData: string = ''): string;
var
  Client: TNetHttpClient;
begin
  Client := TNetHttpClient.Create(nil);
  try
    if ARequestMethod = 'GET' then
      Result := Client.Get(AURL).ContentAsString
    else if ARequestMethod = 'POST' then
      Result := Client.Post(AURL, TStringStream.Create(ARequestData)).ContentAsString
    else if ARequestMethod = 'PUT' then
      Result := Client.Put(AURL, TStringStream.Create(ARequestData)).ContentAsString
    else if ARequestMethod = 'DELETE' then
      Result := Client.Delete(AURL).ContentAsString
    else
      raise Exception.Create('Unsupported request method: ' + ARequestMethod);
  finally
    Client.Free;
  end;
end;

function FormatXMLRequest(const ARequestData: string): string;
begin
  Result := ARequestData; // Modify as per your XML formatting requirements
end;

function FormatJSONRequest(const ARequestData: string): string;
begin
  Result := ARequestData; // Modify as per your JSON formatting requirements
end;

function ExtractXMLValue(const AResponseData, ANodePath: string): string;
begin
  // Extract the value from the XML response based on the specified node path
  // Implement your XML parsing logic here
end;


function ExtractJSONValue(const AResponseData, AFieldName: string): string;
begin
  // Extract the value from the JSON response based on the specified field name
  // Implement your JSON parsing logic here
end;

function GetHTTPStatusCode(const AURL: string; const ARequestMethod: string): Integer;
var
  Client: TNetHttpClient;
begin
  Client := TNetHttpClient.Create(nil);
  try
    if ARequestMethod = 'HEAD' then
      Result := Client.Head(AURL).StatusCode
    else if ARequestMethod = 'GET' then
      Result := Client.Get(AURL).StatusCode
    else if ARequestMethod = 'POST' then
      Result := Client.Post(AURL, nil).StatusCode
    else if ARequestMethod = 'PUT' then
      Result := Client.Put(AURL, nil).StatusCode
    else if ARequestMethod = 'DELETE' then
      Result := Client.Delete(AURL).StatusCode
    else
      raise Exception.Create('Unsupported request method: ' + ARequestMethod);
  finally
    Client.Free;
  end;
end;

function SetRequestHeaders(const AClient: TNetHttpClient; const AHeaders: array of string): TNetHttpClient;
var
  I: Integer;
  HeaderName, HeaderValue: string;
begin
  Result := AClient;
  for I := 0 to High(AHeaders) do
  begin
    HeaderName := Copy(AHeaders, 1, Pos(':', AHeaders) - 1);
HeaderValue := Copy(AHeaders, Pos(':', AHeaders) + 1, Length(AHeaders));
Result.CustomHeaders[HeaderName] := Trim(HeaderValue);
end;
end;

end.
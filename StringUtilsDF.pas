unit StringUtilsDF;

interface

uses
  System.Classes, System.SysUtils;

function ReverseString(const AStr: string): string;
function RemoveWhitespace(const AStr: string): string;
procedure SplitString(const AStr: string; ADelimiter: Char; var AList: TStringList);
function CountOccurrences(const AStr, ASubStr: string): Integer;
function IsPalindrome(const AStr: string): Boolean;
function CapitalizeFirstLetter(const AStr: string): string;
function ExtractNumbers(const AStr: string): string;
function ExtractLetters(const AStr: string): string;
function ContainsOnlyDigits(const AStr: string): Boolean;
function ContainsOnlyLetters(const AStr: string): Boolean;
function ReplaceAll(const AStr, AOldStr, ANewStr: string): string;
function RemoveDuplicates(const AStr: string): string;
function TrimAll(const AStr: string): string;
function PadLeft(const AStr: string; ALength: Integer; APadChar: Char): string;
function PadRight(const AStr: string; ALength: Integer; APadChar: Char): string;

implementation

function ReverseString(const AStr: string): string;
var
  I: Integer;
begin
  SetLength(Result, Length(AStr));
  for I := Length(AStr) downto 1 do
    Result[Length(AStr) - I + 1] := AStr;
end;

function RemoveWhitespace(const AStr: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AStr) do
    if not AStr.IsWhiteSpace then
      Result := Result + AStr;
end;

procedure SplitString(const AStr: string; ADelimiter: Char; var AList: TStringList);
begin
  AList.Clear;
  AList.Delimiter := ADelimiter;
  AList.DelimitedText := AStr;
end;

function CountOccurrences(const AStr, ASubStr: string): Integer;
var
  Position: Integer;
begin
  Result := 0;
  Position := Pos(ASubStr, AStr);
  while Position > 0 do
  begin
    Inc(Result);
    Position := PosEx(ASubStr, AStr, Position + Length(ASubStr));
  end;
end;

function IsPalindrome(const AStr: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(AStr) div 2 do
  begin
    if AStr <> AStr[Length(AStr) - I + 1] then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

function CapitalizeFirstLetter(const AStr: string): string;
begin
  Result := AStr;
  if Result <> '' then
    Result[1] := UpCase(Result[1]);
end;

function ExtractNumbers(const AStr: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AStr) do
  begin
    if AStr.IsDigit then
      Result := Result + AStr;
  end;
end;

function ExtractLetters(const AStr: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AStr) do
  begin
    if AStr.IsLetter then
      Result :=Result + AStr;
end;
end;

function ContainsOnlyDigits(const AStr: string): Boolean;
var
I: Integer;
begin
Result := True;
for I := 1 to Length(AStr) do
begin
if not AStr.IsDigit then
begin
Result := False;
Exit;
end;
end;
end;

function ContainsOnlyLetters(const AStr: string): Boolean;
var
I: Integer;
begin
Result := True;
for I := 1 to Length(AStr) do
begin
if not AStr.IsLetter then
begin
Result := False;
Exit;
end;
end;
end;

function ReplaceAll(const AStr, AOldStr, ANewStr: string): string;
begin
Result := StringReplace(AStr, AOldStr, ANewStr, [rfReplaceAll]);
end;

function RemoveDuplicates(const AStr: string): string;
var
I: Integer;
begin
Result := '';
for I := 1 to Length(AStr) do
begin
if Pos(AStr, Result) = 0 then
Result := Result + AStr;
end;
end;

function TrimAll(const AStr: string): string;
var
I: Integer;
begin
Result := '';
for I := 1 to Length(AStr) do
begin
if not AStr.IsWhiteSpace then
Result := Result + AStr;
end;
end;

function PadLeft(const AStr: string; ALength: Integer; APadChar: Char): string;
begin
if Length(AStr) >= ALength then
Result := AStr
else
Result := StringOfChar(APadChar, ALength - Length(AStr)) + AStr;
end;

function PadRight(const AStr: string; ALength: Integer; APadChar: Char): string;
begin
if Length(AStr) >= ALength then
Result := AStr
else
Result := AStr + StringOfChar(APadChar, ALength - Length(AStr));
end;

end.
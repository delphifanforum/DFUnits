unit ArrayUtilsDF;

interface

procedure ReverseArray(var AArr: array of Integer);
function SumArray(const AArr: array of Integer): Integer;
function AverageArray(const AArr: array of Integer): Double;
function FindMaxValue(const AArr: array of Integer): Integer;
function FindMinValue(const AArr: array of Integer): Integer;
procedure SortArray(var AArr: array of Integer);
function LinearSearch(const AArr: array of Integer; AValue: Integer): Integer;
function BinarySearch(const AArr: array of Integer; AValue: Integer): Integer;
procedure RemoveDuplicates(var AArr: array of Integer);
procedure RotateLeft(var AArr: array of Integer; ARotation: Integer);

implementation

uses
  System.SysUtils;

procedure ReverseArray(var AArr: array of Integer);
var
  I, Temp: Integer;
begin
  for I := 0 to Length(AArr) div 2 - 1 do
  begin
    Temp := AArr;
    AArr := AArr[Length(AArr) - I - 1];
    AArr[Length(AArr) - I - 1] := Temp;
  end;
end;

function SumArray(const AArr: array of Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(AArr) do
    Result := Result + AArr;
end;

function AverageArray(const AArr: array of Integer): Double;
begin
  if Length(AArr) = 0 then
    Result := 0
  else
    Result := SumArray(AArr) / Length(AArr);
end;

function FindMaxValue(const AArr: array of Integer): Integer;
var
  I: Integer;
begin
  Result := AArr[0];
  for I := 1 to High(AArr) do
  begin
    if AArr > Result then
      Result := AArr;
  end;
end;

function FindMinValue(const AArr: array of Integer): Integer;
var
  I: Integer;
begin
  Result := AArr[0];
  for I := 1 to High(AArr) do
  begin
    if AArr < Result then
      Result := AArr;
  end;
end;

procedure SortArray(var AArr: array of Integer);
begin
  TArray.Sort<Integer>(AArr);
end;

function LinearSearch(const AArr: array of Integer; AValue: Integer): Integer;
var
  I: Integer;
begin
  for I := 0 to High(AArr) do
  begin
    if AArr = AValue then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1; // Value not found
end;

function BinarySearch(const AArr: array of Integer; AValue: Integer): Integer;
var
  LowIdx, HighIdx, MidIdx: Integer;
begin
  LowIdx := 0;
  HighIdx := High(AArr);
  while LowIdx <= HighIdx do
  begin
    MidIdx := (LowIdx + HighIdx) div 2;
    if AArr[MidIdx] = AValue then
    begin
      Result := MidIdx;
      Exit;
    end
    else if AArr[MidIdx] < AValue then
      LowIdx := MidIdx + 1
    else
      HighIdx := MidIdx - 1;
  end;
  Result :=-1; // Value not found
end;

procedure RemoveDuplicates(var AArr: array of Integer);
var
I, J, Len: Integer;
begin
Len := Length(AArr);
if Len < 2 then
Exit;

J := 0;
for I := 1 to Len - 1 do
begin
if AArr <> AArr[J] then
begin
Inc(J);
AArr[J] := AArr;
end;
end;

SetLength(AArr, J + 1);
end;

procedure RotateLeft(var AArr: array of Integer; ARotation: Integer);
var
I, J, Len, Temp: Integer;
begin
Len := Length(AArr);
ARotation := ARotation mod Len;
if ARotation = 0 then
Exit;

J := 0;
Temp := AArr[J];
for I := 0 to Len - 1 do
begin
J := (J + ARotation) mod Len;
Temp := AArr[J];
AArr[J] := AArr;
AArr := Temp;
end;
end;

end.
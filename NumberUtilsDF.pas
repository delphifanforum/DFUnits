unit NumberUtilsDF;

interface

function IsEvenNumber(const AValue: Integer): Boolean;
function IsOddNumber(const AValue: Integer): Boolean;
function IsPrimeNumber(const AValue: Integer): Boolean;
function Factorial(const AValue: Integer): Integer;
function Fibonacci(const AIndex: Integer): Integer;
function SumOfDigits(const AValue: Integer): Integer;
function ReverseDigits(const AValue: Integer): Integer;
function IsPalindromeNumber(const AValue: Integer): Boolean;
function GenerateRandomNumber(const AMin, AMax: Integer): Integer;

implementation

uses
  System.SysUtils;

function IsEvenNumber(const AValue: Integer): Boolean;
begin
  Result := AValue mod 2 = 0;
end;

function IsOddNumber(const AValue: Integer): Boolean;
begin
  Result := not IsEvenNumber(AValue);
end;

function IsPrimeNumber(const AValue: Integer): Boolean;
var
  I: Integer;
begin
  Result := AValue > 1;
  for I := 2 to Trunc(Sqrt(AValue)) do
  begin
    if AValue mod I = 0 then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

function Factorial(const AValue: Integer): Integer;
begin
  if AValue <= 1 then
    Result := 1
  else
    Result := AValue * Factorial(AValue - 1);
end;

function Fibonacci(const AIndex: Integer): Integer;
begin
  if AIndex <= 1 then
    Result := AIndex
  else
    Result := Fibonacci(AIndex - 1) + Fibonacci(AIndex - 2);
end;

function SumOfDigits(const AValue: Integer): Integer;
var
  Temp: Integer;
begin
  Result := 0;
  Temp := AValue;
  while Temp > 0 do
  begin
    Result := Result + Temp mod 10;
    Temp := Temp div 10;
  end;
end;

function ReverseDigits(const AValue: Integer): Integer;
var
  Temp: Integer;
begin
  Result := 0;
  Temp := AValue;
  while Temp > 0 do
  begin
    Result := Result * 10 + Temp mod 10;
    Temp := Temp div 10;
  end;
end;

function IsPalindromeNumber(const AValue: Integer): Boolean;
begin
  Result := AValue = ReverseDigits(AValue);
end;

function GenerateRandomNumber(const AMin, AMax: Integer): Integer;
begin
  Randomize;
  Result := Random(AMax - AMin + 1) + AMin;
end;

end.
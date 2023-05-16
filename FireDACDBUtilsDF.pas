unit FireDACDBUtilsDF;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Param;

function ExecuteQuery(const AConnection: TFDConnection; const ASQL: string): TFDQuery;
procedure SetQueryParams(const AQuery: TFDQuery; const AParams: array of Variant);
function FetchSingleValue(const AQuery: TFDQuery): Variant;
procedure InsertRecord(const AQuery: TFDQuery; const ATableName: string; const AFieldValues: array of Variant);
procedure UpdateRecord(const AQuery: TFDQuery; const ATableName: string; const AFieldValues: array of Variant; const ACondition: string);
procedure DeleteRecord(const AQuery: TFDQuery; const ATableName: string; const ACondition: string);
procedure ApplyUpdates(const AQuery: TFDQuery);

implementation

function ExecuteQuery(const AConnection: TFDConnection; const ASQL: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := AConnection;
  Result.SQL.Text := ASQL;
  Result.Open;
end;

procedure SetQueryParams(const AQuery: TFDQuery; const AParams: array of Variant);
var
  I: Integer;
begin
  for I := 0 to High(AParams) do
  begin
    AQuery.Params.Value := AParams;
  end;
end;

function FetchSingleValue(const AQuery: TFDQuery): Variant;
begin
  Result := AQuery.Fields[0].Value;
end;

procedure InsertRecord(const AQuery: TFDQuery; const ATableName: string; const AFieldValues: array of Variant);
var
  I: Integer;
begin
  AQuery.SQL.Text := 'INSERT INTO ' + ATableName + ' VALUES (';
  for I := 0 to High(AFieldValues) do
  begin
    if I > 0 then
      AQuery.SQL.Text := AQuery.SQL.Text + ', ';
    AQuery.SQL.Text := AQuery.SQL.Text + ':Param' + IntToStr(I);
    AQuery.ParamByName('Param' + IntToStr(I)).Value := AFieldValues;
  end;
  AQuery.SQL.Text := AQuery.SQL.Text + ')';
  AQuery.ExecSQL;
end;

procedure UpdateRecord(const AQuery: TFDQuery; const ATableName: string; const AFieldValues: array of Variant; const ACondition: string);
var
  I: Integer;
begin
  AQuery.SQL.Text := 'UPDATE ' + ATableName + ' SET ';
  for I := 0 to High(AFieldValues) do
  begin
    if I > 0 then
      AQuery.SQL.Text := AQuery.SQL.Text + ', ';
    AQuery.SQL.Text := AQuery.SQL.Text + 'Field' + IntToStr(I) + ' = :Param' + IntToStr(I);
    AQuery.ParamByName('Param' + IntToStr(I)).Value := AFieldValues;
  end;
  AQuery.SQL.Text := AQuery.SQL.Text + ' WHERE ' + ACondition;
  AQuery.ExecSQL;
end;

procedure DeleteRecord(const AQuery: TFDQuery; const ATableName: string; const ACondition: string);
begin
  AQuery.SQL.Text := 'DELETE FROM ' + ATableName + ' WHERE ' + ACondition;
  AQuery.ExecSQL;
end;

procedure ApplyUpdates(const AQuery: TFDQuery);
begin
  if AQuery.State in [dsEdit, dsInsert, dsDelete] then
    AQuery.Post;
  AQuery.ApplyUpdates(-1);

end;

end.
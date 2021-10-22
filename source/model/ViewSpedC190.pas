unit ViewSpedC190;

interface

uses
  Model, Classes, Generics.Collections, SysUtils, FireDAC.Comp.Client, Data.DB;

type
  TViewSpedC190 = class(TModel)
  private
    FCSOSN: String;
    FCST: String;
    FCFOP: String;
    FPICMS: Extended;
    FVL_OPR: Extended;
    FVL_BC_ICMS: Extended;
    FVL_ICMS: Extended;
    FVL_BC_ICMS_ST: Extended;
    FVL_ICMS_ST: Extended;
    FVL_IPI: Extended;

  public
    class function list(EmpresaId, NfeId: string): TObjectList<TViewSpedC190>;

    property Csosn: String  read FCSOSN write FCSOSN;
    property Cst: String  read FCST write FCST;
    property Cfop: String  read FCFOP write FCFOP;
    property Picms: Extended  read FPICMS write FPICMS;
    property VlOpr: Extended  read FVL_OPR write FVL_OPR;
    property VlBcIcms: Extended  read FVL_BC_ICMS write FVL_BC_ICMS;
    property VlIcms: Extended  read FVL_ICMS write FVL_ICMS;
    property VlBcIcmsSt: Extended  read FVL_BC_ICMS_ST write FVL_BC_ICMS_ST;
    property VlIcmsSt: Extended  read FVL_ICMS_ST write FVL_ICMS_ST;
    property VlIpi: Extended  read FVL_IPI write FVL_IPI;

  end;

implementation

{ TViewSpedC190 }

class function TViewSpedC190.list(EmpresaId,
  NfeId: string): TObjectList<TViewSpedC190>;
const
  FSql: string =
  'SELECT W.* FROM VIEW_SPED_C190 W ' +
  'WHERE (W.EMPRESA_ID = :EMPRESA_ID) AND (W.NFE_ID = :NFE_ID) ';
var
  FDQuery: TFDQuery;
begin
  try
    FDQuery:= Self.createQuery;
    try
      FDQuery.SQL.Add(FSql);
      FDQuery.Params.ParamByName('EMPRESA_ID').DataType:= ftString;
      FDQuery.Params.ParamByName('NFE_ID').DataType:= ftString;
      FDQuery.Prepare;
      FDQuery.Params.ParamByName('EMPRESA_ID').AsString:= EmpresaId;
      FDQuery.Params.ParamByName('NFE_ID').AsString:= NfeId;
      FDQuery.Open();
      if FDQuery.RecordCount = 0 then Result:= nil
      else
      begin
        Result:= TObjectList<TViewSpedC190>.Create;
        FDQuery.First;
        while not FDQuery.Eof do
        begin
          Result.Add(TViewSpedC190.Create);
          Result.Last.Csosn:= FDQuery.FieldByName('CSOSN').AsString;
          Result.Last.Cst:= FDQuery.FieldByName('CST').AsString;
          Result.Last.Cfop:= FDQuery.FieldByName('CFOP').AsString;
          Result.Last.Picms:= FDQuery.FieldByName('PICMS').AsExtended;
          Result.Last.VlOpr:= FDQuery.FieldByName('VL_OPR').AsExtended;
          Result.Last.VlBcIcms:= FDQuery.FieldByName('VL_BC_ICMS').AsExtended;
          Result.Last.VlIcms:= FDQuery.FieldByName('VL_ICMS').AsExtended;
          Result.Last.VlBcIcmsSt:= FDQuery.FieldByName('VL_BC_ICMS_ST').AsExtended;
          Result.Last.VlIcmsSt:= FDQuery.FieldByName('VL_ICMS_ST').AsExtended;
          Result.Last.VlIpi:= FDQuery.FieldByName('VL_IPI').AsExtended;
          FDQuery.Next();
        end;
      end;
    except
      Result:= nil;
    end;
  finally
    FreeAndNil(FDQuery);
  end;
end;

end.

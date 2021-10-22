{*******************************************************************************
Title: iTEC-SOFTWARE                                                            
Description:  VO  relational the table [NFES] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2010 www.itecsoftware.com.br                           
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sub license, and/or sell              
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           william@itecsoftware.com.br                                          
                                                                                
@author William (william_mk@hotmail.com)                    
@version 1.0                                                                    
*******************************************************************************}
unit NfesVO;

interface

uses
  VO, Atributos, Classes, Constantes, Generics.Collections, SysUtils;

type
  [TEntity]
  [TTable('NFES')]
  TNfesVO = class(TVO)
  private
    FID: String;
    FEMPRESA_ID: String;
    FPARTICIPANTE_ID: String;
    FCUF: String;
    FCNF: String;
    FNATOP: String;
    FINDPAG: String;
    FMODELO: Integer;
    FSERIE: Integer;
    FNNF: Integer;
    FDEMI: TDateTime;
    FDSAIENT: TDateTime;
    FTPNF: String;
    FIDDEST: String;
    FCMUNFG: String;
    FTPIMP: String;
    FTPEMIS: String;
    FCDV: Integer;
    FTPAMB: String;
    FFINNFE: String;
    FINDFINAL: String;
    FINDPRES: String;
    FPROCEMI: String;
    FDHCONT: TDateTime;
    FXJUST: String;
    FQRCODE: String;
    FCHNFE: String;
    FDHRECBTO: TDateTime;
    FNPROT: String;
    FDIGVAL: String;
    FCSTAT: Integer;
    FXMOTIVO: String;
    FCREATED_AT: TDateTime;
    FUPDATED_AT: TDateTime;
    FDELETED_AT: TDateTime;
    FSYNCHRONIZED: String;

  public 
    [TId('ID')]
    [TGeneratedValue(sAuto)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Id: String  read FID write FID;
    [TColumn('EMPRESA_ID','Empresa Id',450,[ldGrid, ldLookup, ldCombobox], False)]
    property EmpresaId: String  read FEMPRESA_ID write FEMPRESA_ID;
    [TColumn('PARTICIPANTE_ID','Participante Id',450,[ldGrid, ldLookup, ldCombobox], False)]
    property ParticipanteId: String  read FPARTICIPANTE_ID write FPARTICIPANTE_ID;
    [TColumn('CUF','Cuf',64,[ldGrid, ldLookup, ldCombobox], False)]
    property Cuf: String  read FCUF write FCUF;
    [TColumn('CNF','Cnf',256,[ldGrid, ldLookup, ldCombobox], False)]
    property Cnf: String  read FCNF write FCNF;
    [TColumn('NATOP','Natop',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Natop: String  read FNATOP write FNATOP;
    [TColumn('INDPAG','Indpag',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Indpag: String  read FINDPAG write FINDPAG;
    [TColumn('MODELO','Modelo',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Modelo: Integer  read FMODELO write FMODELO;
    [TColumn('SERIE','Serie',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Serie: Integer  read FSERIE write FSERIE;
    [TColumn('NNF','Nnf',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Nnf: Integer  read FNNF write FNNF;
    [TColumn('DEMI','Demi',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Demi: TDateTime  read FDEMI write FDEMI;
    [TColumn('DSAIENT','Dsaient',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Dsaient: TDateTime  read FDSAIENT write FDSAIENT;
    [TColumn('TPNF','Tpnf',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Tpnf: String  read FTPNF write FTPNF;
    [TColumn('IDDEST','Iddest',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Iddest: String  read FIDDEST write FIDDEST;
    [TColumn('CMUNFG','Cmunfg',224,[ldGrid, ldLookup, ldCombobox], False)]
    property Cmunfg: String  read FCMUNFG write FCMUNFG;
    [TColumn('TPIMP','Tpimp',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Tpimp: String  read FTPIMP write FTPIMP;
    [TColumn('TPEMIS','Tpemis',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Tpemis: String  read FTPEMIS write FTPEMIS;
    [TColumn('CDV','Cdv',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Cdv: Integer  read FCDV write FCDV;
    [TColumn('TPAMB','Tpamb',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Tpamb: String  read FTPAMB write FTPAMB;
    [TColumn('FINNFE','Finnfe',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Finnfe: String  read FFINNFE write FFINNFE;
    [TColumn('INDFINAL','Indfinal',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Indfinal: String  read FINDFINAL write FINDFINAL;
    [TColumn('INDPRES','Indpres',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Indpres: String  read FINDPRES write FINDPRES;
    [TColumn('PROCEMI','Procemi',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Procemi: String  read FPROCEMI write FPROCEMI;
    [TColumn('DHCONT','Dhcont',80,[ldGrid, ldLookup, ldCombobox], False)]
    property Dhcont: TDateTime  read FDHCONT write FDHCONT;
    [TColumn('XJUST','Xjust',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Xjust: String  read FXJUST write FXJUST;
    [TColumn('QRCODE','Qrcode',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Qrcode: String  read FQRCODE write FQRCODE;
    [TColumn('CHNFE','Chnfe',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Chnfe: String  read FCHNFE write FCHNFE;
    [TColumn('DHRECBTO','Dhrecbto',272,[ldGrid, ldLookup, ldCombobox], False)]
    property Dhrecbto: TDateTime  read FDHRECBTO write FDHRECBTO;
    [TColumn('NPROT','Nprot',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Nprot: String  read FNPROT write FNPROT;
    [TColumn('DIGVAL','Digval',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Digval: String  read FDIGVAL write FDIGVAL;
    [TColumn('CSTAT','Cstat',80,[ldGrid, ldLookup, ldCombobox], False)]
    [TFormatter(ftZerosAEsquerda, taCenter)]
    property Cstat: Integer  read FCSTAT write FCSTAT;
    [TColumn('XMOTIVO','Xmotivo',450,[ldGrid, ldLookup, ldCombobox], False)]
    property Xmotivo: String  read FXMOTIVO write FXMOTIVO;
    [TColumn('CREATED_AT','Created At',272,[ldGrid, ldLookup, ldCombobox], False)]
    property CreatedAt: TDateTime  read FCREATED_AT write FCREATED_AT;
    [TColumn('UPDATED_AT','Updated At',272,[ldGrid, ldLookup, ldCombobox], False)]
    property UpdatedAt: TDateTime  read FUPDATED_AT write FUPDATED_AT;
    [TColumn('DELETED_AT','Deleted At',272,[ldGrid, ldLookup, ldCombobox], False)]
    property DeletedAt: TDateTime  read FDELETED_AT write FDELETED_AT;
    [TColumn('SYNCHRONIZED','Synchronized',32,[ldGrid, ldLookup, ldCombobox], False)]
    property Synchronized: String  read FSYNCHRONIZED write FSYNCHRONIZED;

  end;

implementation



end.

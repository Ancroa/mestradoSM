function varargout = Serial_Arduino(varargin)
% SERIAL_ARDUINO MATLAB code for Serial_Arduino.fig
%      SERIAL_ARDUINO, by itself, creates a new SERIAL_ARDUINO or raises the existing
%      singleton*.
%
%      H = SERIAL_ARDUINO returns the handle to a new SERIAL_ARDUINO or the handle to
%      the existing singleton*.
%
%      SERIAL_ARDUINO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERIAL_ARDUINO.M with the given input arguments.
%
%      SERIAL_ARDUINO('Property','Value',...) creates a new SERIAL_ARDUINO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Serial_Arduino_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Serial_Arduino_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Serial_Arduino

% Last Modified by GUIDE v2.5 04-Apr-2018 13:02:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Serial_Arduino_OpeningFcn, ...
    'gui_OutputFcn',  @Serial_Arduino_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Serial_Arduino is made visible.
function Serial_Arduino_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Serial_Arduino (see VARARGIN)

% Choose default command line output for Serial_Arduino
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Serial_Arduino wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Serial_Arduino_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Parar.
function Parar_Callback(hObject, eventdata, handles)
% Quando o botão Parar Leitura for precionado, então o valor stop_now passa a ser 1
handles.stop_now = 1;
% Atualiza o gui data
guidata(hObject, handles);


% --- Executes on button press in Iniciar.
function Iniciar_Callback(hObject, eventdata, handles)
% variável de armazenamento da serial
global s

% Busca pela serial do Arduino
Numero_da_Porta=1;
Porta_Conectada=1;

% Enquanto a porta não for conectada permanece no while
while Porta_Conectada
    s = serial(['COM' num2str(portNum)]);
    try
        % Setando os parâmetros da Serial
        set(s, 'InputBufferSize', 128); %number of bytes in inout buffer
        set(s, 'FlowControl', 'none');
        set(s, 'BaudRate', 9600);
        set(s, 'Parity', 'none');
        set(s, 'DataBits', 8);
        set(s, 'StopBit', 1);
        set(s, 'Timeout',100);
        
        % Abrindo porta Serial
        fopen(s);
        
        % Condição de parada do while (Porta conectada)
        wrongPort=0;
        
        % Inicializando o botão de parada
        handles.stop_now = 0; 
        
        % Atualizando o GUI data
        guidata(hObject,handles);
        
        % Abrindo o arquivo txt para armazenar os dados
        fileID = fopen('Local_de_armazenamento_dos_dados.txt','w');
        
        % Escrevendo o cabeçalho no arquivo txt
        fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\n','Ax','Ay','Az','Bx','By','Bz');
        
        % Condição de armazenamento dos dados no arquivo txt. Enquanto o botão de parada
        % não for acionado, permanece no while
        while ~(handles.stop_now)
            % Atualiza o gui data
            drawnow();
            handles = guidata(hObject);
            
            % Se houver alguma coisa na serial a condição é verdadeira
            if s.BytesAvailable > 0
                % Armazena os dados na variável data
                data = fscanf(s)
                %plot(data)
                
                % Grava os dados no arquivo txt aberto
                fprintf(fileID,'%s\n',data);
            end
        end
        
        disp('Parou');
        
        % Armazena os dados do txt numa matriz para avalia-los
        matriz_dados = dlmread('Local_de_armazenamento_dos_dados.txt','',1,0);
        
    catch
        % deleta a porta serial quando terminar o processo
        delete(s);
        
        % limpa a porta serial
        clear s
        
        % desconecta todas as portas abertas
        instrreset % close any wrongly opened connection
        
        % condição para iniciar o while da porta serial não conectada
        wrongPort =1 ; % keep trying...
        
        disp('NaoFoiConectado')
    end
    
    % incremento do contador da porta serial
    portNum = portNum + 1
    
    % Se o número de porta serial for igual a 16, para o processo de busca da serial
    if portNum == 16
        error('Arduino is not connected')
    end
end

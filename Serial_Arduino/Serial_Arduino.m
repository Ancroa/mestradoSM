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

% Last Modified by GUIDE v2.5 16-Apr-2018 10:02:40

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
% Quando o bot�o Parar Leitura for precionado, ent�o o valor stop_now passa a ser 1
handles.stop_now = 1;
% Atualiza o gui data
guidata(hObject, handles);

% --- Executes on button press in A_x.
function A_x_Callback(hObject, eventdata, handles)
% hObject    handle to A_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global matriz_dados

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    plot(handles.axes1,matriz_dados(:,1),'r');
end

% --- Executes on button press in A_y.
function A_y_Callback(hObject, eventdata, handles)
% hObject    handle to A_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matriz_dados

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    plot(handles.axes1,matriz_dados(:,2),'b');
end

% --- Executes on button press in A_z.
function A_z_Callback(hObject, eventdata, handles)
% hObject    handle to A_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matriz_dados

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    
    
    plot(handles.axes1,matriz_dados(:,3),'g');
end

% --- Executes on button press in B_x.
function B_x_Callback(hObject, eventdata, handles)
% hObject    handle to B_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matriz_dados

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    
    plot(handles.axes1,matriz_dados(:,4),'m');
end

% --- Executes on button press in B_y.
function B_y_Callback(hObject, eventdata, handles)
% hObject    handle to B_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matriz_dados

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    plot(handles.axes1,matriz_dados(:,5),'c');
end

% --- Executes on button press in B_z.
function B_z_Callback(hObject, eventdata, handles)
% hObject    handle to B_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matriz_dados

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    plot(handles.axes1,matriz_dados(:,6),'k');
end

% --- Executes on button press in Iniciar.
function Iniciar_Callback(hObject, eventdata, handles)
% vari�vel de armazenamento da serial
global s
global matriz_dados

% Busca pela serial do Arduino
Numero_da_Porta=1;
Porta_Conectada=1;

% Enquanto a porta n�o for conectada permanece no while
while Porta_Conectada
    s = serial(['COM' num2str(Numero_da_Porta)]);
    try
        % Setando os par�metros da Serial
        set(s, 'InputBufferSize', 128); %number of bytes in inout buffer
        set(s, 'FlowControl', 'none');
        set(s, 'BaudRate', 9600);
        set(s, 'Parity', 'none');
        set(s, 'DataBits', 8);
        set(s, 'StopBit', 1);
        set(s, 'Timeout',100);
        
        % Abrindo porta Serial
        fopen(s);
        
        % Condi��o de parada do while (Porta conectada)
        Porta_Conectada=0;
        
        % Inicializando o bot�o de parada
        handles.stop_now = 0;
        
        % Atualizando o GUI data
        guidata(hObject,handles);
        
        % Abrindo o arquivo txt para armazenar os dados
        fileID = fopen('dados_Vanessa.txt','w');
        
        % Escrevendo o cabe�alho no arquivo txt
        fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\n','Ax','Ay','Az','Bx','By','Bz');
        
        disp('Conectado!');
        % Condi��o de armazenamento dos dados no arquivo txt. Enquanto o bot�o de parada
        % n�o for acionado, permanece no while
        %figure
        hold on
        while ~(handles.stop_now)
            % Atualiza o gui data
            
            drawnow();
            handles = guidata(hObject);
            
            % Se houver alguma coisa na serial a condi��o � verdadeira
            if s.BytesAvailable > 0
                % Armazena os dados na vari�vel data
                data = fscanf(s);
                
                % Grava os dados no arquivo txt aberto
                fprintf(fileID,'%s\n',data);
                matriz_dados = dlmread('dados_Vanessa.txt','',1,0);
                
                %%%%% Gr�fico do sensor A (Coxa)
                if get(handles.A_x, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,1),'r');
                end
                
                if get(handles.A_y, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,2),'b');
                end
                
                if get(handles.A_z, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,3),'g');
                end
                
                %%%%% Gr�fico do sensor B (Panturrilha)
                if get(handles.B_x, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,4),'m');
                end
                
                if get(handles.B_y, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,5),'c');
                end
                
                if get(handles.B_z, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,6),'k');
                end
                
                % Plota em tempo real o gr�fico dos �ngulos dos sensores
                
            end
        end
        
        disp('Parou');
        
        % Armazena os dados do txt numa matriz para avalia-los
        %matriz_dados = dlmread('Local_de_armazenamento_dos_dados.txt','',1,0);
        
    catch
        % deleta a porta serial quando terminar o processo
        delete(s);
        
        % limpa a porta serialSSSS
        clear s
        
        % desconecta todas as portas abertas
        instrreset % close any wrongly opened connection
        
        % condi��o para iniciar o while da porta serial n�o conectada
        Porta_Conectada =1 ; % keep trying...
        
        disp('NaoFoiConectado')
    end
    
    % incremento do contador da porta serial
    Numero_da_Porta = Numero_da_Porta + 1
    
    % Se o n�mero de porta serial for igual a 16, para o processo de busca da serial
    if Numero_da_Porta == 16
        error('Arduino is not connected')
    end
end

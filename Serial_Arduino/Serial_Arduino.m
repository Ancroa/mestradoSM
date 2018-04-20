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

%Variáveis globais
global nome_arquivo                             % Nome do Arquivo que será salvo os dados
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

cor = ['r' 'b' 'g' 'm' 'c' 'k'];                % Declaração das cores
nome_arquivo = 'dados_Kassio.txt';              % Nome do arquivo
matriz_dados = dlmread(nome_arquivo,'',1,0);    % Armazenamento dos dados

hold on                                         % Replot
zoom on                                         % posibilita o zoom na figura
% Choose default command line output for Serial_Arduino
handles.output = hObject;
handles.stop_now = 1;                           % condição de parada
% Update handles structure
guidata(hObject, handles);                      % Atualização do gui

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
handles.stop_now = 1;                           % Parar programa
% Atualiza o gui data
guidata(hObject, handles);

% --- Executes on button press in A_x.
function A_x_Callback(hObject, eventdata, handles)
% hObject    handle to A_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global grafico_vetor                            % Separa os dados para o plot
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

grafico_vetor(1) = get(handles.A_x, 'Value');   % Armazena os dados da primeira coluna
guidata(hObject,handles);                       % Atualizando o GUI data

if(handles.stop_now == 1)                       % Verifica se o programa está parado
    cla(handles.axes1,'reset');                 % Reseta o gráfico
    hold on
    for i = 1:length(grafico_vetor)             % Plota os dados no gráfico
        if(grafico_vetor(i) == 1)
            plot(handles.axes1,matriz_dados(:,i),cor(i));
        end
    end
end

% --- Executes on button press in A_y.
function A_y_Callback(hObject, eventdata, handles)
% hObject    handle to A_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grafico_vetor                            % Separa os dados para o plot
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

grafico_vetor(2) = get(handles.A_y, 'Value');   % Armazena os dados da segunda coluna
% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)                       % Verifica se o programa está parado
    cla(handles.axes1,'reset');                 % Reseta o gráfico
    hold on
    for i = 1:length(grafico_vetor)             % Plota os dados no gráfico
        if(grafico_vetor(i) == 1)
            plot(handles.axes1,matriz_dados(:,i),cor(i));
        end
    end
end

% --- Executes on button press in A_z.
function A_z_Callback(hObject, eventdata, handles)
% hObject    handle to A_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grafico_vetor                            % Separa os dados para o plot
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

grafico_vetor(3) = get(handles.A_z, 'Value');   % Armazena os dados da terceira coluna

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    cla(handles.axes1,'reset');
    hold on
    for i = 1:length(grafico_vetor)
        if(grafico_vetor(i) == 1)
            plot(handles.axes1,matriz_dados(:,i),cor(i));
        end
    end
end

% --- Executes on button press in B_x.
function B_x_Callback(hObject, eventdata, handles)
% hObject    handle to B_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global grafico_vetor                            % Separa os dados para o plot
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

grafico_vetor(4) = get(handles.B_x, 'Value');   % Armazena os dados da quarta coluna
% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    cla(handles.axes1,'reset');
    hold on
    for i = 1:length(grafico_vetor)
        if(grafico_vetor(i) == 1)
            plot(handles.axes1,matriz_dados(:,i),cor(i));
        end
    end
end

% --- Executes on button press in B_y.
function B_y_Callback(hObject, eventdata, handles)
% hObject    handle to B_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grafico_vetor                            % Separa os dados para o plot
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

grafico_vetor(5) = get(handles.B_y, 'Value');   % Armazena os dados da quinta coluna
% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    cla(handles.axes1,'reset');
    hold on
    for i = 1:length(grafico_vetor)
        if(grafico_vetor(i) == 1)
            plot(handles.axes1,matriz_dados(:,i),cor(i));
        end
    end
end

% --- Executes on button press in B_z.
function B_z_Callback(hObject, eventdata, handles)
% hObject    handle to B_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global grafico_vetor                            % Separa os dados para o plot
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

grafico_vetor(6) = get(handles.B_z, 'Value');   % Armazena os dados da sexta coluna

% Atualizando o GUI data
guidata(hObject,handles);

if(handles.stop_now == 1)
    cla(handles.axes1,'reset');
    hold on
    for i = 1:length(grafico_vetor)
        if(grafico_vetor(i) == 1)
            plot(handles.axes1,matriz_dados(:,i),cor(i));
        end
    end
end


% --- Executes on button press in Iniciar.

function Iniciar_Callback(hObject, eventdata, handles)

global s                                        % variável de armazenamento da serial
global nome_arquivo                             % Nome do Arquivo que será salvo os dados
global cor                                      % Cor para cada dados da figura
global matriz_dados                             % Matriz de dados

Numero_da_Porta = 3;                            % Busca pela serial do Arduino
Porta_Conectada = 1;

while Porta_Conectada                           % Enquanto a porta não for conectada permanece no while
    s = serial(['COM' num2str(Numero_da_Porta)]);
    try
        % Setando os parâmetros da Serial
        set(s, 'InputBufferSize', 128);
        set(s, 'FlowControl', 'none');
        set(s, 'BaudRate', 9600);
        set(s, 'Parity', 'none');
        set(s, 'DataBits', 8);
        set(s, 'StopBit', 1);
        set(s, 'Timeout',100);
        
        fopen(s);                               % Abrindo porta Serial
        Porta_Conectada = 0;                    % Condição de parada do while (Porta conectada)
        handles.stop_now = 0;                   % Inicializando o botão de parada
        guidata(hObject,handles)                % Atualizando o GUI data
        fileID = fopen(nome_arquivo,'w');       % Abrindo o arquivo txt para armazenar os dados
        
        % Escrevendo o cabeçalho no arquivo txt
        fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\n','Ax','Ay','Az','Bx','By','Bz');
        
        disp('Conectado!');
        % Condição de armazenamento dos dados no arquivo txt. Enquanto o botão de parada
        % não for acionado, permanece no while

        while ~(handles.stop_now)
            % Atualiza o gui data
            drawnow();
            handles = guidata(hObject);
            
            % Se houver alguma coisa na serial a condição é verdadeira
            if s.BytesAvailable > 0
                % Armazena os dados na variável data
                data = fscanf(s);
                
                % Grava os dados no arquivo txt aberto
                fprintf(fileID,'%s\n',data);
                matriz_dados = dlmread(nome_arquivo,'',1,0);
                
                %%%%% Gráfico do sensor A (Coxa)
                cla(handles.axes1);
                if get(handles.A_x, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,1),cor(1));
                    set(handles.Ax_value, 'String', matriz_dados(length(matriz_dados),1));
                end
                
                if get(handles.A_y, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,2),cor(2));
                    set(handles.Ay_value, 'String', matriz_dados(length(matriz_dados),2));
                end
                
                if get(handles.A_z, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,3),cor(3));
                    set(handles.Az_value, 'String', matriz_dados(length(matriz_dados),3));
                end
                
                %%%%% Gráfico do sensor B (Panturrilha)
                if get(handles.B_x, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,4),cor(4));
                    set(handles.Bx_value, 'String', matriz_dados(length(matriz_dados),4));
                end
                
                if get(handles.B_y, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,5),cor(5));
                    set(handles.By_value, 'String', matriz_dados(length(matriz_dados),5));
                end
                
                if get(handles.B_z, 'Value') == 1
                    plot(handles.axes1,matriz_dados(:,6),cor(6));
                    set(handles.Bz_value, 'String', matriz_dados(length(matriz_dados),6));
                end
                % Plota em tempo real o gráfico dos ângulos dos sensores
                
            end
        end
        
        disp('Parou');
        
    catch
        % deleta a porta serial quando terminar o processo
        delete(s);
        
        % limpa a porta serialSSSS
        clear s
        
        % desconecta todas as portas abertas
        instrreset % close any wrongly opened connection
        
        % condição para iniciar o while da porta serial não conectada
        Porta_Conectada = 1 ; % keep trying...
    end
    
    % incremento do contador da porta serial
    Numero_da_Porta = Numero_da_Porta + 1
    
    % Se o número de porta serial for igual a 16, para o processo de busca da serial
    if Numero_da_Porta == 16
        error('Arduino is not connected')
    end
end

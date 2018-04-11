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
% hObject    handle to Parar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.stop_now = 1;
guidata(hObject, handles);




% --- Executes on button press in Iniciar.
function Iniciar_Callback(hObject, eventdata, handles)
% hObject    handle to Iniciar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s 

s = serial('COM14'); %assigns the object s to serial port

set(s, 'InputBufferSize', 128); %number of bytes in inout buffer
set(s, 'FlowControl', 'none');
set(s, 'BaudRate', 9600);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);
set(s, 'StopBit', 1);
set(s, 'Timeout',100);
%clc;

disp(get(s,'Name'));
prop(1)=(get(s,'BaudRate'));
prop(2)=(get(s,'DataBits'));
prop(3)=(get(s, 'StopBit'));
prop(4)=(get(s, 'InputBufferSize'));

disp([num2str(prop)]);

fopen(s);           %opens the serial port
handles.stop_now = 0; %Create stop_now in the handles structure
guidata(hObject,handles);  %Update the GUI data

fileID = fopen('dados_Bruno2_linha_reta.txt','w');
fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\n','Ax','Ay','Az','Bx','By','Bz');


while ~(handles.stop_now)
    drawnow();
    handles = guidata(hObject);
    %data = fscanf(s)
    if s.BytesAvailable > 0
        data = fscanf(s)
        fprintf(fileID,'%s\n',data);
    end
    %flushinput(s)
end
fclose(s);
matriz_dados = dlmread('dados_Bruno2_linha_reta.txt','',1,0);
disp('Parou');



%plot(matriz_dados);
%delete(s);
%clear s;

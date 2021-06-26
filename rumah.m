function varargout = rumah(varargin)
% RUMAH MATLAB code for rumah.fig
%      RUMAH, by itself, creates a new RUMAH or raises the existing
%      singleton*.
%
%      H = RUMAH returns the handle to a new RUMAH or the handle to
%      the existing singleton*.
%
%      RUMAH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUMAH.M with the given input arguments.
%
%      RUMAH('Property','Value',...) creates a new RUMAH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rumah_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rumah_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rumah

% Last Modified by GUIDE v2.5 26-Jun-2021 11:31:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rumah_OpeningFcn, ...
                   'gui_OutputFcn',  @rumah_OutputFcn, ...
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


% --- Executes just before rumah is made visible.
function rumah_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rumah (see VARARGIN)
global a
a.urut=[];

% Choose default command line output for rumah
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rumah wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rumah_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATARUMAH.csv');
opts.SelectedVariableNames = [1 3:8];
data = readmatrix('DATARUMAH.csv',opts);
set(handles.uitable1,'Data', data);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATARUMAH.csv');
opts.SelectedVariableNames = [3:8];
x = readmatrix('DATARUMAH.csv',opts);

k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
w=[0.3,0.2,0.23,0.1,0.07,0.1];% bobot untuk masing-masing kriteria

%normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
 if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
  R(:,j)=x(:,j)./max(x(:,j));
 else
  R(:,j)=min(x(:,j))./x(:,j);
 end;
end;

%ranking 20 teratas
for i=1:m,
 V(i)= sum(w.*R(i,:))
end;

[nilai nr]=sort(V,'descend');%diurutkan secara descending

global a
for rank=1:20, %meranking menjadi 20 data
	a.urut=[a.urut; [nilai(rank), nr(rank)]]; %memilih datanya bedasarkan nilai V dan nomor
	disp (a.urut); %menampilkan data yang sudah urut
	set(handles.uitable2,'Data',a.urut);
end;

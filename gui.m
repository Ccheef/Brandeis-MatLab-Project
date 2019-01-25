%Team Project: Musicpedia
%Cosi177a. Scientific Process in Matlab
%Team member: Jerry(Boyuan) Sun, Qifu(Cheef) Yin, Siyuan(Bailey) Lu
%Date: May 2, 2017
%This code implements GUI interface, making this program more organized
%and software-like

function varargout = gui(varargin)
% create an axes that spans the whole gui
%ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
%bg = imread('example.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
%set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
%uistack(ah, 'bottom');
%GUI MATLAB code file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('Property','Value',...) creates a new GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to gui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI('CALLBACK') and GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 29-Apr-2017 19:42:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Get filename from the edit text box
filename=get(handles.edit1,'String');
%use built-in audioread function
[track,Fs] = audioread(filename);
tracklength = len2time(length(track), Fs);
%call miscinfo function, to get average,variance,max and min strength.
info = miscinfo(track);
maxinfo = findpoints(track, info(3), Fs);
mininfo = findpoints(track, info(4), Fs);
%print information in text2
set(handles.text2,'String',sprintf('Time Length: %d min %d sec %d ms\nWeighted Average Strength: %.4f\nResidual of Strength: %.4f\nMax Strength: %.2f (Total number:%d)\nMin Strength: %.2f (Total number:%d)\n',tracklength(1), tracklength(2), tracklength(3),info(1) * 1000,info(2),info(3),length(maxinfo),info(4),length(mininfo)));
beatinfo = bpm_soundenergy(track, Fs, false);
downinfo = bpm_soundenergy(track, Fs, true);
%call keyinfo function to find information about key signature
keyinfo = findkey(track(:, 1), Fs);
%print information in text3
set(handles.text3,'String',sprintf('Number of Beats: %d\nBeats Per Minute: %.2f\nPossible Meter: %s\nMain Tone: %s\nPossible Key Signatures: %s   %s   %s   %s   %s   %s\n',beatinfo(1),beatinfo(2),findmeter(downinfo(1), beatinfo(1)), keyinfo{1}, keyinfo{1:6}));
%plot left channel points in axes1
axes(handles.axes1);
plot(1:length(track), track(:, 1));
title('Left Channel');
%plot right channel points in axes1
axes(handles.axes2);
plot(1:length(track), track(:, 2));
title('Right Channel');


function edit1_Callback(~, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%filename=get(hObject,'String');



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

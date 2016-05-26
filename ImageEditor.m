function varargout = ImageEditor(varargin)
% IMAGEEDITOR MATLAB code for ImageEditor.fig
%      IMAGEEDITOR, by itself, creates a new IMAGEEDITOR or raises the existing
%      singleton*.
%
%      H = IMAGEEDITOR returns the handle to a new IMAGEEDITOR or the handle to
%      the existing singleton*.
%
%      IMAGEEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEEDITOR.M with the given input arguments.
%
%      IMAGEEDITOR('Property','Value',...) creates a new IMAGEEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageEditor

% Last Modified by GUIDE v2.5 26-Dec-2013 01:02:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageEditor_OutputFcn, ...
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

% --- Executes just before ImageEditor is made visible.
function ImageEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageEditor (see VARARGIN)

% Choose default command line output for ImageEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in gallery1Btn.
function gallery1Btn_Callback(hObject, eventdata, handles)
% hObject    handle to gallery1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile({'*.*'}, 'Load Image File');
if (FileName==0) % cancel pressed
    return;
end

handles.fullPath = [PathName FileName];
[a, b, Ext] = fileparts(FileName);
availableExt = {'.bmp', '.jpg', '.jpeg', '.tiff', '.png', '.gif', '.tif'};
FOUND = 0;
for i = 1 : length(availableExt)
    if (strcmpi(Ext, availableExt{i}))
        FOUND = 1;
        break;
    end
end

if (FOUND == 0)
    h = msgbox('File type not supported!', 'Error', 'error');
    return;
end

I = imread(handles.fullPath);

handles.StaticBG1 = I;
handles.CurrentBG1 = I;
handles.rotateDegree = 0;
handles.resizeValue = 1.0;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
axes(handles.axes3); cla;
guidata(hObject, handles);



% --- Executes on button press in cam1Btn.
function cam1Btn_Callback(hObject, eventdata, handles)
% hObject    handle to cam1Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vid = videoinput('winvideo');
set(vid, 'ReturnedColorSpace', 'rgb');
I = getsnapshot(vid);
delete(vid);

handles.StaticBG1 = I;
handles.CurrentBG1 = I;
handles.rotateDegree = 0;
handles.resizeValue = 1.0;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
axes(handles.axes3); cla;
guidata(hObject,handles);


% --- Executes on button press in cam2Btn.
function cam2Btn_Callback(hObject, eventdata, handles)
% hObject    handle to cam2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vid = videoinput('winvideo');
set(vid, 'ReturnedColorSpace', 'rgb');
I = getsnapshot(vid);
delete(vid);

handles.StaticBG2 = I;

axes(handles.axes2); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
axes(handles.axes3); cla;
guidata(hObject,handles);


% --- Executes on button press in gallery2Btn.
function gallery2Btn_Callback(hObject, eventdata, handles)
% hObject    handle to gallery2Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile({'*.*'}, 'Load Image File');
if (FileName == 0) % cancel pressed
    return;
end

handles.fullPath = [PathName FileName];
[a, b, Ext] = fileparts(FileName);
availableExt = {'.bmp', '.jpg', '.jpeg', '.tiff', '.png', '.gif', '.tif'};
FOUND = 0;
for i = 1 : length(availableExt)
    if (strcmpi(Ext, availableExt{i}))
        FOUND = 1;
        break;
    end
end

if (FOUND == 0)
    h = msgbox('File type not supported!', 'Error', 'error');
    return;
end

I = imread(handles.fullPath);
handles.StaticBG2 = I;

axes(handles.axes2); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
axes(handles.axes3); cla;
guidata(hObject, handles);


% --- Executes on selection change in edge1Popup.
function edge1Popup_Callback(hObject, eventdata, handles)
% hObject    handle to edge1Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns edge1Popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from edge1Popup

contents = cellstr(get(hObject,'String'));
c = contents{get(hObject,'Value')};

switch (c)
    
    case 'Edge Detect'
        I = handles.StaticBG1;
        
    case 'Sobel'
        G = rgb2gray(handles.StaticBG1);
        I = edge(G, 'sobel');
        
    case 'Prewit'
        G = rgb2gray(handles.StaticBG1);
        I = edge(G, 'prewitt');
        
    case 'Canny'
        G = rgb2gray(handles.StaticBG1);
        I = edge(G, 'canny');
        
    case 'LoG'
        G = rgb2gray(handles.StaticBG1);
        I = edge(G, 'log');
end

handles.CurrentBG1 = handles.StaticBG1;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 1));
axes(handles.axes6); cla; imhist(I(:, :, 1));
axes(handles.axes3); cla;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edge1Popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edge1Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in effectsPopup.
function effectsPopup_Callback(hObject, eventdata, handles)
% hObject    handle to effectsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns effectsPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from effectsPopup

contents = cellstr(get(hObject,'String'));
c = contents{get(hObject,'Value')};

switch (c)
    
    case 'Effects'  % Default case - Revert to original
        I = handles.StaticBG1;
        
    case 'Sepia' 
        G = handles.StaticBG1;
        G = im2double(G);
        I = Sepia(G);
        
    case 'Grayscale'
        G = handles.StaticBG1;
        G = im2double(G);
        I = Greyscale(G);
        
    case 'False Colour'
        G = handles.StaticBG1;
        I = FalseColour(G);
        
    case 'Enhance'
        G = handles.StaticBG1;
        G = im2double(G);
        I = Enhance(G);
end

handles.CurrentBG1 = I;

axes(handles.axes1); cla; imshow(handles.StaticBG1);
axes(handles.axes3); cla; imshow(I);

axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function effectsPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to effectsPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function brightnessSlider_Callback(hObject, eventdata, handles)
% hObject    handle to brightnessSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

v = get(hObject,'Value');
G = handles.StaticBG1;
I = G + v;

percent = uint8((v + 255) / 5.1);
set(handles.brightVal, 'String', [num2str(percent) '%']);

handles.CurrentBG1 = I;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function brightnessSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightnessSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function blendSlider_Callback(hObject, eventdata, handles)
% hObject    handle to blendSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global blendCount;
a = get(hObject, 'Value');
set(handles.blendVal, 'String', a);

switch (blendCount)
    
    case 0  % Default case - Revert to original
        I = handles.StaticBG1; 
        
    case 1 
        I = NormalBlend(handles.Blend1, handles.Blend2, a); 
        
    case 2
        [~, n, ~] = size(handles.Blend1);
        overlapArea = 64 * a;
        mat = SigmoidMatrix(n, overlapArea);
        I = SigmoidBlend(handles.Blend1, handles.Blend2, mat);
        
    case 3
        I = NormalBlend(handles.Blend1, handles.Blend2, 0.5); 
        
    case 4
        I = NormalBlend(handles.Blend1, handles.Blend2, 0.5); 
end

axes(handles.axes3); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function blendSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blendSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function blendVal_Callback(hObject, eventdata, handles)
% hObject    handle to blendVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blendVal as text
%        str2double(get(hObject,'String')) returns contents of blendVal as a double


% --- Executes during object creation, after setting all properties.
function blendVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blendVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in blendPopup.
function blendPopup_Callback(hObject, eventdata, handles)
% hObject    handle to blendPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns blendPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from blendPopup

G1 = handles.CurrentBG1;
G1 = im2double(G1);

G2 = handles.StaticBG2;
G2 = im2double(G2);
[m, n, d] = size(G1);
G2 = imresize(G2, [m n]);

global blendCount;
contents = cellstr(get(hObject,'String'));
c = contents{get(hObject,'Value')};

switch (c)
    
    case 'Blend Mode'  % Default case - Revert to original
        I = G1;
        blendCount = 0; 
        
    case 'Normal' 
        I = NormalBlend(G1, G2, 0.5);
        blendCount = 1; 
        
    case 'Sigmoid'
        mat = SigmoidMatrix(n, 32);
        I = SigmoidBlend(G1, G2, mat);
        blendCount = 2; 
        
    case 'Gaussian'
        I = NormalBlend(G1, G2, 0.5);
        blendCount = 3; 
        
    case 'Poisson'
        I = NormalBlend(G1, G2, 0.5);
        blendCount = 4; 
end

handles.Blend1 = G1;
handles.Blend2 = G2;

axes(handles.axes3); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function blendPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blendPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in blueBtn.
function blueBtn_Callback(hObject, eventdata, handles)
% hObject    handle to blueBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blueBtn

c = get(hObject,'Value');

switch (c)
    
    case 0
        G = handles.StaticBG1;
        G(:, :, 3) = 0;
        
    case 1
        G = handles.StaticBG1;
        G(:, :, 3) = 255;
end

handles.CurrentBG1 = G;

axes(handles.axes1); cla; imshow(G);
axes(handles.axes4); cla; imhist(G(:, :, 1));
axes(handles.axes5); cla; imhist(G(:, :, 2));
axes(handles.axes6); cla; imhist(G(:, :, 3));
guidata(hObject, handles);


% --- Executes on button press in greenBtn.
function greenBtn_Callback(hObject, eventdata, handles)
% hObject    handle to greenBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of greenBtn

c = get(hObject,'Value');

switch (c)
    
    case 0
        G = handles.StaticBG1;
        G(:, :, 2) = 0;
        
    case 1
        G = handles.StaticBG1;
        G(:, :, 2) = 255;
end

handles.CurrentBG1 = G;

axes(handles.axes1); cla; imshow(G);
axes(handles.axes4); cla; imhist(G(:, :, 1));
axes(handles.axes5); cla; imhist(G(:, :, 2));
axes(handles.axes6); cla; imhist(G(:, :, 3));
guidata(hObject, handles);


% --- Executes on button press in redBtn.
function redBtn_Callback(hObject, eventdata, handles)
% hObject    handle to redBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of redBtn

c = get(hObject,'Value');

switch (c)
    
    case 0
        G = handles.StaticBG1;
        G(:, :, 1) = 0;
        
    case 1
        G = handles.StaticBG1;
        G(:, :, 1) = 255;
end

handles.CurrentBG1 = G;

axes(handles.axes1); cla; imshow(G);
axes(handles.axes4); cla; imhist(G(:, :, 1));
axes(handles.axes5); cla; imhist(G(:, :, 2));
axes(handles.axes6); cla; imhist(G(:, :, 3));
guidata(hObject, handles);



% --- Executes on slider movement.
function color1Slider_Callback(hObject, eventdata, handles)
% hObject    handle to color1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color1Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color1Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function color2Slider_Callback(hObject, eventdata, handles)
% hObject    handle to color2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function color2Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color2Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in filterPopup.
function filterPopup_Callback(hObject, eventdata, handles)
% hObject    handle to filterPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filterPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filterPopup

contents = cellstr(get(hObject,'String'));
c = contents{get(hObject,'Value')};

switch (c)
    
    case 'Filters'  % Default case - Revert to original
        I = handles.StaticBG1;
        
    case 'Blur' 
        G = handles.StaticBG1;
        G = im2double(G);
        len = 21;
        theta = 0;
        handles.psf = fspecial('motion', len, theta);
        I = imfilter(G, handles.psf, 'conv', 'circular');
        handles.Blurred = I;
        
    case 'Noisy'
        I = imnoise(handles.StaticBG1, 'gaussian', 0, 0.005);
        
    case 'Salt Pepper'
        I = imnoise(handles.StaticBG1, 'salt & pepper', 0.02);
        
    case 'De-Blur'
        I = deconvwnr(handles.Blurred, handles.psf);
        
    case 'Median'
        G = handles.StaticBG1;
        I = Median(G);
end

handles.CurrentBG1 = I;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
axes(handles.axes3); cla;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function filterPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rotatePlusBtn.
function rotatePlusBtn_Callback(hObject, eventdata, handles)
% hObject    handle to rotatePlusBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.rotateDegree = handles.rotateDegree + 10;
I = imrotate(handles.StaticBG1, handles.rotateDegree, 'bilinear');

handles.CurrentBG1 = I;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);


% --- Executes on button press in rotateMinusBtn.
function rotateMinusBtn_Callback(hObject, eventdata, handles)
% hObject    handle to rotateMinusBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.rotateDegree = handles.rotateDegree - 10;
I = imrotate(handles.StaticBG1, handles.rotateDegree, 'bilinear');

handles.CurrentBG1 = I;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);


% --- Executes on button press in resizeMinusBtn.
function resizeMinusBtn_Callback(hObject, eventdata, handles)
% hObject    handle to resizeMinusBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.resizeValue = handles.resizeValue - 0.04;
I = imresize(handles.StaticBG1, handles.resizeValue);

handles.CurrentBG1 = I;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);


% --- Executes on button press in resizePlusBtn.
function resizePlusBtn_Callback(hObject, eventdata, handles)
% hObject    handle to resizePlusBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.resizeValue = handles.resizeValue + 0.04;
I = imresize(handles.StaticBG1, handles.resizeValue);

handles.CurrentBG1 = I;

axes(handles.axes1); cla; imshow(I);
axes(handles.axes4); cla; imhist(I(:, :, 1));
axes(handles.axes5); cla; imhist(I(:, :, 2));
axes(handles.axes6); cla; imhist(I(:, :, 3));
guidata(hObject, handles);



% --- Manual Functions - Customized Image editing functions mainly done on
% a per pixel processing process.


% Greyscaling an image
function ImgOut = Greyscale(ImgIn)
% Average out the color values in each channel
% Used for getting a grey image and preserving 3 channels (redundancy)

[m, n, d] = size(ImgIn);
ImgOut = zeros(m, n, d);

for x = 1 : m
    for y = 1 : n
        ImgOut(x, y, 1) = (ImgIn(x, y, 1) * 0.333) + (ImgIn(x, y, 2) * 0.333) + (ImgIn(x, y, 3) * 0.333);
        ImgOut(x, y, 2) = ImgOut(x, y, 1);
        ImgOut(x, y, 3) = ImgOut(x, y, 1);
    end
end

% Sepia Toning an image
function ImgOut = Sepia(ImgIn)
% ImgIn MUST be in double format
% Sepia toning from RGB image based on A.FORGE library formula

[m, n, d] = size(ImgIn);
ImgOut = zeros(m, n, d);

for x = 1 : m
    for y = 1 : n
        ImgOut(x, y, 1) = (ImgIn(x, y, 1) * 0.393) + (ImgIn(x, y, 2) * 0.769) + (ImgIn(x, y, 3) * 0.189);
        ImgOut(x, y, 2) = (ImgIn(x, y, 1) * 0.349) + (ImgIn(x, y, 2) * 0.686) + (ImgIn(x, y, 3) * 0.168);
        ImgOut(x, y, 3) = (ImgIn(x, y, 1) * 0.272) + (ImgIn(x, y, 2) * 0.534) + (ImgIn(x, y, 3) * 0.131);
    end
end

% False Colouring an image - Interchange color channels
function ImgOut = FalseColour(ImgIn)
% Randomly interchange between R, G, B

R = [1 2 3];
R = R(randperm(3));

[m, n, ~] = size(ImgIn);
ImgOut = ImgIn;

for x = 1 : m
    for y = 1 : n
        ImgOut(x, y, 1) = ImgIn(x, y, R(1));
        ImgOut(x, y, 2) = ImgIn(x, y, R(2));
        ImgOut(x, y, 3) = ImgIn(x, y, R(3));
    end
end


% Blending 2 images - Simple averaging with slider
function ImgOut = NormalBlend(Img1, Img2, a)
% Img1, Img2 MUST be in double format and of SAME SIZE
% a is also a double value between 0.0 and 1.0 

[m, n, d] = size(Img1);
ImgOut = Img1;

for x = 1 : m
    for y = 1 : n
        ImgOut(x, y, 1) = a * Img1(x, y, 1) + (1.0 - a) * Img2(x, y, 1);
        ImgOut(x, y, 2) = a * Img1(x, y, 2) + (1.0 - a) * Img2(x, y, 2);
        ImgOut(x, y, 3) = a * Img1(x, y, 3) + (1.0 - a) * Img2(x, y, 3);
    end
end


% Generate the sigmoid weight distribution for any row - left to right
function mat = SigmoidMatrix(width, a)
% input parameter a determines the main slope of the sigmoid curve
% this provides a measure of the spread area between the images

mat = zeros(1, width);
mat = im2double(mat);

for i = 1 : width
    x = i - width / 2;
    mat(i) = 1 / (1 + exp(-x / a)); 
end


% Blending 2 images - Overlay stitch left to right
function ImgOut = SigmoidBlend(Img1, Img2, mat)
% Img1, Img2 MUST be in double format and of SAME SIZE
% a is also a double value between 0.0 and 1.0 

[m, n, ~] = size(Img1);
ImgOut = Img1;

for x = 1 : m
    for y = 1 : n
        ImgOut(x, y, 1) = mat(y) * Img1(x, y, 1) + (1.0 - mat(y)) * Img2(x, y, 1);
        ImgOut(x, y, 2) = mat(y) * Img1(x, y, 2) + (1.0 - mat(y)) * Img2(x, y, 2);
        ImgOut(x, y, 3) = mat(y) * Img1(x, y, 3) + (1.0 - mat(y)) * Img2(x, y, 3);
    end
end


% Median filtering of RGB color image
function ImgOut = Median(ImgIn)
% Img1, Img2 MUST be in double format and of SAME SIZE
% a is also a double value between 0.0 and 1.0 

[m, n, d] = size(ImgIn);
ImgOut = ImgIn;

MedRed   = medfilt2(ImgIn(:, :, 1));
MedGreen = medfilt2(ImgIn(:, :, 2));
MedBlue  = medfilt2(ImgIn(:, :, 3));

for x = 1 : m
    for y = 1 : n
        ImgOut(x, y, 1) = MedRed(x, y);
        ImgOut(x, y, 2) = MedGreen(x, y);
        ImgOut(x, y, 3) = MedBlue(x, y);
    end
end


% Contrast adjustment of RGB color image
function ImgOut = Enhance(ImgIn)
% ImgIn is in RGB format color image
% RGB image is converted to HSV color space
% Histogram Equalization done over V and S, gives a clear and vivid effect
% ImgOut is converted back to RGB

[m, n, d] = size(ImgIn);
ImgOut = ImgIn;

HSV = rgb2hsv(ImgIn);
H = HSV(:, :, 1);
S = HSV(:, :, 2);
V = HSV(:, :, 3);
V = adapthisteq(V);
S = adapthisteq(S);

for x = 1 : m
    for y = 1 : n
        ImgOut(x, y, 1) = H(x, y);
        ImgOut(x, y, 2) = S(x, y);
        ImgOut(x, y, 3) = V(x, y);
    end
end

ImgOut = hsv2rgb(ImgOut);
imwrite(ImgOut, 'output.jpg');

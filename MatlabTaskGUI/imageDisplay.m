function varargout = imageDisplay(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageDisplay_OpeningFcn, ...
                   'gui_OutputFcn',  @imageDisplay_OutputFcn, ...
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
% global variables------------------------------------------------------
global a;
global collectImage;
global low0OR1;
global heigh0OR1;
%displaying function----------------------------------------------------
function imageDisplay_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);


function varargout = imageDisplay_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


%---------------------------used function-------------------------------


%browsing an image function
function Browes_Callback(hObject, eventdata, handles)
    [Filename, Pathname] = uigetfile('*.jpg','File Selector');
    name = strcat(Pathname, Filename);
    global a;
    a = imread(name);
    set(handles.edit1, 'string', name);
    axes(handles.BrowesAxies);
    imshow(a);

%rotate function
function Rotate_Callback(hObject, eventdata, handles)
    global a ;
    a = imrotate(a,45);
    axes(handles.BrowesAxies);
    imshow(a);


%adjustment function
function Adjust_Callback(hObject, eventdata, handles)


%histogram function
function Histogram_Callback(hObject, eventdata, handles)
    global a;
    axes(handles.histAxies);
    imhist(a);


%cut function
function Cut_Callback(hObject, eventdata, handles)
    global a;global collectImage;
    r = str2double (get(handles.rows, 'String'));
    c = str2double(get(handles.columns, 'String'));
    %disp(r);
    [height, width,~] = size(a);
     boxWidth =floor(width/c);
     boxHeight = floor(height/r);
     figure;
     for i = 1:c
         for j = 1:r
             startX = (i-1)*boxWidth+1;
             startY = (j-1)*boxHeight+1 ;
             endX = startX + boxWidth -1;
             endY = startY + boxHeight -1;
             subImage = a(startY:endY, startX:endX,:);
             subplot(r,c,(j-1)*c+i)
             imshow(subImage)
             collect(startY: endY, startX:endX,:) = subImage;
         end
     end
   collectImage = collect;


%collect function
function Collect_Callback(hObject, eventdata, handles)
global collectImage;
axes(handles.cutAxies);
imshow(collectImage);


%edit rows
function rows_Callback(hObject, eventdata, handles)
function rows_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


%edit columns
function columns_Callback(hObject, eventdata, handles)
function columns_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


%slider functions-------------------------------------------------------
function HighAdjustmentSlider_Callback(hObject, eventdata, handles)
    global a;
    global low0OR1; 
    global heigh0OR1;
    low0OR1 = str2double(get(handles.low01, 'String'));
    heigh0OR1= str2double(get(handles.heigh01, 'String'));
    data = get(handles.HighAdjustmentSlider,'Value')
    data1 = str2double(num2str(data))
    if  data1<1 && (low0OR1 ==1 || low0OR1 ==0)&&(heigh0OR1==1 ||heigh0OR1==0)      
        a = imadjust(a,[ data1 1 ] , [low0OR1 heigh0OR1]);
        disp(data1)
        axes(handles.BrowesAxies);
        imshow(a);
    else
        disp("low must be less than 1 or high and low must be 0 or 1")
    end

function HighAdjustmentSlider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
function low01_Callback(hObject, eventdata, handles)


function low01_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function heigh01_Callback(hObject, eventdata, handles)

function heigh01_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function logSlider_Callback(hObject, eventdata, handles)
    global a;
    data = get(handles.logSlider,'Value')
    data1 = str2double(num2str(data))
    disp( data1)
    a = im2uint8 ( mat2gray ( log(data1 + double ( a ))));
    axes(handles.BrowesAxies);
    imshow(a);
  
function logSlider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

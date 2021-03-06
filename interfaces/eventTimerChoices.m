function varargout = eventTimerChoices(varargin)
% EVENTTIMERCHOICES M-file for eventTimerChoices.fig
%      EVENTTIMERCHOICES, by itself, creates a new EVENTTIMERCHOICES or raises the existing
%      singleton*.
%
%      H = EVENTTIMERCHOICES returns the handle to a new EVENTTIMERCHOICES or the handle to
%      the existing singleton*.
%
%      EVENTTIMERCHOICES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EVENTTIMERCHOICES.M with the given input arguments.
%
%      EVENTTIMERCHOICES('Property','Value',...) creates a new EVENTTIMERCHOICES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eventTimerChoices_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eventTimerChoices_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eventTimerChoices

% Last Modified by GUIDE v2.5 12-Oct-2009 17:09:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eventTimerChoices_OpeningFcn, ...
                   'gui_OutputFcn',  @eventTimerChoices_OutputFcn, ...
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


% --- Executes just before eventTimerChoices is made visible.
function eventTimerChoices_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eventTimerChoices (see VARARGIN)

% Choose default command line output for eventTimerChoices
handles.output = hObject;
set(handles.imageText, 'String', varargin{1});

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes eventTimerChoices wait for user response (see UIRESUME)
 uiwait(handles.eventTimerChoices);


% --- Outputs from this function are returned to the command line.
function varargout = eventTimerChoices_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

varargout{1} = get(handles.saveMaskCheck, 'Value');
varargout{2} = str2double(get(handles.beforeText, 'String'));
varargout{3} = str2double(get(handles.afterText, 'String'));
varargout{4} = get(handles.rememberCheck, 'Value');
if varargout{4} == 1
    rememberCondition = get(handles.rememberConditionRadio, 'Value');
    if rememberCondition == 1
        varargout{5} = 'condition';
    else
        varargout{5} = 'all';
    end
else
    varargout{5} = 'none';
end
close(hObject);


% --- Executes on button press in saveMaskCheck.
function saveMaskCheck_Callback(hObject, eventdata, handles)
% hObject    handle to saveMaskCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveMaskCheck

checkState = get(hObject, 'Value');
if checkState == 1
    set(handles.beforeText, 'Enable', 'on');
    set(handles.afterText, 'Enable', 'on');
else
    set(handles.beforeText, 'Enable', 'off');
    set(handles.afterText, 'Enable', 'off');
end


% --- Executes on button press in rememberCheck.
function rememberCheck_Callback(hObject, eventdata, handles)
% hObject    handle to rememberCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

checkState = get(hObject, 'Value');
if checkState == 1
    set(handles.rememberConditionRadio, 'Enable', 'on');
    set(handles.rememberAllRadio, 'Enable', 'on');
else
    set(handles.rememberConditionRadio, 'Enable', 'off');
    set(handles.rememberAllRadio, 'Enable', 'off');
end


% Hint: get(hObject,'Value') returns toggle state of rememberCheck


% --- Executes on button press in okButton.
function okButton_Callback(hObject, eventdata, handles)
% hObject    handle to okButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Check to see the user only entered numbers for frames before and after the
%ROI.
beforeText = get(handles.beforeText, 'String');
afterText = get(handles.afterText, 'String');

numStringBefore = str2double(beforeText);
numStringAfter = str2double(beforeText);

lenBeforeText = length(beforeText);
lenNumStringBefore = length(numStringBefore);    

lenAfterText = length(afterText);
lenNumStringAfter = length(numStringAfter);    

if isempty(numStringBefore) || lenBeforeText ~= lenNumStringBefore
        hWarndlg = warndlg('Numbers only for frames before or after ROI');
        uiwait(hWarndlg);
        uicontrol(handles.beforeText);
        return;
end

if isempty(numStringAfter) || lenAfterText ~= lenNumStringAfter
        hWarndlg = warndlg('Numbers only for frames before or after ROI');
        uiwait(hWarndlg);
        uicontrol(handles.afterText);
        return;
end



uiresume;



% --- Executes on button press in rememberConditionCheck.
function rememberConditionCheck_Callback(hObject, eventdata, handles)
% hObject    handle to rememberConditionCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rememberConditionCheck


% --- Executes on button press in rememberAllCheck.
function rememberAllCheck_Callback(hObject, eventdata, handles)
% hObject    handle to rememberAllCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rememberAllCheck



function beforeText_Callback(hObject, eventdata, handles)
% hObject    handle to beforeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beforeText as text
%        str2double(get(hObject,'String')) returns contents of beforeText as a double


% --- Executes during object creation, after setting all properties.
function beforeText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beforeText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function afterText_Callback(hObject, eventdata, handles)
% hObject    handle to afterText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of afterText as text
%        str2double(get(hObject,'String')) returns contents of afterText as a double


% --- Executes during object creation, after setting all properties.
function afterText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to afterText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



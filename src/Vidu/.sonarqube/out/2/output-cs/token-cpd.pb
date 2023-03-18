–
<D:\Vidu\src\Vidu\Application\Commands\CloseSessionCommand.cs
	namespace 	
Application
 
. 
Commands 
; 
public

 
record

 
CloseSessionCommand

 !
(

! "
string

" (
	SessionId

) 2
)

2 3
:

4 5
IRequest

6 >
<

> ?
Unit

? C
>

C D
;

D E
public 
class &
CloseSessionCommandHandler '
:( )
IRequestHandler* 9
<9 :
CloseSessionCommand: M
,M N
UnitO S
>S T
{ 
private 
readonly 
IPersistanceService (
_persistanceService) <
;< =
public 
&
CloseSessionCommandHandler %
(% &
IPersistanceService& 9
persistanceService: L
)L M
{ 
_persistanceService 
= 
persistanceService 0
;0 1
} 
public 

async 
Task 
< 
Unit 
> 
Handle "
(" #
CloseSessionCommand# 6
request7 >
,> ?
CancellationToken@ Q
cancellationTokenR c
)c d
{ 
var 
session 
= 
await 
_persistanceService /
. 
GetSessionAsyncById  
(  !
request! (
.( )
	SessionId) 2
,2 3
cancellationToken4 E
)E F
;F G
if 

( 
session 
== 
null 
) 
{ 	
throw 
new !
ArgumentNullException +
(+ ,
$str, T
)T U
;U V
} 	
var 
client 
= 
new 

RestClient #
(# $
)$ %
;% &
var 
httpRequest 
= 
new 
RestRequest )
() *
$str* X
+Y Z
request[ b
.b c
	SessionIdc l
,l m
Methodn t
.t u
Deleteu {
){ |
;| }
httpRequest   
.   
	AddHeader   
(   
$str   -
,  - .
$str  / S
)  S T
;  T U
RestResponse!! 
response!! 
=!! 
await!!  %
client!!& ,
.!!, -
ExecuteAsync!!- 9
(!!9 :
httpRequest!!: E
)!!E F
;!!F G
return## 
Unit## 
.## 
Value## 
;## 
}$$ 
}%% ô%
@D:\Vidu\src\Vidu\Application\Commands\CreateConnectionCommand.cs
	namespace 	
Application
 
. 
Commands 
; 
public 
record #
CreateConnectionCommand %
(% &
string& ,
Id- /
,/ 0
string0 6
UserId7 =
)= >
:? @
IRequestA I
<I J
stringJ P
>P Q
;Q R
public 
class *
CreateConnectionCommandHandler +
:, -
IRequestHandler. =
<= >#
CreateConnectionCommand> U
,U V
stringW ]
>] ^
{ 
private 
readonly 
IPersistanceService (
_persistanceService) <
;< =
public 
*
CreateConnectionCommandHandler )
() *
IPersistanceService* =
persistanceService> P
)P Q
{ 
_persistanceService 
= 
persistanceService 0
;0 1
} 
public 

async 
Task 
< 
string 
> 
Handle $
($ %#
CreateConnectionCommand% <
request= D
,D E
CancellationTokenF W
cancellationTokenX i
)i j
{ 
var 
session 
= 
await 
_persistanceService /
. )
FindByUserIdInSpecificSession *
(* +
request+ 2
.2 3
Id3 5
,5 6
request7 >
.> ?
UserId? E
,E F
cancellationTokenF W
)W X
;X Y
if 

( 
session 
== 
null 
) 
{ 	
throw   
new   !
ArgumentNullException   +
(  + ,
$str  , r
)  r s
;  s t
}!! 	
var$$ 
client$$ 
=$$ 
new$$ 

RestClient$$ #
($$# $
)$$$ %
;$$% &
var%% 
restTequest%% 
=%% 
new%% 
RestRequest%% )
(%%) *
$str%%* X
+%%X Y
session%%Y `
.%%` a
Id%%a c
+%%c d
$str%%d q
,%%q r
Method%%s y
.%%y z
Post%%z ~
)%%~ 
;	%% €
restTequest&& 
.&& 
	AddHeader&& 
(&& 
$str&& -
,&&- .
$str&&/ S
)&&S T
;&&T U
RestResponse'' 
response'' 
='' 
await''  %
client''& ,
.'', -
ExecuteAsync''- 9
(''9 :
restTequest'': E
)''E F
;''F G
if(( 

((( 
response(( 
.(( 
Content(( 
!=(( 
null((  $
)(($ %
{)) 	
var** 
content** 
=** 
JObject** !
.**! "
Parse**" '
(**' (
response**( 0
.**0 1
Content**1 8
)**8 9
;**9 :
session++ 
.++ 
AddConnection++ !
(++! "
content++" )
[++) *
$str++* .
]++. /
is++0 2
not++3 6
null++7 ;
?++< =
content++> E
[++E F
$str++F J
]++J K
!++K L
.++L M
ToString++M U
(++U V
)++V W
:++W X
$str++X Z
,++Z [
content,, 
[,, 
$str,, 
],, 
is,,  "
not,,# &
null,,' +
?,,, -
content,,. 5
[,,5 6
$str,,6 <
],,< =
!,,= >
.,,> ?
ToString,,? G
(,,G H
),,H I
:,,I J
$str,,J L
,,,L M
(-- 
bool-- 
)-- 
(-- 
content-- 
[-- 
$str-- '
]--' (
??--) +
false--, 1
)--1 2
)--2 3
;--3 4
await.. 
_persistanceService.. %
...% &
Update..& ,
(.., -
session..- 4
,..4 5
cancellationToken..6 G
)..G H
;..H I
return// 
content// 
[// 
$str// "
]//" #
.//# $
ToString//$ ,
(//, -
)//- .
.//. /
Remove/// 5
(//5 6
$num//6 7
,//7 8
$num//9 :
)//: ;
;//; <
}00 	
else11 
{22 	
return33 
$str33 
;33 
}44 	
}55 
}66 ç
=D:\Vidu\src\Vidu\Application\Commands\CreateSessionCommand.cs
	namespace		 	
Application		
 
.		 
Commands		 
;		 
public 
record  
CreateSessionCommand "
(" #
List# '
<' (
string( .
>. /
UserIds0 7
)7 8
:9 :
IRequest; C
<C D

SessionDtoD N
>N O
;O P
public 
class '
CreateSessionCommandHandler (
:) *
IRequestHandler+ :
<: ; 
CreateSessionCommand; O
,O P

SessionDtoQ [
>[ \
{ 
private 
readonly 
IMapper 
_mapper $
;$ %
private 
readonly 
IPersistanceService (
_persistanceService) <
;< =
private 
readonly 
IGRPCService !
_grpcService" .
;. /
public 
'
CreateSessionCommandHandler &
(& '
IMapper' .
mapper/ 5
,5 6
IPersistanceService7 J
persistanceServiceK ]
,] ^
IGRPCService_ k
grpcServicel w
)w x
{ 
_mapper 
= 
mapper 
; 
_grpcService 
= 
grpcService "
;" #
_persistanceService 
= 
persistanceService 0
;0 1
} 
public 

async 
Task 
< 

SessionDto  
>  !
Handle" (
(( ) 
CreateSessionCommand) =
request> E
,E F
CancellationTokenG X
cancellationTokenY j
)j k
{ 
var 
session 
= 
_grpcService #
.# $

SendCreate$ .
(. /
)/ 0
;0 1
foreach 
( 
var 
userId 
in 
request &
.& '
UserIds' .
). /
{ 	
session 
. 
	AddUserId 
( 
userId $
)$ %
;% &
}   	
await"" 
_persistanceService"" !
.""! "
Insert""" (
(""( )
session"") 0
,""0 1
cancellationToken""2 C
)""C D
;""D E
return$$ 
_mapper$$ 
.$$ 
Map$$ 
<$$ 

SessionDto$$ %
>$$% &
($$& '
session$$' .
)$$. /
;$$/ 0
}%% 
}&& §
=D:\Vidu\src\Vidu\Application\Commands\UpdateSessionCommand.cs
	namespace 	
Application
 
. 
Commands 
; 
public 
record  
UpdateSessionCommand "
(" #
string# )
Id* ,
,, -
int. 1
Duration2 :
,: ;
string< B
ReasonC I
)I J
:K L
IRequestM U
<U V
SessionV ]
>] ^
;^ _
public

 
class

 '
UpdateSessionCommandHandler

 (
:

) *
IRequestHandler

+ :
<

: ; 
UpdateSessionCommand

; O
,

O P
Session

Q X
>

X Y
{ 
private 
readonly 
IPersistanceService (
_persistanceService) <
;< =
public 
'
UpdateSessionCommandHandler &
(& '
IPersistanceService' :
persistanceService; M
)M N
{ 
_persistanceService 
= 
persistanceService 0
;0 1
} 
public 

async 
Task 
< 
Session 
> 
Handle %
(% & 
UpdateSessionCommand& :
request; B
,B C
CancellationTokenD U
cancellationTokenV g
)g h
{ 
var 
session 
= 
await 
_persistanceService /
. 
GetSessionAsyncById  
(  !
request! (
.( )
Id) +
,+ ,
cancellationToken- >
)> ?
;? @
if 

( 
session 
== 
null 
) 
{ 	
throw 
new 
	Exception 
(  
$str  f
)f g
;g h
} 	
var 
updatedSession 
= 
session $
.$ %
AddClosedInfo% 2
(2 3
request3 :
.: ;
Duration; C
,C D
requestE L
.L M
ReasonM S
)S T
;T U
await 
_persistanceService !
.! "
Update" (
(( )
updatedSession) 7
,7 8
cancellationToken9 J
)J K
;K L
return 
updatedSession 
; 
}   
}!! ƒ
0D:\Vidu\src\Vidu\Application\Commons\IMapFrom.cs
	namespace 	
Application
 
. 
Commons 
; 
public 
	interface 
IMapFrom 
< 
T 
> 
{ 
void 
Mapping	 
( 
Profile 
profile  
)  !
=>" $
profile% ,
., -
	CreateMap- 6
(6 7
typeof7 =
(= >
T> ?
)? @
,@ A
GetTypeB I
(I J
)J K
)K L
;L M
} Ä"
6D:\Vidu\src\Vidu\Application\Commons\MappingProfile.cs
	namespace 	
Application
 
. 
Commons 
. 
Mappings &
;& '
public 
class 
MappingProfile 
: 
Profile %
{ 
public 

MappingProfile 
( 
) 
{		 %
ApplyMappingsFromAssembly

 !
(

! "
Assembly

" *
.

* + 
GetExecutingAssembly

+ ?
(

? @
)

@ A
)

A B
;

B C
} 
private 
void %
ApplyMappingsFromAssembly *
(* +
Assembly+ 3
assembly4 <
)< =
{ 
var 
mapFromType 
= 
typeof  
(  !
IMapFrom! )
<) *
>* +
)+ ,
;, -
var 
mappingMethodName 
= 
nameof  &
(& '
IMapFrom' /
</ 0
object0 6
>6 7
.7 8
Mapping8 ?
)? @
;@ A
bool 
HasInterface 
( 
Type 
t  
)  !
=>" $
t% &
.& '
IsGenericType' 4
&&5 7
t8 9
.9 :$
GetGenericTypeDefinition: R
(R S
)S T
==U W
mapFromTypeX c
;c d
var 
types 
= 
assembly 
. 
GetExportedTypes -
(- .
). /
./ 0
Where0 5
(5 6
t6 7
=>8 :
t; <
.< =
GetInterfaces= J
(J K
)K L
.L M
AnyM P
(P Q
HasInterfaceQ ]
)] ^
)^ _
._ `
ToList` f
(f g
)g h
;h i
var 
argumentTypes 
= 
new 
Type  $
[$ %
]% &
{' (
typeof) /
(/ 0
Profile0 7
)7 8
}9 :
;: ;
foreach 
( 
var 
type 
in 
types "
)" #
{ 	
var 
instance 
= 
	Activator $
.$ %
CreateInstance% 3
(3 4
type4 8
)8 9
;9 :
var 

methodInfo 
= 
type !
.! "
	GetMethod" +
(+ ,
mappingMethodName, =
)= >
;> ?
if 
( 

methodInfo 
!= 
null "
)" #
{   

methodInfo!! 
.!! 
Invoke!! !
(!!! "
instance!!" *
,!!* +
new!!, /
object!!0 6
[!!6 7
]!!7 8
{!!9 :
this!!; ?
}!!@ A
)!!A B
;!!B C
}"" 
else## 
{$$ 
var%% 

interfaces%% 
=%%  
type%%! %
.%%% &
GetInterfaces%%& 3
(%%3 4
)%%4 5
.%%5 6
Where%%6 ;
(%%; <
HasInterface%%< H
)%%H I
.%%I J
ToList%%J P
(%%P Q
)%%Q R
;%%R S
if'' 
('' 

interfaces'' 
.'' 
Count'' $
>''% &
$num''' (
)''( )
{(( 
foreach)) 
()) 
var))  

@interface))! +
in)), .

interfaces))/ 9
)))9 :
{** 
var++ 
interfaceMethodInfo++ /
=++0 1

@interface++2 <
.++< =
	GetMethod++= F
(++F G
mappingMethodName++G X
,++X Y
argumentTypes++Z g
)++g h
;++h i
interfaceMethodInfo-- +
?--+ ,
.--, -
Invoke--- 3
(--3 4
instance--4 <
,--< =
new--> A
object--B H
[--H I
]--I J
{--K L
this--M Q
}--R S
)--S T
;--T U
}.. 
}// 
}00 
}11 	
}22 
}33 ×
<D:\Vidu\src\Vidu\Application\Commons\ViduConnectionConfig.cs
	namespace 	
Application
 
. 
Commons 
; 
public 
class  
ViduConnectionConfig !
{ 
public 

string 
BaseUrl 
{ 
get 
;  
set! $
;$ %
}& '
public 

string 
RestUrl 
{ 
get 
;  
set! $
;$ %
}& '
public		 

string		 
Authorization		 
{		  !
get		" %
;		% &
set		' *
;		* +
}		, -
}

 §
0D:\Vidu\src\Vidu\Application\ConfigureService.cs
	namespace 	
	Microsoft
 
. 

Extensions 
. 
DependencyInjection 2
;2 3
public 
static 
class 
ConfigureServices %
{ 
public		 

static		 
IServiceCollection		 $"
AddApplicationServices		% ;
(		; <
this		< @
IServiceCollection		A S
services		T \
)		\ ]
{

 
services 
. 
AddAutoMapper 
( 
Assembly '
.' ( 
GetExecutingAssembly( <
(< =
)= >
)> ?
;? @
services 
. 
	AddScoped 
< 
IPersistanceService .
,. /
PersistService0 >
>> ?
(? @
)@ A
;A B
services 
. 
	AddScoped 
< 
IGRPCService '
,' (
GRPCService) 4
>4 5
(5 6
)6 7
;7 8
services 
. 

AddMediatR 
( 
cfg 
=> 
cfg 
. *
RegisterServicesFromAssemblies 1
(1 2
Assembly 
.  
GetExecutingAssembly -
(- .
). /
)/ 0
) 
; 
return 
services 
; 
} 
} -
+D:\Vidu\src\Vidu\Application\GlobalUsing.cs×
1D:\Vidu\src\Vidu\Application\Models\SessionDto.cs
	namespace 	
Application
 
. 
Models 
; 
public 
record 

SessionDto 
: 
IMapFrom #
<# $
Session$ +
>+ ,
{ 
public 

bool 
	Recording 
; 
public		 

string		 
	MediaMode		 
;		 
public

 

string

 
RecordingMode

 
;

  
public 

string 
ForcedVideoCodec "
;" #
public 

bool 
allowTranscoding  
;  !
} 
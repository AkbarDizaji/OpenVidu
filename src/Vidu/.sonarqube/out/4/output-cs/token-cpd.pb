¸
7D:\Vidu\src\Vidu\Presentation\App_Start\WebApiConfig.cs
	namespace 	
WebHookReceivers
 
{ 
public 

static 
class 
WebApiConfig $
{ 
public 
static 
void 
Register #
(# $
HttpConfiguration$ 5
config6 <
)< =
{ 	
config 
. "
MapHttpAttributeRoutes )
() *
)* +
;+ ,
config 
. 
Routes 
. 
MapHttpRoute &
(& '
name 
: 
$str "
," #
routeTemplate 
: 
$str 6
,6 7
defaults 
: 
new 
{ 
id  "
=# $
RouteParameter% 3
.3 4
Optional4 <
}= >
) 
; 
config 
. 0
$InitializeReceiveGenericJsonWebHooks 7
(7 8
)8 9
;9 :
} 	
} 
} ˝
9D:\Vidu\src\Vidu\Presentation\Controllers\ApiContoller.cs
	namespace 	
Presentation
 
. 
Controllers "
;" #
[ 
ApiController 
] 
[ 
Route 
( 
$str 
) 
] 
public 
class 
ApiController 
: 
ControllerBase +
{		 
private

 
readonly

 
ILogger

 
<

 
ApiController

 *
>

* +
_logger

, 3
;

3 4
private 
readonly 
IOpenViduService %
_openViduService& 6
;6 7
public 

ApiController 
( 
ILogger  
<  !
ApiController! .
>. /
logger0 6
,6 7
IOpenViduService8 H
openViduServiceI X
)X Y
{ 
_logger 
= 
logger 
; 
_openViduService 
= 
openViduService *
;* +
_openViduService 
. 
RegisterHandler (
(( )
	SaveEvent) 2
)2 3
;3 4
} 
private 
Task 
	SaveEvent 
( 
OpenViduEvent (
data) -
)- .
{ 
_logger 
. 
LogInformation 
( 
data #
.# $
Json$ (
)( )
;) *
System 
. 
Diagnostics 
. 
Debug  
.  !
	WriteLine! *
(* +
$str+ ;
); <
;< =
return 
Task 
. 
CompletedTask !
;! "
} 
}   ˇ
AD:\Vidu\src\Vidu\Presentation\Controllers\ConnectionController.cs
	namespace 	
Presentation
 
. 
Controllers "
;" #
[		 
Route		 
(		 
$str		 
)		 
]		 
[

 
ApiController

 
]

 
public 
class  
ConnectionController !
:" #

Controller$ .
{ 
	protected 
	IMediator 
Mediator  
=>! #
HttpContext$ /
./ 0
RequestServices0 ?
.? @
GetRequiredService@ R
<R S
	IMediatorS \
>\ ]
(] ^
)^ _
;_ `
[ 
HttpPost 
] 
[  
ProducesResponseType 
( 
$num 
) 
] 
[  
ProducesResponseType 
( 
$num 
) 
] 
public 

async 
Task 
CreateConnection &
(& '
[ 	
FromBody	 
] #
CreateConnectionCommand *
request+ 2
,2 3
CancellationToken 
cancellationToken +
) 
=> 
await	 
Mediator 
. 
Send 
( 
request $
,$ %
cancellationToken& 7
)7 8
;8 9
} ô%
>D:\Vidu\src\Vidu\Presentation\Controllers\SessionController.cs
	namespace 	
Presentation
 
. 
Controllers "
;" #
[ 
Route 
( 
$str 
) 
] 
[ 
AllowAnonymous 
] 
[ 
ApiController 
] 
public 
class 
SessionController 
:  

Controller! +
{ 
	protected 
	IMediator 
Mediator  
=>! #
HttpContext$ /
./ 0
RequestServices0 ?
.? @
GetRequiredService@ R
<R S
	IMediatorS \
>\ ]
(] ^
)^ _
;_ `
[ 
HttpPost 
] 
[  
ProducesResponseType 
( 
$num 
) 
] 
[    
ProducesResponseType   
(   
$num   
)   
]   
public!! 

async!! 
Task!! 
CreateSession!! #
(!!# $
["" 	
FromBody""	 
]""  
CreateSessionCommand"" '
request""( /
,""/ 0
CancellationToken## 
cancellationToken## +
)$$ 
=>$$ 
await$$	 
Mediator$$ 
.$$ 
Send$$ 
($$ 
request$$ $
,$$$ %
cancellationToken$$& 7
)$$7 8
;$$8 9
[,, 

HttpDelete,, 
(,, 
$str,, 
),, 
],, 
[--  
ProducesResponseType-- 
(-- 
$num-- 
)-- 
]-- 
[..  
ProducesResponseType.. 
(.. 
$num.. 
).. 
].. 
public// 

async// 
Task// 
CloseSession// "
(//" #
string00 
	sessionId00 
,00 
CancellationToken11 
cancellationToken11 +
)22 
=>22 
await22	 
Mediator22 
.22 
Send22 
(22 
new22  
CloseSessionCommand22! 4
(224 5
	sessionId225 >
)22> ?
,22? @
cancellationToken22A R
)22R S
;22S T
[44 
HttpPost44 
]44 
[55 
Route55 

(55
 
$str55 
)55 
]55 
public66 

async66 
Task66 
ViduCallBack66 "
(66" #
)66# $
{77 
var88 
a88 
=88 
$num88 
;88 
var:: 
req:: 
=:: 
HttpContext:: 
.:: 
Request:: %
;::% &
using<< 
StreamReader<< 
reader<< !
=<<" #
new<<$ '
StreamReader<<( 4
(<<4 5
req<<5 8
.<<8 9
Body<<9 =
,<<= >
Encoding<<? G
.<<G H
UTF8<<H L
,<<L M
true<<N R
,<<R S
$num<<T X
,<<X Y
true<<Z ^
)<<^ _
;<<_ `
var>> 
bodyStr>> 
=>> 
await>> 
reader>> "
.>>" #
ReadToEndAsync>># 1
(>>1 2
)>>2 3
;>>3 4
var@@ 
content@@ 
=@@ 
JObject@@ 
.@@ 
Parse@@ #
(@@# $
bodyStr@@$ +
)@@+ ,
;@@, -
ifBB 

(BB 
contentBB 
[BB 
$strBB 
]BB 
.BB 
ToStringBB %
(BB% &
)BB& '
==BB( *
$strBB+ =
)BB= >
{CC 	
awaitDD 
MediatorDD 
.DD 
SendDD 
(DD  
newDD  # 
UpdateSessionCommandDD$ 8
(DD8 9
contentDD9 @
[DD@ A
$strDDA L
]DDL M
.DDM N
ToStringDDN V
(DDV W
)DDW X
,DDX Y
Int32DDZ _
.DD_ `
ParseDD` e
(DDe f
contentDDf m
[DDm n
$strDDn x
]DDx y
.DDy z
ToString	DDz Ç
(
DDÇ É
)
DDÉ Ñ
)
DDÑ Ö
,
DDÖ Ü
content
DDá é
[
DDé è
$str
DDè ó
]
DDó ò
.
DDò ô
ToString
DDô °
(
DD° ¢
)
DD¢ £
)
DD£ §
,
DD§ •
new
DD¶ ©
CancellationToken
DD™ ª
(
DDª º
)
DDº Ω
)
DDΩ æ
;
DDæ ø
}EE 	
}GG 
}II .
,D:\Vidu\src\Vidu\Presentation\GlobalUsing.cs
(D:\Vidu\src\Vidu\Presentation\Program.cs
var 
builder 
= 
WebApplication 
. 
CreateBuilder *
(* +
args+ /
)/ 0
;0 1
builder 
. 
Services 
. 
AddControllers 
(  
)  !
;! "
builder 
. 
Services 
. #
AddEndpointsApiExplorer (
(( )
)) *
;* +
builder 
. 
Services 
. 
AddSwaggerGen 
( 
)  
;  !
builder 
. 
Services 
. "
AddApplicationServices '
(' (
)( )
;) *
var 
app 
= 	
builder
 
. 
Build 
( 
) 
; 
if 
( 
app 
. 
Environment 
. 
IsDevelopment !
(! "
)" #
)# $
{ 
app 
. 

UseSwagger 
( 
) 
; 
app 
. 
UseSwaggerUI 
( 
) 
; 
} 
app 
. 
UseHttpsRedirection 
( 
) 
; 
app(( 
.(( 
UseAuthorization(( 
((( 
)(( 
;(( 
app** 
.** 
MapControllers** 
(** 
)** 
;** 
app,, 
.,, 
Run,, 
(,, 
),, 	
;,,	 
“
7D:\Vidu\src\Vidu\Presentation\Service\StorageService.cs
	namespace 	
Presentation
 
. 
Service 
; 
public 
class 
StorageService 
: 
IHostedService ,
{ 
private 
readonly 
IOpenViduService %
_openViduService& 6
;6 7
public

 

StorageService

 
(

 
IOpenViduService

 *
openViduService

+ :
)

: ;
{ 
_openViduService 
= 
openViduService *
;* +
} 
private 
Task 

StoreEvent 
( 
OpenViduEvent )
@event* 0
)0 1
{ 
System 
. 
Diagnostics 
. 
Debug  
.  !
	WriteLine! *
(* +
$str+ ;
); <
;< =
return 
Task 
. 
CompletedTask !
;! "
} 
public 

void 
Init 
( 
) 
{ 
_openViduService 
. 
RegisterHandler (
(( )

StoreEvent) 3
)3 4
;4 5
} 
public 

Task 

StartAsync 
( 
CancellationToken ,
cancellationToken- >
)> ?
{ 
Init 
( 
) 
; 
return   
Task   
.   
CompletedTask   !
;  ! "
}!! 
public## 

Task## 
	StopAsync## 
(## 
CancellationToken## +
cancellationToken##, =
)##= >
{$$ 
return%% 
Task%% 
.%% 
CompletedTask%% !
;%%! "
}&& 
}'' 
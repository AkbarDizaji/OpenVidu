õ
?D:\Vidu\src\Vidu\Infrastructure\ExternalServices\IRestClient.cs
	namespace 	
Infrastructure
 
. 
ExternalServices )
{ 
public		 

	interface		 
IRestClient		  
{

 
} 
} 0
.D:\Vidu\src\Vidu\Infrastructure\GlobalUsing.cs¡
3D:\Vidu\src\Vidu\Infrastructure\GRPC\GRPCService.cs
	namespace 	
Infrastructure
 
. 
GRPC 
; 
public 
class 
GRPCService 
: 
IGRPCService '
{ 
public		 

Session		 

SendCreate		 
(		 
)		 
{

 
CreateSessionReply 
reply  
=! "
new# &
CreateSessionReply' 9
(9 :
): ;
;; <
var 
channel 
= 
GrpcChannel !
.! "

ForAddress" ,
(, -
$str- E
)E F
;F G
try 
{ 	
var 
client 
= 
new 
Greeter $
.$ %
GreeterClient% 2
(2 3
channel3 :
): ;
;; <
var 
reply2 
= 
client 
.  
SendSessionCreate  1
(1 2
new  
CreateSessionRequest (
(( )
)) *
) 
; 
reply 
= 
reply2 
; 
} 	
catch 
( 
	Exception 
ex 
) 
{ 	
throw 
; 
} 	
return 
new 
Session 
( 
reply  
.  !
Id! #
,# $
reply% *
.* +
	Recording+ 4
,4 5
reply6 ;
.; <
	MediaMode< E
,E F
replyG L
.L M
RecordingModeM Z
,Z [
reply 
. 
ForcedVideoCodec "
," #
reply$ )
.) *
AllowTranscoding* :
): ;
;; <
} 
} Œ
4D:\Vidu\src\Vidu\Infrastructure\GRPC\IGRPCService.cs
	namespace 	
Infrastructure
 
. 
GRPC 
; 
public 
	interface 
IGRPCService 
{ 
Session 

SendCreate 
( 
) 
; 
} Ì	
BD:\Vidu\src\Vidu\Infrastructure\Persistance\IPersistanceService.cs
	namespace 	
Infrastructure
 
. 
Persistance $
;$ %
public 
	interface 
IPersistanceService $
{ 
Task 
< 	
Session	 
> 
GetSessionAsyncById %
(% &
string& ,
Id- /
,/ 0
CancellationToken1 B
cancellationTokenC T
)T U
;U V
Task		 
<		 	
Session			 
>		 )
FindByUserIdInSpecificSession		 /
(		/ 0
string		0 6
id		7 9
,		9 :
string		; A
userId		B H
,		H I
CancellationToken		I Z
cancellationToken		[ l
)		l m
;		m n
Task 
Insert	 
( 
Session 
session 
,  
CancellationToken! 2
cancellationToken3 D
)D E
;E F
Task 
Update	 
( 
Session 
session 
,  
CancellationToken! 2
cancellationToken3 D
)D E
;E F
} Ö'
=D:\Vidu\src\Vidu\Infrastructure\Persistance\PersistService.cs
	namespace 	
Infrastructure
 
. 
Persistance $
{		 
public

 

class

 
PersistService

 
:

  !
IPersistanceService

" 5
{ 
private 
MongoClient 
mongoClient '
;' (
private 
IMongoDatabase 
db !
;! "
private 
IMongoCollection  
<  !
Session! (
>( )

collection* 4
;4 5
public 
PersistService 
( 
) 
{ 	
mongoClient 
= 
new 
MongoClient )
() *
)* +
;+ ,
db 
= 
mongoClient 
. 
GetDatabase (
(( )
$str) 4
)4 5
;5 6

collection 
= 
db 
. 
GetCollection )
<) *
Session* 1
>1 2
(2 3
$str3 =
)= >
;> ?
} 	
public 
async 
Task 
Insert  
(  !
Session! (
session) 0
,0 1
CancellationToken2 C
cancellationTokenD U
)U V
{ 	
await 

collection 
. 
InsertOneAsync +
(+ ,
session, 3
,3 4
cancellationToken5 F
)F G
;G H
} 	
public 
async 
Task 
Update  
(  !
Session! (
session) 0
,0 1
CancellationToken2 C
cancellationTokenD U
)U V
{ 	
var 
filter 
= 
Builders !
<! "
Session" )
>) *
.* +
Filter+ 1
.1 2
Eq2 4
(4 5
s5 6
=>7 9
s: ;
.; <
Id< >
,> ?
session@ G
.G H
IdH J
)J K
;K L
await 

collection 
. 
ReplaceOneAsync ,
(, -
filter- 3
,3 4
session5 <
)< =
;= >
}   	
public"" 
async"" 
Task"" 
<"" 
Session"" !
>""! "
GetSessionAsyncById""# 6
(""6 7
string""7 =
Id""> @
,""@ A
CancellationToken""B S
cancellationToken""T e
)""e f
{## 	
var$$ 
filter$$ 
=$$ 
Builders$$ !
<$$! "
Session$$" )
>$$) *
.$$* +
Filter$$+ 1
.$$1 2
Eq$$2 4
($$4 5
s$$5 6
=>$$7 9
s$$: ;
.$$; <
Id$$< >
,$$> ?
Id$$@ B
)$$B C
;$$C D
return&& 
await&& 

collection&& #
.&&# $
Find&&$ (
(&&( )
filter&&) /
)&&/ 0
.&&0 1
FirstOrDefaultAsync&&1 D
(&&D E
)&&E F
;&&F G
}'' 	
public)) 
async)) 
Task)) 
<)) 
Session)) !
>))! ")
FindByUserIdInSpecificSession))# @
())@ A
string))A G
id))H J
,))J K
string))K Q
userId))R X
,))X Y
CancellationToken))Z k
cancellationToken))l }
)))} ~
{** 	
var++ 
filter++ 
=++ 
Builders++ !
<++! "
Session++" )
>++) *
.++* +
Filter+++ 1
.++1 2
Eq++2 4
(++4 5
$str++5 >
,++> ?
userId++@ F
)++F G
;++G H
filter,, 
&=,, 
(,, 
Builders,, 
<,,  
Session,,  '
>,,' (
.,,( )
Filter,,) /
.,,/ 0
Eq,,0 2
(,,2 3
$str,,3 8
,,,8 9
id,,: <
),,< =
),,= >
;,,> ?
var-- 

projection-- 
=-- 
Builders-- %
<--% &
Session--& -
>--- .
.--. /

Projection--/ 9
.--9 :
Include--: A
(--A B
$str--B K
)--K L
;--L M
var// 
item// 
=// 
await// 

collection// '
.00 
Find00 
(00 
filter00 
)00 
.22 
FirstOrDefaultAsync22 $
(22$ %
cancellationToken22% 6
)226 7
;227 8
return33 
item33 
;33 
}44 	
}66 
}77 
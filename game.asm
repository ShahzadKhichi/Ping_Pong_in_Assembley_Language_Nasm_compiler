[org 0x0100]
jmp start
welcome:db        '                        Welcome to Ping Pong Game ',0
intstructions:db  '                             Instructions',0
intstruct1:db     '1. Player1 can move paddle up and down using w and s repectively',0
intstruct2:db     '2. Player2 can move paddle up and down using arrow up and arrow down repectively',0
intstruct3:db     '3. The player that will make 5 score first is the winner of game ',0
intstruct4:db     '4. Increment of score will happen if opponent miss the ball from his/her side  ',0
intstruct5:db     '5. To pause or unpause the Game  at any moment you can press p  ',0
intstruct6:db     '6. To Exit the Game at  any moment press ESC (expect pause moment)',0
intstruct7:db     'Ali Naqi(23F-3052), Shahzad(23F-3012), Wijdan Hyder(23F-3024)',0
continue :db      '                      Press any key to start the Game',0
player1:db        'Ali Naqi won the Game ',0
player2:db        'Shahzad won the Game ',0
scorestr:db       'Score : ',0
pauseStr:db       'Game Paused',0
unpauseStr:db     '           ',0
lenth:dw 0
score1:dw 0
score2:dw 0
p1:db 'Ali Naqi',0
p2:db 'Shahzad',0
winScore:dw 5
leftPaddle: dw 1950,2110,2270
rightPaddle:dw 2046,2206,2366
Walls:dw 506,610,346,3706
boolExit:dw 0
cls:
    push ax
    push di
    push es
    mov di,0
    mov ax,0xb800
    mov es,ax
    mov ax,0x720
    mov cx,2000
    cld
    rep stosw
    
    pop es
    pop di
    pop ax
    ret
strlen: 
    push bp
    mov bp,sp
    push es
    push cx
    push di
    les di, [bp+4] 
    mov cx, 0xffff 
    xor al, al 
    repne scasb 
    mov ax, 0xffff 
    sub ax, cx 
    dec ax 

    pop di
    pop cx
    pop es
    pop bp
    ret 4

printstr: 
    push bp
    mov bp, sp
    push es
    push ax
    push cx
    push si
    push di
    push ds 
    mov ax, [bp+4]
    push ax 
    call strlen 
    cmp ax, 0 
    jz exit 
    mov [lenth],ax
    mov cx, ax 
    mov ax, 0xb800
    mov es, ax 
    mov di,[bp+6]
    mov si, [bp+4] 
    mov ah, 0x07
    cld 
nextchar: 
    lodsb 
    stosw 
    loop nextchar 
exit:
    pop di
    pop si
    pop cx
    pop ax
    pop es
    pop bp
    ret 4
intialLoader:
    push ax

    call cls
    mov ax,160
    push ax
    mov ax,welcome
    push ax
    call printstr

    mov ax,320
    push ax
    mov ax,intstructions
    push ax
    call printstr


    mov ax,480
    push ax
    mov ax,intstruct1
    push ax
    call printstr

    mov ax,640
    push ax
    mov ax,intstruct2
    push ax
    call printstr

    mov ax,800
    push ax
    mov ax,intstruct3
    push ax
    call printstr

    mov ax,960
    push ax
    mov ax,intstruct4
    push ax
    call printstr

    mov ax,1120
    push ax
    mov ax,intstruct5
    push ax
    call printstr

    mov ax,1280
    push ax
    mov ax,intstruct6
    push ax
    call printstr

    mov ax,1600
    push ax
    mov ax,continue
    push ax
    call printstr
	
    mov ax,1780
    push ax
    mov ax,intstruct7
    push ax
    call printstr

    pop ax
    ret 
printScore:
    push es
    push di
    push ax

    mov ax,0xb800
    mov es,ax
    mov ax,2084
    push ax
    mov ax,scorestr
    push ax
    call printstr

      mov ax,1764
    push ax
    mov ax,p1
    push ax
    call printstr

    mov ax,0x0730
    add ax,[score1]

    mov di,2100

    stosw
    mov ax,2216
    push ax
    mov ax,scorestr
    push ax
    call printstr

     mov ax,1896
    push ax
    mov ax,p2
    push ax
    call printstr

    mov ax,0x0730
    add ax,[score2]
    mov di,2232
    
    stosw


    pop ax
    pop di
    pop es
    ret

designBorder:
    push bp
    mov bp,sp
    push dx
    push ax
    push es
    push di
    push cx

    mov ax,0xb800
    mov es,ax
    mov di,[bp+4]
    mov dx,[bp+6]
    mov cx,[bp+8]
    mov ax,0x3720
   
doPrint:
    mov [es:di],ax 
    add di,dx
    loop doPrint

    pop cx
    pop di
    pop es
    pop ax
    pop dx
    pop bp
    ret 8   

printBorder:
    push ax

    mov ax,0x49
    push ax
    mov ax,21
    push ax
    mov ax,160
    push ax
    mov ax,506
    push ax
    call designBorder
    mov ax,0x49
    push ax
    mov ax,21
    push ax
    mov ax,160
    push ax
    mov ax,610
    push ax
    call designBorder
    mov ax,0x5f
    push ax
    mov ax,53
    push ax
    mov ax,2
    push ax
    mov ax,346
    push ax
    call designBorder
    mov ax,0x5f
    push ax
    mov ax,51
    push ax
    mov ax,2
    push ax
    mov ax,3708
    push ax
    call designBorder

    pop ax
    ret
desginPaddle: 

    push bp
    mov bp,sp
    push ax
    push es
    push di

    mov ax, 0xb800
    mov es,ax
    mov di,[bp+4]
    mov ax,0x2720
    mov [es:di],ax
    add di,160
    mov [es:di],ax
    add di,160
    mov [es:di],ax

    pop di
    pop es
    pop ax
    pop bp

    ret 2

designBall:

    push bp
    mov bp,sp
    push ax
    push es
    push di

    mov ax, 0xb800
    mov es,ax
    mov di,[bp+4]
    mov ax,0x074f
    mov [es:di],ax
    pop di
    pop es
    pop ax

    pop bp

    ret 2

printGround:
    
    
   
    call printBorder
    push word[leftPaddle]
    call desginPaddle
    push word[rightPaddle]
    call desginPaddle
    call printScore

   
    ret  

moveBall:
    push bp
    mov bp,sp

    push dx
    push ax
    push es
    push di
    push cx

    mov cx,[bp+4]
    shl word[bp+4],1
    mov di,[bp+6]
    mov ax,0xb800
    mov es,ax
    mov dx,[bp+8]

    mov cx,0x0720
    
mover:
    
    mov word[es:di],cx
    add di,dx
    mov cx,[es:di]
    mov word[es:di],0x034f
    call delay
    
    call detectPaddleMove
    
    push di
    mov ax,leftPaddle
    push ax
    call hitPaddelLeft

    push di
    mov ax,rightPaddle
    push ax
    call hitPaddelRight

    mov ax,320
    push ax
    mov ax,2
    push ax
    mov ax,53
    push ax
    mov ax,[Walls+4]
    push ax 
    call hitWalls

    mov ax,-320
    push ax
    mov ax,2
    push ax
    mov ax,53
    push ax
    mov ax,[Walls+6]
    
    push ax 
    call hitWalls

    mov ax,score2
    push ax
    mov ax,98
    push ax
    mov ax,160
    push ax
    mov ax,24
    push ax
    mov ax,[Walls]
    push ax 
    call hitLeftRight



    mov ax,score1
    push ax
    mov ax,-98
    push ax
    mov ax,160
    push ax
    mov ax,24
    push ax
    mov ax,[Walls+2]
    push ax 
    call hitLeftRight
    
    call printBorder
    call printScore
    call checkWinner
  


    cmp word[boolExit],0
    jz mover
  
    pop cx
    pop di
    pop es
    pop ax
    pop dx
   
    pop bp
    ret 6
delay:
    push cx
    push ax


    mov ax,5
delayMaker:
    mov cx,0xFFFF
delayer:  
    loop delayer
    dec ax  
    cmp ax,0

    jne delayMaker
    pop ax
    pop cx
    ret

detectPaddleMove:

    push ax
    push bx
    push di
    
    mov ah,1
    int 0x16
    jz return

    mov ah,0
    int 0x16

    cmp ax,0x011b
    jne checkW
    mov word[boolExit],1
   
checkW:    
    cmp al,0x77
    jne checkS
    mov bx,leftPaddle
    mov di,[bx]
    sub di,160
    cmp di,506
    jle return
    push bx
    call paddleUp
   
checkS:
    cmp al,0x73
    jne checkUp
    mov bx,leftPaddle
    mov di,[bx+4]
    sub di,-160
    cmp di,3706
    jge return
    push bx
    call paddleDown
   
checkUp:
    cmp ax,0x4800
    jne checkDown
    mov bx,rightPaddle
     mov di,[bx]
    add di,-160
    cmp di,506
    jle return
    push bx
    call paddleUp
   
checkDown:
    cmp ax,0x5000
    jne checkPause
    mov bx,rightPaddle
    mov di,[bx+4]
    add di,160
    cmp di,3706
    jge return
    push bx
    call paddleDown
  
return:

checkPause:
    cmp al,0x70
    jne exitFun

    mov bx,60
    push bx
    mov bx,pauseStr
    push bx
    call printstr
pauseLoop:
    mov ah,0
    int 0x16
    cmp al,0x70

    jne pauseLoop

    mov bx,60
    push bx
    mov bx,unpauseStr
    push bx
    call printstr
exitFun:    

    pop di
    pop bx
    pop ax
    
    ret

paddleUp:
    push bp
    mov bp,sp
    push ax
    push bx
    push di

    mov bx,[bp+4]

    mov di,[bx+4]
    mov ax,0x0720
    stosw
    
    add word[bx],-160
    add word[bx+2],-160
    add word[bx+4],-160
    push word[bx]
    call desginPaddle
    

    pop di
    pop bx
    pop ax
    pop bp
    ret 2


paddleDown:

       push bp
    mov bp,sp
    push ax
    push bx
    push di

    mov bx,[bp+4]

    mov di,[bx]
    mov ax,0x0720
    stosw

    add word[bx],160
    add word[bx+2],160
    add word[bx+4],160
    push word[bx]
    call desginPaddle
    

    pop di
    pop bx
    pop ax
    pop bp
    ret 2


ballMotion:
    push ax

    mov ax,-2
    push ax
    mov ax,2158
    push ax
    mov ax,23
    push ax
    call moveBall

    pop ax
    ret  
hitPaddelLeft:
    push bp
    mov bp,sp
    push bx
    push di
    mov bx,[bp+4]
    mov di,[bp+6]
    add di,dx
    cmp di,[bx]
    je FOUND1
    cmp di,[bx+2]
    je FOUND2 
    cmp di,[bx+4]
    je FOUND3  
    jmp notFOUND
FOUND1:
    mov dx,162
    jmp notFOUND
FOUND2:
    mov dx,2
    jmp notFOUND
FOUND3:        
    mov dx,-158
notFOUND:
    pop di
    pop bx
    pop bp
    ret 4
hitPaddelRight:
    push bp
    mov bp,sp
    push bx
    push di
    mov bx,[bp+4]
    mov di,[bp+6]
    add di,dx
    cmp di,[bx]
    je found1
    cmp di,[bx+2]
    je found2 
    cmp di,[bx+4]
    je found3  
    jmp notFound
found1:
    mov dx,158
    jmp notFound
found2:
    mov dx,-2
    jmp notFound
found3:        
    mov dx,-162
notFound:
    pop di
    pop bx
    pop bp
    ret 4  

hitWalls:
    push bp
    mov bp,sp
    push di
    push bx
    push si
    push cx
    push ax

    add di,dx
    mov bx,[bp+4]
    mov cx,[bp+6]
    
checkHitBrick:
    cmp di,bx
    je hitBrick
    add bx,[bp+8]
    loop checkHitBrick
    jmp noHitBrick
hitBrick:
    add dx,[bp+10]
noHitBrick:
    pop ax
    pop cx
    pop si
    pop bx
    pop di
    pop bp
    ret 8


hitLeftRight:

    push bp
    mov bp,sp
    push bx
    push si
    push cx
    push ax

    

    add di,dx
    mov bx,[bp+4]
    mov cx,[bp+6]
checkLeftRightBrick:
    cmp di,bx
    je hitLeftRightBrick
    add bx,[bp+8]
    loop checkLeftRightBrick
    jmp nohitLeftRightBrick

hitLeftRightBrick:

    sub di,dx
    mov ax,0x0720
    stosw 
    sub di,2
    add di,[bp+10]

    mov bx,[bp+12]

    mov ax,[bx]
    inc ax
    mov [bx],ax

    
nohitLeftRightBrick:
    sub di,dx

    pop ax
    pop cx
    pop si
    pop bx
    pop bp
    ret 10

checkWinner:
    push ax
    push bx

    mov bx,word[winScore]
    cmp word[score1],bx
    jl nextCompare
    mov word[boolExit],1

    mov ax,2134
    push ax
    mov ax,player1
    push ax
    call printstr


nextCompare:
    cmp word[score2],bx
    jl noWinner
    mov word[boolExit],1
    mov ax,2134
    push ax
    mov ax,player2
    push ax
    call printstr

noWinner:
    pop ax
    pop bx
    ret;


start:
    

    call intialLoader

    int 0x16
    call cls
    call printGround
    call ballMotion

endGame:
    mov ax,0x4c00
    int 0x21

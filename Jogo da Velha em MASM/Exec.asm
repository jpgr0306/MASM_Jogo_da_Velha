		.386
		.model flat, stdcall
		.stack 4096
		
		ExitProcess PROTO, dwExitCode:DWORD
		
		include Irvine32.inc
		
		.data
		
		;Conjunto de strings para serem impressas
		jogada byte "Insira a posicao da jogada: ",0     
		vertical byte "|",0    
		horizontal byte "---", 0     
		x byte "X", 0     
		o byte "O", 0     
		space byte " ", 0     
		quebralinha BYTE ' ', 13, 10, 0     
		printavitoriax BYTE "<o jogador X ganhou>", 0
		printavitoriao BYTE "<o jogador O ganhou>", 0
		printaempate BYTE "<jogo empatado>", 0
		invalido BYTE "<valor de entrada invalido>", 0
		posicao BYTE "<posicao ja jogada>", 0
		
		;Variável de input do usuário
		myvar byte 20 DUP(?)              
		
		;Vetor de 9 numeros
		dwArray dword 9 dup (?) 
		
		
		.code
		main PROC
		
		;Move vetor de 9 unidades para registrador esi
		mov esi, offset dwArray   
		
		;Inicialização dos registradores          
		xor     ecx, ecx             
		xor     edx, edx             
		xor     ebx, ebx             
		xor     eax, eax            
		
		@@:
		;Inicia todas as posições do vetor com "ESPAÇO"
		mov [esi + 4 * eax], offset space
		
		;Loop para percorrer o vetor com as posições do tabuleiro
		inc eax            
		cmp eax, 9             
		jne @B
		           
		jogo:
		
		;Chamada para o jogador entrar a posição
		mov edx, offset jogada             
		call writestring             
		call readint
		
		;Validação para valor maior que 9
		cmp eax, 9
		jg invalid
		
		;Validação para valor menor que 1
		cmp eax, 1
		jl invalid
		
		;Inicializa a posição com índice 0
		dec eax             
		
		;Validação para posição já preenchida
		mov edx, offset space
		cmp [esi + 4 * eax], edx
		jne utilizado
		
		xor edx, edx
		inc ecx            
		cmp ecx, 1             
		jne d                      
		mov [esi + 4 * eax], offset x             
		cmp ecx, 2            
		jne u             
		d:
		
		;Se ecx = 1, seta a posição escolhida pelo jogador em O
		mov [esi + 4 * eax], offset o             
		
		;Zera ecx, ou seja, jogador O jogou e muda a vez para X!
		xor ecx, ecx              
		u:
		
		;Inicialização de edi e eax
		xor edi, edi              
		xor eax, eax              
		@@:
		
		;Métodos abaixos serão usados para realizar a print do jogo em andamento
		
		mov edx, [esi + 4 * eax]
		call writestring
		inc eax
		mov edx, offset vertical
		call writestring
		mov edx, [esi + 4 * eax]
		call writestring
		inc eax
		mov edx, offset vertical
		call writestring
		mov edx, [esi + 4 * eax]
		call writestring
		inc eax
		
		inc edi
		
		mov edx, offset quebralinha
		call writestring
		cmp edi, 3
		jne @B
		
		;Inicialização de eax, edi e edx
		xor eax, eax
		xor edi, edi
		xor edx, edx
		
		;Na sequência serão testadas todas as 16 situações de vitória de alguém,
		;sendo feitos os desvios necessários para as linhas respectivas
		
		condicao1:
		xor edi, edi
		xor edx, edx
		condicao1a:
		
		mov edx, [esi + 4 * 0]
		mov edi, offset x
		cmp edx, edi
		jne condicao1b
		mov edi, [esi + 4 * 1]
		cmp edx, edi
		jne condicao1b
		mov edx, [esi + 4 * 2]
		cmp edx, edi
		je vitoriax
		
		condicao1b:
		xor edi, edi
		xor edx, edx
		condicao1c:
		
		mov edx, [esi + 4 * 3]
		mov edi, offset x
		cmp edx, edi
		jne condicao1d
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne condicao1d
		mov edx, [esi + 4 * 5]
		cmp edx, edi
		je vitoriax
		
		condicao1d:
		xor edi, edi
		xor edx, edx
		condicao1e:
		
		mov edx, [esi + 4 * 6]
		mov edi, offset x
		cmp edx, edi
		jne condicao2
		mov edi, [esi + 4 * 7]
		cmp edx, edi
		jne condicao2
		mov edx, [esi + 4 * 8]
		cmp edx, edi
		je vitoriax
		
		condicao2:
		xor edi, edi
		xor edx, edx
		condicao2a:
		
		mov edx, [esi + 4 * 0]
		mov edi, offset o
		cmp edx, edi
		jne condicao2b
		mov edi, [esi + 4 * 1]
		cmp edx, edi
		jne condicao2b
		mov edx, [esi + 4 * 2]
		cmp edx, edi
		je vitoriao
		
		condicao2b:
		xor edi, edi
		xor edx, edx
		condicao2c:
		
		mov edx, [esi + 4 * 3]
		mov edi, offset o
		cmp edx, edi
		jne condicao2d
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne condicao2d
		mov edx, [esi + 4 * 5]
		cmp edx, edi
		je vitoriao
		
		condicao2d:
		xor edi, edi
		xor edx, edx
		condicao2e:
		
		mov edx, [esi + 4 * 6]
		mov edi, offset o
		cmp edx, edi
		jne condicao3
		mov edi, [esi + 4 * 7]
		cmp edx, edi
		jne condicao3
		mov edx, [esi + 4 * 8]
		cmp edx, edi
		je vitoriao
		
		condicao3:
		xor edi, edi
		xor edx, edx
		condicao3a:
		
		mov edx, [esi + 4 * 0]
		mov edi, offset x
		cmp edx, edi
		jne condicao3b
		mov edi, [esi + 4 * 3]
		cmp edx, edi
		jne condicao3b
		mov edx, [esi + 4 * 6]
		cmp edx, edi
		je vitoriax
		
		condicao3b:
		xor edi, edi
		xor edx, edx
		condicao3c:
		
		mov edx, [esi + 4 * 1]
		mov edi, offset x
		cmp edx, edi
		jne condicao3d
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne condicao3d
		mov edx, [esi + 4 * 7]
		cmp edx, edi
		je vitoriax
		
		condicao3d:
		xor edi, edi
		xor edx, edx
		condicao3e:
		
		mov edx, [esi + 4 * 2]
		mov edi, offset x
		cmp edx, edi
		jne condicao4
		mov edi, [esi + 4 * 5]
		cmp edx, edi
		jne condicao4
		mov edx, [esi + 4 * 8]
		cmp edx, edi
		je vitoriax
		
		condicao4:
		xor edi, edi
		xor edx, edx
		condicao4a:
		
		mov edx, [esi + 4 * 0]
		mov edi, offset o
		cmp edx, edi
		jne condicao4b
		mov edi, [esi + 4 * 3]
		cmp edx, edi
		jne condicao4b
		mov edx, [esi + 4 * 6]
		cmp edx, edi
		je vitoriao
		
		condicao4b:
		xor edi, edi
		xor edx, edx
		condicao4c:
		
		mov edx, [esi + 4 * 1]
		mov edi, offset o
		cmp edx, edi
		jne condicao4d
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne condicao4d
		mov edx, [esi + 4 * 7]
		cmp edx, edi
		je vitoriao
		
		condicao4d:
		xor edi, edi
		xor edx, edx
		condicao4e:
		
		mov edx, [esi + 4 * 2]
		mov edi, offset o
		cmp edx, edi
		jne condicao5
		mov edi, [esi + 4 * 5]
		cmp edx, edi
		jne condicao5
		mov edx, [esi + 4 * 8]
		cmp edx, edi
		je vitoriao
		
		condicao5:
		xor edi, edi
		xor edx, edx
		condicao5a:
		
		mov edx, [esi + 4 * 0]
		mov edi, offset x
		cmp edx, edi
		jne condicao5b
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne condicao5b
		mov edx, [esi + 4 * 8]
		cmp edx, edi
		je vitoriax
		
		condicao5b:
		xor edi, edi
		xor edx, edx
		condicao5c:
		
		mov edx, [esi + 4 * 2]
		mov edi, offset x
		cmp edx, edi
		jne condicao6
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne condicao6
		mov edx, [esi + 4 * 6]
		cmp edx, edi
		je vitoriax
		
		condicao6:
		xor edi, edi
		xor edx, edx
		condicao6a:
		
		mov edx, [esi + 4 * 0]
		mov edi, offset o
		cmp edx, edi
		jne condicao6b
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne condicao6b
		mov edx, [esi + 4 * 8]
		cmp edx, edi
		je vitoriao
		
		condicao6b:
		xor edi, edi
		xor edx, edx
		condicao6c:
		
		mov edx, [esi + 4 * 2]
		mov edi, offset o
		cmp edx, edi
		jne continuar
		mov edi, [esi + 4 * 4]
		cmp edx, edi
		jne continuar
		mov edx, [esi + 4 * 6]
		cmp edx, edi
		je vitoriao
		
		;Retorna ao jogo se não ocorreram 9 jogadas e, senão, dá o empate
		continuar:
		
		inc ebx
		cmp ebx, 9
		jne jogo   
		cmp ebx, 9
		jmp empate
		
		;Printa na tela o empate e encerra o jogo
		empate:
		mov edx, offset printaempate
		call writestring
		jmp saida
		
		;Printa que o jogador 1 saiu vitorioso
		vitoriax:
		mov edx, offset printavitoriax
		call writestring
		jmp saida
		
		;Printa que o jogador 2 saiu vitorioso
		vitoriao:
		mov edx, offset printavitoriao
		call writestring
		jmp saida
		
		;Printa que um valor de entrada inválido foi inserido
		invalid:
		mov edx, offset invalido
		call writestring
		mov edx, offset quebralinha
		call writestring
		jmp jogo
		
		;Printa que a posição já foi preenchida antes
		utilizado:
		mov edx, offset posicao
		call writestring
		mov edx, offset quebralinha
		call writestring
		jmp jogo
		
		;Encerra o jogo
		saida:
		call readint
		INVOKE ExitProcess, 0
		main ENDP
		
		END main
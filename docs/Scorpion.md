<p align="center">
<img src="resources/scorpion/logo.png" alt="Scorpion Logo" style="max-height: 300px">
</p>


<h1 align="center">Scorpion Bytecode</h1>

<p align="center">
<img src="https://img.shields.io/badge/extension-.scorp-a1a1a1.svg" style="max-height: 300px;" alt="Extension: .scorp">
</p>

Scorpion is a simple instruction language, with a very small [instruction set](#instruction-set).

Lioness is compiled to Scorpion, which can be executed using an interpreter. The interpreter included in this project does not perform any JIT compilation, making it safe to use in sandboxed environments, such as in iOS apps.

## Instruction set
| Mnemonic      | Opcode <br/>(UInt8) | Arguments | Stack <br/>[before] ➡️ [after] | Description                                                                           |
|---------------|---------------------|-----------|-------------------------------|---------------------------------------------------------------------------------------|
| push_const    | 0                   | value     | ➡️ value                       | push ```value``` onto the stack                                                       |
| add           | 1                   |           | value1, value2 ➡️ result       | add two numbers                                                                       |
| sub           | 2                   |           | value1, value2 ➡️ result       | subtract two numbers (```value1``` - ```value2```)                                    |
| mul           | 3                   |           | value1, value2 ➡️ result       | multiply two numbers                                                                  |
| div           | 4                   |           | value1, value2 ➡️ result       | divide two numbers (```value1``` / ```value2```)                                      |
| pow           | 5                   |           | value1, value2 ➡️ result       | raise ```value2``` to power of ```value1```                                           |
| and           | 6                   |           | value1, value2 ➡️ result       | AND two booleans                                                                      |
| or            | 7                   |           | value1, value2 ➡️ result       | OR two booleans                                                                       |
| not           | 8                   |           | value ➡️ result                | inverse boolean                                                                       |
| eq            | 9                   |           | value1, value2 ➡️ result       | compare two values (equal), push result (boolean)                                     |
| neq           | 10                  |           | value1, value2 ➡️ result       | compare two values (not equal), push result (boolean)                                 |
| if_true       | 11                  | label     | value ➡️                       | pop boolean and if true: jump to ```label```                                          |
| if_false      | 12                  | label     | value ➡️                       | pop boolean and if false: jump to ```label```                                         |
| cmple         | 13                  |           | value1, value2 ➡️ result       | compare two values (less than or equal), push result (boolean)                        |
| cmplt         | 14                  |           | value1, value2 ➡️ result       | compare two values (less than), push result (boolean)                                 |
| goto          | 15                  | label     |                               | jump to label                                                                         |
| reg_store     | 16                  | reg       | value ➡️                       | pop value and store in ```reg``` register                                             |
| reg_update    | 17                  | reg       | value ➡️                       | pop value and update in ```reg``` register                                            |
| reg_clear     | 18                  | reg       |                               | clear register ```reg```                                                              |
| reg_load      | 19                  | reg       | ➡️ value                       | get value in ```reg``` register and push onto stack                                   |
| invoke_virt   | 20                  | id        |                               | invoke virtual #```id```                                                              |
| exit_virt     | 21                  |           |                               | exit current virtual                                                                  |
| pop           | 22                  |           | value ➡️                       | pop value and discard                                                                 |
| skip_past     | 23                  | label     |                               | skip program counter one past ```label```                                             |
| struct_init   | 24                  |           | ➡️ struct                      | initialize empty struct and push onto stack                                           |
| struct_set    | 25                  | member    | struct, value ➡️ struct        | pop struct, pop value, set value to ```member```, push updated struct                 |
| struct_update | 26                  | key-path  | struct, value ➡️ struct        | pop struct, pop value, set value to the member at ```key-path```, push updated struct |
| struct_get    | 27                  | member    | struct ➡️ value                | pop struct, get ```member``` value and push it onto the stack                         |
| virt_h        | 28                  |           |                               | virtual header, increments register depth                                             |
| pvirt_h       | 29                  |           |                               | private virtual header, does not increment register depth                             |
| virt_e        | 30                  |           |                               | virtual end, decrements register depth                                                |
| pvirt_e       | 31                  |           |                               | private virtual end, does not decrement register depth                                |

## Examples

<table>
  <tr>
    <th>Lioness</th>
    <th>Scorpion</th> 
  </tr>
  
<tr>

<td>
<pre lang="swift">
a = 1
b = 2
c = a + b
</pre>
</td>

<td>
<pre lang="asm">
1: push_const vnumber(1.0)
2: reg_store i1               ; a
3: push_const vnumber(2.0)
4: reg_store i2               ; b
5: reg_load i1                ; a
6: reg_load i2                ; b
7: add                        ; +
8: reg_store i3               ; c
</pre>
</td>

</tr>

<tr>

<td>
<pre lang="swift">
func isPositive(x) returns {
	return x > 0
}

a = isPositive(2.0)
</pre>
</td>

<td>
<pre lang="asm">
1: virt_h i1                  ; isPositive(x)
	2: skip_past i4               ; skip exit instruction
	3: invoke_virt i2             ; cleanup_isPositive()
	4: exit_virt                  ; exit function
	5: reg_store i1               ; x
	6: push_const vnumber(0.0)
	7: reg_load i1                ; x
	8: cmplt                      ; >
	9: goto i3                    ; return

	10: pvirt_h i2                ; cleanup_isPositive
		11: reg_clear i1              ; cleanup x
	12: pvirt_e

13: virt_e

14: push_const vnumber(2.0)
15: invoke_virt i1            ; isPositive
16: reg_store i2              ; a
</pre>
</td>

</tr>

</table>



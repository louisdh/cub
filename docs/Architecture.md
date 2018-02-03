# Architecture
This project consists of four main steps that, when put together, can run Lioness source code from a raw string to an executed result.

## Lioness pipeline

### Full pipeline:
| 🛬 ```source code``` | ➡️ | Lexer 	| ➡️ | Parser | ➡️ | Compiler |  ➡️ | Interpreter | ➡️ | ```result``` 🛫 |
|---------------------- |---- |------- |---|-------- |--- |---------- |--- |------------- |--- |-------- |

The following table describes the ```I/O``` of each step in the pipeline:

|             	|       Input       	|       Output      |
|:-----------:	|:-----------------:	|:-----------------:|
|    Lexer    	|    Source code    	|       Tokens      |
|    Parser   	|       Tokens      	|        AST        |
|   Compiler  	|        AST        	| [Scorpion Bytecode](Scorpion.md) |
| Interpreter 	| [Scorpion Bytecode](Scorpion.md) 	|  Execution result |

*Note: Each step in the pipeline is independent from all others. This makes unit testing very straight forward.*

#### Practical workflow:
In practice it is common to want to compile source code once and execute it multiple times. The following pipelines provide this in an efficient way:

*Pipeline 1:*

| 🛬 ```source code``` | ➡️ | Lexer 	| ➡️ | Parser | ➡️ | Compiler |  ➡️ | ```Bytecode``` | ➡️ | ```encode``` 🛫 |
|----------------------|----|------- |---|-------- |----|----------|----|----------------|--- |-------- |

This pipeline can be written in Swift as:

```swift
public func compileToBytecode(_ source: String) throws -> BytecodeBody {
    return try (lexer |> parse |> compile)(source)
}
```

This makes use of the custom ```|>``` (pipe) operator.

*Pipeline 2:*

| 🛬 ```decode``` | ➡️ | ```Bytecode``` | ➡️ | Interpreter | ➡️ | ```result``` 🛫 |
|-----------------|----|--------------- |-----|------------ |----|-----------------|

The encoding/decoding will typically be followed by writing/reading the bytecode to disk, to enable efficient distribution. 

Generally the performance of the interpreter step (pipeline 2) is deemed more important than compilation time (pipeline 1). A concrete example of this is compile time code optimization: this will, by definition, slow down compilation time. But the performance gains at runtime are worth it.
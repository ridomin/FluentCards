# FluentCards - Agent Development Guide

This document provides essential information for AI agents working on the FluentCards .NET library for Adaptive Cards.

## Build Commands

### Core Commands
```bash
# Build entire solution
dotnet build

# Build specific project
dotnet build src/FluentCards/FluentCards.csproj
dotnet build tests/FluentCards.Tests/FluentCards.Tests.csproj

# Clean solution
dotnet clean
```

### Testing Commands
```bash
# Run all tests
dotnet test

# Run tests with detailed output
dotnet test --verbosity normal

# Run specific test file
dotnet test tests/FluentCards.Tests/BuilderTests.cs

# Run specific test method
dotnet test --filter "Builder_CreatesValidCard"

# List all available tests
dotnet test --list-tests

# Run tests in specific project
dotnet test tests/FluentCards.Tests/FluentCards.Tests.csproj

# Run tests with coverage (if coverlet is available)
dotnet test --collect:"XPlat Code Coverage"
```

### Sample Projects
```bash
# Run library samples
dotnet run --project samples/FluentCards.Samples

# Run web renderer sample
dotnet run --project samples/RenderAC
```

## Code Style Guidelines

### C# Conventions
- **Target Framework**: .NET 8.0 (net8.0)
- **Language Version**: Latest
- **Nullable Reference Types**: Enabled (`nullable enable`)
- **Implicit Usings**: Enabled (`implicit usings enable`)
- **AOT Compatibility**: Enabled where applicable

### Naming Conventions
- **Classes**: PascalCase (e.g., `AdaptiveCard`, `TextBlockBuilder`)
- **Methods**: PascalCase (e.g., `WithText`, `AddContainer`)
- **Properties**: PascalCase (e.g., `Version`, `HorizontalAlignment`)
- **Fields/Constants**: PascalCase for public, _camelCase for private
- **Enums**: PascalCase with descriptive names (e.g., `TextSize`, `HorizontalAlignment`)

### File Organization
```
src/FluentCards/
├── Root models (AdaptiveCard.cs, AdaptiveElement.cs)
├── Element models (TextBlock.cs, Image.cs, Container.cs, etc.)
├── Builder classes (AdaptiveCardBuilder.cs, TextBlockBuilder.cs, etc.)
├── Enums (TextSize.cs, TextColor.cs, etc.)
├── Serialization/ (JSON converters, serializers)
└── Validation/ (validation logic, exceptions)
```

### Import Organization
- System namespaces first
- Third-party namespaces second
- Local/FluentCards namespaces last
- Use `global using` directives appropriately in project files

### XML Documentation
- All public APIs must have comprehensive XML documentation
- Include `<summary>`, `<param>`, `<returns>` tags
- Use `<exception>` for documented exceptions
- Provide usage examples in documentation where helpful

### Builder Pattern Implementation
- Follow established pattern: `WithXxx()` for properties, `AddXxx()` for collections
- Always return `this` for method chaining
- Use lambda expressions for configuration: `AddTextBlock(tb => tb.WithText("Hello"))`
- Internal fields named with underscore prefix: `_textBlock`

## JSON Serialization

### Source Generators
- Use `System.Text.Json` source generation for AOT compatibility
- Define serialization contexts in `FluentCardsJsonContext.cs`
- Support both indented and compact serialization
- Use `[JsonPolymorphic]` and `[JsonDerivedType]` for inheritance hierarchies

### Custom Converters
- Enum to camelCase conversion via `CamelCaseEnumConverter<T>`
- Special handling for polymorphic properties
- Fallback element conversion

### Property Naming
- JSON properties use camelCase (Adaptive Cards standard)
- C# properties use PascalCase
- Use `[JsonPropertyName]` attribute for mapping

## Validation System

### Validation Pattern
- Static `AdaptiveCardValidator` class with public `Validate()` and `ValidateAndThrow()` methods
- Return `IReadOnlyList<ValidationIssue>` for comprehensive reporting
- Use `ValidationSeverity` enum (Error, Warning, Info)
- Include path, code, and message in validation issues

### Exception Handling
- Custom `AdaptiveCardValidationException` for validation errors
- Include collection of errors in exception
- Use try/catch patterns for optional validation

## Testing Guidelines

### Test Framework
- **Framework**: xUnit
- **Assertions**: Built-in `Assert` class
- **Test Files**: Named with `Tests.cs` suffix
- **Test Methods**: PascalCase with descriptive names

### Test Structure
```csharp
[Fact]
public void Method_Scenario_ExpectedResult()
{
    // Arrange
    var builder = AdaptiveCardBuilder.Create();
    
    // Act
    var result = builder.Build();
    
    // Assert
    Assert.NotNull(result);
}
```

### Test Categories
- Unit tests for individual classes and methods
- Integration tests for complete scenarios
- Serialization tests for JSON handling
- Validation tests for validation logic
- Edge case tests for boundary conditions

## Error Handling

### Exceptions
- Create custom exception types where needed
- Include descriptive messages and relevant context
- Use standard .NET exception patterns
- Document exceptions in XML comments

### Validation Errors
- Collect multiple validation issues before failing
- Provide clear, actionable error messages
- Include property paths in validation issues

## Performance Considerations

### Source Generation
- Prefer source-generated JSON serialization over reflection
- Support both AOT and JIT scenarios
- Minimize allocations in hot paths
- Use `string.IsNullOrEmpty()` and `string.IsNullOrWhiteSpace()` appropriately

### Memory Management
- Use collections efficiently (pre-size when possible)
- Prefer `List<T>` over arrays when size varies
- Use `ReadOnlyCollection<T>` for exposing internal collections

## Compatibility

### Adaptive Cards Schema
- Target Adaptive Cards 1.5 schema
- Support backward compatibility where possible
- Validate against schema requirements
- Handle version-specific features gracefully

### .NET Compatibility
- Support .NET 8.0 and later
- Enable AOT compatibility where possible
- Minimize external dependencies
- Use .NET standard libraries when possible

## Common Patterns

### Adding New Elements
1. Create model class inheriting from `AdaptiveElement` or `AdaptiveAction`
2. Add `[JsonDerivedType]` attribute to base class
3. Create corresponding builder class
4. Add methods to `AdaptiveCardBuilder`
5. Create comprehensive tests
6. Update documentation

### Adding Validation Rules
1. Add validation logic to appropriate private method in `AdaptiveCardValidator`
2. Include severity, path, code, and message
3. Add tests for both positive and negative cases
4. Update exception messages if needed

## Project Structure Understanding

### Solution Layout
- `src/FluentCards/` - Main library code
- `tests/FluentCards.Tests/` - Unit and integration tests
- `samples/FluentCards.Samples/` - Library usage examples
- `samples/RenderAC/` - Web renderer demonstration
- `benchmarks/` - Performance benchmarking code

### Key Dependencies
- `System.Text.Json` - JSON serialization with source generation
- `xunit` - Testing framework
- `coverlet.collector` - Code coverage

## Development Workflow

1. Make changes to library code
2. Run `dotnet build` to ensure compilation
3. Run `dotnet test` to verify all tests pass
4. Test with samples to verify functionality
5. Update documentation if needed
6. Ensure validation and serialization work correctly

When making changes, always consider the fluent API consistency, AOT compatibility, and the overall developer experience.
# FluentCards Documentation

Welcome to the FluentCards API documentation. FluentCards is a .NET library for building Adaptive Cards using a fluent builder pattern with strong typing and JSON serialization powered by Source Generators.

## Features

- 🚀 **Fluent Builder Pattern**: Intuitive, type-safe API for creating Adaptive Cards
- 📊 **AOT Compatible**: Native AOT support for high performance
- 🎯 **Strong Typing**: Full IntelliSense support with compile-time safety
- 📝 **JSON Serialization**: Built-in serialization with Source Generators
- ✅ **Validation**: Comprehensive validation system with detailed error reporting
- 📖 **Complete XML Documentation**: Full IntelliSense support with detailed API documentation

## Getting Started

The library provides a fluent API for creating Adaptive Cards. Here's a simple example:

```csharp
using FluentCards;

var card = AdaptiveCardBuilder
    .Create()
    .AddTextBlock(tb => tb
        .WithText("Hello, World!")
        .WithSize(TextSize.Large)
        .WithWeight(TextWeight.Bolder))
    .AddTextBlock(tb => tb
        .WithText("This is a sample Adaptive Card created with FluentCards."))
    .Build();
```

## API Reference

Use the navigation to explore the complete API documentation.
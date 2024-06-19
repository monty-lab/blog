---
layout: post
title: C++17之std::optional
date: 2024-05-31 18:52 +0800
categories: [C++17]
tags: [C++17]
toc: true
---

类模板 `std::optional` 管理一个可选的容纳值，既可以存在也可以不存在的值。

一种常见的使用情况是一个可能失败的函数的返回值。与其他手段，如 `std::pair<T, bool>` 相比，optional 良好地处理构造开销高昂的对象，并更加可读，因为它显式表达意图。

# 成员函数

## 1. 构造函数

![optional_construction.png](/assets/img/optional_construction.png)

(1) 构造不含值的对象。

```cpp
std::optional<double> opt;
```

(2) 复制构造函数：如果 other 包含值，那么初始化所含值，如同以表达式 `T obj(*other)` 直接初始化（\*other 代表解引用后的对象, 但不是直接列表初始化）T 类型的对象。如果 other 不含值，那么构造一个不含值的对象。

(3) 移动构造函数：如果 other 含值，那么初始化所含值，如同以表达式 `std::move(*other)` 直接初始化（但不是直接列表初始化）T 类型的对象，且不令 other 为空：被移动的 std::optional 仍然包含值，但该值自身是被移动的。如果 other 不含值，那么构造一个不含值的对象。

```cpp
std::optional<double> a(10.09); // 创建一个包含值10.09的std::optional对象
std::optional<double> b(std::move(a)); //使用移动构造函数创建一个新的std::optional对象
```

(8) 转型构造函数：构造一个含值的对象，如同从实参 std::forward\<U\>(value) 直接初始化（但不是直接列表初始化）T 类型的对象一般初始化。

```cpp
std::optional<double> a(10.09); // 创建一个包含值10.09的std::optional对象
```

## 2. operator=

![optional_operator=.png](/assets/img/optional_operator=.png)

从中看出std::optional的赋值函数参数包括std::nullopt_t、左值引用、右值引用、模板单值、模板做值和模板右值。

## 3. 观察器

### 3.1 operator->和operator*

operator->返回所含值的指针；operator*返回所含值的引用

此运算符不检查 optional 是否含值！你能手动用 has_value() 或简单地用 operator bool() 做检查。另外，若需要有检查访问，可使用 value() 或 value_or()。

### 3.2 operator bool和has_value

检查对象是否含值

### 3.3 value 和 value_or

std::optional\<T\>::value 若 *this 含值，则返回到所含值的引用。

std::optional\<T\>::value_or 若 *this 含值则返回其所含的值，否则返回 default_value

```cpp
template< class U >
constexpr T value_or( U&& default_value ) const&;

// 等价于

bool(*this) ? **this : static_cast<T>(std::forward<U>(default_value))
```

[参考链接：std::optional-cppreference.com](https://zh.cppreference.com/w/cpp/utility/optional)
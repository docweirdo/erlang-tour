# erlang-tour
A few lines of Erlang Code to explain basic syntax and concepts alongside a presentation

## Motivation
This repository serves as a collection of a few erlang files which I and a study partner used to explain and showcase the basics of the Erlang syntax, functionality and 
some core concepts of the language. They have little to no explanation in inline comments, as these examples were used alongside a presantation.

## Structure
The idea with these files is an iterative expansion. They revolve around a catshop, in which workes a catshop clerk. Customers can order cats and return them.
This example was very vaguely inspired by some chapters of the Book [Learn You Some Erlang for great good!](https://learnyousomeerlang.com/).

The general structure is as follows:

### catshop_clerk_1_1
Modules, imports and exports, records and basic functions

### catshop_clerk_1_2
Recursion, Pattern Matching, Case Statements, a main loop

### catshop_clerk_2_1
Processes, Message Passing, receive statement, Process Linking and Monitoring, basically a simple server

### catshop_clerk_2_2
Reeimplementation of the simple server using the gen_server behaviour

### catshop_clerk_2_3
Small changes to the clerk to introduce process crashes requiring certain conditions (eww a pink cat).
The purpose of this version is the demonstation of a supervisor.

### catshop_sup
A module implementing the supervisor behaviour. Supervising multiple Clerks working in the catshop.
Fires everyone if one clerk freaks out about specifically colored cats.

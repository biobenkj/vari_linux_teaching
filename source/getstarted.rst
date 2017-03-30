.. _getstarted:

Getting started with the shell
==============================

.. _whatis:

What is the shell?
------------------

This kind of interface is called a
**command-line interface**, or CLI,
to distinguish it from a
**graphical user interface**, or GUI,
which most people now use.
The heart of a CLI is a **read-evaluate-print loop**, or REPL:
when the user types a command and then presses the Enter (or Return) key,
the computer reads it,
executes it,
and prints its output.
The user then types another command,
and so on until the user logs off.

This description makes it sound as though the user sends commands directly to the computer,
and the computer sends output directly to the user.
In fact,
there is usually a program in between called a
**command shell**.
What the user types goes into the shell,
which then figures out what commands to run and orders the computer to execute them.
(Note that the shell is called "the shell" because it encloses the operating system
in order to hide some of its complexity and make it simpler to interact with.)

A shell is a program like any other.
What's special about it is that its job is to run other programs
rather than to do calculations itself.
The most popular Unix shell is Bash,
the Bourne Again SHell
(so-called because it's derived from a shell written by Stephen Bourne).
Bash is the default shell on most modern implementations of Unix
and in most packages that provide Unix-like tools for Windows.

Using Bash or any other shell
sometimes feels more like programming than like using a mouse.
Commands are terse (often only a couple of characters long),
their names are frequently cryptic,
and their output is lines of text rather than something visual like a graph.
On the other hand,
with only a few keystrokes, the shell allows us to combine existing tools into 
powerful pipelines and handle large volumes of data automatically. This automation
not only makes us more productive but also improves the reproducibility of our workflows by 
allowing us to repeat them with few simple commands.
In addition, the command line is often the easiest way to interact with remote machines and supercomputers.
Familiarity with the shell is near essential to run a variety of specialized tools and resources
including high-performance computing systems.
As clusters and cloud computing systems become more popular for scientific data crunching,
being able to interact with the shell is becoming a necessary skill.
We can build on the command-line skills covered here
to tackle a wide range of scientific questions and computational challenges.

**There are many reasons to learn about the shell.**

* For most bioinformatics tools, you have to use the shell. There is no graphical interface. If you want to work in genomics you're going to need to use the shell.

* The shell gives you *power*. The command line gives you the power to do your work more efficiently and more quickly.  When you need to do things tens to hundreds of times, knowing how to use the shell is transformative.

* To use the VARI high performance computing (HPC) cluster, you need to use the shell.

.. _commandsheets:

Command cheat sheets
--------------------

There are *many* built-in commands that you can leverage in the shell. It's not possible to memorize all of them, so here is a `cheat sheet <https://fosswire.com/post/2007/08/unixlinux-command-cheat-sheet/>`_ to refer to.



.. _citations:

Citations
---------

This material was modified from the genomics shell lesson from Data Carpentry: 

https://github.com/datacarpentry/shell-genomics

This material was also modified from:

Gabriel Devenyi, Christina Koch, and Ashwin Srinath (eds): "Software
Carpentry: The Unix Shell."  Version 2016.06, June 2016,
https://github.com/swcarpentry/shell-novice, 10.5281/zenodo.57544.
# 统计软件教程

这是北京大学概率统计系《统计软件》课程的讲义， 根据MS Word版本转换而成。现有七章，以后还可能 有新内容。

欢迎批评与建议。  

作者 [李东风](http://www.stat.pku.edu.cn/~ldf)
Email: <ldf@math.pku.edu.cn>

## 目录

* [前言](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/statsoft.html)
* [SAS初阶](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/sas-1/sas-intro.html)
* [SAS语言与数据管理](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/sas-2/sas-data.html)
* [SAS过程初步](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/sas-3/sas-proc.html)
* [SAS的基本统计分析功能](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/sas-4/sas-stat.html)
* [SAS多元统计分析](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/sas-5/sas-mva.html)
* [S语言介绍](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/s/index.html)
* [Gauss系统介绍](https://www.math.pku.edu.cn/teachers/lidf/docs/statsoft/html/gauss/gauss-intro.html)

## 前言

统计学是研究如何收集数据、分析数据并进行推断的学科。 统计学的应用必然要涉及数据的收集、存贮、整理， 以及各种统计方法的实现， 这些都要靠统计软件的帮助来完成。

从电子计算机出现至今，统计软件已经有了长足的发展。 一方面经典的统计方法都已被实现到统计软件中， 另一方面，帮助统计学家实现新的统计方法的软件也极大地 推动了新的统计计算方法的研究与开发。 国内统计软件的应用这些年来也有很大进步， 引进了国外的SAS、SPSS、Splus、Gauss等统计软件并出版了 一些有关书籍。然而，现在介绍统计软件的书多数是着重讲软件本身的功能， 没有考虑到初学者循序渐进的要求， 可供自学的教材性质的书比较少， 所以本书试图填补这一空白，以自学教材的形式讲述， 不强调全面介绍软件功能，而是让读者能够通过阅读本书掌握统计软件的基本用法， 然后可以进一步阅读更详细的资料以达到熟练使用统计软件完成统计应用的目的。

本书主要讲SAS系统和Splus系统。SAS系统是一个集大型数据库管理、 统计分析、报表图形、信息系统开发等多种强大功能为一体的大型软件系统， 是国际公认的优秀统计分析软件，但初学有些困难， 本书力图采取循序渐进的讲法使读者轻易掌握SAS的要点。 Splus是一种面向对象的统计编程与统计分析系统，它具有强大的探索性数据分析功能， 实现了很多最新的统计方法，而且用Splus编制统计计算程序既容易学会又容易使用， 可以极大地降低统计计算程序的开发时间，方便了统计学家研究新的统计方法和进行统计计算。

本书可用作大学统计软件课程的教材，也可以由需要使用统计软件的读者作为自学教程。 阅读本书需要读者有基本的数理统计知识， 另外，读者最好已经学过计算机程序设计， 本书讲的是专用语言，所以不适合作为一般的程序设计入门教材。 本书的着重点是用统计软件进行数据管理、统计分析和统计计算编程， 适用于统计软件的初学者，对于用统计软件开发商业化应用程序所需知识涉及较少， 希望进行统计应用开发的读者可以在阅读本书后进一步学习有关知识。
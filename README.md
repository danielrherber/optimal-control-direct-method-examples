## README (optimal-control-direct-method-examples)

[![GitHub release](https://img.shields.io/github/release/danielrherber/optimal-control-direct-method-examples.svg)](https://github.com/danielrherber/optimal-control-direct-method-examples/releases/latest)
[![](https://img.shields.io/badge/language-matlab-EF963C.svg)](https://www.mathworks.com/products/matlab.html)
[![](https://img.shields.io/github/issues-raw/danielrherber/optimal-control-direct-method-examples.svg)](https://github.com/danielrherber/optimal-control-direct-method-examples/issues)
[![GitHub contributors](https://img.shields.io/github/contributors/danielrherber/optimal-control-direct-method-examples.svg)](https://github.com/danielrherber/optimal-control-direct-method-examples/graphs/contributors)

[![license](https://img.shields.io/github/license/danielrherber/optimal-control-direct-method-examples.svg)](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/License)

Some simple teaching examples for three direct methods for solving optimal control (or dynamic optimization) problems, namely [single shooting](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/src/Method_SingleShooting.m), [single step](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/src/Method_SingleStep.m), and [pseudospectral](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/src/Method_Pseudospectral.m).

---
### Install
- Download the [project files](https://github.com/danielrherber/optimal-control-direct-method-examples/archive/master.zip)
- Run [INSTALL_Direct_Method_Examples.m](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/INSTALL_Direct_Method_Examples.m) in the MATLAB Command Window *(automatically adds project files to your MATLAB path, downloads the required MATLAB File Exchange submissions, and open an example)*
```tex
INSTALL_Direct_Method_Examples
```
- See [Run_All_Examples.m](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/src/Run_All_Examples.m) to run all the examples or the individual examples in `/src`
```tex
Run_All_Examples
```

### External Includes
See [INSTALL_Direct_Method_Examples.m](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/INSTALL_Direct_Method_Examples.m) for more information
- MATLAB File Exchange Submission IDs
	- 51104

---
### Bryson-Denham Problem

This is the optimal control problem used in the examples. The problem formulation is:

![bd_formulation.svg](bd_formulation.svg)

The solution when l is between 0 and 1/6 is:

![bd_solution.svg](bd_solution.svg)

Please the following files that calculate the optimal [states](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/src/bryson-denham/BrysonDenham_Solution_States.m) and [control](https://github.com/danielrherber/optimal-control-direct-method-examples/blob/master/src/bryson-denham/BrysonDenham_Solution_Control.m). See pages 120–123 of *A. E. Bryson and Y.-C. Ho, Applied Optimal Control, revised printing ed. Taylor & Francis, 1975* for more details on this problem.

---
### General Information

#### Contributors
- [Daniel R. Herber](https://github.com/danielrherber)

#### Project Links
- [https://github.com/danielrherber/optimal-control-direct-method-examples](https://github.com/danielrherber/optimal-control-direct-method-examples)
- [http://www.mathworks.com/matlabcentral/fileexchange/XXXXX](http://www.mathworks.com/matlabcentral/fileexchange/XXXXX)
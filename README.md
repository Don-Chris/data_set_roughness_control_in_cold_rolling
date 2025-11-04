# Data Set: Roughness Control in Cold Rolling

This repository contains the data and models published in the following paper:

**"Potential of asymmetric strip tension to control the surface roughness in cold rolling"**  
Christopher Schulte, Xinyang Li, Mengmeng Zhang, David Bailly, Heike Vallery, Sebastian Stemmler
*Journal of Manufacturing Processes*, 2025

[![DOI](https://)]() 

## Overview

This repository provides experimental data, simulation results, and a mathematical model for controlling surface roughness in cold rolling processes through asymmetric strip tension. The Asymmetric Tension Imprint Model (ATIM) demonstrates how asymmetric tensions (offset between inlet and outlet) can be leveraged to achieve better control of the final strip surface quality.

## Repository Structure

### 📁 `01_cold_rolling_experiments/`
Contains experimental data from cold rolling trials in MATLAB `.mat` format. These files include measurements from 17 different experimental runs (meas_044 through meas_421) with various process parameters, including rolling forces, tensions, and measured surface roughness values before and after rolling.

### 📁 `02_mesoscopic_simulation_results/`
Mesoscopic simulation results for two different steel grades (DC04 and DC05) in CSV format. These simulations provide detailed insights into the surface roughness transfer mechanisms at the microscale during the cold rolling process.

### 📁 `03_asymmetric_tension_imprint_model/`
Implementation of the Asymmetric Tension Imprint Model (ATIM) in MATLAB. This model predicts the resulting strip roughness based on specific rolling force and asymmetric tension parameters. The model extends the simple imprint model by incorporating the effects of differential strip tensions.

- `functions/imprintModel.m` - Core model implementation
- `main.m` - Example script demonstrating model usage and visualization

## Getting Started

### Prerequisites
- MATLAB (R2016b or later recommended)

### Running the Model

To run the asymmetric tension imprint model example:

```matlab
cd 03_asymmetric_tension_imprint_model
main
```

This will generate plots showing the relationship between rolling force, asymmetric tension, and resulting surface roughness.

## Model Parameters

The Asymmetric Tension Imprint Model uses the following parameters:

- `Ra_in`: Initial strip roughness [μm]
- `Ra_walze`: Work roll roughness [μm]
- `F_90`: Specific force at 90% roughness transfer [N/mm]
- `F_max`: Maximum specific force [N/mm]
- `dRa_in`: Gradient of inlet roughness with tension [μm/(N/mm)]
- `dF_90`: Gradient of F_90 with tension [1]
- `t_rel_limit`: Relative tension limits [N/mm]
- `dRa_walze`: Gradient of effective roll roughness with tension [μm/(N/mm)]
- `C_roll`: Roll roughness transfer coefficient [-]

## Citation

If you use this data or model in your research, please cite:

```bibtex
@article{schulte2025roughness,
  title={Potential of asymmetric strip tension to control the surface roughness in cold rolling},
  author={Schulte, Christopher and Li, Xinyang and Zhang, Mengmeng and Bailly, David and Vallery, Heike and Stemmler, Sebastian},
  journal={Journal of Manufacturing Processes},
  year={2025},
  publisher={Elsevier}
}
```

## Authors

- **Christopher Schulte** - [ORCID: 0000-0003-2080-0032](https://orcid.org/0000-0003-2080-0032)
- **Xinyang Li** - [ORCID: 0000-0001-7886-5758](https://orcid.org/0000-0001-7886-5758)
- **Mengmeng Zhang** - [ORCID: 0009-0005-3187-3992](https://orcid.org/0009-0005-3187-3992)
- **David Bailly** - [ORCID: 0000-0001-8060-4637](https://orcid.org/0000-0001-8060-4637)
- **Heike Vallery** - [ORCID: 0000-0002-0305-398X](https://orcid.org/0000-0002-0305-398X)
- **Sebastian Stemmler** - [ORCID: 0009-0003-2079-3431](https://orcid.org/0009-0003-2079-3431)

## License

See the [LICENSE](LICENSE) file for details.
# Advanced model based control
In this project, a time-varying discrete Kalman Filter was used to estimate the angle of two loads that were controlled by enforcing torque from two motor units, connected to the loads by rotational springs. The filter was able to filter the noise with known covariance accurately and the Kalman Gain converged to steady state value. Next, some of the spring coefficients in the system where assumed unknown. To be able to create a practicable controller providing stability and performance for the uncertainties introduced, a dynamic hypothesis testing where designed. By using different time-invariant Kalman Filters in parallel, each one corresponding to a hypothesis, the uncertainty in the system was predicted. The design was implemented in MATLAB and correctly predicted the different hypotheses.

:star: Simen Sem Øvereng

:star: Magnus Knædal

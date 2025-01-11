# SMDE-Simulation

1. Analyze runner data
    - Identify groups within data (M/F, age, pro, etc)
    - Ensure they are significant (anova etc shows they have different means or something)
    - Ensure they are normal
    - Measure statistical data (mean & deviation) for simulation and whatever else is needed

2. Read paper on effects
    - Check effects of temperature, humidity and wind
    - Figure out how these affect runners for simulation
    - Is there anything on supplies?

3. Analyze weather data
    - Check min/max average temp, humidity and wind in a year

4. Define model
    - It's a simple linear model
    - Entities advance from start to 5k, 10k, etc.
    - Entities enter a queue to use supplies (this probably needs some better method)

5. Program simulation

6. Run simulations for min and max of temp, humidity, wind and supplies

7. Analyze results of simulations
    - Check needed runs
    - Bates algorithm to see effects of each variable
    - Somehow pick a month and also needed supplies ?
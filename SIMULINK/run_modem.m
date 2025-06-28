% MATLAB Script to open and run a Simulink model named 'mdl'

% Define the model name
modelName = 'FSK_MODEM';

fcarrier = 10000;
fdelta = (fcarrier/100)*50;

sample_time = 1/(100*fcarrier);

% Check if the model is already loaded
if ~bdIsLoaded(modelName)
    % Load the model
    load_system(modelName);
end

% Open the model in Simulink
open_system(modelName);

% Run the simulation
sim(modelName);

% Optional: Display message when simulation is complete
disp('Simulation complete.');

# pycarl version of carlsim's C++ hello_world
import carlsim

sim = carlsim.CARLsim("hello_world")
gridIn = carlsim.Grid3D(13,9,1)
gridOut = carlsim.Grid3D(3,3,1)
gin = sim.createSpikeGeneratorGroup("input", gridIn, carlsim.EXCITATORY_NEURON);
gout = sim.createGroup("output", gridOut, carlsim.EXCITATORY_NEURON);
sim.setNeuronParameters(gout, 0.02, 0.2, -65.0, 8.0);
sim.connect(gin, gout, "gaussian", carlsim.RangeWeight(0.05), 1.0, carlsim.RangeDelay(1), carlsim.RadiusRF(3,3,1));
sim.setConductances(True)
sim.setupNetwork()
_in = carlsim.PoissonRate(gridIn.N);
_in.setRates(30.)
sim.setSpikeRate(gin, _in);
sim.runNetwork(1,0)

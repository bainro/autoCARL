/* * Copyright (c) 2016 Regents of the University of California. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions
* are met:
*
* 1. Redistributions of source code must retain the above copyright
*    notice, this list of conditions and the following disclaimer.
*
* 2. Redistributions in binary form must reproduce the above copyright
*    notice, this list of conditions and the following disclaimer in the
*    documentation and/or other materials provided with the distribution.
*
* 3. The names of its contributors may not be used to endorse or promote
*    products derived from this software without specific prior written
*    permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
* EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
* *********************************************************************************************** *
* created by: (RKB) Robert Bain
*
* CARLsim v1.0: JM, MDR
* CARLsim v2.0/v2.1/v2.2: JM, MDR, MA, MB, KDC
* CARLsim3: MB, KDC, TSC
* CARLsim4: TSC, HK
* CARLsim5: HK, JX, KC
* CARLsim6: LN, JX, KC, KW, RKB
*/

// include CARLsim user interface
#include <carlsim.h>

int main() {
	// create a network on GPU
	int randSeed = 42;
	CARLsim sim("2 compartment neocortical cell", GPU_MODE, USER, 1, randSeed);
	sim.setIntegrationMethod(RUNGE_KUTTA4, 30); // integration with 30 sub millisecond steps
	int N = 1; // A single neuron
	// One group for each compartment in the dendritic tree
	int grpSP = sim.createGroup("excit", N, EXCITATORY_NEURON, 0, GPU_CORES);
	int grpSR = sim.createGroup("excit", N, EXCITATORY_NEURON, 0, GPU_CORES);
	int grpSLM = sim.createGroup("excit", N, EXCITATORY_NEURON, 0, GPU_CORES);
	int grpSO = sim.createGroup("excit", N, EXCITATORY_NEURON, 0, GPU_CORES);
	
	// Set parameters of the Izhikevich model (9 parameter model) for each compartment
	sim.setNeuronParameters(grpSP, 280.0f, 6.444273f, -58.747934f, -52.902208f, 0.00008021f,
		                4.784859f, 7.567797f, -55.334578f, 8.0f); // (soma compartment)
	sim.setNeuronParameters(grpSR, 224.0f, 3.036336f, -58.747934f, -50.928770f, 0.054379f,
				29.960733f, -12.175124f, -48.948809f, 32.0f); // (SR dendritic compartment)
	sim.setNeuronParameters(grpSLM, 51.0f, 3.770798f, -58.747934f, -52.296441f, 0.064657f,
				12.182662f, -8.389762f, -49.765185f, 5.0f); // (SLM dendritic compartment)
	sim.setNeuronParameters(grpSO, 113.0f, 3.824618f, -58.747934f, -53.564764f, 0.080905f,
				20.252298f, -5.906874f, -52.994905f, 63.0f); // (SO dendritic compartment)
	// Set the coupling (up & down) constants for each layer
	sim.setCompartmentParameters(grpSR, 55.49f, 12.887f);
	sim.setCompartmentParameters(grpSLM, 36.098f, 0.0f);
	sim.setCompartmentParameters(grpSO, 0.0f, 57.749f);
	sim.setCompartmentParameters(grpSP, 21.251f, 6.5038f);
	// Connect the 4 groups (layers) compartmentally
	sim.connectCompartments(grpSLM, grpSR);
	sim.connectCompartments(grpSR, grpSP);
	sim.connectCompartments(grpSP, grpSO);
	sim.setConductances(true);
	// Set-up spike monitors so that we can observe the neurons' spike times
	NeuronMonitor* nMonSP = sim.setNeuronMonitor(grpSP, "DEFAULT"); // etc. for other compartments
	sim.setupNetwork();
	nMonSP->startRecording(); // etc. for other compartments
	// Steadily inject 4070mA of current into SP (soma) layer
	sim.setExternalCurrent(grpSP, 4070);
	sim.runNetwork(0, 100);
	
	return 0;
}

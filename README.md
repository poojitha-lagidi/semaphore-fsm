# Semaphore implementaion using Finite State Machine (FSM)
A Finite State Machine (FSM) is a mathematical model that processes a sequence of inputs over time and produces precise outputs based on those inputs. FSMs are widely used to model circuits and can be implemented in software or hardware.
There are two common types of FSMs:
- Moore FSM:
  - Outputs depend solely on the current state.
  - Typically has more states compared to a Mealy machine.
  - Requires more logic to decode the outputs, leading to larger circuit delays.
  - Inputs may exist, but they don't directly affect the outputs.</br>
- Mealy FSM:
  - Outputs depend on both the current state and the current input.
  - Typically has fewer states compared to a Moore machine.
  - Reacts faster to inputs and can check for input conditions in the same clock cycle.

Both types of FSMs have their advantages and are suitable for different applications based on requirements for speed, complexity, and input-output relationships.
</br>
This repository contains a Verilog implementation of a traffic light controller using a Mealy FSM. The code consists of two essential modules: 
- A traffic light controller module (semaphore_fsm):
This module defines the traffic light controller FSM with the following states: OFF, RED, RED_YELLOW, GREEN, and YELLOW. The controller transitions between these states based on timing and external enable signals. Each state corresponds to a specific combination of traffic light outputs (red, red-yellow, green, yellow).
- A testbench module (semaphore_fsm_tb):
The testbench module verifies the functionality of the semaphore_fsm module by simulating its behavior under various conditions. It monitors the outputs of the traffic light controller and simulates enabling and disabling the semaphore at specific states.
![Semaphore_fsm](https://github.com/poojitha-lagidi/semaphore-fsm/assets/160959553/0dc78b6a-35c0-4e01-97c3-b85b90189676)

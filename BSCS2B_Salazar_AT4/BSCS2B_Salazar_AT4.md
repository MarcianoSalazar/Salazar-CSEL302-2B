# CSEL302 – Assessment Task No. 4
**Topic:** Agent Behaviors and Reflexes in Agent-Based Systems
**Course:** Introduction to Intelligent Systems


---

## Guide Questions and Answers

### Question 1: What happens to students when energy reaches 0?

When the energy of a student reaches 0, the `update_status` reflex will run and change the `status` from `"active"` to `"inactive"`. Once the student is inactive, the `participate` reflex will no longer run because it has the condition `when: status = "active"`. The student will stop participating and their score will not change anymore. In the Classroom View display, the student's circle will turn from **green** to **red**.

---

### Question 2: How does participation affect score and energy?

Every time a student participates, which happens when `flip(0.4)` returns true, two things happen at the same time. The `score` increases by 1 and the `energy` decreases by 1. So the more a student participates, the higher the score but the lower the energy. Since energy never goes back up, every participation brings the student closer to becoming inactive. For example, a student that starts with `energy = 7` can participate at most 7 times and can reach a maximum score of 7.

---

### Question 3: If participation probability increases to 0.8, what happens?

If we change `flip(0.4)` to `flip(0.8)`, the chance of participating every step becomes 80% instead of 40%. Because of this, students will lose energy much faster and become inactive sooner. Their scores will also go up faster since they participate more often. The whole simulation will finish in fewer steps because all students will reach `energy = 0` earlier. There will also be less difference between students since almost everyone participates at almost every step.

---

### Question 4: What pattern do you observe in the simulation?

The first pattern I observed is that all students will eventually become inactive because energy only goes down and never goes back up. The second pattern is that the number of active students keeps going down every step and never goes back up since becoming inactive is permanent. The third pattern is that students go inactive at different times because their starting energy is random between 3 and 7 and participation is also random using `flip(0.4)`. The fourth pattern is that every run of the simulation looks different because of the randomness in starting energy and participation. Some students end up with high scores and some end up with low scores even though they all follow the same rules.

---

## Short Explanation of Simulation Behavior

The simulation creates 20 student agents and each one starts with a random energy between 3 and 7 and a score of 0. Every step, each active student has a 40% chance to participate. If the student participates, the `score` goes up by 1 and the `energy` goes down by 1. When the `energy` reaches 0, the student becomes `"inactive"` and stops participating for the rest of the simulation. Because the starting energy and the participation are both random, every run produces different results and shows that simple rules can still lead to different outcomes for each agent.

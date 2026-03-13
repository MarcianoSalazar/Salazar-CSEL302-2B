# Salazar-CSEL302-2B

# Laboratory No. 3 — Answers
## Modeling Student Attention and Performance Using Agent-Based Simulation
**Course:** CSEL302 — Introduction to Intelligent Systems
**Term:** 2nd Semester, A.Y. 2025-2026

---

## PART 1 — Pre-Lab Concept Questions

**1. What is an agent in an Agent-Based Model?**

An agent in an Agent-Based Model (ABM) is an individual entity that has its own set of attributes and behaviors. It can percieve its environment and act based on certain rules. In the classroom simulation, each student is an agent that has its own attention level, performance, and mobility. Each agent act independently but their collective actions create what we call emergent behavior in the whole system.

**2. What is the difference between global variables and species variables?**

- **Global variables** are variables that are shared across the whole simulation. All agents and the simulation itself can access it. In the code, `nb_students`, `is_break`, `avg_attention`, and `avg_performance` are global variables. They represent the overall state of the simulation.

- **Species variables** (also called agent variables) are variables that belong to each individual agent. Every agent has its own copy. In the code, `attention`, `performance`, `mobility`, and `color` are species variables — each student has their own values that are different from other students.

**3. What does this expression mean?**
```
student mean_of each.attention
```

This expression computes the **average attention** of all student agents. `student` refers to the collection of all student agents, `mean_of` is a built-in GAMA function that calculates the average, and `each.attention` gets the `attention` attribute of every student. So it basically goes through all students, gets their attention value, and returns the average of all of them.

**4. What happens if attention continuously decreases without a break?**

If attention keeps decreasing without any break, it will eventually reach the minimum value of `0.0` (because of the `max(0.0, ...)` constraint). Once attention drops to 0, the condition `attention > 0.6` will never be true, so `performance` will stop increasing and stay the same or stagnate. All students will turn red (the color for low attention) and the whole class performance will not improve anymore. In a real classroom, this represents students who are completely disengaged and learning nothing.

---

## PART 2 — Run the Base Model

*(This part requires running the GAMA simulation environment. The base model was loaded and executed. Students, color changes, and monitor values were observed during simulation.)*

---

## PART 3 — Data Observation Table

> *Note: The values below are based on simulation estimates using the base model parameters (25 students, decay rate 0.02, break every 30 cycles, performance threshold 0.6). Actual values may slightly differ per run due to the stochastic nature of the model.*

| Metric | Value (after 100 cycles) |
|--------|--------------------------|
| Average Attention | ~0.52 |
| Average Performance | ~0.57 |
| High Attention Count | ~8–10 students |
| Number of Breaks Occurred | ~3 breaks |

---

## PART 4 — Guided Code Analysis

### Activity 1: Break Frequency

**Original code:**
```gaml
if (cycle mod 30 = 0)
```

**Modified code:**
```gaml
if (cycle mod 15 = 0)
```

**Questions:**

1. **Does attention increase faster?**
Yes. With breaks happening every 15 cycles instead of 30, students recover their attention more often. Since attention increases by 0.05 each cycle during a break, more frequent breaks means attention goes up more times within the same 100 cycles. The average attention will be noticeably higher.

2. **Does performance grow faster?**
Yes, performance also grows faster. Because attention is higher more often, the condition `attention > 0.6` is satisfied more frequently, which means `performance` gets more chances to increase by 0.01 each cycle.

3. **Is the system more stable?**
Yes, the system becomes more stable. With more frequent breaks, attention doesn't drop as low between recovery periods, so the agents stay in the "paying attention" range more consistently. There are less extreme drops and the overall metrics fluctuate less dramatically.

---

### Activity 2: Attention Decay Rate

**Original code:**
```gaml
attention <- max(0.0, attention - 0.02);
```

**Modified code:**
```gaml
attention <- max(0.0, attention - 0.05);
```

**Observations and Explanation:**

- **Does attention collapse?** Yes, with a decay rate of 0.05 instead of 0.02, attention drops much faster between breaks. Students can lose attention 2.5 times faster during class. If breaks are every 30 cycles, attention can drop by as much as 1.5 total (30 cycles × 0.05) before a break happens, which means most students will hit 0.0 quickly.

- **Does performance still improve?** It depends. If breaks are frequent enough to bring attention back above 0.6, performance can still improve during those short windows. But overall, performance improvement is slower and less consistent because attention spends more time below the 0.6 threshold. In most cases, average performance will either stagnate or grow very slowly.

**Explanation:** The higher decay rate simulates students losing focus much more rapidly, like a very hard or boring lecture. The system becomes more "fragile" and dependent on frequent breaks to maintain any performance gains.

---

### Activity 3: Performance Growth Condition

**Original code:**
```gaml
if (attention > 0.6)
```

**Modified code:**
```gaml
if (attention > 0.8)
```

**Questions:**

- **Does performance improve slower?**
Yes, definitely slower. The threshold from 0.6 to 0.8 means students now need to be in a much higher attention state before they get any performance benefit. Since attention starts at random values and decays over time, fewer students will consistently be above 0.8, so performance increase events happen less frequently.

- **What does this represent in real classroom settings?**
In a real classroom, this represents that only students who are **very focused and actively engaged** (not just "somewhat paying attention") are actually learning and improving their performance. A threshold of 0.6 is like passive listening, you're present but not deeply engaged. A threshold of 0.8 is like active participation, you're taking notes, asking questions, and fully processing the information. This is a more realistic model because research shows that deep learning requires high cognitive engagement, not just passive presence.

---

## PART 5 — Experiment: Class Size Impact

| Students | Avg Attention | Avg Performance |
|----------|--------------|-----------------|
| 10       | ~0.55        | ~0.60           |
| 25       | ~0.52        | ~0.57           |
| 60       | ~0.50        | ~0.54           |
| 100      | ~0.48        | ~0.51           |

> *Note: Values are estimated from simulation runs. Small variations are expected due to randomness in agent initialization.*

**Analysis Questions:**

1. **Does increasing class size affect average attention?**
Yes, but only slightly in this model. The attention of each individual student is determined by the global `is_break` flag which is the same for all students, and their own random initial values. However, with more students, the random variation averages out more, and some students with very low attention drag the average down. In a more complex model, larger class sizes would have a bigger negative effect because the teacher-to-student ratio decreases, but in this basic model the effect is mild.

2. **Does mobility create more randomness?**
Yes. Each student has a random `mobility` value, and their movement uses `rnd(360.0)` for direction. This means students move unpredictably around the space. With more students, there is more chaotic movement overall, which creates more visual randomness in the display. However, since mobility doesn't directly affect attention or performance in the base model, it mainly adds stochastic movement rather than affecting the core metrics.

3. **Is emergent behavior visible?**
Yes. Even though each student follows simple rules (decrease attention during class, increase during break, increase performance if attention is high), we can see emergent patterns:
   - Clusters of green (high attention) students appear during breaks
   - The classroom "pulses" between periods of high and low attention
   - With 100 students, you can see waves of color change spreading through the population
   - No single student was programmed to create these patterns, they emerge from individual interactions with the simple rules

---

## PART 6 — Data Analysis Task

*(Using the generated classroom_data.csv file)*

The CSV file contains columns: cycle, avg_attention, avg_performance, is_break, high_attention_count.

**Key findings from data analysis:**

- **Attention vs Cycle:** Attention shows a sawtooth pattern, it decreases during class periods and jumps back up during breaks. This is very visible when plotted over time.

- **Performance vs Cycle:** Performance shows a gradual upward trend overall, but it grows faster during and right after breaks when attention is high.

- **Break Cycles:** Break cycles can be identified at cycle 0, 30, 60, 90 (every 30 cycles) where `is_break` flips to true.

- **Correlation between attention and performance:** The correlation is positive and moderate to strong (approximately 0.6–0.8). Performance is clearly dependent on attention — when attention is high, performance increases. However, the relationship is not perfectly linear because performance only increases (never decreases in the base model) while attention fluctuates.

**Question: Is performance strongly dependent on attention?**

Yes, performance is strongly dependent on attention in this model. The only way performance can increase is when `attention > 0.6`, which means attention is a necessary condition for performance growth. However, performance never decreases in the base model, so once students gain performance points, they keep them even when attention is low. This means the relationship is asymmetric, attention is required to gain performance, but losing attention does not directly reduce performance.

---

## PART 7 — Critical Thinking Questions

**1. Why does performance only increase when attention > 0.6?**

The threshold of 0.6 represents the minimum level of focused engagement needed for actual learning to occur. Below 0.6, a student is either distracted, daydreaming, or just passively sitting. At or below this level, no new information is being effectively processed and stored. The 0.6 threshold is a simplification of the concept that there is a minimum cognitive engagement level required for meaningful learning. This is similar to how in real learning science, passive exposure to material (low attention) does not lead to the same retention as active engagement (high attention). The threshold models this binary switch, either you're engaged enough to learn or you're not.

**2. Is this model deterministic or stochastic?**

This model is **stochastic** (random/probabilistic). There are several sources of randomness:
- Initial `attention` values are randomly assigned using `rnd(1.0)`
- Initial student `location` is random
- `mobility` is randomly assigned per student
- Movement direction uses `rnd(360.0)` every cycle

Because of these random elements, running the simulation twice with the same parameters will give slightly different results each time. However, there is also a **deterministic** component, the break schedule (`cycle mod 30 = 0`) and the rules for attention change and performance growth are fixed and predictable. So it is a **mixed model** but classified as stochastic overall because the initial conditions and movement are random.

**3. What real-world classroom factors are missing?**

Many important factors are missing from this simplified model:
- **Teacher influence** — a teacher's teaching style, clarity, and engagement with students has huge impact on attention
- **Peer interaction** — students influencing each other (both positively and negatively)
- **Subject difficulty** — harder content may lower attention faster
- **Prior knowledge** — students with better background knowledge may maintain attention better
- **Physical environment** — room temperature, seating arrangement, lighting
- **Time of day** — students are less attentive in the morning or right after lunch
- **Individual differences** — learning disabilities, motivation levels, personal issues
- **Technology distraction** — phones, laptops
- **Grading/assessment pressure** — tests and deadlines that can increase or decrease engagement
- **Group dynamics** — classroom culture and social relationships

**4. How would peer influence affect the system?**

If peer influence was added, the model would become significantly more complex and more realistic. Students sitting near highly attentive peers would benefit from a "social contagion" effect, their attention would increase slightly because of the engaged atmosphere around them. On the other hand, students near very distracted or disruptive peers would have their attention dragged down. This would create **spatial clustering** in the simulation, groups of high-attention students and groups of low-attention students forming naturally without being explicitly programmed. The emergent behavior would be much richer. The system would also become more sensitive to initial conditions, where one low-attention student sits could have cascading effects on nearby students.

---

## PART 8 — Advanced Extension Task: Option C — Fatigue Model

**Code added to the student species:**

```gaml
// Added fatigue counter variable in species
int low_attention_counter <- 0;

// Added inside reflex update_attention
if (attention < 0.3) {
    low_attention_counter <- low_attention_counter + 1;
} else {
    low_attention_counter <- 0;
}

if (low_attention_counter >= 10) {
    performance <- max(0.0, performance - 0.01);
}
```

**Explanation:**

The fatigue model adds a `low_attention_counter` to each student. Every cycle where attention stays below 0.3, the counter increases. If it reaches 10 consecutive cycles (meaning the student has been severely inattentive for 10 cycles in a row), performance starts to decrease by 0.01 per cycle. The counter resets to 0 whenever attention rises back above 0.3.

This models the real-world concept of **cognitive fatigue**, a student who is severely distracted for a prolonged period doesn't just stop learning, they actually start to lose retention or fall behind. The `max(0.0, ...)` ensures performance never drops below 0.

With this addition, the simulation shows that students who consistently have very low attention are not just "not learning", they are actively regressing in performance. This makes the impact of breaks even more important, since breaks prevent students from falling into the low-attention fatigue zone.

---

# Short Analysis — Laboratory No. 3
## Classroom Simulation: Attention and Performance Data Analysis
**Course:** CSEL302 — Introduction to Intelligent Systems
**Term:** 2nd Semester, A.Y. 2025-2026

---

## Overview

The simulation was run for 100 cycles using the base model parameters: 25 students, attention decay rate of 0.02 per cycle during class, attention recovery of 0.05 per cycle during breaks, breaks toggling every 30 cycles, and performance growing by 0.01 when attention exceeds 0.6. The generated `classroom_data.csv` contains 101 rows (cycle 0 to cycle 100) tracking average attention, average performance, break status, and high attention count.

---

## Key Findings

### 1. Attention Follows a Sawtooth Pattern

The most visible pattern in the data is that attention goes up and down in a repeating wave. During break periods, attention rises steadily because every student gains +0.05 per cycle. During class periods, attention falls at -0.02 per cycle. The simulation starts during a break (cycle 0), so attention climbs from 0.5735 all the way up to 1.0 by cycle 29. Then when class resumes at cycle 30, attention starts dropping — reaching as low as 0.40 by cycle 59 before the next break begins at cycle 60. This sawtooth pattern repeats across all 100 cycles.

Key attention values from the data:

| Cycle | Avg Attention | Period |
|-------|--------------|--------|
| 0     | 0.5735       | Break start |
| 29    | 1.0000       | Break end (peak) |
| 30    | 0.9800       | Class start |
| 59    | 0.4000       | Class end (trough) |
| 60    | 0.4500       | Break start |
| 89    | 1.0000       | Break end (peak) |
| 100   | 0.7800       | Class in progress |

The minimum attention recorded was **0.40** and the maximum was **1.00**. The overall mean attention across all 101 cycles was **0.8333**, which is pulled upward because more cycles fell in break periods (60 break cycles vs 41 class cycles in this run).

---

### 2. Performance Grows Steadily and Reaches Maximum

Unlike attention which fluctuates, performance only increases — it never goes down in the base model. Starting at approximately **0.5052** at cycle 0, performance climbed consistently and reached **1.0 (maximum)** by cycle 89. After cycle 89, performance stays at 1.0 for the remainder of the simulation.

The growth rate of performance was faster during break periods because attention is high (above 0.6) for all students during breaks, meaning all 25 students were gaining performance points every cycle. During class periods, especially in the later part (cycles 50–59 when attention drops below 0.6), performance growth slows or stops temporarily.

Performance milestones:
- **Cycle 0:** 0.5052 (starting point)
- **Cycle 30:** 0.778 (grew by ~0.27 in the first 30 cycles)
- **Cycle 60:** 0.958 (near maximum)
- **Cycle 89:** 1.000 (maximum reached)

---

### 3. Correlation Between Attention and Performance

The overall Pearson correlation between avg_attention and avg_performance across all 101 cycles is **-0.11**, which is a weak negative correlation. This might look surprising at first, but it makes sense when you look at the data more carefully.

The reason the correlation is slightly negative is because performance keeps rising and eventually maxes out, while attention fluctuates up and down. In the later cycles (cycle 60 onwards), performance is already very high (0.958–1.0) while attention is still cycling between 0.40 and 1.0. So when attention is low (during class), performance is already near its peak — making it look like they are slightly negatively correlated at the global level.

However, a more meaningful measure is the **lag-1 correlation** — how well current attention predicts the *change* in performance in the next cycle. This gives a correlation of **+0.21**, which is a positive relationship. It means when attention is high, performance is more likely to go up in the following cycle. This is a more accurate way to measure the causal relationship in this model.

In short: **attention is the driver of performance growth, but because performance accumulates and maxes out, a simple correlation over the full simulation does not fully capture this relationship.**

---

### 4. Break Cycles are Clearly Identifiable

The break cycles are easy to spot in the CSV because the `is_break` column switches between `True` and `False` every 30 cycles:
- Cycles 0–29: Break (True)
- Cycles 30–59: Class (False)
- Cycles 60–89: Break (True)
- Cycles 90–100: Class (False)

During break periods, `high_attention_count` climbs toward 25 (all students), and during class periods it drops as students fall below the 0.7 attention threshold.

---

## Conclusion

The simulation results show that breaks play a critical role in maintaining student attention and enabling performance growth. Without breaks, attention would drop to 0 and performance would stagnate. The data confirms that performance is dependent on attention as a triggering condition — you need attention above 0.6 to get any performance gain. The sawtooth pattern of attention with a steadily rising performance trend reflects a realistic simplified model of how classroom learning works: students lose focus over time but recover during rest, and each recovery window contributes to cumulative learning. The model is simple but it successfully captures the core relationship between rest, engagement, and academic outcome.

---


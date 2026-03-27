
model classroom_simulation

global {

    init {
        create student number: 20 {
            location <- { rnd(100.0), rnd(100.0), 0.0 };
            energy   <- rnd(3, 7);
        }
    }

    int active_count   -> { student count (each.status = "active") };
    int inactive_count -> { student count (each.status = "inactive") };
}

species student {

    int energy    <- 5;
    int score     <- 0;
    string status <- "active";

    reflex participate when: status = "active" {
        if flip(0.8) {
            score  <- score + 1;
            energy <- energy - 1;
        }
    }

    reflex update_status {
        if energy <= 0 {
            status <- "inactive";
        }
    }

    aspect default {
        draw circle(1) color: (status = "active") ? #green : #red;
    }
}

experiment classroom_experiment type: gui {

    output {

        display "Classroom View" {
            species student aspect: default;
        }

        display "Score Chart" {
            chart "Student Scores Over Time" type: series {
                datalist (student collect each.name)
                    value: (student collect each.score)
                    color: #blue;
            }
        }

        display "Energy Chart" {
            chart "Student Energy Over Time" type: series {
                datalist (student collect each.name)
                    value: (student collect each.energy)
                    color: #orange;
            }
        }

        display "Status Chart" {
            chart "Active vs Inactive Students" type: series {
                data "Active"   value: active_count   color: #green;
                data "Inactive" value: inactive_count color: #red;
            }
        }

        monitor "Active Students"   value: active_count;
        monitor "Inactive Students" value: inactive_count;
        monitor "Highest Score"     value: (student max_of each.score);
        monitor "Average Score"     value: (student mean_of each.score) with_precision 2;
        monitor "Average Energy"    value: (student mean_of each.energy) with_precision 2;
    }
}
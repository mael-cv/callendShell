#!/bin/bash

source ./functions.sh

# Ask the user if he is a student or a teacher
selector() {
    clear
    echo "|####################|"
    echo "|  Authentification  |"
    echo "|####################|"
    echo "|                    |"
    echo "|   Bienvenue dans   |"
    echo "|     PPCallendar    |"
    echo "|                    |"
    echo "|   Pour continuer   |"
    echo "| selectionnez votre |"
    echo "|      role:         |"
    echo "|                    |"
    echo "| [0] - Etudiant     |"
    echo "| [1] - Professeur   |"
    echo "|                    |"
    echo "|   int [0] or [1]   |"
    echo "|                    |"
    echo "|####################|"
    read -r role
    [[ "$role" == "0" || "$role" == "1" ]] && return "$role"
    clear
    echo "Role was Unknow please try again"
    selector
}

# If the user is a student; student menu
student() {
    clear
    echo "|####################|"
    echo "|  Welcome student!  |"
    echo "|####################|"

    stutend_json="calendars/student.json"

    
    echo "|------- MENU -------|"
    echo "|--------------------|"
    echo "      [1] - Cours dans une semaine [1-52]"
    echo "      [2] - Nombre d'heures dans une semaine [1-52]"
    echo "      [3] - Voir les prochains examens"
    echo "|--------------------|"
    
    read -r choice

    case "$choice" in
        1)
            display_lessons $stutend_json
            ;;
        2)
            display_hour_for_week $stutend_json
            ;;
        3)
            display_upcoming_tests $stutend_json
            ;;
        *)
            echo "Invalid option. Please try again."
            student
            ;;
    esac
}

# If the user is a teacher; teacher menu
teacher() {
    clear
    echo "|####################|"
    echo "|  Welcome teacher!  |"
    echo "|####################|"

    teacher_json="calendars/teacher.json"
    student_json="calendars/student.json"

    echo "|------- MENU -------|"
    echo "|--------------------|"
    echo "     [1] - Cours dans une semaine [1-52]"
    echo "     [2] - Nombre d'heures dans une semaine [1-52]"
    echo "     [3] - Prochaines leçon d'un module [Nom du Module]"
    echo "     [4] - Emploi du temps commun avec un étudiant"
    echo "|--------------------|"
    read -r choice

    case "$choice" in
        1)
            display_lessons $teacher_json
            ;;
        2)
            display_hour_for_week $teacher_json
            ;;
        3)
            display_lessons_of_type $teacher_json
            ;;
        4)
            display_common_schedule $teacher_json $student_json
            ;;
        *)
            echo "Invalid option. Please try again."
            teacher
            ;;
    esac

}

selector
if [[ $? -eq 0 ]]; then
    student
else
    teacher
fi

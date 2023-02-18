#!/bin/bash

PS3="Choose: "
select ITEM in "Display current date and time." "List users logged in" "Display disk usage" "Create a new user" "Weather" "Quit"
do
        case $REPLY in
                1)
                        echo "The current date and time: "
                        sleep 1
                        date +"%Y-%m-%d %H:%M:%S"
                        break
                        ;;
                2)
                        echo "Listing users logged in: "
                        sleep 1
                        who
                        break
                        ;;
                3)
                        echo "Displaying disk usage: "
                        sleep 1
                        df -h
                        break
                        ;;

                4)
                        read -p "Enter the name of the user you want to create: " usrname
                        read -p "Enter the defualt shell for this user (default option is /bin/sh): " sh
                        read -p "Do you want to create a home folder? (y/n) " ans
                        if [[ -z $sh ]]
                        then
                                $sh="/bin/sh"
                        fi

                        sleep 1

                        if [[ $ans == "y" ]] || [[ $ans == "Y" ]]
                        then
                                sudo useradd -m -s $sh $usrname
                        elif [[ $ans == "n" ]] || [[ $ans == "N" ]]
                        then
                                sudo useradd -s $sh $usrname
                        else
                                echo "Wrong choice."
                                break
                        fi
                        if [[ $? -eq 0 ]]
                        then 
                                echo "Created the user $usrname successfully..."
                                break
                        fi
                        ;;

                5)
                        echo "Displaying today's weather..."
                        sleep 1
                        curl -s "https://wttr.in/?2"
                        break
                        ;;

                6 | q)
                        echo "Quitting..."
                        break
                        ;;

                *)
                        echo "Your selection $REPLY is invalid."
        esac
done

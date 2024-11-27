#!/bin/sh

check_disk_usage() {
    echo "Disk usage:"
    df -hT
}

monitor_running_processes() {
    echo "Running services:"
    systemctl list-units --type=service --state=running
}

access_memory_usage() {
    echo "Memory usage:"
    free -h
}

evaluate_cpu_usage() {
    echo "CPU usage:"
    top -bn1 | grep "Cpu(s)"
}

send_email_report() {
    local email="rajgupta271990@gmail.com"
    local report_file="/tmp/system_health_report.txt"
    echo "Generating system health report..."

    {
        echo "System Health Report - $(date)"
        echo "----------------------------------------"
        check_disk_usage
        monitor_running_processes
        access_memory_usage
        evaluate_cpu_usage
    } > "$report_file"

    echo "Sending report to $email"
    mail -s "System Health Report" "$email" < "$report_file"
    echo "Report Sent successfully."
}

while true; do
    echo "System Health Check Menu"
    echo "1. Check Disk Usage"
    echo "2. Monitor Running Services"
    echo "3. Assess Memory Usage"
    echo "4. Evaluate CPU Usage"
    echo "5. Generate and Send Comprehensive Report via email"
    echo "6. Exit"
    read -p "Choose an optin [1-6]:" choice

    case $choice in 
        1) check_disk_usage;;
        2) monitor_running_processes;;
        3) access_memory_usage;;
        4) evaluate_cpu_usage;;
        5) send_email_report;;
        6) echo "Exiting..."; exit 0;;
        *) echo "Invalid Choice. Please select a valid option.";;
    esac
    echo
done

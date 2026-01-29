# HMS - Hostel Management System (DevOps Edition) 

## 🏗️ Architecture
This project demonstrates a production-grade **3-Tier Architecture** deployment using **Infrastructure as Code (IaC)**. The application is decoupled into isolated layers for security and scalability.

* **Web Layer (The Waiter):** Nginx (Reverse Proxy & Load Balancer) - *Port 8080*
* **App Layer (The Kitchen):** FastAPI (Python 3.12) running via Systemd - *Internal Port 8000*
* **Data Layer (The Fridge):** PostgreSQL 14 (Isolated Database Node) - *Internal Port 5432*

## 🛠️ Tech Stack
* **Infrastructure:** Vagrant, VirtualBox, Shell Scripting (Bash)
* **Configuration Management:** Automated Provisioning Scripts
* **Backend:** FastAPI, SQLAlchemy, Pydantic
* **Database:** PostgreSQL
* **OS:** Ubuntu 22.04 LTS (Jammy Jellyfish)

## 🚀 How to Deploy (Local Production Simulation)

### Prerequisites
* [VirtualBox](https://www.virtualbox.org/) or VMware Fusion
* [Vagrant](https://www.vagrantup.com/)
* Git

### Installation
1.  **Clone the repository**:
    ```bash
    git clone [https://github.com/marcusadigun/student-management-devops.git](https://github.com/marcusadigun/student-management-devops.git)
    cd student-management-devops
    ```

2.  **Secure Configuration**:
    Create a `.env.prod` file in the root directory (do not commit this file!).
    ```bash
    # Database Connection (Connects to the DB VM)
    DATABASE_URL=postgresql://hms_user:securepassword@192.168.56.10:5432/hms_db

    # Secrets
    JWT_KEY=your_secret_key
    GROQ_API_KEY=your_api_key
    
    # Email Config
    MAIL_FROM=your_email@gmail.com
    MAIL_USERNAME=your_email@gmail.com
    MAIL_PASSWORD=your_app_password
    MAIL_SERVER=smtp.gmail.com
    ```

3.  **Provision Infrastructure**:
    Run the following command to spin up the Web, App, and DB servers automatically:
    ```bash
    vagrant up
    ```

4.  **Access the Application**:
    Visit `http://localhost:8080` to view the application via the Nginx Reverse Proxy.

## 📂 Project Structure
```text
├── Vagrantfile             # Infrastructure definition (3 VMs)
├── scripts/                # Provisioning scripts
│   ├── install_db.sh       # Sets up PostgreSQL
│   ├── install_app.sh      # Sets up Python & FastAPI Service
│   └── install_web.sh      # Sets up Nginx Reverse Proxy
├── src/                    # Application Source Code
└── requirements.txt        # Python Dependencies

You are absolutely right. The current README.md only describes how to run the app manually with Python, but your project is now a sophisticated 3-Tier DevOps Architecture.

To make your GitHub repository look professional (and get those recruiter clicks), replace the entire content of your README.md with this version. It documents the architecture, the technology stack, and the automated deployment instructions.

Updated README.md
Markdown

# HMS - Hostel Management System (DevOps Edition) 🚀

## 🏗️ Architecture
This project demonstrates a production-grade **3-Tier Architecture** deployment using **Infrastructure as Code (IaC)**. The application is decoupled into isolated layers for security and scalability.

* **Web Layer (The Waiter):** Nginx (Reverse Proxy & Load Balancer) - *Port 8080*
* **App Layer (The Kitchen):** FastAPI (Python 3.12) running via Systemd - *Internal Port 8000*
* **Data Layer (The Fridge):** PostgreSQL 14 (Isolated Database Node) - *Internal Port 5432*

## 🛠️ Tech Stack
* **Infrastructure:** Vagrant, VirtualBox, Shell Scripting (Bash)
* **Configuration Management:** Automated Provisioning Scripts
* **Backend:** FastAPI, SQLAlchemy, Pydantic
* **Database:** PostgreSQL
* **OS:** Ubuntu 22.04 LTS (Jammy Jellyfish)

## 🚀 How to Deploy (Local Production Simulation)

### Prerequisites
* [VirtualBox](https://www.virtualbox.org/) or VMware Fusion
* [Vagrant](https://www.vagrantup.com/)
* Git

### Installation
1.  **Clone the repository**:
    ```bash
    git clone [https://github.com/marcusadigun/student-management-devops.git](https://github.com/marcusadigun/student-management-devops.git)
    cd student-management-devops
    ```

2.  **Secure Configuration**:
    Create a `.env.prod` file in the root directory (do not commit this file!).
    ```bash
    # Database Connection (Connects to the DB VM)
    DATABASE_URL=postgresql://hms_user:securepassword@192.168.56.10:5432/hms_db

    # Secrets
    JWT_KEY=your_secret_key
    GROQ_API_KEY=your_api_key
    
    # Email Config
    MAIL_FROM=your_email@gmail.com
    MAIL_USERNAME=your_email@gmail.com
    MAIL_PASSWORD=your_app_password
    MAIL_SERVER=smtp.gmail.com
    ```

3.  **Provision Infrastructure**:
    Run the following command to spin up the Web, App, and DB servers automatically:
    ```bash
    vagrant up
    ```

4.  **Access the Application**:
    Visit `http://localhost:8080` to view the application via the Nginx Reverse Proxy.

## 📂 Project Structure
```text
├── Vagrantfile             # Infrastructure definition (3 VMs)
├── scripts/                # Provisioning scripts
│   ├── install_db.sh       # Sets up PostgreSQL
│   ├── install_app.sh      # Sets up Python & FastAPI Service
│   └── install_web.sh      # Sets up Nginx Reverse Proxy
├── src/                    # Application Source Code
└── requirements.txt        # Python Dependencies
🧪 Testing the Setup
Web Server: Accessible at http://localhost:8080

App Server: Isolated on private network 192.168.56.11

Database: Isolated on private network 192.168.56.10

License
This project is for educational purposes.


### **How to Update It**
1.  Open `hms/README.md` in VS Code.
2.  Delete everything inside.
3.  Paste the code block above.
4.  Save and run:
    ```bash
    git add README.md
    git commit -m "docs: Update README to reflect 3-tier Vagrant architecture"
    git push origin main
    ```

Testing CI Automation!

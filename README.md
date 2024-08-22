# LearningALV1

Welcome to the `LearningALV1` project! This repository is dedicated to helping you get started with Microsoft Dynamics 365 Business Central's AL (Application Language) development. This project serves as a learning resource for building extensions and customizations in Business Central using AL.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Introduction

`LearningALV1` is a simple project created to help new developers understand the basics of AL development in Dynamics 365 Business Central. It includes examples of creating tables, pages, and other AL objects commonly used in Business Central development.

## Features

- **Table Definition**: Learn how to define tables in AL, including primary keys, field definitions, and data classification.
- **Page Design**: Understand how to create and customize pages, including List and Card pages.
- **Permissions**: Learn how to set permissions for your AL objects.
- **Tooltips and Layout**: See how to add helpful tooltips and organize page layouts effectively.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- **Business Central Sandbox**: You need access to a Microsoft Dynamics 365 Business Central Sandbox environment.
- **AL Language Extension**: Install the AL Language extension in Visual Studio Code.
- **Visual Studio Code**: Make sure you have Visual Studio Code installed on your machine.
- **BC Development Environment**: Familiarity with the Business Central development environment is recommended.

## Installation

To set up this project locally:

1. Clone this repository:

    ```bash
    git clone https://github.com/agichimu/LearningALV1.git
    ```

2. Open the project in Visual Studio Code.

3. Connect to your Business Central Sandbox by configuring the `launch.json` file.

4. Deploy the project to your sandbox environment:

    - Press `F5` or use the `Ctrl+F5` shortcut to build and deploy the extension.

## Project Structure

Here’s a quick overview of the project structure:

- **Tables**: Contains table objects that define the structure of the data in your extension.
- **Pages**: Contains page objects like `Card` and `List` pages, which define the UI for interacting with your data.
- **Codeunits**: Optional - for more advanced logic and business processes.
- **Extensions**: Optional - for extending existing Business Central functionality.

## Usage

Once the extension is deployed, you can:

- Explore the `UsersCard` page to see how data from the `Users` table is displayed and managed.
- Use the `UsersList` page to view a list of all user records.
- Experiment with the provided AL code to further customize the functionality.

## Contributing

Contributions are what make the open-source community such a fantastic place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this project better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

## Contact

Your Name -  alexandergichimu98@gmail.com

Project Link: [https://github.com/agichimu/LearningALV1.git](https://github.com/agichimu/LearningALV1.git)

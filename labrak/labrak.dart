import 'dart:io';
import 'dart:math';

// Node for Linked List
class Node {
  String city;
  Node? next;

  Node(this.city);
}

// Linked List to hold the cities
class LinkedList {
  Node? head;

  void append(String city) {
    if (head == null) {
      head = Node(city);
    } else {
      Node current = head!;
      while (current.next != null) {
        current = current.next!;
      }
      current.next = Node(city);
    }
  }

  void display() {
    Node? current = head;
    while (current != null) {
      print(current.city);
      current = current.next;
    }
  }
}

// Graph class to solve TSP and handle city distance lookups
class Graph {
  List<List<int>> adjMatrix;
  List<String> cities;

  Graph(this.adjMatrix, this.cities);

  // Function to get the distance between two cities
  int getDistance(String from, String to) {
    int fromIndex = cities.indexOf(from);
    int toIndex = cities.indexOf(to);

    if (fromIndex == -1 || toIndex == -1) {
      print('Kota tidak ditemukan.');
      return -1;
    }

    return adjMatrix[fromIndex][toIndex];
  }

  // Calculate the total distance for multiple city hops
  int calculateRouteDistance(List<String> route) {
    int totalDistance = 0;

    for (int i = 0; i < route.length - 1; i++) {
      int distance = getDistance(route[i], route[i + 1]);
      if (distance == -1) {
        return -1; // Stop if invalid city pair is found
      }
      totalDistance += distance;
    }

    return totalDistance;
  }
}

void main() {
  // Create a Linked List to store the cities
  LinkedList citiesList = LinkedList();
  citiesList.append('A');
  citiesList.append('B');
  citiesList.append('C');
  citiesList.append('D');
  citiesList.append('E');

  // Display cities in the Linked List
  print('Cities in the Linked List:');
  citiesList.display();

  // Matrix of distances between cities
  List<List<int>> adjMatrix = [
    [0, 8, 3, 4, 10],  // A
    [8, 0, 5, 2, 7],   // B
    [3, 5, 0, 1, 6],   // C
    [4, 2, 1, 0, 3],   // D
    [10, 7, 6, 3, 0]   // E
  ];

  // List of cities
  List<String> cities = ['A', 'B', 'C', 'D', 'E'];

  // Create the graph with the distance matrix and city list
  Graph graph = Graph(adjMatrix, cities);

  // User input to find distance between multiple cities
  while (true) {
    print('\nMasukkan rute kota yang ingin dihitung (contoh: A B D) atau ketik "exit" untuk keluar:');
    String? input = stdin.readLineSync();

    if (input == null || input.toLowerCase() == 'exit') {
      print('Program selesai.');
      break;
    }

    List<String> route = input.split(' ');

    if (route.length >= 2) {
      int totalDistance = graph.calculateRouteDistance(route);

      if (totalDistance != -1) {
        print('Total jarak untuk rute ${route.join(' -> ')} adalah $totalDistance.');
      } else {
        print('Ada kota yang tidak valid dalam rute.');
      }
    } else {
      print('Masukan tidak valid. Harap masukkan minimal dua kota.');
    }
  }
}

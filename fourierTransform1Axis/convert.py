import cv2
import numpy as np
import matplotlib.pyplot as plt
from scipy.spatial import distance

# Edge detection (Canny)
def detect_edges(image_path):
    img = cv2.imread(image_path)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(gray, threshold1=100, threshold2=200)
    return edges

# Find pixel coordinates of edges
def get_edge_coordinates(edges):
    edge_points = np.column_stack(np.where(edges > 0))
    return edge_points

# Nearest Neighbor algorithm
def nearest_neighbor_path(edge_points):
    # Take the first point
    path = [edge_points[0]]
    remaining_points = list(edge_points[1:])

    while remaining_points:
        # Current position
        current_point = path[-1]

        # Find the nearest neighbor
        distances = distance.cdist([current_point], remaining_points, 'euclidean')[0]
        nearest_idx = np.argmin(distances)
        nearest_point = remaining_points.pop(nearest_idx)

        # Update the path
        path.append(nearest_point)

    return np.array(path)

# Draw the path
def plot_path(path):
    plt.figure(figsize=(6, 6))
    plt.plot(path[:, 1], path[:, 0], color='black')  # Draw coordinates
    plt.axis('off')  # Hide axes
    plt.show()

# Generate one-line art
def generate_one_line_art(image_path):
    edges = detect_edges(image_path)
    edge_points = get_edge_coordinates(edges)
    path = nearest_neighbor_path(edge_points)
    plot_path(path)
    return path

# Example usage
path = generate_one_line_art('concept_images_1.jpeg')

file = open("save.txt","w")
for i in path:
    file.write(str(i[0])+" "+str(i[1])+"\n")
file.close()

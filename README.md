# Neural-Net-Vizualization
Visualization of neural networks weights

How can we vizualize weights in high-dimensional, iterative, predictive algorithms? I use “vanilla”, or single hidden layer network as an example. To illustrate the power neural net vizualization, I simulate data with a vector of Y, 20×100,000 matrix of X, 1 hidden layer, and 20 nodes.

First, heat map representation could be a good choice. In addition, I use clustering to improve the visualization of heat map. This heatmap is presented in "heatmap" file.

Second, a network could be presented as a neural interpretation diagram. I use R package "NeuralNetTools" to do it. Line thickness is in proportion to magnitude of the weight relative to all others. The hidden layer is labeled as H1 through H10. Finally, it is possible to construct a neural interpretation diagram where only strongest links are presented. Results are in "graph" and "graph2" files.

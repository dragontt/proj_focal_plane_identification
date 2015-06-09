# proj_focal_plane_identification

### Primary Objective

Locate starting frame number of even series of all cells located in focal plane 1.

### Second Objective

1. Determine the entry velocity for each cell in px/frame. 
2. Do other focal planes (more than 2) exist. Explore and quantify.

### Solution:

1. Use connected component to identify different cell object. 
2. Distinguish invidual cell object on different focal plane based on its histogram.
3. Track the center of cell frame by frame and average those discrete velocity for each cell to compute the entry velocity.

Note: Only two categories of focal planes are identified in the given image stack

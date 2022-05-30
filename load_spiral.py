######################################################################
#  Read a 3D path output by path_util.asy library and turn it
#  into a blender path.
#
#  This script is licensed under the GNU Lesser Public License 3.
#
#  Dov Grobgeld <dov.grobgeld@gmail.com>
#  2022-05-30 Mon
######################################################################

import bpy
from mathutils import Vector
import json
from dataclasses import dataclass

class AsyJson:
  def __init__(self, json_filename):
    with open(json_filename) as fh:
      data = json.load(fh)
      self.points = data['points']
      self.cyclic = data['cyclic']

coords = AsyJson('/tmp/spiral.json') 

# make a new curve
data = bpy.data.curves.new('An asymptote curve','CURVE')
data.dimensions = '3D'

# make a new splin in that curve
spline = data.splines.new(type='BEZIER')
spline.use_cyclic_u = coords.cyclic

# A spline point for each point
spline.bezier_points.add(len(coords.points)-1)

# Assign the point coordinates to the splite points
for p, coord in zip(spline.bezier_points, coords.points):
  p.co = coord['co']
  p.handle_left_type = 'FREE'
  p.handle_right_type = 'FREE'
  p.handle_left = coord['left']
  p.handle_right = coord['right']

# make a new object with the curve
obj = bpy.data.objects.new('Asy Curve',data)
obj.location = (0,0,0)
obj.data.resolution_u=128
obj.data.bevel_resolution=128
obj.data.fill_mode = 'FULL'
obj.data.bevel_depth=0.2
bpy.context.collection.objects.link(obj)

  

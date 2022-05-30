//======================================================================
//  A utility to export a path in json that can be read by a python
//  blender script
//
//  This script is licensed under the GNU Lesser General Public Version 3
//
//  Dov Grobgeld <dov.grobgeld@gmail.com>
//  2022-05-30 Mon
//----------------------------------------------------------------------
import three;

string bool_to_string(bool b)
{
  if (b)
    return "1";
  else
    return "0";
}

string triple_string(triple tr)
{
  return '['+string(tr.x) + ',' + string(tr.y) + ',' + string(tr.z)+']';
}


void save_path3(path3 p, string filename)
{
  file fout = output(filename);
  string json = '{\n';

  json += "  \"cyclic\": " + bool_to_string(cyclic(p)) + ',\n';
  json += "  \"points\": [" + '\n';
  int len = size(p);

  int i=0;
  while(i<len) {
    json += '    {\n';
    json += "      \"co\": " + triple_string(point(p,i)) + ',\n';
    json += "      \"left\": " + triple_string(precontrol(p,i)) + ',\n';
    json += "      \"right\": " + triple_string(postcontrol(p,i)) + '\n';
    json += '    }';
    if (i < len-1)
      json += ',';
    json += '\n';
    i+= 1;
  }
  json += '  ]\n';

  json+= '}\n';
  
  write(fout, json);
}


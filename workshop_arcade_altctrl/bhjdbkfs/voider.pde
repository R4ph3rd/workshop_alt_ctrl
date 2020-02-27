class voider { 
  float [] xpos0 = {107.986694,111.58734,118.515205,125.08925,131.28091,137.06165,142.4029,147.2761,151.65265,155.50409,158.80179,161.51724,163.62183,165.08707,165.88434,165.9851,165.36081,164.73587,163.9927,161.87906,159.03175,155.47202,151.22107,146.3002,140.73059,134.53345,127.730064,120.34163,112.38939,103.89456,94.87839,85.3621,75.36692,64.91409,59.504944,54.025032,42.749588,31.162415,19.33796,7.350688,-4.7249465,-16.814486,-28.843472,-40.73745,-52.421963,-63.822548,-74.86476,-85.47413,-95.5762,-105.09653,-113.96065,-118.09137,-122.0941,-129.47469,-136.13246,-142.09747,-147.39975,-152.0694,-156.13641,-159.63089,-162.58286,-165.02235,-166.97946,-168.48425,-170.00613,-170.6622,-170.45168,-170.06894,-168.35434,-165.5148,-161.56587,-156.52313,-150.40213,-143.21837,-134.98743,-130.44147,-125.70652,-115.40754,-104.14271,-95.051254,-88.72473,-82.17491,-75.40582,-68.421524,-61.226036,-53.8234,-46.217648,-38.412827,-30.412964,-26.333282,-22.212532,-13.829096,-5.303323,3.3336868,12.050835,20.817024,29.601154,38.372124,47.098846,55.750206,64.295105,72.70247,80.94118,88.98013,96.78825,104.33441,107.986694,107.986694};
  float [] ypos0 = {-142.63841,-138.97218,-131.2575,-123.110306,-114.55957,-105.63431,-96.36352,-86.77621,-76.90139,-66.768074,-56.405243,-45.841927,-35.10711,-24.229816,-13.239038,-2.1637888,8.96693,14.544525,20.114548,31.2434,42.320744,53.304268,64.151665,74.82062,85.268814,95.45395,105.333694,114.86577,124.00781,132.71756,140.95267,148.67087,155.8298,162.38718,165.39935,168.2913,173.51712,178.06259,181.9159,185.06522,187.49873,189.20467,190.17117,190.38647,189.83871,188.51614,186.4069,183.49922,179.78122,175.24115,169.86716,166.82828,163.64786,156.61864,148.85448,140.43,131.4198,121.898506,111.94072,101.62102,91.01404,80.194374,69.23664,58.215435,41.712452,20.18452,9.849457,-0.2543683,-19.368586,-37.28371,-54.12534,-70.01906,-85.09047,-99.46515,-113.26869,-119.97958,-126.62589,-139.46957,-151.5549,-159.93745,-165.18265,-170.10098,-174.66199,-178.83519,-182.59003,-185.89603,-188.72272,-191.03955,-192.81604,-193.46771,-194.03107,-194.67099,-194.73318,-194.22484,-193.15315,-191.52527,-189.34836,-186.62964,-183.37628,-179.5954,-175.29425,-170.47995,-165.15973,-159.34073,-153.03012,-146.23508,-142.63841,-142.63841};
  
  void display(float xpos,float ypos) {
    pushMatrix();
    translate(xpos,ypos);
    beginShape();
     for(int x = 0; x < xpos0.length; x++){
       curveVertex(xpos0[x],  ypos0[x]);
     }
    endShape();
    popMatrix();
  }
}

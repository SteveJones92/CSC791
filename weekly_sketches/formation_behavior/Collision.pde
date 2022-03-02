/********************************************************
isCollidingCircleRectangle()
  
  params:
   circleX - center x coordinate for circle
   circleY - center y coordinate for circle
   radius  - radius of circle
   rectangleX - top left corner X coordinate
   rectangleY - top left corner Y coordinate
   rectangleWidth - width of rectangle
   rectangleHeight - and the height
 
 returns boolean - whether the two shapes are colliding
 
 code adapted from:
   http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
 adapted by: Jonathan Cecil
********************************************************/
boolean isCollidingCircleRectangle(
    float circleX,
    float circleY,
    float radius,
    float rectangleX,
    float rectangleY,
    float rectangleWidth,
    float rectangleHeight
      )
{
    float circleDistanceX = abs(circleX - rectangleX - rectangleWidth/2);
    float circleDistanceY = abs(circleY - rectangleY - rectangleHeight/2);

    if (circleDistanceX > (rectangleWidth/2 + radius)) { return false; }
    if (circleDistanceY > (rectangleHeight/2 + radius)) { return false; }

    if (circleDistanceX <= (rectangleWidth/2)) { return true; } 
    if (circleDistanceY <= (rectangleHeight/2)) { return true; }

    float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
                         pow(circleDistanceY - rectangleHeight/2, 2);

    return (cornerDistance_sq <= pow(radius,2));
}

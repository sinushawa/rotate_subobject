viewsys = viewport.getTM()
viewsys.translation = point3 0 0 0
a=(pickPoint snap:#3D) as point3
abis = a
a=a*viewsys
a=[a.x,a.y,0]
pp1=(pickPoint snap:#3D) as point3
pp1=pp1*viewsys
pp1=[pp1.x,pp1.y,0]
pp2=(pickPoint snap:#3D) as point3
pp2=pp2*viewsys
pp2=[pp2.x,pp2.y,0]
N1=pp1-a
N1=normalize N1
N2=pp2-a
N2=normalize N2
val = cross N1 N2
angleR = acos (dot N1 N2)
if (val.x<0 OR val.y<0 OR val.z<0) do
(
	angleR=-angleR
)
vertSelected = polyop.getVertSelection selection[1]
vertArray = vertSelected as array
Poses = #()
for i in vertArray do
(
	vertPos = polyop.getVert selection[1] i
	newPos = ((vertPos-abis) * (xformMat ((eulerangles 0 0 angleR) as matrix3) viewsys).rotationpart) + abis
	append Poses newPos
)
polyop.setVert selection[1] vertSelected Poses

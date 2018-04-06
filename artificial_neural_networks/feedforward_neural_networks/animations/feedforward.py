import numpy as np
import matplotlib.transforms as mtransforms
from matplotlib import pyplot as plt
from matplotlib import animation
from matplotlib.patches import FancyBboxPatch

# To get a math font
plt.rc('mathtext', fontset="cm")


fig = plt.figure()
fig.set_dpi(100)
fig.set_size_inches(13,7.5)

ax = plt.axes(xlim=(-2, 20), ylim=(-2, 11))



# Function to draw a circle
def circle(x, y, fc='none', radius=0.75):
	from matplotlib.patches import Circle
	from matplotlib.patheffects import withStroke
	c = Circle((x, y), radius, clip_on=False, linewidth=1,
				edgecolor='black', facecolor=fc,
				path_effects=[withStroke(linewidth=1, foreground='w')])
	ax.add_artist(c)
	return c


# Function to draw a line
def line(p1, p2):
	x=[p1[0],p2[0]]
	y=[p1[1],p2[1]]
	ax.plot(x, y, c=(0,0,0), lw=1)



# Function to write text
def text(x, y, text):
	text = ax.text(x, y, text, fontsize=20, ha='center', va='center')
	return text


# Function to draw a fancy box
def draw_bbox(bb, facecolor):
    # boxstyle=square with pad=0, i.e. bbox itself.
    p_bbox = FancyBboxPatch((bb.xmin, bb.ymin),
                            abs(bb.width), abs(bb.height),
                            boxstyle="round,pad=0.2",
                            ec="k", fc=facecolor,
                            )
    ax.add_patch(p_bbox)





###########################
#    Highlight layers     #
###########################
# Input layer
#bb = mtransforms.Bbox([[0, 2], [2, 8]])
#draw_bbox(bb, (0., 1., 0., 0.5));

# Hidden layer
#bb = mtransforms.Bbox([[8, 2], [10, 10]])
#draw_bbox(bb, (0., 0., 1., 0.5));

# Ouput layer
#bb = mtransforms.Bbox([[16, 2], [18, 6]])
#draw_bbox(bb, (1., 0., 0., 0.5));


##########################
##    Create Weights    ##
##########################
# Input layer
# bias
w1 = plt.Circle((0,0), 0.25)
w2 = plt.Circle((0,0), 0.25)
w3 = plt.Circle((0,0), 0.25)
w4 = plt.Circle((0,0), 0.25)

w1_c = circle(-1,7)
w1_t =   text(-1,7,r'$W^{(1)}_{10}$')
m1_t =	 text( 0,7,r'$*$')
w2_c = circle(-1,5)
w2_t =   text(-1,5,r'$W^{(1)}_{11}$')
m2_t =	 text( 0,5,r'$*$')
w3_c = circle(-1,3)
w3_t =   text(-1,3,r'$W^{(1)}_{12}$')
m3_t =	 text( 0,3,r'$*$')
w4_c = circle(-1,1)
w4_t =   text(-1,1,r'$W^{(1)}_{13}$')
m4_t =	 text( 0,1,r'$*$')

##########################
#
##########################
z21_t = text(5,7,r'');
z22_t = text(5,5,r'');
z23_t = text(5,3,r'');

a21_t = text(9,7,r'');
a22_t = text(9,5,r'');
a23_t = text(9,3,r'');

z31_t = text(13,5,r'');
z32_t = text(13,3,r'');

y1_t = text(17,5,r'');
y2_t = text(17,3,r'');



def init():
	ax.add_patch(w1)
	ax.add_patch(w2)
	ax.add_patch(w3)
	ax.add_patch(w4)
	return w1, w2, w3, w4


show_time = 50;
wait_time = 50;
weigth_fade_time = 50;
feed_time = 100;



anim_time = [wait_time]; # wait
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+feed_time); # feed
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+feed_time); # feed
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+feed_time); # feed
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+feed_time); # feed
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+feed_time); # feed
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+feed_time); # feed
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+weigth_fade_time); # fade
anim_time.append(anim_time[-1]+feed_time); # feed
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show
anim_time.append(anim_time[-1]+show_time); # show

total_time 	= anim_time[-1];



# Hide
w1.set_color('none')
w2.set_color('none')
w3.set_color('none')
w4.set_color('none')
w1_c.set_edgecolor('none')
w1_t.set_color('none')
m1_t.set_color('none')
w2_c.set_edgecolor('none')
w2_t.set_color('none')
m2_t.set_color('none')
w3_c.set_edgecolor('none')
w3_t.set_color('none')
m3_t.set_color('none')
w4_c.set_edgecolor('none')
w4_t.set_color('none')
m4_t.set_color('none')



# Function for animation
def animate(i):

	# Weights
	if i<anim_time[0]: # ------------------------------------------------- wait
		# Nothing just wait a while
		a=0

	elif i<anim_time[1]: # ----------------------------------------------- fade
		#color = w1_c.get_edgecolor()
		#color = list(color)
		#color[3] += 1.0/weigth_fade_time
		#color[3] = np.clip(color[3], 0, 1)
		#color = tuple(color)

		#w1_c.set_edgecolor(color)
		#w1_t.set_color(color)
		#m1_t.set_color(color)

		#w2_c.set_edgecolor(color)
		#w2_t.set_color(color)
		#m2_t.set_color(color)

		#w3_c.set_edgecolor(color)
		#w3_t.set_color(color)
		#m3_t.set_color(color)

		w1_c.set_edgecolor('black')
		w1_t.set_color('black')
		m1_t.set_color('black')

		w2_c.set_edgecolor('black')
		w2_t.set_color('black')
		m2_t.set_color('black')

		w3_c.set_edgecolor('black')
		w3_t.set_color('black')
		m3_t.set_color('black')

		

	elif i<anim_time[2]: # ----------------------------------------------- feed
		# Color
		w1.set_color('#80bfff')
		w2.set_color('#80bfff')
		w3.set_color('#80bfff')
		w4.set_color('none')

		start = anim_time[1]

		# b1 to a21
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 7
		w1.center = (x,y)

		# x1 to a21
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 5+2/float(feed_time)*(i-start)
		w2.center = (x,y)

		# x2 to a21
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 3+4/float(feed_time)*(i-start)
		w3.center = (x,y)

	elif i<anim_time[3]: # ----------------------------------------------- show
		z21_t.set_text(r'$\sum$');

	elif i<anim_time[4]: # ----------------------------------------------- show
		z21_t.set_text(r'$z^{(2)}_1$');

	elif i<anim_time[5]: # ----------------------------------------------- fade
		w1_c.set_edgecolor('none')
		w1_t.set_color('none')
		m1_t.set_color('none')

		w2_c.set_edgecolor('none')
		w2_t.set_color('none')
		m2_t.set_color('none')

		w3_c.set_edgecolor('none')
		w3_t.set_color('none')
		m3_t.set_color('none')

	elif i<anim_time[6]: # ----------------------------------------------- fade
		w1_c.set_edgecolor('black')
		w1_t.set_color('black')
		m1_t.set_color('black')
		w1_t.set_text(r'$W^{(1)}_{20}$')

		w2_c.set_edgecolor('black')
		w2_t.set_color('black')
		m2_t.set_color('black')
		w2_t.set_text(r'$W^{(1)}_{21}$')

		w3_c.set_edgecolor('black')
		w3_t.set_color('black')
		m3_t.set_color('black')
		w3_t.set_text(r'$W^{(1)}_{22}$')

	elif i<anim_time[7]: # ----------------------------------------------- feed
		start = anim_time[6]

		# b1 to a22
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 7-2/float(feed_time)*(i-start)
		w1.center = (x,y)

		# x1 to a22
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 5
		w2.center = (x,y)

		# x2 to a22
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 3+2/float(feed_time)*(i-start)
		w3.center = (x,y)

	elif i<anim_time[8]: # ----------------------------------------------- show
		z22_t.set_text(r'$\sum$');

	elif i<anim_time[9]: # ----------------------------------------------- show
		z22_t.set_text(r'$z^{(2)}_2$');

	elif i<anim_time[10]: # ---------------------------------------------- fade
		w1_c.set_edgecolor('none')
		w1_t.set_color('none')
		m1_t.set_color('none')

		w2_c.set_edgecolor('none')
		w2_t.set_color('none')
		m2_t.set_color('none')

		w3_c.set_edgecolor('none')
		w3_t.set_color('none')
		m3_t.set_color('none')

	elif i<anim_time[11]: # ---------------------------------------------- fade
		color = w1_c.get_edgecolor()
		color = list(color)
		color[3] += 1.0/weigth_fade_time
		color[3] = np.clip(color[3], 0, 1)
		color = tuple(color)

		w1_c.set_fc('white')
		w1_c.set_edgecolor('black')
		w1_t.set_color('black')
		m1_t.set_color('black')
		w1_t.set_text(r'$W^{(1)}_{30}$')

		w2_c.set_fc('white')
		w2_c.set_edgecolor('black')
		w2_t.set_color('black')
		m2_t.set_color('black')
		w2_t.set_text(r'$W^{(1)}_{31}$')

		w3_c.set_fc('white')
		w3_c.set_edgecolor('black')
		w3_t.set_color('black')
		m3_t.set_color('black')
		w3_t.set_text(r'$W^{(1)}_{32}$')

	elif i<anim_time[12]: # ---------------------------------------------- feed
		start = anim_time[11]

		# b1 to a22
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 7-4/float(feed_time)*(i-start)
		w1.center = (x,y)

		# x1 to a22
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 5-2/float(feed_time)*(i-start)
		w2.center = (x,y)

		# x2 to a22
		x = 1.75+(2.5/float(feed_time))*(i-start)
		y = 3
		w3.center = (x,y)

	elif i<anim_time[13]: # ---------------------------------------------- show
		z23_t.set_text(r'$\sum$');

	elif i<anim_time[14]: # ---------------------------------------------- show
		z23_t.set_text(r'$z^{(2)}_3$');

	elif i<anim_time[15]: # ---------------------------------------------- fade
		w1_c.set_alpha(0)
		w1_t.set_color('none')

		w2_c.set_alpha(0)
		w2_t.set_color('none')

		w3_c.set_alpha(0)
		w3_t.set_color('none')

		w4_c.set_alpha(0)
		w4_c.set_fc('white')
		w4_c.set_ec('black')

		m1_t.set_color('none')
		m2_t.set_color('none')
		m3_t.set_color('none')

		w1.set_color('none')
		w2.set_color('none')
		w3.set_color('none')

	elif i<anim_time[16]: # ---------------------------------------------- feed
		start = anim_time[15]

		w1.set_color('#80bfff')
		w2.set_color('#80bfff')
		w3.set_color('#80bfff')
		w4.set_color('none')

		# b1 to a22
		x = 5.75+(2.5/float(feed_time))*(i-start)
		y = 7
		w1.center = (x,y)

		# x1 to a22
		x = 5.75+(2.5/float(feed_time))*(i-start)
		y = 5
		w2.center = (x,y)

		# x2 to a22
		x = 5.75+(2.5/float(feed_time))*(i-start)
		y = 3
		w3.center = (x,y)

	elif i<anim_time[17]: # ---------------------------------------------- show
		a21_t.set_text(r'$g^{(2)}$');
		a22_t.set_text(r'$g^{(2)}$');
		a23_t.set_text(r'$g^{(2)}$');

	elif i<anim_time[18]: # ---------------------------------------------- show
		a21_t.set_text(r'$a^{(2)}_1$');
		a22_t.set_text(r'$a^{(2)}_2$');
		a23_t.set_text(r'$a^{(2)}_3$');

		w1_c.center = (7,9)
		w1_t.set_position((7,9))
		m1_t.set_position((8,9))
		w2_c.center = (7,7)
		w2_t.set_position((7,7))
		m2_t.set_position((8,7))
		w3_c.center = (7,5)
		w3_t.set_position((7,5))
		m3_t.set_position((8,5))
		w4_c.center = (7,3)
		w4_t.set_position((7,3))
		m4_t.set_position((8,3))

	elif i<anim_time[19]: # ---------------------------------------------- fade

		# hide
		w1.set_color('none')
		w2.set_color('none')
		w3.set_color('none')
		w4.set_color('none')

		w1_c.set_alpha(1)
		w1_t.set_color('black')
		m1_t.set_color('black')
		w1_t.set_text(r'$W^{(2)}_{10}$')

		w2_c.set_alpha(1)
		w2_t.set_color('black')
		m2_t.set_color('black')
		w2_t.set_text(r'$W^{(2)}_{11}$')

		w3_c.set_alpha(1)
		w3_t.set_color('black')
		m3_t.set_color('black')
		w3_t.set_text(r'$W^{(2)}_{12}$')

		w4_c.set_alpha(1)
		w4_t.set_color('black')
		m4_t.set_color('black')
		w4_t.set_text(r'$W^{(2)}_{13}$')

	elif i<anim_time[20]: # ---------------------------------------------- feed
		start = anim_time[19]

		w1.set_color('#80bfff')
		w2.set_color('#80bfff')
		w3.set_color('#80bfff')
		w4.set_color('#80bfff')

		# a20
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 9-4/float(feed_time)*(i-start)
		w1.center = (x,y)

		# a21
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 7-2/float(feed_time)*(i-start)
		w2.center = (x,y)

		# a22
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 5
		w3.center = (x,y)

		# a23
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 3+2/float(feed_time)*(i-start)
		w4.center = (x,y)

	elif i<anim_time[21]: # ---------------------------------------------- show
		z31_t.set_text(r'$\sum$');

	elif i<anim_time[22]: # ---------------------------------------------- show
		z31_t.set_text(r'$z^{(3)}_1$');

	elif i<anim_time[23]: # ---------------------------------------------- fade
		color = w1_c.get_edgecolor()
		color = list(color)
		color[3] -= 1.0/weigth_fade_time
		color[3] = np.clip(color[3], 0, 1)
		color = tuple(color)

		w1_c.set_alpha(0)
		w1_t.set_color('none')
		m1_t.set_color('none')
		w1_t.set_text(r'$W^{(2)}_{10}$')

		w2_c.set_alpha(0)
		w2_t.set_color('none')
		m2_t.set_color('none')
		w2_t.set_text(r'$W^{(2)}_{11}$')

		w3_c.set_alpha(0)
		w3_t.set_color('none')
		m3_t.set_color('none')
		w3_t.set_text(r'$W^{(2)}_{12}$')

		w4_c.set_alpha(0)
		w4_t.set_color('none')
		m4_t.set_color('none')
		w4_t.set_text(r'$W^{(2)}_{13}$')

	elif i<anim_time[24]: # ---------------------------------------------- fade
		w1_c.set_alpha(1)
		w1_t.set_color('black')
		m1_t.set_color('black')
		w1_t.set_text(r'$W^{(2)}_{20}$')

		w2_c.set_alpha(1)
		w2_t.set_color('black')
		m2_t.set_color('black')
		w2_t.set_text(r'$W^{(2)}_{21}$')

		w3_c.set_alpha(1)
		w3_t.set_color('black')
		m3_t.set_color('black')
		w3_t.set_text(r'$W^{(2)}_{22}$')

		w4_c.set_alpha(1)
		w4_t.set_color('black')
		m4_t.set_color('black')
		w4_t.set_text(r'$W^{(2)}_{23}$')

	elif i<anim_time[25]: # ---------------------------------------------- feed
		start = anim_time[24]

		w1.set_color('#80bfff')
		w2.set_color('#80bfff')
		w3.set_color('#80bfff')
		w4.set_color('#80bfff')

		# a20
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 9-6/float(feed_time)*(i-start)
		w1.center = (x,y)

		# a21
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 7-4/float(feed_time)*(i-start)
		w2.center = (x,y)

		# a22
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 5-2/float(feed_time)*(i-start)
		w3.center = (x,y)

		# a23
		x = 9.75+(2.5/float(feed_time))*(i-start)
		y = 3
		w4.center = (x,y)

	elif i<anim_time[26]: # ----------------------------------------------- show
		z32_t.set_text(r'$\sum$');

	elif i<anim_time[27]: # ----------------------------------------------- show
		z32_t.set_text(r'$z^{(3)}_2$');

	elif i<anim_time[28]: # ---------------------------------------------- fade

		# hide
		w1.set_color('none')
		w2.set_color('none')
		w3.set_color('none')
		w4.set_color('none')

		w1_c.set_alpha(0)
		w1_t.set_color('none')
		m1_t.set_color('none')
		w1_t.set_text(r'$W^{(2)}_{10}$')

		w2_c.set_alpha(0)
		w2_t.set_color('none')
		m2_t.set_color('none')
		w2_t.set_text(r'$W^{(2)}_{11}$')

		w3_c.set_alpha(0)
		w3_t.set_color('none')
		m3_t.set_color('none')
		w3_t.set_text(r'$W^{(2)}_{12}$')

		w4_c.set_alpha(0)
		w4_t.set_color('none')
		m4_t.set_color('none')
		w4_t.set_text(r'$W^{(2)}_{13}$')

	elif i<anim_time[29]: # ---------------------------------------------- feed
		start = anim_time[28]

		w1.set_color('#80bfff')
		w2.set_color('#80bfff')

		# z31
		x = 13.75+(2.5/float(feed_time))*(i-start)
		y = 5
		w1.center = (x,y)

		# z32
		x = 13.75+(2.5/float(feed_time))*(i-start)
		y = 3
		w2.center = (x,y)

	elif i<anim_time[30]: # ---------------------------------------------- show
		y1_t.set_text(r'$softmax$');
		y2_t.set_text(r'$softmax$');

	elif i<anim_time[31]: # ---------------------------------------------- show
		y1_t.set_text(r'$\widehat{y}_1$')
		y2_t.set_text(r'$\widehat{y}_2$')

	elif i<anim_time[32]: # ---------------------------------------------- show

		# hide
		w1.set_color('none')
		w2.set_color('none')
		w3.set_color('none')
		w4.set_color('none')
		
	return w1, w2, w3, w4, w1_c, w1_t, w2_c, w2_t, w3_c, w3_t, w4_c, w4_t, m1_t, m2_t, m3_t, m4_t, z21_t, z22_t, z23_t, z31_t, z32_t, a21_t, a22_t, a23_t, y1_t, y2_t



##########################
##    Create Neurons    ##
##########################

# Input layer ------------
# bias
circle(1,7,(0.,1.0,0.,0.3))
text(1,7,r'$+1$')
# x1
circle(1,5,(0.,1.0,0.,0.3))
text(1,5,r'$x_1$')
# x2
circle(1,3,(0.,1.0,0.,0.3))
text(1,3,r'$x_2$')

# z1 ------------
# z11
circle(5,7)
# z12
circle(5,5)
# z13
circle(5,3)

# Hidden layer -----------
# bias
circle(9,9,(0.,0.,1.,0.3))
text(9,9,r'$+1$');
# a21
circle(9,7,(0.,0.,1.,0.3))
# a22
circle(9,5,(0.,0.,1.,0.3))
# a23
circle(9,3,(0.,0.,1.,0.3))

# z2 ------------
# z21
circle(13,5)
# z22
circle(13,3)

# Output layer -----------
# y1
circle(17,5,(1.,0.,0.,0.3))
#text(9,5,r'$\widehat{y}_1$');
# y2
circle(17,3,(1.,0.,0.,0.3))
#text(9,3,r'$\widehat{y}_2$');




##########################
##     Create Links     ##
##########################

# Input layer to z1 layer
# bias
line([1.75,7], [4.25,7])
line([1.75,7], [4.25,5])
line([1.75,7], [4.25,3])
# x1
line([1.75,5], [4.25,7])
line([1.75,5], [4.25,5])
line([1.75,5], [4.25,3])
# x2
line([1.75,3], [4.25,7])
line([1.75,3], [4.25,5])
line([1.75,3], [4.25,3])

# z1 layer to hidden layer
# z11
line([5.75,7], [8.25,7])
# z12
line([5.75,5], [8.25,5])
# z13
line([5.75,3], [8.25,3])

# Hidden layer to z2 layer
# bias
line([9.75,9], [12.25,5])
line([9.75,9], [12.25,3])
# a21
line([9.75,7], [12.25,5])
line([9.75,7], [12.25,3])
# a22
line([9.75,5], [12.25,5])
line([9.75,5], [12.25,3])
# a23
line([9.75,3], [12.25,5])
line([9.75,3], [12.25,3])

# z2 layer to output layer
# z21
line([13.75,5], [16.25,5])
# z22
line([13.75,3], [16.25,3])



# Remove axis
plt.axis('off')

# call the animator.  blit=True means only re-draw the parts that have changed.
anim = animation.FuncAnimation(fig, animate,
							   init_func=init,
                               frames=total_time,
							   interval=20,
							   blit=True)

# Set up formatting for the movie files
Writer = animation.writers['ffmpeg']
writer = Writer(fps=15, metadata=dict(artist='Me'), bitrate=1800)

# Save the animation
anim.save('feedforward.mp4', writer=writer)

plt.show()

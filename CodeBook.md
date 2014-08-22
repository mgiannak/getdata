#melted_data R dataset
ActivityLabel
. The activity during which the measures were taken, as defined in the 'activity_labels.txt' file of the original dataset.
.. Possible Values : WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING

Subject
. The id of the subject wearing the sensors when the measures were taken.
.. A number between 1 and 30

Measure
. A string identifiying the measure with following components separated with dots.
.. 'frequency' or 'time': Fast Fourier Transform or time domain signals
.. 'body' or 'gravity' : The initial acceleration signal was separated in 2 components using a low pass Butterworth filter
.. 'acceleration' or 'gyroscope' : If the measure was about linear or angular velocity 
.. 'jerk' : If the measure was derived in time to obtain a Jerk signal
.. 'mean' or 'std' : If the measures have been averaged (mean) or if we've taken the standard deviation of them.
.. 'magnitude' : If we show the magnitude of the measure or the measure itself
.. 'xaxis', 'yaxis', 'zaxis' : the axis of the underlying measure.

Value
. A number. Original values (before averaging or other statistical computations) are normalized and bounded within [-1,1]

#tidy_data R dataset
ActivityLabel
. The activity during which the measures were taken, as defined in the 'activity_labels.txt' file of the original dataset.
.. Possible Values : WALKING,WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING

Subject
. The id of the subject wearing the sensors when the measures were taken.
.. A number between 1 and 30

Measure
. A string identifiying the measure with following components separated with dots.
.. 'frequency' or 'time': Fast Fourier Transform or time domain signals
.. 'body' or 'gravity' : The initial acceleration signal was separated in 2 components using a low pass Butterworth filter
.. 'acceleration' or 'gyroscope' : If the measure was about linear or angular velocity 
.. 'jerk' : If the measure was derived in time to obtain a Jerk signal
.. 'mean' or 'std' : If the measures have been averaged (mean) or if we've taken the standard deviation of them.
.. 'magnitude' : If we show the magnitude of the measure or the measure itself
.. 'xaxis', 'yaxis', 'zaxis' : the axis of the underlying measure.

Value
. A number which is the average of all values by ActivityLabel, Subject and Measure from the melted_data dataset. Original values (before averaging or other statistical computations) are normalized and bounded within [-1,1]

clear
connector on gandhi1408;
m = mobiledev;
m.PositionSensorEnabled = 1;
m.Logging = 1;
pause();
m.Logging = 0;
[lat, lon, t, spd] = poslog(m);

% load drivingAroundMathWorks lat lon spd;
% nBins = 10;
% binSpacing = (max(spd) - min(spd))/nBins;
% binRanges = min(spd):binSpacing:max(spd)-binSpacing;
% 
% % Add an inf to binRanges to enclose the values above the last bin.
% binRanges(end+1) = inf;
% 
% % histc determines which bin each speed value falls into.
% [~, spdBins] = histc(spd, binRanges);
% 
% lat = lat';
% lon = lon';
% spdBins = spdBins';
% 
% % Create a geographical shape vector, which stores the line segments as
% % features.
% s = geoshape();
% 
% for k = 1:nBins
% 
%     % Keep only the lat/lon values which match the current bin. Leave the
%     % rest as NaN, which are interpreted as breaks in the line segments.
%     latValid = nan(1, length(lat));
%     latValid(spdBins==k) = lat(spdBins==k);
% 
%     lonValid = nan(1, length(lon));
%     lonValid(spdBins==k) = lon(spdBins==k);
% 
%     % To make the path continuous despite being segmented into different
%     % colors, the lat/lon values that occur after transitioning from the
%     % current speed bin to another speed bin will need to be kept.
%     transitions = [diff(spdBins) 0];
%     insertionInd = find(spdBins==k & transitions~=0) + 1;
% 
%     % Preallocate space for and insert the extra lat/lon values.
%     latSeg = zeros(1, length(latValid) + length(insertionInd));
%     latSeg(insertionInd + (0:length(insertionInd)-1)) = lat(insertionInd);
%     latSeg(~latSeg) = latValid;
% 
%     lonSeg = zeros(1, length(lonValid) + length(insertionInd));
%     lonSeg(insertionInd + (0:length(insertionInd)-1)) = lon(insertionInd);
%     lonSeg(~lonSeg) = lonValid;
% 
%     % Remove the excess NaN values between segment values.
%     nans = isnan(latSeg);
%     leadingNans = [0 diff(nans)]; % Look for first instances of NaN groups
%     latSegTrimmedNans = latSeg(~isnan(latSeg) | leadingNans == 1);
%     lonSegTrimmedNans = lonSeg(~isnan(lonSeg) | leadingNans == 1);
% 
%     % Add the lat/lon segments to the geographic shape vector.
%     s(k) = geoshape(latSegTrimmedNans, lonSegTrimmedNans);
% 
% end

wm = webmap('MapQuest Open Street Map');

mwLat = lat;
mwLon = lon;
name = 'MathWorks';
iconDir = fullfile(matlabroot,'toolbox','matlab','icons');
iconFilename = fullfile(iconDir, 'matlabicon.gif');
wmmarker(mwLat, mwLon, 'FeatureName', name, 'Icon', iconFilename);

colors = autumn(nBins);

wmline(s, 'Color', colors, 'Width', 5);

wmzoom(160);

m.PositionSensorEnabled = 0;

clear m;

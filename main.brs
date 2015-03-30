'Library "v30/bslDefender.brs"
Function Main() as void
	di = CreateObject("roDeviceInfo")
	print di.GetModel()
	print di.GetVersion() 
	print di.GetDeviceUniqueId()

    screen = CreateObject("roListScreen")
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)
    InitTheme()
    screen.SetHeader("Welcome to The Channel BD")
    screen.SetBreadcrumbText("Menu", "Breakfast")
    
    contentList = InitContentList()
    screen.SetContent(contentList)
    screen.show()
    
    while (true)
        msg = wait(0, port)
        if (type(msg) = "roListScreenEvent")
            if (msg.isListItemFocused())
                screen.SetBreadcrumbText("Menu", contentList[msg.GetIndex()].Title)
            endif            
            if (msg.isListItemSelected())
                'screen.SetBreadcrumbText("Menu", contentList[msg.GetIndex()].Title)
				'if (msg.GetIndex() = 0)
				displayVideo("", msg.GetIndex())
					'print "Selected Index: " + msg.GetIndex() 
					'title = "Selected:" '+ msg.GetIndex()
					'dialog = CreateObject( "roOneLineDialog" )
					'dialog.SetTitle( "Selected" )
					'dialog.SetTitle(msg.GetIndex())
					'dialog.ShowBusyAnimation()
					'dialog.show()
					'm = wait(500, dialog)
					'Sleep(4000)
				'endif
            endif            
        endif
    end while
End Function

Function InitTheme() as void
    app = CreateObject("roAppManager")

    primaryText                 = "#FFFFFF"
    secondaryText               = "#707070"
    'buttonText                  = "#C0C0C0"
    'buttonHighlight             = "#ffffff"
    backgroundColor             = "#e0e0e0"
    
    theme = {
        BackgroundColor: backgroundColor
        OverhangSliceHD: "pkg:/images/Overhang_Slice_HD.png"
        OverhangSliceSD: "pkg:/images/Overhang_Slice_HD.png"
        OverhangLogoHD: "pkg:/images/channel_BD_logo.png"
        OverhangLogoSD: "pkg:/images/channel_BD_logo.png"
        OverhangOffsetSD_X: "25"
        OverhangOffsetSD_Y: "15"
        OverhangOffsetHD_X: "25"
        OverhangOffsetHD_Y: "15"
        BreadcrumbTextLeft: "#37491D"
        BreadcrumbTextRight: "#E1DFE0"
        BreadcrumbDelimiter: "#37491D"
        'ThemeType: "generic-dark"
        ListItemText: secondaryText
        ListItemHighlightText: primaryText
        ListScreenDescriptionText: secondaryText
        ListItemHighlightHD: "pkg:/images/select_bkgnd.png"
        ListItemHighlightSD: "pkg:/images/select_bkgnd.png"        
    }
    app.SetTheme( theme )
End Function

Function InitContentList() as object
    contentList = [
        {
            Title: "Ekushey TV",
            ID: "1",
            SDSmallIconUrl: "pkg:/images/etv-small.jpg",
            HDSmallIconUrl: "pkg:/images/etv-small.jpg",
            HDBackgroundImageUrl: "pkg:/images/ekushey-tv.jpg",
            SDBackgroundImageUrl: "pkg:/images/ekushey-tv.jpg",            
            ShortDescriptionLine1: "Ekushey TV",
            ShortDescriptionLine2: "Ekushey Television (ETV) is a private terrestrial channel in Bangladesh, Official transmission began on April 14, 2000"
        },
        {
            Title: "Gaan Bangla TV",
            ID: "2",
            SDSmallIconUrl: "pkg:/images/gb_small.jpg",
            HDSmallIconUrl: "pkg:/images/gb_small.jpg",
            HDBackgroundImageUrl: "pkg:/images/gb1.jpg",
            SDBackgroundImageUrl: "pkg:/images/gb1.jpg",
            ShortDescriptionLine1: "Gaan Bangla",
            ShortDescriptionLine2: "Gaan Bangla Television , the new HD music channel in Bangladesh, The Channel official test transmission began on 14th October, 2013 from apstar7 satellite. GaanBangla TV features"
        },
        {
            Title: "SA TV",
            ID: "3",
            SDSmallIconUrl: "pkg:/images/SATV_small.jpg",
            HDSmallIconUrl: "pkg:/images/SATV_small.jpg",
            HDBackgroundImageUrl: "pkg:/images/SATV.jpg",
            SDBackgroundImageUrl: "pkg:/images/SATV.jpg",            
            ShortDescriptionLine1: "SA TV",
            ShortDescriptionLine2: "SA Television is a new private satellite TV Channel which officially began broadcasting from January, 2013"
        },
        {
            Title: "Jamuna TV",
            ID: "4",
            SDSmallIconUrl: "pkg:/images/jamuna_small.jpg",
            HDSmallIconUrl: "pkg:/images/jamuna_small.jpg",
            HDBackgroundImageUrl: "pkg:/images/jamuna4.jpg",
            SDBackgroundImageUrl: "pkg:/images/jamuna4.jpg",            
            ShortDescriptionLine1: "Jamuna TV",
            ShortDescriptionLine2: "Jamuna TV is a private channel in Bangladesh, Official transmission began on September, 2012"
        }
        {
            Title: "Independent TV",
            ID: "5",
            SDSmallIconUrl: "pkg:/images/ind_small.jpg",
            HDSmallIconUrl: "pkg:/images/ind_small.jpg",
            HDBackgroundImageUrl: "pkg:/images/inde.jpg",
            SDBackgroundImageUrl: "pkg:/images/inde.jpg",            
            ShortDescriptionLine1: "Independent TV",
            ShortDescriptionLine2: "Independent TV is a private channel in Bangladesh, Official transmission began on March 2010"
        }
        {
            Title: "Channel i",
            ID: "6",
            SDSmallIconUrl: "pkg:/images/channel_ise.jpg",
            HDSmallIconUrl: "pkg:/images/channel_ise.jpg",
            HDBackgroundImageUrl: "pkg:/images/channeli.jpg",
            SDBackgroundImageUrl: "pkg:/images/channeli.jpg",            
            ShortDescriptionLine1: "Channel i TV",
            ShortDescriptionLine2: "Channel i TV is a private channel in Bangladesh, Official transmission began on October 1, 1999"
        }
    ]
    return contentList
End Function

Function displayVideo(args As Dynamic, tv As integer)
    print "Displaying video: "
    p = CreateObject("roMessagePort")
    video = CreateObject("roVideoScreen")
    video.setMessagePort(p)

    'bitrates  = [0]          ' 0 = no dots, adaptive bitrate
    'bitrates  = [348]    ' <500 Kbps = 1 dot
    'bitrates  = [664]    ' <800 Kbps = 2 dots
    'bitrates  = [996]    ' <1.1Mbps  = 3 dots
    'bitrates  = [2048]    ' >=1.1Mbps = 4 dots
    bitrates  = [0]

    'Swap the commented values below to play different video clips...
    urls = ["http://video.ted.com/talks/podcast/CraigVenter_2008_480.mp4"]
    qualities = ["HD"]
    StreamFormat = "mp4"
    title = "Craig Venter Synthetic Life"
    srt = "file://pkg:/source/craigventer.srt"

    'urls = ["http://video.ted.com/talks/podcast/DanGilbert_2004_480.mp4"]
    'qualities = ["HD"]
    'StreamFormat = "mp4"
    'title = "Dan Gilbert asks, Why are we happy?"

    ' Apple's HLS test stream
    'urls = ["http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"]
    'urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/en1-sat.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yNi8yMDE1IDM6Mjg6MTggQU0maGFzaF92YWx1ZT1aaGtzVDhsMld0a0Ria2liYWNURUtnPT0mdmFsaWRtaW51dGVzPTIwMA=="]
    
	If tv = 0
		urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/ekushey0000011223234455668795666784-25.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yNi8yMDE1IDg6NTg6MzUgQU0maGFzaF92YWx1ZT1IUmhIUFZBMGVhcDBvcEtLNUNvSXdRPT0mdmFsaWRtaW51dGVzPTIwMA=="]
		'urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/mob0000ntv0000.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yOC8yMDE1IDY6NDY6MzAgQU0maGFzaF92YWx1ZT1wMmNTSGJMaHVBUmJ5UWI3cWp5L0lnPT0mdmFsaWRtaW51dGVzPTIwMA=="]
    Else If tv = 1
		urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/gaanbd00543543642-sg.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yOC8yMDE1IDQ6MTE6NTcgQU0maGFzaF92YWx1ZT1ITFFRU2s5WWRYVFVDRjM5TFBZS3pRPT0mdmFsaWRtaW51dGVzPTIwMA=="]
    Else If tv = 2
		urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/mob0000satvoff0000.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yOC8yMDE1IDY6NDk6NDcgQU0maGFzaF92YWx1ZT1yZjJrUi9lbHBURXprK3dHYzF3Q2tnPT0mdmFsaWRtaW51dGVzPTIwMA=="]
    Else If tv = 3
		'urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/ekattor001122332445574455666-25.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yOC8yMDE1IDc6NDk6NDIgQU0maGFzaF92YWx1ZT1vVDhPakFNTXVHQXZNZHpHYkZ1bzRnPT0mdmFsaWRtaW51dGVzPTIwMA=="]
		urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/mob0000jamuna-ffm0000.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yOC8yMDE1IDk6MDA6MTEgQU0maGFzaF92YWx1ZT10MitCS3lyMjVXekhVMC9pN3ZOV0JRPT0mdmFsaWRtaW51dGVzPTIwMA=="]
    Else If tv = 4
		urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/en1-sat.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yOC8yMDE1IDY6MzY6MjcgQU0maGFzaF92YWx1ZT12Tnd4MjZiMzJ0SEdnUkpZRmlvellBPT0mdmFsaWRtaW51dGVzPTIwMA=="]
    Else If tv = 5
		urls = ["http://mobs.jagobd.com:1935/c2VydmVyX3RpbWU9My8xLzIwMTQgMjo1MTo1NCBBTSZoYXNoX3ZhbHVlPXFmcG5iZ1g4S1VMeEFBMGNUMTV5VlE9PSZ2YWxpZG1pbnV0ZXVzPTI/channeli0000ll88O22l4l445888696.stream/playlist.m3u8?key=c2VydmVyX3RpbWU9My8yOC8yMDE1IDY6NDI6MzggQU0maGFzaF92YWx1ZT1jbFdqUk1RaXVkQkVDakNwamdwRmdnPT0mdmFsaWRtaW51dGVzPTIwMA=="]
	EndIf
	
    qualities = ["SD"]
    streamformat = "hls"
    title = "Streaming Live Channel"

    ' Big Buck Bunny test stream from Wowza
    'urls = ["http://ec2-174-129-153-104.compute-1.amazonaws.com:1935/vod/smil:BigBuckBunny.smil/playlist.m3u8"]
    'qualities = ["SD"]
    'streamformat = "hls"
    'title = "Big Buck Bunny"

    if type(args) = "roAssociativeArray"
        if type(args.url) = "roString" and args.url <> "" then
            urls[0] = args.url
        end if
        if type(args.StreamFormat) = "roString" and args.StreamFormat <> "" then
            StreamFormat = args.StreamFormat
        end if
        if type(args.title) = "roString" and args.title <> "" then
            title = args.title
        else 
            title = ""
        end if
        if type(args.srt) = "roString" and args.srt <> "" then
            srt = args.StreamFormat
        else 
            srt = ""
        end if
    end if
    
    videoclip = CreateObject("roAssociativeArray")
    videoclip.StreamBitrates = bitrates
    videoclip.StreamUrls = urls
    videoclip.StreamQualities = qualities
    videoclip.StreamFormat = StreamFormat
    videoclip.Title = title
    videoclip.Live = True
    'print "srt = ";srt
    'if srt <> invalid and srt <> "" then
    '    videoclip.SubtitleUrl = srt
    'end if
    
    video.SetContent(videoclip)
    video.show()

    lastSavedPos   = 0
    statusInterval = 10 'position must change by more than this number of seconds before saving

    while true
        msg = wait(0, video.GetMessagePort())
        if type(msg) = "roVideoScreenEvent"
            if msg.isScreenClosed() then 'ScreenClosed event
                print "Closing video screen"
                exit while
            else if msg.isPlaybackPosition() then
                nowpos = msg.GetIndex()
                if nowpos > 10000
                    
                end if
                if nowpos > 0
                    if abs(nowpos - lastSavedPos) > statusInterval
                        lastSavedPos = nowpos
                    end if
                end if
            else if msg.isRequestFailed()
                print "Index: "; msg.GetIndex(); " play failed: "; msg.GetMessage()
				obj = msg.GetInfo()
				for each key in obj
					print "  " key "=" obj[key]
				end for				
            else if msg.isStreamSegmentInfo()
                print "Stream Segment Info"
				print "Index: "; msg.GetIndex(); " Message: "; msg.GetMessage()	'"BW: "; obj.StreamBandwidth; 
				obj = msg.GetInfo()
				for each key in obj
					print "  " key "=" obj[key]
				end for				
            else if msg.isStreamStarted()
				print "Stream Started"
				print "Index: "; msg.GetIndex()'; "Message: "; msg.GetMessage(); "BW: "; obj.StreamBitrate; 
				obj = msg.GetInfo()
				for each key in obj
					print "  " key "=" obj[key]
				end for				
            else if msg.isStatusMessage()
				print "Status Message"
				print " msg: "; msg.GetMessage()
            else if msg.isTimedMetaData()
				print "TimedMeta Data"
				print " msg: "; msg.GetMessage()
				obj = msg.GetInfo()
				for each key in obj
					print "  " key "=" obj[key]
				end for				
            else
                print "Unknown event: "; msg.GetType(); " msg: "; msg.GetMessage()
            endif
        end if
    end while
End Function

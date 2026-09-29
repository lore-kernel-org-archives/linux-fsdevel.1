Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8620F516156
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682920; cv=none; b=Xh80NeLYEpmaHHjNEuch27aQ5gWVysanTvZTfdID7LyDSjOkDVCacf69aPu+OWft8cK283L6MSKz5LWO6yT4dIhP2TtjaHNkb8RhM1CX8RzIW+7i+UegZl1dtm3QGzTecndvSHhttyCTROFRNG2ZmnC4QaNN/G5hEoKMP2EMHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682920; c=relaxed/simple;
	bh=+D1EpXOsao70oTHN1ZB/SJuPMfP4iFavKifX1vQAiZc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WCk195sgrTTDmWzIW8UX10wlAeYz3LRKPhe5uM31kgn+siS3SO/4R9BLsRiEe2j0sD/Rmk1ifcNAfTwQB0tdjyDrAdZU6BC1MWaKAeKgWlLNAQQZc2zJ2aP7f+XveKZizq1kVbDbEFq//Ikac7S0qLlMKXN8UDCHo+wehXMWur8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=TtASs+EW; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="TtASs+EW"
X-KPN-MessageId: 78d39de7-bbfc-11f1-8f57-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 78d39de7-bbfc-11f1-8f57-005056992ed3;
	Tue, 29 Sep 2026 13:54:05 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 78d212ec-bbfc-11f1-b3e3-0050569977a2;
	Tue, 29 Sep 2026 13:54:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=OyhKnhJnfh2BfCSlCihElmUmqjeW6EvlAyoMD8gCw24=;
	b=TtASs+EWgMOqFN90qK7IplYbkh0d+RZ6VM2eYiEA3yxgZGrdTi7dAzX5wfd/GNT8ftitw8qucklcM
	 +JcgUfiFiUue8d24hReOoAfwiA/ktKA5ReoXqgh7dbIvHWK9T50yw5t1fTwfOLZmjN1VCATryZ418h
	 pk1OY+suZWlxP145u9oMklLcPf4WEWvzGRCuAKJF67itDuNJ0/Ktgb+QDx6q7rqTDrw1X8rngJP4ca
	 WZQvo/lqcf5cUPhXQvctBCYbjRlAiGqbOGIyfZOb6fkf84OAjsDecaY5TgEUSVPt6ox/8RuRtciIwQ
	 zw2lN9SiYmQlAiXnvWFKkmzNKvUmj7g==
X-KPN-MID: 33|zaxh6UFxVctBfRcuwMrql1Yc+Wj9ISaWRbUJpDejJxGUQ8hNlQtKeTpTEiVyM8f
 L7hOXwbSvGZ7toORSC1ZdPMSB9/YWp8x+y4prbEpQfCk=
X-CMASSUN: 33|zf9aU6r3/aPS4YYE1OBJyI8QJyt3MMKnV0is/H3I2zHKi4v4wZV8NHHJrY+IutV
 pNG4XaL/pNFYTJf1dASNjnA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 78c57858-bbfc-11f1-8edd-00505699eff2;
	Tue, 29 Sep 2026 13:54:05 +0200 (CEST)
Date: Tue, 29 Sep 2026 13:54:05 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1010887891.582666.1790682845752@kpc.webmail.kpnmail.nl>
In-Reply-To: <178977609418.207413.15011378414000392029@noble.neil.brown.name>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 19-09-2026 02:01 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
> > 
> > nfsd_create_locked() used to do that before vfs_mkdir() could return a
> > dentry, but it doesn't any more.  The reason was because
> > d_splice_alias() on might return a different dentry. 
> > In this case we want the same dentry, but we need to do a lookup on it.
> > 
> > I'd rather fix this in kernfs, but maybe that is a longer-term goal.
> > 
> > The comment in kernfs_dop_revalidate() suggests the we should d_drop()
> > the negative dentry and d_alloc_parallel() a new one and ->lookup that.
> > I'm not certain that is needed if we keep the parent locked, but we
> > would need to be certain.
> > We at least need to d_drop() the dentry before ->lookup as ->lookup
> > cannot handle hashed dentries and a hashed-negative dentry is passed
> > to ->mkdir.
> > 
> > I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ....
> > probably not.
> > 
> > Summary: I think that if vfs_mkdir() returns NULL (success) but the
> > dentry is negative, we need to d_drop() and call ->lookup with a big
> > comment about kernfs.  But we need to double-check that this will do the
> > right thing with ->d_time (I think it will).
> > We also need to think carefully about races with
> > kernfs_dop_revalidate(), which could happen concurrently with the
> > ->lookup.
> 
> I've thought a bit more about this ...  I think that doing a lookup after
> the vfs_mkdir() results in a negative is a bit ugly.  It assumes things
> about the fs that I would rather not assume.
> 
> I would rather have the current proposed code check for a negative
> dentry, and fail with -EIO or similar.
> 

I just noticed that there's precedent for this in overlayfs in super.c:

		/* Weird filesystem returning with hashed negative (kernfs)? */
		err = -EINVAL;
		if (d_really_is_negative(work))
			goto out_dput;

Shall we just do this for current kernel release, then we can add support
later if wanted.

(But let's do EOPNOTSUPP instead of EINVAL)

What do you think?

Thanks,
Jori.

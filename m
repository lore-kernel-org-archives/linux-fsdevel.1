Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586064CC61A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065955; cv=none; b=uZMxZIkeSdvclq2V7KEfRI8q5yFzcVOWWjqT3Qj5MhGDvsfTdWvFYqCLdn8r3iw5Zwelg19o9RbemN/G2XVa5k9BJRRAzZFo98/U4AmrFjuhBplme2R15/4B9lu7aoyr8FjUHnWnUGSdSuXolUC8VytLAnG1LOlEeC1G8bSKAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065955; c=relaxed/simple;
	bh=bxOLRyx+TtzIaCObuWShkyjhDbes/LDLjKEl4CexuEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmmObk8HDAksvwz8u8/2mSPb8yTNpaL/zKkI8qv6527wdQ7+8SX8XJIkt5vSPfXrhEoQLXHuR/Ry5TfgA8L4ZC6D/lqgofrw50kzCmKd17i3730GsrlibR4iJ/F6AlMXpTK0l9TTS4IckDT6MfggIK9G86Or7txI2nlm7haikqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaX3zQe1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qz4gOev9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaX3zQe1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qz4gOev9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790065951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6HyFSOK4HYSfvcwVKnaiUCa+pWXMNUUzDe6nYFstxk=;
	b=OaX3zQe1A/i6f2euJs4tg+AxapSpwR/3HNRrlUjSYIpC9Mpdqm+Kj2SRngRipSkoiPwBFa
	zKsoxQVrgM/M7HDYboV9viAOVrd+eXclj+dPXexYRpPt2rIFqfz5jy2ytcX+46/V8uP7+C
	M88uKc11snPa14dasNqQJu3m5Pg4bAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-mf6IfXk6NSe_Ff_bILl41w-1; Tue, 22 Sep 2026 04:32:29 -0400
X-MC-Unique: mf6IfXk6NSe_Ff_bILl41w-1
X-Mimecast-MFC-AGG-ID: mf6IfXk6NSe_Ff_bILl41w_1790065949
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so25073975e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790065948; x=1790670748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v6HyFSOK4HYSfvcwVKnaiUCa+pWXMNUUzDe6nYFstxk=;
        b=Qz4gOev9TgVra5iOJWfTnbYEokCVKsZZUgM98FD6WKxETb+2CICQBG8jcqxWFdPrbv
         cf6wdt+ujB5YeEcHJYuRkn8CK4IsSIsaeQgLb1AOid1GU2VkOBDgM6zaLxKBN4kVfebZ
         amF/j7UhBtdBBIGHGO2yMskam0cpjPpF4kbhtgkJXJ5mXjX44+faUpCgF3EYfu/VgdIH
         7WG8dtTdaLbsPxPTWd5NZW52Xep/pfo/msijT/oEnpLZZZ6uLBvrDMpJ+X/+BYLPMFb7
         CjYY2bCexHm1KLIM93NpZ9JciGGb0Ay6sFee16y+WNwGJLKVcjV63Q1i25pBPCXdMsLf
         L68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790065948; x=1790670748;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6HyFSOK4HYSfvcwVKnaiUCa+pWXMNUUzDe6nYFstxk=;
        b=sqgp60Yb12lrsV4Xp5vnr4WXMkYfYxAWPOD5LEaGZrGZZNO25EXds0CWSa+hv/UAaS
         qdB1h0ZU/i8e0Rd52Z56Oqg8xb/yxjIWW3BHgBlQ6SGMcGFhFHSWFVPHVyIxjxkU9oGM
         qwUiU+zv8u/45m+LsW65QfMF3B1l7/O9aqNrSwwrY3h6mjXeK4D+q8ybr6J4ANyA3YBl
         F6PMsaY2js+uPa1npsWrjELILFYZ6DPxPHmsP0rZ5uc+vmFKuXi5LO941yGNuMUzh1ER
         NJfX7gyDcSXq3LAQYhgLXe1cIQ0OzJzJEw5Jc05X/yfHVywY5r6cXI5mU8OVmP4lIFLr
         WCNw==
X-Forwarded-Encrypted: i=1; AKwUvBz1oLyEe9nDWofb1XI7t/Dx8KF8+oP2Gsq3wyZrNEDmJ6q2v8vs9otovbJr8zLsTs1qHHw0M9R9m8+tzV8a@vger.kernel.org
X-Gm-Message-State: AFuF++kwXFOsL6TGxbeZyXloWnG5Z02hFG1ASue27oPK3Jw95EkscSQ9
	Qd88kycyeSTqN2vQ08m4bC22zNY874vB8tXEpmEdAojk61EnY6SGB+PrFybdxmIxCn4uzNPljU0
	4FXrClqTDj16fd2KCCII3lzRWv7/zXXxuJasNcFrqBucXTKCUWdaRe2/Scj22X7IB8w==
X-Gm-Gg: AYBFou0Pn7cxGmD54pqbe4Fg9j6z/k0306hE+O1Aid6GmRtClGjeZtqVdtwJFSaMMSE
	/ezE8VxRAqG/ZhZgrS+iKmLKIAvbRGqqi9JhFLcqcH7eCuUky//bmb4RJKEW8tdET11auQQP3DC
	RRHI79FPTUgVd+6F+zOPkLVxqHlIv5EnpKVoh4gZHhv0jo0KHedTHwIsVDEpBL7NyprCmrkNJMy
	kHBNo03U5v2KnJ6nQgicsneh1mLOIvSwsleXEOYVyvvHboykaSdB2Er/JFiw8osrJSYRtAJmK7I
	kxu1+U7f9r+9mYqFxiTk14oDsHq5cjqm8E0wd79krG48cudgQh2FOSdz/79+RYAACBYd8pthKFh
	uAoq6Pf24QlPEu23ShnDjFdBMwiplvfF8+Q==
X-Received: by 2002:a05:600c:3f0b:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49fc5750c61mr161766895e9.21.1790065948499;
        Tue, 22 Sep 2026 01:32:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3f0b:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49fc5750c61mr161766615e9.21.1790065948022;
        Tue, 22 Sep 2026 01:32:28 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdabe8a2asm32746655e9.4.2026.09.22.01.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:32:27 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:32:24 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Andrey Albershteyn <aalbersh@kernel.org>, ebiggers@kernel.org, hch@lst.de, 
	Carlos Maiolino <cem@kernel.org>, fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH v16 13/21] xfs: add XFS_BMAPI_UNWRITTEN to unmap
 unwritten extents in __xfs_bunmapi()
Message-ID: <arI8cvh8rgIwmv9V@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-14-aalbersh@kernel.org>
 <20260922043402.GM2705364@frogsfrogsfrogs>
 <arIsIhrWltHi9Aej@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arIsIhrWltHi9Aej@infradead.org>

On 2026-09-22 00:20:02, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 09:34:02PM -0700, Darrick J. Wong wrote:
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index cc48f6e20e80..7ba76017ae56 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -5280,6 +5280,10 @@ __xfs_bunmapi(
> > >  		if (del.br_startoff + del.br_blockcount > end + 1)
> > >  			del.br_blockcount = end + 1 - del.br_startoff;
> > >  
> > > +		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> > > +				del.br_state != XFS_EXT_UNWRITTEN)
> > 
> > Odd indentation?
> > 
> > 		if ((flags & XFS_BMAPI_UNWRITTEN) &&
> > 		    del.br_state != XFS_EXT_UNWRITTEN)
> 
> Yeah.
> 
> > /me again wonders if bunmapi ought to have its own flags instaed of
> > reusing *some* of bmapi.  But I concede that ought to be a different
> > cleanup, because figuring out which flags are for bunmapi.  I think it's
> > REMAP, ATTR_FORK, NODISCARD, and UNWRITTEN?
> 
> I think that would create more confusion than it helps.  OTOH asserting
> the valid flag would be helful.
> 
> Sashiko complains about interactions with the weird rtextent bunmap
> behavior.  Should we disallow fsverity with a larger than fsb
> rtextensive to not bother with this?  Btw, did you test this series
> with RT classic and or zoned?

yeah, I will disallow it

I did many revisions back, but haven't tested recent versions, I
will test with rt for the next version

-- 
- Andrey


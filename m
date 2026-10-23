Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790962;
	b=OzT7E2kL8hL87jCb4WCeGAt9m3H5nhbt+EeP2wKKXzFs7x5GFoJkyrooprqzE+DnU3LZ
	 rRdRmO/xDlzDdKHnlC+3vlJcK9QHSzC+DmDHnPt4vsurnVeXFWXDTk0SFASWGXGWmyiad
	 iEp4cmOXjMYpqvT+ITd+aCMtKI1i2u0NRgjTnUiOHPsQGacavgUo/tB4y1Zd3nUMoPVUG
	 UPf3NaToJViFrTk/hHyPD0JtIsD09Mkl6DwHzWF7cX9lQZcCGo9zwTStWk/kwQ5c8yd4O
	 K4OhxDt9nNllO4UEGRfo2h7/UQ7jgwTyKE/R+eYwquNxjh+dciqWYInc5LWt0EjXQSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790962;
	h=DMARC-Filter:X-KPN-MessageId:Received:Received:DKIM-Signature:
	 X-KPN-MID:X-CMASSUN:X-KPN-VerifiedSender:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Priority:Importance:X-Originating-IP;
	bh=P8r/Csn/92j4h8MtHtX1sZoBvM1beEuyAAhxjMFapGU=;
	b=VLaNcjEzbqbaHk65qa6bosbS2Kj2ngC5QqIQlHBH8HfeeJA1J0rLehOsGP2yVSeqbdb5
	 SQ3W/maXpnKvleXQ/LanVegkOCVZ0dXSVfppb5j9JYZ9fnFCNNZ1AOFk/ZsWY8zkwsQvQ
	 /iFQG4sYaWsOSuD2R+1VTTVwBDQGet44Kw/eJkGc1PUL6519GV+w/MuBEbGq6M1npjex/
	 Uy34DXBtZ2pS+mdmNnLYhtG0Wbyqp/Rb/g6mpIkU6pVGuSHOPRZioIAV7HIF8KwQxqdeL
	 FfJshQTdy5krFTcg9KGkaxf5btN7AmKXWhYbRvHpHyS6LcQQIglHgl0CHV0B3zjMPAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=Cv9qmTOd;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3AE606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 21:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF3AE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=Cv9qmTOd
X-KPN-MessageId: c83ea5f0-cf28-11f1-87e5-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c83ea5f0-cf28-11f1-87e5-00505699b430;
	Fri, 23 Oct 2026 23:29:09 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id c83dac1e-cf28-11f1-a8ab-0050569977a2;
	Fri, 23 Oct 2026 23:29:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=P8r/Csn/92j4h8MtHtX1sZoBvM1beEuyAAhxjMFapGU=;
	b=Cv9qmTOdqfL9hpKDjDDeRhSW+jMdxGpjw5yoMBp7Dw3ot7ZsadfOJ+/LgbxsYYNGHgSSi4rW0kZEb
	 STgzOljDaEM+voHExGKw618OMl7IigX1EiUt9I+SNRTOZ+yKxgZHzua+0LcLmqyS13vmv1f8IGur80
	 hFmxkhCo9kvU2QfHuCFIePvidKEYaGXrKuEfv2eMKfSY/rRkrEvTJ1dS3H43rUGA9SgHZF5fe/jB8i
	 BKTrVyiifXfyIxwh6UTP0Ah82TbeROVKwf+GOj955nUYJjOzeCCI9Ce3atB+Xf4mWlZc/zA0X/cqG9
	 FPuNPa3YBzkq8o3mYLgFVtMZEyfci8g==
X-KPN-MID: 33|1IzAEM6rixJ+Yc595J1FUe0NB+J4eIXJuyF9t9cRGlboL+T2pvIhzimUEjN7av8
 Oy6sJHeKyAQQdxtPBm/jEb/e68SHFGrtc2DtrCD9vBa0=
X-CMASSUN: 33|hsnx0XdPDNSjIeH+evRzrTLkxbIwPEYQkvUHp9XVoxbyrzMy6+d7WmjjUDON01c
 uxoxT+DnmkYxVF4FyEYbObg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id c8381e70-cf28-11f1-a030-005056995d6c;
	Fri, 23 Oct 2026 23:29:09 +0200 (CEST)
Date: Fri, 23 Oct 2026 23:29:08 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, Christian Brauner <christian@brauner.io>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Message-ID: <1780856356.2118300.1792790948991@kpc.webmail.kpnmail.nl>
In-Reply-To: <ataWrUkD-rqeoFcV@linux.dev>
References: <20261016220029.3276154-1-shakeel.butt@linux.dev>
 <atUkrrdfu_ihfmZ8@daedalus> <ataWrUkD-rqeoFcV@linux.dev>
Subject: Re: [PATCH v3] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Hi Shakeel,

> Op 19-10-2026 19:34 EDT schreef Shakeel Butt <shakeel.butt@linux.dev>:
> 
>  
> Hi Jori and thanks a lot for taking a look.
> 

You're welcome! Thanks for looking into this.

> > 
> > I understand this is intended to have some kind of ownership semantics,
> > but I must say for such a simple function, I find the contract quite
> > complex to check. Do we really need an out parameter here?
> 
> Not really. I just used it simply call iput(new) without a check. I can change
> it and make it more like inode_insert5() and let caller do check before calling
> iput().
> 

I'd prefer no out parameter then. I actually need the same function, more or less.
My problem is that I want inode allocation before calling scops->mkdir, so that
if that goes -ENOMEM, then we don't create the directory. However, since I can
expect that there's not going to be an inode present, the ilookup is not needed.
So I guess I need a kernfs_get_inode_locked_fast() or something.

But also, shouldn't we just replicate the structure of iget5_locked() here? Except
that we pass in an allocated inode. We invoke a lot more code if we rely on iput()
instead of destroy_inode(). Then maybe we need to use alloc_inode() instead of
new_inode() as well.

> > 
> [...]
> > > @@ -294,7 +298,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
> > >  {
> > >  	struct kernfs_super_info *info = kernfs_info(sb);
> > >  	struct kernfs_root *kf_root = kfc->root;
> > > -	struct inode *inode;
> > > +	struct inode *inode, *new;
> > >  	struct dentry *root;
> > >  
> > >  	info->sb = sb;
> > > @@ -314,10 +318,12 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
> > >  	sb->s_shrink->seeks = 0;
> > >  
> > >  	/* get root inode, initialize and unlock it */
> > > +	new = new_inode(sb);
> > >  	down_read(&kf_root->kernfs_rwsem);
> > > -	inode = kernfs_get_inode(sb, info->root->kn);
> > > +	inode = kernfs_get_inode_locked(sb, info->root->kn, &new);
> > 
> > What are you serializing against here? I've been looking at this as well
> > recently, and I thought we could just get rid of the locking here. But
> > on second look, I am not so sure what is correct.
> > 
> > Is there anything that serializes kernfs_get_tree() with root node
> > removal?
> 
> That is a good question and honestly I didn't know the answer. After digging a
> bit, I think 07/12 patch [1] of your series is right.
> 
> Superblock is still private here and it is added to the supers list after
> kernfs_fill_super. Root removal is not serialized by kernfs and kernfs users
> keep the root alive across the mount.
> 

I am not sure that last statement is true for all kernfs users. I will have to
verify.

> I can drop the kernfs_fill_super change from my patch and I think your patch
> will cover it better.
> 

OK.

> [1] https://lore.kernel.org/20261016143806.2946578-8-jkoolstra@xs4all.nl

Best,
Jori.

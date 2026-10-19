Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792452864;
	b=GcnR5mjEy9Sxpu+Q7jRICFODyqzq9q4bCB0jUo5FYOvS/YUmJ1azVydjbQ5WCp4WJgiy
	 rGehDla27TuW/nnF4gAdYkNyuztLcjBt7ygCWWfu5ekTLaCv3vjJcp4/WEGLbidN5bK45
	 3OCLGMQHO4kCef6Z/8oJc73recyPzFd7kmQT13pr41HEgsJQPbl+w51/aNMJFekcZjQq4
	 jlqgVBrB66Q1PhA2J6ybty9Swdi3krJV1mFF+LOiHasF20yUdW+n+e4Gd8jOg/ULggGD1
	 9w/1KZL2yBkiTkLYIKOPcsFq3hvAWUDSZF9MaW2jMDPK74Xeo8y5b4ck+fQm0SMgIMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792452864;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YLCzEt34deTzd8GzZtmkJa4LKNaOg+tNl9krAgeHoCg=;
	b=G+9nplMDyUO6OqdV+8DVkxx/XaoaLjvhfLIS1TPkaGhidmwSIzoi/LDENRtH+yXlSVef
	 hG8vM375+Fm5edEB2AnwDLduxZm7WP5fYY4Z+BYoRbb3e249vkHCUCFSQ6zIaAaBzJRy8
	 AbC+EdteTLaKyRw6HKAp+5OMuL0Q3yZonzRVEzzhRCMz1kaR7JiLOLEI6peoi6fsmmv9W
	 wgzmtliuZ9wtO1q2BRsIPvrmyloA6XUO50uzOxr7cJZVErbtRWFgpJhK0Zu4dXm+/Zv2W
	 soZgK5rHcO5lEtGxU0d8hIHD5/7a9cp83mUss1iex+cF9QKFsFUPFPzmKffRE7gDAHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a6lMNBWx;
	arc=none smtp.remote-ip=91.218.175.239
Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1614606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 23:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1614606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=a6lMNBWx
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aMMF/FAUJVnlFGwhOFiS9QB+HqFAXSJzpM6RCa2uQ48=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792452860; v=1; x=1793057660;
 b=a6lMNBWx5t+x03VTq8o4kVThGnP9qrzQ/o13HKQbtbyQwHE07Y2/1yEec8GWokSCASpVhr/l
 5WqWA5ZUDLMrIqKOC7ruILh3DlqlPv9OPGVe/z0R75DaMJeS/qebi2gKQf2ipqNKvg8dPO4buZy
 svIcJ9iG8C7F/BVGc2TXlzg4=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6b338b86b22b178a;
	Mon, 19 Oct 2026 23:34:20 +0000
X-Mizu-Trace-ID: 6b338b86b22b178a
X-Migadu-Flow: FLOW_OUT
Date: Mon, 19 Oct 2026 16:34:19 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Christian Brauner <christian@brauner.io>, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
Message-ID: <ataWrUkD-rqeoFcV@linux.dev>
References: <20261016220029.3276154-1-shakeel.butt@linux.dev>
 <atUkrrdfu_ihfmZ8@daedalus>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atUkrrdfu_ihfmZ8@daedalus>

Hi Jori and thanks a lot for taking a look.

On Sun, Oct 18, 2026 at 10:47:56PM +0200, Jori Koolstra wrote:
> On Fri, Oct 16, 2026 at 03:00:29PM -0700, Shakeel Butt wrote:
[...]
> > +/**
> > + * kernfs_get_inode_locked - get the inode of @kn under kernfs_rwsem
> > + * @sb: super block
> > + * @kn: kernfs_node to get the inode for
> > + * @new: points to an inode from new_inode(@sb), or to %NULL if that failed
> > + *
> > + * The caller allocates *@new before taking kernfs_rwsem, as the allocation
> > + * can stall in memcg reclaim.  If @kn needs a new inode, *@new is used and
> 
> I wouldn't mention memcg here per se, it is not relevant to grasp its
> use. In another series I have implemented almost the same thing (but you
> did it better!).

Ack, will remove memcg here.

> 
> > + * set to %NULL.  Otherwise the caller frees it with iput() after dropping
> > + * the lock.
> > + *
> > + * A new inode is added only with kernfs_rwsem held and @kn active, so
> > + * __kernfs_remove() always finds it to clear i_nlink.
> > + *
> > + * Context: kernfs_rwsem held for read.
> > + *
> > + * Return: the inode, %NULL if @kn is inactive and has no inode, or
> > + * ERR_PTR(-ENOMEM) if @kn needs an inode and *@new is %NULL.
> > + */
> > +struct inode *kernfs_get_inode_locked(struct super_block *sb,
> > +				      struct kernfs_node *kn,
> > +				      struct inode **new)
> 
> I understand this is intended to have some kind of ownership semantics,
> but I must say for such a simple function, I find the contract quite
> complex to check. Do we really need an out parameter here?

Not really. I just used it simply call iput(new) without a check. I can change
it and make it more like inode_insert5() and let caller do check before calling
iput().

> 
[...]
> > @@ -294,7 +298,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
> >  {
> >  	struct kernfs_super_info *info = kernfs_info(sb);
> >  	struct kernfs_root *kf_root = kfc->root;
> > -	struct inode *inode;
> > +	struct inode *inode, *new;
> >  	struct dentry *root;
> >  
> >  	info->sb = sb;
> > @@ -314,10 +318,12 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
> >  	sb->s_shrink->seeks = 0;
> >  
> >  	/* get root inode, initialize and unlock it */
> > +	new = new_inode(sb);
> >  	down_read(&kf_root->kernfs_rwsem);
> > -	inode = kernfs_get_inode(sb, info->root->kn);
> > +	inode = kernfs_get_inode_locked(sb, info->root->kn, &new);
> 
> What are you serializing against here? I've been looking at this as well
> recently, and I thought we could just get rid of the locking here. But
> on second look, I am not so sure what is correct.
> 
> Is there anything that serializes kernfs_get_tree() with root node
> removal?

That is a good question and honestly I didn't know the answer. After digging a
bit, I think 07/12 patch [1] of your series is right.

Superblock is still private here and it is added to the supers list after
kernfs_fill_super. Root removal is not serialized by kernfs and kernfs users
keep the root alive across the mount.

I can drop the kernfs_fill_super change from my patch and I think your patch
will cover it better.

[1] https://lore.kernel.org/20261016143806.2946578-8-jkoolstra@xs4all.nl

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490193;
	b=gtCJT/ZSQzefIQdKcqjfr3dem4ocLmfZq92s09AqPh6Qzp5IOUe1iewPlMcCmspFRjrC
	 gaSJR9gIG9VvC6QEIhmL40CJMizmIINz4H7M8T4Fi+VEcNVotz+vvj4Tups/c/wYykKI4
	 u5WpnFY+2RkHJBN6NWHLCH7pUtVAmkEer2pzEdxxYWHWnX/gEpp20Y722mdnKTC19uNg4
	 ArfRt2xeZjUDxCZZUodozz1y0F9lMKZ9psG3jS3TYO46khSaPrfPr5rSDep1ZeyRQa4cR
	 qaiiCJRPX7OSaXkalYfuvjKdFlhBK37S1KnkWzhc9awEprzFfsIJO19OD3YxZ2/yR6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490193;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZJucTTkKAG0Qf2Hna7gn9aHfY39lAiCRoh9+xLxTWwU=;
	b=fFwZid/cNMOdBLVPMBb1jW6caITIYeSEr05ULhQTXdVAwyR1AxCJ/7SS4vSL0uX2ul9A
	 k8Oj1cf8liQ95GTppAmSGXG8oiHeOWDEUJWVVTtlxRqK2IpmoagE1oQ2V9JiVxUFhTt8K
	 FD6qyOgJz33VXdzuA6e7YPr4Fl9/9Ym8/uYgc4Cj/XZjLHvgk0OK41Y13fe6u8G4d44IX
	 I0u8WN7VgpWGPvZleX/DPayxslrMgT8aQ2MyapoWiKWdXXyaOgoQxaXWffEdI6+TO7ZWk
	 aqHfC2wO7sdGCrQl+ArOz63oeOe2rJOj4ZfFzrpaERMqtiAll/oxpwyQdbTglMA94Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xlDeBT4t;
	arc=none smtp.remote-ip=91.218.175.253
Received: from mta0.migadu.com (out-253.mta0.migadu.com [91.218.175.253])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83E606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 13:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E83E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xlDeBT4t
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4yDAAlqJNV9bWDRAIqZYAiBDcqwKXJ3Bkn8ZNcaoP7E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794490190; v=1; x=1795094990;
 b=xlDeBT4tVzUjS1qYML5UR+4Dh72zb96uz+D76t0Q/b+s52rAkMKkSWuGO/Wiu71AOgNQS9bb
 nJ5vVmHvBTzvmaTb38XGIxAA/TFYneLFfr0CU2UonoXGX3Lcn4MvP7c5P2yqy8FlnX/RlzSCrjD
 B4CIb8ocGK+Cg4HueK7qfgRU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aae3e7d1ab55cbee;
	Thu, 12 Nov 2026 13:29:50 +0000
X-Mizu-Trace-ID: aae3e7d1ab55cbee
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 05:29:48 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
	Meta kernel team <kernel-team@meta.com>, linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
Message-ID: <avW_E0stwo6e-y58@linux.dev>
References: <20261111215058.1837351-1-shakeel.butt@linux.dev>
 <1984940723.1098701.1794483492769@kpc.webmail.kpnmail.nl>
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
In-Reply-To: <1984940723.1098701.1794483492769@kpc.webmail.kpnmail.nl>

On Thu, Nov 12, 2026 at 12:38:12PM +0100, Jori Koolstra wrote:
> 
> > Op 11-11-2026 16:50 EST schreef Shakeel Butt <shakeel.butt@linux.dev>:
> > 
> >  
[...]
> > +	new = new_inode(sb);
> > +	if (!new)
> > +		return -ENOMEM;
> >  	down_read(&kf_root->kernfs_rwsem);
> > -	inode = kernfs_get_inode(sb, info->root->kn);
> > +	inode = kernfs_get_inode_locked(new, info->root->kn);
> >  	up_read(&kf_root->kernfs_rwsem);
> >  	if (!inode) {
> >  		pr_debug("kernfs: could not get root inode\n");
> > 
> > base-commit: ecdfc51a6a78aaf1c4ac1d8b6ea199cc2ed020ac
> > -- 
> > 2.53.0-Meta
> 
> Does this compile? I added a bool parameter to kernfs_get_inode_locked(),
> for this patch to be able to do a lookup first, but you haven't added that.
> I think you want to set lookup=true everywhere, right?
> 

Yes, it builds on vfs-7.5.directory (base-commit ecdfc51a6a78).
Christian's fixup there dropped @lookup, so kernfs_get_inode_locked()
now takes just (inode, kn).

I don't think this patch needs @lookup.  inode_insert5() already
returns an inode that is already hashed, so an ilookup() first only
changes things for an inactive node.  Lookup and the fh_to_* paths
only get there with an active node, under the same kernfs_rwsem hold,
and fill_super works on a new superblock.  In ->get_parent, an
inactive parent means the directory being decoded is being removed.
reconnect_one() then returns -ESTALE either way, because readdir
skips the removed child.

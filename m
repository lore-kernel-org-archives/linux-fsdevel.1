Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1F442367;
	Tue, 22 Sep 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066106; cv=none; b=SbtPAFOg4G5NJKOGuXaqi2zHD291LTqSwiFvBUj8bK4fsj6YdKY7+7S9drUv9V4o2CVJ/SCU2XGqJ0X7Xu/0HAev03Ah0Jfy8MMxup96UX31lVrblrYtq4H85gmUmXx85Nco227KDAm1cvxdK6exukQA4S6J0CGIuPkCCxweLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066106; c=relaxed/simple;
	bh=gGUIYieV24A6lUUX1gSh58XZU7HKx2PCY9euDoctP+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK3QlYhvERcy71XRB22u4SepkTGI/WTSwb2A/rauoNKXAYLRvUwqdxTCMaG64ArtbLbUvKUMYbvK5/K/NUODmAU6EtY/VPwmrC+yTz8ItLjAPzE2gViIdn+1CybsuR58dsDB3KmNXmoFVWZmKCM8nLPQrKDnD3ctXapZN8FWzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=AHlmL3yv; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="AHlmL3yv"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 26C0114C2D6;
	Tue, 22 Sep 2026 10:34:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1790066102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1wp8p1aEBwAksuFVWvFD43qsY5klCVg78/py079j2N4=;
	b=AHlmL3yvGghWeG82SismoGhcaDe1YC6MzyvPHcGQNArDWsskn4fs4iWj62tQ817vpfHASp
	zFUiqC2cC4mQawowwydaT+x/NsNZ9HedPekT73MjsJ94bdN7JqhnR/FNpycft5C6cShlMk
	B7U8r6TPPq/UCbsRh+IrHgzTQ520jY9OiQ/PNUZkhOQ/OlSOkv/TutmTS2C7mn7GBZS0Nu
	gQkQmQ4SJKXKNT7OkO2jENSHrDJS3IAPAtZfz15NmcgpIsB/dkbXYh5uBtJ2RgCtjNZLe6
	CnIkwTbdV8VT4eXEmZoSqEeZMIu/7FvXxKvMldocAVNeUPvrIdQwlATXbTN3SA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5b7922d3;
	Tue, 22 Sep 2026 08:34:55 +0000 (UTC)
Date: Tue, 22 Sep 2026 17:34:40 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, v9fs@lists.linux.dev,
	Haobin Wu <853555@gmail.com>, jack@suse.cz, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com, willy@infradead.org,
	dhowells@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [PATCH v3 3/3] 9p: skip over-long directory entry names for
 legacy 9p2000 too
Message-ID: <arI9oOXMsB-iG7jm@codewreck.org>
References: <20260918024851.51229-1-853555@gmail.com>
 <20260918024851.51229-4-853555@gmail.com>
 <2050867.PYKUYFuaPT@weasel>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2050867.PYKUYFuaPT@weasel>

Haobin Wu,
Thanks, I picked up all three patches

Christian Schoenebeck wrote on Fri, Sep 18, 2026 at 02:08:00PM +0200:
> On Friday, 18 September 2026 04:48:51 CEST Haobin Wu wrote:
> > The legacy 9p2000 and 9p2000.u readdir path, v9fs_dir_readdir(), parses
> > each entry with p9stat_read() and, unlike the 9p2000.L path, never had
> > a 256-byte name limit: a name of any length up to the wire maximum was
> > handed to dir_emit(). getdents64() therefore returned names longer than
> > NAME_MAX that no later syscall can use, and failed with -EIO for names
> > of PATH_MAX bytes or more.
> > 
> > Apply the same NAME_MAX check as the previous patch does for
> > v9fs_dir_readdir_dotl(), so both protocol variants behave the same.
> > 
> > Note that this is a behaviour change for 9p2000 and 9p2000.u: entries
> > with names longer than NAME_MAX used to be listed and are now skipped.
> 
> That sentence is a bit misleading, isn't it?
> 
> Name length 256..4095:
>   - before: listed, but unusable (ENAMETOOLONG)
>   - now: entry skipped, fetch continues
> 
> Name length >=4096:
>   - before: aborts the entire fetch (similar to 9p2000.L side)
>   - now: entry skipped, fetch continues

Right, I've shamelessly copied that in when applying
https://github.com/martinetd/linux/commit/55d6732b8015705a657d96fc5bd37fbed349624a

> > @@ -126,8 +128,16 @@ static int v9fs_dir_readdir(struct file *file, struct
> > dir_context *ctx) return -EIO;
> >  			}
> > 
> > -			over = !dir_emit(ctx, st.name, strlen(st.name),
> > -					QID2INO(&st.qid), dt_type(&st));
> > +			namelen = strlen(st.name);
> > +			if (namelen > NAME_MAX) {
> 
> ... maybe better if (namelen >= PATH_MAX) here for legacy 9p2000(.u)?

Given things won't work after the name is picked up anyway (from what I
tried at least stat didn't work), I don't think it matters much, but I'm
fine breaking compatibility here.
We can bring the limit back up to PATH_MAX if someone claims it's useful
somewhere.

> > +				p9_debug(P9_DEBUG_ERROR,
> > +					 "skip dentry: name length %zu > NAME_MAX\n",
> > +					 namelen);
> > +				over = false;
> 
> Nit: alternative would be init over = false and dropping explicit assignment 
> inside loop branch here. But that's already personal taste level.

(I actually had the same comment, so made the swap locally)

-- 
Dominique Martinet | Asmadeus

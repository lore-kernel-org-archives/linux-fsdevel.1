Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314D2E1F06;
	Sun, 17 May 2026 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779005212; cv=none; b=EDFoUPjIUtaqkXYgYRI76LuRXFCPigl8dhcRbPGGDc1NO9ZO/proyMgKydNk/1Q0VVQTT9k6f2BNvTSp1xFjle/H4wOVrzLjCFUZi/Jf6E6EUGRw/OGjxBNlrYqPgfkZNiOtlja3NZYDaLpAPMpcu1cJoSiyftr2RARPzbFj2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779005212; c=relaxed/simple;
	bh=uhTrkKL4IJufye3y2imoYk/TBVB6PtQaTVwPh+9QMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn1LhfR0yl0arKsuAaDQJ9Q49uV4m372tdWBOC/9ldTvin1rqr9NrY5wAHY/z0oMG5uV8WFa3kJpq/h+dVhX4s0K0yl1NHJJ4sWGn6KP0USbJ2ev0CykVtZjVh++NMcek3yr9jSX/+GTWy7xaFLsL7PrG5be6PUqvMHJ42/Na60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (075-132-067-156.ip-addr.inexio.net [156.67.132.75])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id 4B7F9E0055;
	Sun, 17 May 2026 09:57:42 +0200 (CEST)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Sun, 17 May 2026 09:57:41 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v2] dcache: add fs.dentry-limit sysctl with
 negative-first reaper
Message-ID: <aglh7SrXWbYgD3nA@fedora.fritz.box>
References: <20260516-limit-dentries-cache-v2-1-c733a78e603b@ddn.com>
 <agj5JkPZ7eNbFueR@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agj5JkPZ7eNbFueR@casper.infradead.org>

On Sun, May 17, 2026 at 12:09:26AM +0100, Matthew Wilcox wrote:
> On Sat, May 16, 2026 at 04:52:54PM +0200, Horst Birthelmer wrote:
> > There was a discussion at LSFMM about servers with too many cached
> > negative dentries.
> > That gave me the idea to keep the dentries in general limited
> > if the system administrator needs it to.
> 
> I feel you should link to the dozens of previous attempts at this kind
> of thing to show that you're aware that this has been tried before and
> you're doing something meaningfully different.
> 

Hi Matthew,

thanks for looking at this.

- The first limitation of dentries I could find was a patch for Linux 2.6.7
which introduced the vfs_cache_pressure option. [1]
This is still in use today but will not limit dentries as such just the
relation of where to release the pressure but you have to get into a pressure
situation for it to actually matter.
For my case when we get into pressure the fuse server could already be in heavy
trouble (we have had OOM events for the cgroup due to this)

- in 2011 there was the attempt to limit dentries by container [2] [3]
Here Dave Chinner made the point that the dentry cache is usually not the problem
but the inode cache, which is exactly what we see as well, since the fuse server
has to keep a lot of private data for every cached inode. However we have the
information for LRU only for the dentries, so it is the best way we can keep this
under control, limit the number of dentries to an acceptable amounr.

- there was an entire series by Waiman Long starting at around 2017 [4] 
Here even you were part of the discussion, and I think the ideas are very similar,
I'm just more worried about unused dentries (I just prefer negative ones on
reclaim) There are several of different attempts in this context.

- then there was tbe one I mentioned in the cover letter [5]
which was trying to modify the caching to limit the excessing traversing when
there are so many entries.
I'm trying to save the same symptoms but not with that approach at all. I don't
worry at all about the chache structures.

- there was [6] by Gautham Ananthakrishna
Here the focus was on the memory used for the dentries. This is none of my concern
in this patch. I'm trying to just not keep dentries and indirectly inodes 
unnecessarily in the kernel and as a consequence in the fuse server in user space.

- currently we have the possibility via /proc/sys/fs/dentry-negative to disable
negative dentries completely
I am completely agnostic to this. If an admin disables negative dentries I try to
free some by freeing unused ones and make the limit, if not this is no problem.

I'm sure I have probably missed some where the limitation of dentries was a 
secodnary effect. I have searched for patches for fs/dcache.c that had anything
to do with dentries.

--
As a conclusion, I think I have an uncommon perspective on the cache entries
since I don't usually work on vfs but argue from the perspective of a fuse server
Where the kernel makes us waste resources. This hurts way more in the FUSE context
than in a 'normal' file system.
I have taken the look at the dentry cache just because people told me that this
has to be solved in the vfs (and I agree). I actually have a somewhat hacky patch
to do this from fuse and only for the fuse sb.

This patch will start a worker when we pass the set limit and free the negative
dentries then continue on with the unused dentries based on the LRU data.

What I'm trying to achieve is keep only actually used entries in if we are over
an arbitrary limit, and trying not to mess too much with the work that is done
by the kernel. Then there is the point that shrink_dentry_list() is only there
since 2019, so older approaches did not have tthe possibility.

The short version: This is noothing new, just a new combination of already existing
solutions, that could be useful.

[1] https://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm1/broken-out/vfs-shrinkage-tuning.patch
[2] https://lwn.net/Articles/441164/
[3] https://lore.kernel.org/all/4DBFF1AD.90303@parallels.com/
[4] https://lore.kernel.org/all/1500298773-7510-1-git-send-email-longman@redhat.com/
[5] https://lore.kernel.org/linux-fsdevel/20260331012925.74840-1-raven@themaw.net/
[6] https://lore.kernel.org/all/1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com/

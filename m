Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD43D75DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372299; cv=none; b=oS/lRM4wGKM2ZuxMEJoGK8zXQ/2gwaF5RunVTxcmDoJ7GB4EAc6DqiBatmWerquuD0J7VE00r5QHrl/ikPpOPccHg3xeJ9cg67BD6u1+Zu6GdLtGtqKwj0HjQp2e+AjkJszhvkwsU4LJEQNciaHAfAydCxGbHMTTnWpPim/2QAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372299; c=relaxed/simple;
	bh=KGyzR6Xr/duTB6cN2dhJAoKg7SYKWn8PB1baEe5S6x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsOxBNCviNnW6OzNeP2yqF6JLDejVR7NWmLrs9XWluemDEGS4fzzZecgg5hhCnybBbiVGLQ5umCUuLYiXOOW0kHRbaZsstLWVknuvIZ8ppV+eycU2zJzywZT0LaUoHGRH2UFEjN2OdUcW+gV0QcCtAROQ9MT2OiKyPBErDj5TXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqjZ1hDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqjZ1hDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1205EC19424;
	Tue, 24 Mar 2026 17:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774372299;
	bh=KGyzR6Xr/duTB6cN2dhJAoKg7SYKWn8PB1baEe5S6x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqjZ1hDnRY8AgHaMMqbx4BsGy3IhzO5weeuBgWbGSF2d4W+jl7DSgeOWvsjBzFhXG
	 KzoHI+4nXP5+senJqS52eiZJKNWh+iFKOXUHwuW4kKaYO6nz8WILJcpMq13xTS8E+V
	 Tl6+5S+5zt0HHOkHyLfZX9ulE5zzp0LbvXnrdvGPXYO7w1z3emwQUD5R76nXcVEbkW
	 WpRljtFIE26dBsOUVJIvOEWFujgSjG8JYD38kUPKCuGJ/SDIeyks5wXaIM7KHGOojO
	 j1FBnHzvaS+M7J45TBMBc9mpy0T7kKcQAUHO89ri69mqZtTMQFLm7AzT/gu8/Qa/BP
	 pbxQO57T17phw==
Date: Tue, 24 Mar 2026 10:11:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, jim.harris@nvidia.com,
	linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>,
	Konrad Sztyber <ksztyber@nvidia.com>,
	German Maglione <gmaglione@redhat.com>, hreitz@redhat.com
Subject: Re: fuse: buffered reads limited to 256KB regardless of negotiated
 max_pages
Message-ID: <20260324171138.GS6202@frogsfrogsfrogs>
References: <20260316145435.BA2542605C3@ubuntu.localdomain>
 <20260324132149.GB668717@fedora>
 <30a271bd-eaba-4248-af66-df18a61864ca@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a271bd-eaba-4248-af66-df18a61864ca@bsbernd.com>

On Tue, Mar 24, 2026 at 05:05:45PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/24/26 14:21, Stefan Hajnoczi wrote:
> > On Mon, Mar 16, 2026 at 07:54:35AM -0700, jim.harris@nvidia.com wrote:
> >> Hi all,
> >>
> >> We have a FUSE server that advertises max_write=1MB and max_pages=256
> >> in the FUSE_INIT response. Buffered sequential writes arrive at the
> >> server at the full 1MB as expected. However, buffered sequential reads
> >> are capped at 256KB per FUSE READ request.
> >>
> >> The cap comes from the BDI readahead window. bdi->ra_pages defaults to
> >> VM_READAHEAD_PAGES (32 pages / 128KB). For sequential access (e.g. cp),
> >> posix_fadvise(POSIX_FADV_SEQUENTIAL) doubles the per-file readahead
> >> window to 2 * bdi->ra_pages (256KB), producing the observed 256KB
> >> limit. A 1MB application read() results in four sequential 256KB
> >> round trips to the FUSE server instead of one.
> > 
> > Hi Jim,
> > Thanks for sharing this issue. I am CCing Geman Maglione and Hanna
> > Czenczek who work on virtiofsd and are also becoming more involved in
> > the virtiofs kernel driver.
> > 
> >> In process_init_reply(), the kernel processes the
> >> server's max_readahead response like this:
> >>
> >>     ra_pages = arg->max_readahead / PAGE_SIZE;
> >>     fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);
> >>
> >> Since bdi->ra_pages starts at VM_READAHEAD_PAGES (128KB), and the
> >> kernel sends this value as init_in->max_readahead, the server can only
> >> decrease readahead -- never increase it. Even if the server responds
> >> with max_readahead=1MB, the min() clamps it back to 128KB.
> >>
> >> Other filesystems set ra_pages or io_pages based on server/device
> >> capabilities:
> >>
> >>   - SMB/CIFS sets ra_pages directly (2 * rsize, or from mount option)
> >>   - Ceph sets ra_pages directly from mount option
> >>   - 9P sets both ra_pages and io_pages from maxdata
> >>   - NFS sets io_pages from rsize
> >>
> >> I see two possible approaches and would like feedback:
> >>
> >> Option A: Fix the max_readahead negotiation
> >>
> >> Replace the current:
> >>
> >>     fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);
> >>
> >> with:
> >>
> >>     fm->sb->s_bdi->ra_pages = min(ra_pages, fc->max_pages);
> >>
> >> This uses the server's max_readahead response directly, capped by
> >> fc->max_pages for safety. I think this is backward compatible:
> >> existing servers that echo the kernel's 128KB value get the same
> >> result. Servers that return a lower value still reduce it. Only
> >> servers that return a higher value see changed behavior.
> >>
> >> FUSE servers can opt in by advertising a larger max_readahead in the
> >> FUSE_INIT response.
> >>
> >> Option B: Set io_pages from max_pages
> >>
> >> Set bdi->io_pages after FUSE_INIT negotiation:
> >>
> >>     fm->sb->s_bdi->io_pages = fc->max_pages;
> >>
> >> This matches what NFS does (setting io_pages from rsize). The
> >> readahead code uses max(bdi->io_pages, ra->ra_pages) to determine
> >> the maximum readahead size, so a large io_pages would allow larger
> >> readahead submissions.
> >>
> >> This is simpler since no server-side change is needed. However, it
> >> bypasses the max_readahead protocol field, making max_readahead
> >> effectively meaningless for any device with large max_pages.
> >>
> >> In both cases, fc->max_pages is already clamped by
> >> fc->max_pages_limit, which for virtio-fs accounts for the virtqueue
> >> descriptor count.
> >>
> >> Thoughts?
> > 
> > I think this is a question for Miklos. You could also send a patch with
> > your preferred solution to expediate this.
> > 
> > Thank you for looking into this - it will be nice to remove this
> > performance limitation.
> 
> 
> We have this patch in our branch:
> 
> commit 763c96da4bd6d1bb95d8e6bb7fd352389f3a17b9
> Author: Bernd Schubert <bschubert@ddn.com>
> Date:   Wed May 7 23:39:00 2025 +0200
> 
>     fuse: Use fuse-server provided read-ahead for CAP_SYS_ADMIN
>     
>     read-ahead is currently limited to bdi->ra_pages. One can change
>     that after the mount with something like
>     
>     minor=$(stat -c "%d" /path/to/fuse)
>     echo 1024 > /sys/class/bdi/0:$(minor)/read_ahead_kb
>     
>     Issue is that fuse-server cannot do that from its ->init method,
>     as it has to know about device minor, which blocks before
>     init is complete.
>     
>     Fuse already sets the bdi value, but upper limit is the current
>     bdi value. For CAP_SYS_ADMIN we can allow higher values.
>     
>     Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index af8404f539a3..417598bb3575 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1369,7 +1369,10 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
>  			fc->no_flock = 1;
>  		}
>  
> -		fm->sb->s_bdi->ra_pages =
> +		if (CAP_SYS_ADMIN)

I really hope your branch has:

		if (has_capability_noaudit(current, CAP_SYS_ADMIN))

and not what's written there. ;)

--D

> +			fm->sb->s_bdi->ra_pages = ra_pages;
> +		else
> +			fm->sb->s_bdi->ra_pages =
>  				min(fm->sb->s_bdi->ra_pages, ra_pages);
>  		fc->minor = arg->minor;
>  		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
> 
> 
> 
> 
> Maybe we can increase the limit for non privileged servers, but
> not to fc->max_pages, because an admin might tune fuse_max_pages_limit 
> to a rather large  value. I was able to kind of crash the system
> with >16MB read-ahead in early 6.x kernels (I think 6.1).
> 
> 
> 
> 

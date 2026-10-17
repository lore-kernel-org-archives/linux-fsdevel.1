Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88DF348463;
	Sat, 17 Oct 2026 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792228458; cv=none; b=mDaaV+86izNFZomFyESS/74G+O+d45W8MftRgG9k9AMSeeIKY3LOtMTzfBxBRyZDpgORdiMrFdELhKE/uljK5vxGSyNVk5QEqir0/z/qYYuPja+EZB9F0zVSdoJ2OEnC2u0ml5zTo2yj3YSF4dmr3jEKd7fiL53dCafgd7Chr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792228458; c=relaxed/simple;
	bh=8vABHsB13eyqoMgwp6aTT5t4riKAcG78mN2q6kXrNg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc4NckgvgxCDTKsv3xOk8aRqvYyAqWQR12+1r/n82Xbl5CmM9hpdXRX4lHJ9HUB3+IljUPczgGjPUWaJ1Vgkxc/D55Njs2DQAqDBnxSekQHmnEW6LN4mxZrMXwgS2ygQpPR2E7SgZfdO7FARp/D2CSTG8jviF97diidslb61GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pg7Uzfa1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pg7Uzfa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220AC1F000C4;
	Sat, 17 Oct 2026 09:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792228456;
	bh=CnRNgtJg3qHsn4g0qrZKuVv1hDNtWmsy7zLHcTj6znE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pg7Uzfa10I7JHTA982u7w07n9+pFsyM4SRqINgM9czcXcUkH/Aw62F/qdufEy7go5
	 x1MgavQB3jndA/KisJmgce+AP8frlKWD/z8vkQ8typ0nOR7S36hoUHvEEXTERez1Fk
	 l5g4zGMGbSH+2w3wJgmfUt1By3Qp+T2TWjWa9NDY=
Date: Sat, 17 Oct 2026 11:14:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Christian Brauner <christian@brauner.io>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
Message-ID: <2026101745-brisket-outspoken-ef6c@gregkh>
References: <20261016220029.3276154-1-shakeel.butt@linux.dev>
 <236f5fe73f01f03d75dddca9362f39a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <236f5fe73f01f03d75dddca9362f39a7@kernel.org>

On Fri, Oct 16, 2026 at 12:42:29PM -1000, Tejun Heo wrote:
> On Fri, Oct 16, 2026 at 03:00:29PM -0700, Shakeel Butt wrote:
> > In the Meta fleet, on 6.16 with the kernfs changes queued for 7.4
> > backported, we still see long cgroupfs stalls:
> >
> > - oomd and below waited 72 seconds in kernfs_fop_readdir() while an out
> >   of memory container created cgroups.  They resumed when the kernel OOM
> >   killer killed the container's workload.
> >
> > - oomd waited 15 minutes in kernfs_iop_lookup().  PID 1 waited for
> >   kernfs_rwsem in cgroup_rmdir() while holding cgroup_mutex.
> >
> > - A lock profiler sampling part of the fleet saw kernfs_iop_lookup()
> >   hold kernfs_rwsem across memcg reclaim on 26 hosts in 29 days, for up
> >   to 625 ms.
> >
> > The profiler shows where these stalls come from.  kernfs_iop_lookup()
> > and the export ops allocate a new inode while holding kernfs_rwsem for
> > read.  The inode is charged to the caller's memcg.  If that memcg is at
> > memory.max, the allocation can stay in reclaim for a long time,
> > sometimes until an OOM kill.  A writer then queues on the lock and every
> > new reader queues behind it.  On cgroup2 this blocks every cgroupfs user
> > on the machine.
> >
> > Such lookups are common in a memcg that is out of memory.  Its reclaim
> > drops its kernfs dentries fast, and the files of a new cgroup have no
> > inodes yet.
> >
> > Allocate the inode before taking kernfs_rwsem, and free it if it is not
> > used, as commit 8b64f32fee95 ("kernfs: allocate the new name outside
> > kernfs_rwsem") and commit 5ad03af18434 ("kernfs: allocate the open node
> > outside the open file mutex") do.  Everything else still runs under the
> > lock, so a new inode is added only for an active node, and
> > __kernfs_remove() still finds every inode it must clear i_nlink on, as
> > commit dc1a0cc95737 ("kernfs: don't lose IN_DELETE_SELF when decoding a
> > file handle") needs.
> >
> > The inode goes unused when the name does not exist, the node is
> > inactive, or it already has an inode.  In a VM, a lookup of a missing
> > name takes about 0.35 us longer, 1.65 us instead of 1.3 us on
> > cgroupfs.  Cold lookups of existing sysfs and cgroupfs files are not
> > slower.
> >
> > kernfs_get_parent_dentry() also held the lock across d_obtain_alias(),
> > which allocates a dentry.  Hold it only around the inode lookup, as
> > __kernfs_fh_to_dentry() already does.  This also gives ->get_parent the
> > active test that the IN_DELETE_SELF fix left out: a parent that is
> > being removed and has no inode now gets -ESTALE instead of a new inode
> > with i_nlink 1.
> >
> > kernfs_fill_super() preallocates the root inode the same way, so no
> > inode is allocated under kernfs_rwsem any more.
> >
> > Tested on a 316-CPU machine.  A task in a full 256 MB memcg with slow
> > swap looks up the files of new cgroups.  Worst waits in 60 seconds:
> >
> >                                   before    after
> >   oomd, for kernfs_rwsem          236 ms   0.1 ms
> >   below, for kernfs_rwsem         356 ms   0.8 ms
> >   systemd, for kernfs_rwsem       160 ms    37 us
> >   readdir of another directory    530 ms   3.9 ms
> >
> > The lookup itself is still slow.  The VFS still holds its directory's
> > lock, so other work in that one directory still waits.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Suggested-by: Tejun Heo <tj@kernel.org>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

This looks sane, but it's really late in the cycle, can we wait until
after -rc1 to add it to the tree for lots of testing in -next?

thanks,

greg k-h

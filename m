Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23F440B360
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184582; cv=none; b=JdzgRTbIq89kbuDukK4lr6VMJP4DkbF2Ze774PGNuziSoJA8aD7Mz5PXljYTDq9ARmzty4nCNUJ3Sadu3ThgbjqD4v3Ppomw0AqTX5+jDX7n6qkrj4CXtD6Z2gs0wDRqnAN0GW0/m5m/jM9wikVfyUgGtafwEZkyHhAGmMdBTOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184582; c=relaxed/simple;
	bh=28ylzu+o5fZiKT36o+HUSHzro3k5S/9mBS+q1EJsaZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ2cE3pfAMcSCGGteNCR7FrqBu8+KzUMSD/n0a+t9KkzG0fs2Z4/32wFfsBoiGipr2Lhm/eucKTSgan3JOV2HyONIfROtCa7h0JtLahBcvK2Irhcn5gNrxB9JjIT/degCsegT9p8StythGOA1Yj5OK3vt1s0xr/jd+TdWjjhlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=scbzIcyY; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="scbzIcyY"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=28ylzu+o5fZiKT36o+HUSHzro3k5S/9mBS+q1EJsaZM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792184577; v=1; x=1792789377;
 b=scbzIcyY+L+NtDZielEU4Uq2X12ngiXj436+zmJI64+lvbHzCRgdR4NXymOCV2T69qlpcauX
 2ahKMunQg6fcNq4lW2E1xaxrzwsGsNKchtDeJH6OXuVDe4YDUGT+41cVwP9a0GVlZ5DSE4jaa2e
 FmLQrAUXIT3gnTS0Nu+vOAdc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dad739c8675871cd;
	Fri, 16 Oct 2026 21:02:57 +0000
X-Mizu-Trace-ID: dad739c8675871cd
X-Migadu-Flow: FLOW_OUT
Date: Fri, 16 Oct 2026 14:02:56 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christian Brauner <christian@brauner.io>, Meta kernel team <kernel-team@meta.com>, 
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernfs: allocate inodes and dentry outside
 kernfs_rwsem
Message-ID: <atKQcFFeKG76LkLQ@linux.dev>
References: <20261016164345.31618-1-shakeel.butt@linux.dev>
 <06b62af1faefaddcb9d5d09cbaf7a2ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b62af1faefaddcb9d5d09cbaf7a2ad@kernel.org>

On Fri, Oct 16, 2026 at 10:33:20AM -1000, Tejun Heo wrote:
> Hello, Shakeel.
> 
> On Fri, Oct 16, 2026 at 09:43:45AM -0700, Shakeel Butt wrote:
> > Allocate the inode with the lock dropped.  kernfs_iget() first looks for
> > an existing inode.  If there is none, it pins the node, drops the lock,
> > allocates, takes the lock again, and adds the inode only if the node is
> > still active.  So __kernfs_remove() still finds every inode it must
> > clear i_nlink on, as commit dc1a0cc95737 ("kernfs: don't lose
> > IN_DELETE_SELF when decoding a file handle") needs.
> 
> Would it be simpler to allocate the inode before taking kernfs_rwsem and
> free it if it ends up unused, as 8b64f32fee95 ("kernfs: allocate the new
> name outside kernfs_rwsem") and 5ad03af18434 ("kernfs: allocate the open
> node outside the open file mutex") do? Then the lock doesn't have to be
> dropped, and there's no need for the pin and the active recheck. The
> unused cases (negative lookups, inactive nodes, nodes which already have
> an inode) are exceptions, and an inode alloc and free isn't expensive.

Thanks for taking a look and yes, it is much better and simpler.

> 
> The helper would then just run under kernfs_rwsem. Maybe
> kernfs_get_inode_locked() would be a better name for it?

Ack

> 
> kernfs_fill_super() can preallocate the same way, which gets rid of the
> last inode allocation under kernfs_rwsem.

Ack

> cgroup_may_write() allocates
> the inode under cgroup_mutex and could allocate before grabbing the
> mutex too.

Let me send this one as a separate patch.

> 
> > kernfs_get_parent_dentry() also held the lock across d_obtain_alias(),
> > which allocates a dentry.  Hold it only around kernfs_iget(), as
> > __kernfs_fh_to_dentry() already does.
> 
> This also adds the active test to ->get_parent. A parent which is being
> removed and has no inode now gets -ESTALE instead of a new inode with
> i_nlink 1, which closes the window dc1a0cc95737 ("kernfs: don't lose
> IN_DELETE_SELF when decoding a file handle") left open. Can you mention
> it in the description?

Yes, I will do.

Thanks again for the review.

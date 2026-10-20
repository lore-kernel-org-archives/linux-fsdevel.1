Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792534211;
	b=LtxSHkUpTIp38Tb3Qt4KazEBodt9tyvBO93dcfvFwvvhMFb9MIEUHLo71tx9+bvsg5h5
	 uAfc2HS5FHoQizLOZf++FQ+44Zv8TFOkPclvsMp0+qKEBa4XVcsodjYZ7AZfkrox9uDU5
	 yywXzLj5eYzG/+CuA3RCDq6G5mbwWlByyxYW4vOv1Z1q8bOPjaxo/yWZGUCkSLUV85w3D
	 ZDe7moGPaCdubQhncSshKOC0ZQXemfB2T4vftnMWQBj24BN6d2FTqkXR27U+iqCP/ETCm
	 3gde5Ku8u1DCaSjFXtG+df0cBtT+5m9Bls2E7NooE0BF8E++QrgOr5ZnipzlicZrrpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792534211;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wC7eO4Nqk4KZLdcN14swpHZxWyRamkg0re5UUTziYH4=;
	b=b9MK4b1SDs31Wpz2/ztaCZTn3yLB62ebpZDNadiuwy6uwPSJzDePOl/KhZ0e41W6lfVL
	 M69AUbNwZ5KqTSnUkF2FPL+ZfLlrKESiOIYUlH0jY4LBYHarGzBPqp+ntFbDOL/OyGnPW
	 9z1xJG5vPABuH30wWeXrFqD9KkATjNXpjbZJME/N/yjm1KDwGdMDTou8gGpZjlopCa3xj
	 Ac+HYl0YpgUdBPykx2pKy8rSg8yLjW0OQP9x+3994p+YMFWSTeJEkWJhw4BYvzMB4VmqW
	 OgRlGxARo5DMtJyIM1n1bBVRihPQW7aO4aFjy36+UMm96SHgkoMymoFRN8cZPecyvsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmyAiEce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97494606A319
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmyAiEce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E78D1F000C9;
	Tue, 20 Oct 2026 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792534211;
	bh=wC7eO4Nqk4KZLdcN14swpHZxWyRamkg0re5UUTziYH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lmyAiEceiohjlomp5OsDg06G4lKBLeNOnePW/C6m+WLvbu7/GPwhyNtKMrag/G2ex
	 n7+gXGQ76anfMREO1vbPugq1zolcX/+l+NCYmKEy/j6AeHEMuJ1ORGRw5qAiYcfTsl
	 21fbb6mP55yEnv38n2jZrmcPzR02+v0iO8kbuOl62YG8ZXg7sFY8ymYNUuYaGKnH1w
	 N5p9E8beCOJBLh21vIGh+PCKE17vU2ZE1o5XzZdTOhm1bZEctpgyS42lfERSUJQyX8
	 0n/EKCtI7jBBt1vf4UYCWOSHhhZZdIKLLbhbHnnl551AX8HJifE2V9YYAzOoPKlIWp
	 8AB9lK5JvLmzA==
Date: Wed, 21 Oct 2026 09:10:02 +1100
From: Dave Chinner <dgc@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 0/7 v3] fs: Deferred inode reclaim
Message-ID: <atfmukIp61u_dn6Z@dread>
References: <20261009133253.20102-1-jack@suse.cz>
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
In-Reply-To: <20261009133253.20102-1-jack@suse.cz>

On Mon, Oct 12, 2026 at 10:23:38AM +0200, Jan Kara wrote:
> Hello,
> 
> here is the third revision of my patches implementing deferred inode reclaim to
> deal with MM warnings due to GFP_NOFAIL allocations from reclaim paths. This
> happens because to reclaim some inodes, filesystems have to do IO including
> complex operations using journalling and forward progress of these depends on
> successful memory allocations (which is impossible to guarantee from reclaim
> context).
> 
> Since the last revision the most notable changes include addition of automatic
> deferal of inode eviction from iput() when inode link-count is 0 and we are in
> reclaim (PF_MEMALLOC flag set). This path gets triggered e.g. by overlayfs
> whose inodes hold dentry references on upper filesystem and thus slab reclaim
> of overlayfs inodes can trigger the last dput() (and thus iput()) of already
> unlinked files. Since inode deletion is practically guaranteed to require IO
> (and thus possibly e.g. loading allocation information into memory) I've
> decided to unconditionally defer reclaim in this case instead of marking inodes
> in each filesystem.
> 
> Another bigger change in this series is that we now protect deferred inode
> reclaim from filesystem freezing. Otherwise inode eviction could block the
> reclaim worker on frozen filesystem which could stall deferred inode reclaim on
> the whole system. Deferred reclaim workers now skip reclaiming inodes on frozen
> filesystem and we block filesystem freezing while the worker is evicting
> current batch of its inodes.
> 
> The last bigger change is that mark_inode_reclaim_deferred() does not block
> when the queue of deferred inodes grows over limit anymore. Instead it queues
> task work to delay the task appropriately when returning to userspace. This
> solves possible lockups when tasks would get throttled when calling
> mark_inode_reclaim_deferred() with some locks or transaction started.

Hmmm. This re-implements the XFS inodegc infrastructure at the VFs
level, but without all the internal XFS knowledge of when background
inodegc processing is required. It looks rather complex compared to
the XFS inodegc code....

Whilst I agree that the VFS should be able to do this for
filesystems like ext4, we really don't want to be deferring inodegc
processing twice.  Hence for XFS we really want the VFS to call
evict() immediately for all inodes so that the filesystem can
correctly decide if deferred processing is necessary or not...

> The patches have survived full fstests run on ext4 when marking all loaded ext4
> inodes for deferred reclaim to stress the deferred reclaim paths. I have also
> tested (when marking all inodes for deferred reclaim) the patches by creating a
> memcg with 128m memory limit and then scanning from 10 processes 1m inodes in
> total which heavily exercises deferred inode reclaim paths. This also verified
> efficiency of throttling of marking of inodes for deferred reclaim. Basically
> we cannot guarantee any particular limit on the number of inodes queued for
> deferred reclaim as that is bound only by their number in memory and memory
> pressure. But as the number of queued inodes grows, the tasks creating them get
> slowed down so eventually some equilibrium is hit. In my VM this was at ~10k
> inodes (only slightly above the 8k limit when throttling kicks in) but this all
> very much depends on the reclaim pressure, speed of deferred reclaim etc. so I
> don't think this is some representative number.

XFS has a "almost-hard" queue limit is 256 queued inodes per CPU.
Anything larger than that sees reduced performance under sustained
inode cache pressure and latency problems when eviction processing
of individual inodes takes a long time (e.g. deferred unlink of a
set of inodes with millions of extents each).

In normal operations, however, the low queue limit means triggers
the scheduler to move the reclaiming thread to another CPU to allow
the queued cleanup work to run on the same CPU it was last touched
on. Performance testing showed that moving the reclaiming task was
much, much better than pushing the reclaiming work to other CPUs
whilst blocking on the throttle. Deep queues (like many thousands of
inodes) caused other problems with ongoing (non-reclaim) operations
then contending with resources with queued background inodegc.

i.e. for XFS it has proven better to have short queues, short
backoffs and schedule/process small batches concurrently than it is
to have deep queues, spreading the work out many kworkers and having
"end-of-queueing" throttling behaviour...

> The first patch is a pure fix for a problem I've hit when running fstests.  The
> second patch deals with lazy timestamp updates which I've decided to handle
> better directly inside the writeback infrastructure instead of deferring
> reclaim. The remaining patches implement the inode reclaim deferal. Ext4 use of
> deferred inode reclaim is there mostly as a demonstration. Other filesystems
> need to determine which inodes need deferred reclaim and mark them as such
> which generally requires good internal knowledge of the filesystem. I'm hoping
> that once the infrastructure is there, fs developers prompted by MM warnings
> will start using it :). I know for a fact that besides ext4 e.g. gfs2 wants
> to use this infrastructure.

But XFS doesn't, so it needs to be optional. :)

-Dave.
-- 
Dave Chinner
dgc@kernel.org

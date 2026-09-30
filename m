Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55250AC04
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778314; cv=none; b=emcXjUnwX5Yx8euRXj9KBDB34CKHVycUuPeZF2fABtRjrBMlQRi58QPu5wKFtrppxLNN/H3495mky9oF6/iKfBXqBZVBzoEwu87tOLQoSJAMwHEzVRiJF4cpUekKi0UKjq7pL7NSnWZMgRN5CwZlAnzeeEd6Lwcl4nvLTSlEByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778314; c=relaxed/simple;
	bh=JRiG0miFmhpuVLYiSPY0nDBScoqYM9R4KgggAenJ2SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stPqdhZeUnDOVMdNIn6TEFXW43uhWsLrcJ8sCWqmHctmvxBWDCavI4ILrwZY1wPvuYr4hpNpGu2tHX+ahRDCdpqHcm3CeVjR+4kL0SZF/u10P4iDbulsTlDocsKkWrTlqsXMfFcw8i00poiPFra1xRynwc8yjkRyAB0HxX8Xd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBCS4+LQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBCS4+LQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B161F000FF;
	Wed, 30 Sep 2026 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778298;
	bh=xdqn8jaes/7yzZn0Sv5IMKv/fi+R1x53WIn7OlrVd5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nBCS4+LQ5lJx4AWazCSD2t+T9rlszILCCjyntcRhEcJjqRBLH2ZoUGtzzmNc4q8Sn
	 fvJfEwyNbzeJ3IPuupSijSjdZy49eftWRpOMcv9B18omttt9wYhUS17rL8KjzoFAnm
	 HV6F+SOQvzkMplkZ2aDSoK2N14usWBKDNFa1IBIHcD6NESQUYTRvWxN5iLpysEMjaj
	 qOJ8UMUky12YARAEJJiuXon0C6RnVGQ2y+f3DV8gIroBBVy1zci+gtcHCAnDdbgFSF
	 inRfWfO2sfQMhnABHW9esX0JqAMVYCCcUXx1dzJB5agt6cMrKClif8KMVCoq40W3MI
	 qy95INF9BhOSQ==
Date: Wed, 30 Sep 2026 15:24:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <ar0a9y2E0nDTIC8V@gremlin>
References: <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
 <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
 <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin>
 <arz8Plu6J4YOTi0a@gremlin>
 <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>

On Wed, Sep 30, 2026 at 10:14:27PM +0800, 天狼 wrote:
> Hi David, Lorenzo,
>
> We currently work around this issue by setting the global
> vm.dirty_expire_centisecs to 60000.
>
> We have also developed a kernel module as another option. It exposes an
> ioctl that takes a file descriptor. For an already-dirty inode, it updates
> dirtied_when to the current jiffies and moves the inode to the newest end
> of the writeback dirty list, postponing its selection by periodic
> writeback. It leaves the dirty state intact and does not remove an inode
> from an already-queued flush.
>
> To keep postponing periodic writeback, the application must call this
> ioctl continuously at intervals shorter than vm.dirty_expire_centisecs,
> expressed in centiseconds. Once the calls stop, the normal expiration
> interval applies from the last call.
>
> The key code, with checks and locking omitted, is:
>
>     inode->dirtied_when = jiffies;
>     if (!(inode->i_state & I_SYNC_QUEUED))
>         list_move(&inode->i_io_list, &wb->b_dirty);
>

Yeah that's absolutely violating how writeback is supposed to work.

> However, neither changing a global setting nor maintaining a separate
> kernel module is as elegant as having this supported directly in the
> kernel.

You're neglecting the question David and I have both raised with you here, which
is why you can't simply use shmem (e.g. a memfd) to achieve what you want to do
here?

Writing to a MAP_SHARED mapping is not recommended for a number of reasons, and
most software that does something like what you're doing uses shmem to achieve
it.

Overall I don't think there's a sensible kernel solution to your problem.

I strongly recommend you look at a shmem solution.

--
Cheers, Lorenzo

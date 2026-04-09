Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2FE25CC79;
	Thu,  9 Apr 2026 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721686; cv=none; b=Rp11MQ8T1O9+SBuGaxJ5LEYgTLI+hsk047ctLR8Abg+vBBtiTr4Gbi0ZY8Rm7JHX9DYdl79r2RLKiYcSypjDg6ZaJ5vVX6zpsLXMdVE7YxknLvSVAwvi7N8WMdbMKwfREx/6fyfuwHG8VEpR+jwlXbykq+wzdUu8Ik0QK+/lark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721686; c=relaxed/simple;
	bh=RGmpNngIfJC7vsE/AA6AGxc8jF7BEr2rUsoHZzp8PsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv6riFtgCJWe4nIEZ62rQr9IC2uZa7PtTgzPfOxT/oc5Lp8O9p38kMyQrbAYLKS/0tb4d9RtcrOroyBSgEqudk1kv4Pq4URXsFJ24Rxg1hfi+4XX9/QKUXn7h2vGWNsALeRH4wGYHnL5D2CeRtfKKPxnnxC7nw6rK3LdlLzdq9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOTz9tLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOTz9tLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933BFC2BC9E;
	Thu,  9 Apr 2026 08:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775721685;
	bh=RGmpNngIfJC7vsE/AA6AGxc8jF7BEr2rUsoHZzp8PsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOTz9tLV6I6aNdusDm3HswNPIWXdRp/W6DkRosUNvQIzX9eaIsc5Tbz0x7b4UcVJD
	 VghAjUDqOJFDCdxJWd6SUI9/j/6Ib9lheDAoTXVwEbTbxh69QWEZ28y3Uj0PaniLm8
	 eLCzJ9OnW71vIFeqfBTsPsf7/n5c5f4d6sxAWDTKB1Kd7U2Jx9X/sliZ4ru/t8xybV
	 Hngi1RQTrPDym8ZFVyYzNfVv88ValdoNCYPc7mNPNEyZL6YlHovTNGUlGIZfbyelGm
	 cWIZka/2Kf5Nu6Kh7areDqyG7LuzyK1U5AKAPK1Pio5MDnq19kTt+XsB8sbiO/H5B7
	 KeLJ25ueK/PNA==
Date: Thu, 9 Apr 2026 09:01:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: "Denis M. Karpov" <komlomal@gmail.com>, rppt@kernel.org, 
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@kernel.org, jannh@google.com, 
	peterx@redhat.com, pfalcato@suse.de, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <addcUpxfuR2llaiW@lucifer>
References: <20260407081442.6256-1-komlomal@gmail.com>
 <20260408123700.1596800-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408123700.1596800-1-usama.arif@linux.dev>

On Wed, Apr 08, 2026 at 05:36:59AM -0700, Usama Arif wrote:
> On Tue,  7 Apr 2026 11:14:42 +0300 "Denis M. Karpov" <komlomal@gmail.com> wrote:
>
> > The current implementation of validate_range() in fs/userfaultfd.c
> > performs a hard check against mmap_min_addr without considering
> > capabilities, but the mmap() syscall uses security_mmap_addr()
> > which allows privileged processes (with CAP_SYS_RAWIO) to map below
> > mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
> > dac_mmap_min_addr variable which can be changed with
> > /proc/sys/vm/mmap_min_addr.
> >
> > Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
> > with -EINVAL for valid memory areas that were successfully mapped
> > below mmap_min_addr even with appropriate capabilities.
> >
> > This prevents apps like binary compilers from using UFFD for valid memory
> > regions mapped by application.
> >
> > Replace the rigid mmap_min_addr check with security_mmap_addr() to align
> > userfaultfd with the standard kernel memory mapping security policy.
> >
> > Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> >
> > ---
> > Initial RFC following the discussion on the [BUG] thread.
> > Link: https://lore.kernel.org/all/CADtiZd0tWysx5HMCUnOXfSHB7PXAuXg1Mh4eY_hUmH29S=sejg@mail.gmail.com/
> > ---
> >  fs/userfaultfd.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index bdc84e521..dbfe5b2a0 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_range(
> >  		return -EINVAL;
> >  	if (!len)
> >  		return -EINVAL;
> > -	if (start < mmap_min_addr)
> > -		return -EINVAL;
> >  	if (start >= task_size)
> >  		return -EINVAL;
> >  	if (len > task_size - start)
> >  		return -EINVAL;
> >  	if (start + len <= start)
> >  		return -EINVAL;
> > -	return 0;
> > +	return security_mmap_addr(start);
>
> Is this introducing an ABI change?
>
> The old code returned -EINVAL when start was below mmap_min_addr.
> The new code calls security_mmap_addr() which returns -EPERM when
> the caller lacks CAP_SYS_RAWIO. Existing userspace callers checking
> specifically for -EINVAL would see different behavior start is
> below mmap_min_addr.

You mean API change? :) we don't guarantee ABI for kernel stuff anyway.

Firstly, as with Harry, I don't believe we should be duplicating checks here
anyway. UFFD is duplicative enough as it is.

And this is such a silly edge case that I don't think it is valid or reasonable
for us to account for whichever totally insane user relies on a pointless
re-check being done there and _then_ relies on the error code
being... -EINVAL... which is overloaded for a million other possible failures.

Let's let it be -EFAULT and remove this silly check altogether.

>
> >  }
> >
> >  static __always_inline int validate_range(struct mm_struct *mm,
> > --
> > 2.47.3
> >
> >

Thanks, Lorenzo

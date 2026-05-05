Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E93F7A94;
	Tue,  5 May 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975849; cv=none; b=n7fVyslS1cEMCBwr3hgMbEgrWpbjQB2mm2LnZbFcUn4PKEzBqWnf0fXsBXxkYe42oKHSf+M+yHev0/E4q16+jkY5pitAK96s/NFQYOie1oh9kFTqPdakDT3GHss8T3RCI/FE77YKlYwz0JLy0kSSvJtOOmEwpoilV7rTBqkXoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975849; c=relaxed/simple;
	bh=d8zJj4KQwNvVaZUWE7Gf1PYyAbDyUzahxPz+7fxw0A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxBF2Txf6wXn5QVvBPO9H9bUUqtHgJphXN6RJKyfRfyiiiP1wy3k+2OUEyWu22LNxQrdBYnLSsqWyysipnbXIBHeVX+g72MqCdcsQ4op8wQyIX8Lwr7kCTZScfjvri7rkaCwMy0XDit8Ez40zY/jlr32sVockfcWYFnOPrpKaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8d5dD7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8d5dD7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535BEC2BCB9;
	Tue,  5 May 2026 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777975845;
	bh=d8zJj4KQwNvVaZUWE7Gf1PYyAbDyUzahxPz+7fxw0A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l8d5dD7x24SjKGXE/Xq1Qvp9eEplBYpU0UaymvU7snTL5H5EfPX3nDhPAFhCk3pqN
	 62g1BMrf7GhAbnP1VU8sbH+ZrwxVBip6Bn+x+wcB7n4Ap1uMwpvVy1zjFWUsG/9W90
	 34ZdRlhrUegm0yEkzz7ZRKyc+auISoxop9qRLW3RcpARVGBOgTKrDqe1gV9erW0fuj
	 Z8o5PeruxWCX3lT756NTIdrGwngrK92z1gjqwrvlANAb6hjyh/lHAtCUDQC50VbfmN
	 aLEZWomB+MGOgwKQBNXGTk8FyNQyey6+rrP9s7HIocsUgml2a1YW74R6B7588fRZp8
	 b5pHlGPivQQXw==
Date: Tue, 5 May 2026 11:10:40 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: "Denis M. Karpov" <komlomal@gmail.com>, rppt@kernel.org, 
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@kernel.org, jannh@google.com, 
	peterx@redhat.com, pfalcato@suse.de, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <afnCAnLSDXnLRhLq@lucifer>
References: <20260407081442.6256-1-komlomal@gmail.com>
 <20260408123700.1596800-1-usama.arif@linux.dev>
 <addcUpxfuR2llaiW@lucifer>
 <408fc657-94a2-4832-b5cd-7013c002403d@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408fc657-94a2-4832-b5cd-7013c002403d@linux.dev>

On Thu, Apr 09, 2026 at 11:52:12AM +0100, Usama Arif wrote:
>
>
> On 09/04/2026 09:01, Lorenzo Stoakes wrote:
> > On Wed, Apr 08, 2026 at 05:36:59AM -0700, Usama Arif wrote:
> >> On Tue,  7 Apr 2026 11:14:42 +0300 "Denis M. Karpov" <komlomal@gmail.com> wrote:
> >>
> >>> The current implementation of validate_range() in fs/userfaultfd.c
> >>> performs a hard check against mmap_min_addr without considering
> >>> capabilities, but the mmap() syscall uses security_mmap_addr()
> >>> which allows privileged processes (with CAP_SYS_RAWIO) to map below
> >>> mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
> >>> dac_mmap_min_addr variable which can be changed with
> >>> /proc/sys/vm/mmap_min_addr.
> >>>
> >>> Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
> >>> with -EINVAL for valid memory areas that were successfully mapped
> >>> below mmap_min_addr even with appropriate capabilities.
> >>>
> >>> This prevents apps like binary compilers from using UFFD for valid memory
> >>> regions mapped by application.
> >>>
> >>> Replace the rigid mmap_min_addr check with security_mmap_addr() to align
> >>> userfaultfd with the standard kernel memory mapping security policy.
> >>>
> >>> Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> >>>
> >>> ---
> >>> Initial RFC following the discussion on the [BUG] thread.
> >>> Link: https://lore.kernel.org/all/CADtiZd0tWysx5HMCUnOXfSHB7PXAuXg1Mh4eY_hUmH29S=sejg@mail.gmail.com/
> >>> ---
> >>>  fs/userfaultfd.c | 4 +---
> >>>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> >>> index bdc84e521..dbfe5b2a0 100644
> >>> --- a/fs/userfaultfd.c
> >>> +++ b/fs/userfaultfd.c
> >>> @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_range(
> >>>  		return -EINVAL;
> >>>  	if (!len)
> >>>  		return -EINVAL;
> >>> -	if (start < mmap_min_addr)
> >>> -		return -EINVAL;
> >>>  	if (start >= task_size)
> >>>  		return -EINVAL;
> >>>  	if (len > task_size - start)
> >>>  		return -EINVAL;
> >>>  	if (start + len <= start)
> >>>  		return -EINVAL;
> >>> -	return 0;
> >>> +	return security_mmap_addr(start);
> >>
> >> Is this introducing an ABI change?
> >>
> >> The old code returned -EINVAL when start was below mmap_min_addr.
> >> The new code calls security_mmap_addr() which returns -EPERM when
> >> the caller lacks CAP_SYS_RAWIO. Existing userspace callers checking
> >> specifically for -EINVAL would see different behavior start is
> >> below mmap_min_addr.
> >
> > You mean API change? :) we don't guarantee ABI for kernel stuff anyway.
> >
>
> Ah no, I meant ABI, I hope :)
>
> The return value of validate_unaligned_range() flows directly back to the
> ioctl() return value, which is visible to userspace. The error code a program
> sees from ioctl(fd, UFFDIO_REGISTER, ...) changes from -EINVAL to -EPERM for
> the same input, right? Its probably not an issue, but we would need to update
> https://man7.org/linux/man-pages/man2/ioctl_userfaultfd.2.html
> right?

Ah right I see, yeah just a doc change then :)

Cheers, Lorenzo

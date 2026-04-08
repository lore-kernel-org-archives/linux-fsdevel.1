Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D87245005
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651834; cv=none; b=D7cdpPO1GBrjJVVgVe5YTUH9XhLQmGVUIYC8M+WSss3orKgvHuBwwbJYZ92ozD+bWg4dFHE1qDwRjtYRnuyEFr0LT1CxTzkubsa064k83Bf6dRC3lOG011EXg4xMPQawYaiio6Jxh9bWESe0/pmumEJ27lIppfFhTW2cLIyi9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651834; c=relaxed/simple;
	bh=NLwi39iG6x+4DNei3a8leGjXiKw3I9Rzak2FVdeN0d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAq2llzu7PVe0InffxAOmUNJyi6WU40tiM1dQSQua4hliMDOIuhHTiMF8lH8e+cvsHlCIdMuYtWZukvw5O7t5/5BtY8xT7VSs00vQLEF3/nlViGOpHlYbcmYUn7XW5bqvN/7oj83zc+Ws8BzkZZkdeqfSPDLt6toVHh5AmDT+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LojMvni9; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LojMvni9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775651830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7ozxszcWAzUiiO7dnD+2XLganhUT/yvfmOrIFi0J4o=;
	b=LojMvni9LRcUFivfS2//FW6d4oquvN57vihlfqSaUW5XqAUIYTV/zoRXKgzs+sk1dtwBY3
	45254wkgwY7gkR/4eSAIZrf9nWHh+UlKN3vMXpTdOgS0uMkyQqYBaMlvMVPfi/FCBpSrnq
	j6fbEfOSQU7/VVrzdgvjzRlJd3kGoWM=
From: Usama Arif <usama.arif@linux.dev>
To: "Denis M. Karpov" <komlomal@gmail.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below mmap_min_addr
Date: Wed,  8 Apr 2026 05:36:59 -0700
Message-ID: <20260408123700.1596800-1-usama.arif@linux.dev>
In-Reply-To: <20260407081442.6256-1-komlomal@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue,  7 Apr 2026 11:14:42 +0300 "Denis M. Karpov" <komlomal@gmail.com> wrote:

> The current implementation of validate_range() in fs/userfaultfd.c
> performs a hard check against mmap_min_addr without considering
> capabilities, but the mmap() syscall uses security_mmap_addr()
> which allows privileged processes (with CAP_SYS_RAWIO) to map below
> mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
> dac_mmap_min_addr variable which can be changed with
> /proc/sys/vm/mmap_min_addr.
> 
> Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
> with -EINVAL for valid memory areas that were successfully mapped
> below mmap_min_addr even with appropriate capabilities.
> 
> This prevents apps like binary compilers from using UFFD for valid memory
> regions mapped by application.
> 
> Replace the rigid mmap_min_addr check with security_mmap_addr() to align
> userfaultfd with the standard kernel memory mapping security policy.
> 
> Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> 
> ---
> Initial RFC following the discussion on the [BUG] thread.
> Link: https://lore.kernel.org/all/CADtiZd0tWysx5HMCUnOXfSHB7PXAuXg1Mh4eY_hUmH29S=sejg@mail.gmail.com/
> ---
>  fs/userfaultfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index bdc84e521..dbfe5b2a0 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_range(
>  		return -EINVAL;
>  	if (!len)
>  		return -EINVAL;
> -	if (start < mmap_min_addr)
> -		return -EINVAL;
>  	if (start >= task_size)
>  		return -EINVAL;
>  	if (len > task_size - start)
>  		return -EINVAL;
>  	if (start + len <= start)
>  		return -EINVAL;
> -	return 0;
> +	return security_mmap_addr(start);

Is this introducing an ABI change?

The old code returned -EINVAL when start was below mmap_min_addr.
The new code calls security_mmap_addr() which returns -EPERM when
the caller lacks CAP_SYS_RAWIO. Existing userspace callers checking
specifically for -EINVAL would see different behavior start is
below mmap_min_addr.

>  }
>  
>  static __always_inline int validate_range(struct mm_struct *mm,
> -- 
> 2.47.3
> 
> 

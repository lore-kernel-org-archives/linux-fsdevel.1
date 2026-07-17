Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBC2DF13A;
	Fri, 17 Jul 2026 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285214; cv=none; b=WETHhmgTv8INNksdym7n9bklOK5J3re/Sxmaw9/2bJho77D2QOIc4S4arGer2UfZNi7DXpo+ktMp26oUkUEooG/Lj0bI21leq+TTs4EZZnz5v19B/tcBkio0ZTDD2zRUHW2der84MuS2xM3svUKHzF+RUb4U7mw8w734gGs5JOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285214; c=relaxed/simple;
	bh=CIQg1p69wkbqKNHwGP78SGGMMpbznLsqUCdm42Z4f7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jtx4iY0pSqem8DZe1jrb6d05i99mtlfp1LTIxlKx7DUQ+2d6ZmPQR6kwe3R/HzssJMPhWQgI6oicDNE8VM0QZxHgVUZc001z7NnaRbz+GQHSNvQv6r0bhX5YHePgJPnTWCoQCWYRbL9XJoLmUTWbLelJ0c5ufsX3NwmTjx+gMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzkUquUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzkUquUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B27C1F000E9;
	Fri, 17 Jul 2026 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285213;
	bh=3H4YLFiWf6/et6CXjfq0ULsNF5gxpRV9YLwLUMKI6wQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hzkUquUHODHWzH8JpKjAUClJJpSoP2sxVLRw9lRKpXDE8aev3+TxKlI+vMvW0QWul
	 L89qf7kK+KUSZ/2CPyeHYehcd62RbBWdUu9PB1AZ6zS6fZt3AZwjRPOMzKrbd5uzlc
	 jLXCChY7qhZEHgfFtw2bqKisOGKE5b1V6055GqxzSZ2n/NfRnzv0z1yDat0/lILAw8
	 uN3HU6gVTgF6EHoyv1xSxgZ9VZb/PM0NbRuu34jGywpvBSL3sniln6rKtfLWCli0S7
	 fqO4uAmOtGS1lTZxW5hZZfx9u4pMU3fRV5d+wzQU9GZonew+7oDD8as7UDkDUAzgWZ
	 /wpT+AHMmI2zw==
Message-ID: <c1fa877e-de9d-4d85-9d2b-6971f0cbd7ff@kernel.org>
Date: Fri, 17 Jul 2026 11:46:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/mseal: limit scope of mseal address zero to
 address zero
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/26 15:43, Lorenzo Stoakes (ARM) wrote:
> Commit 44f65d900698 ("binfmt_elf: mseal address zero") unconditionally
> provided do_mseal() to any internal kernel caller in order to address a
> corner case slated for possible removal.
> 
> It also incorrectly attempts to mseal() without checking to see whether the
> mapping even succeeded.
> 
> Restrict the scope to the corner case by providing mseal_mmap_page_zero()
> which asserts the MMAP_PAGE_ZERO personality.
> 
> Avoid unnecessary checks in the start, end range by abstracting the actual
> mseal()'ing to mseal() and have mseal_mmap_page_zero() call that instead.
> 
> Only try to seal the VMA if we mapped the VMA.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  fs/binfmt_elf.c    |  7 ++-----
>  include/linux/mm.h |  8 ++------
>  mm/mseal.c         | 48 +++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 16a56b6b3f6c..e3131a311995 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1353,11 +1353,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>  		   emulate the SVr4 behavior. Sigh. */
>  		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
>  				MAP_FIXED | MAP_PRIVATE, 0);
> -
> -		retval = do_mseal(0, PAGE_SIZE, 0);
> -		if (retval)
> -			pr_warn_ratelimited("pid=%d, couldn't seal address 0, ret=%d.\n",
> -					    task_pid_nr(current), retval);
> +		if (!error)
> +			mseal_mmap_page_zero();
>  	}
>  
>  	regs = current_pt_regs();
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 550fb92957d1..87feaa5a2b78 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -5291,13 +5291,9 @@ int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *
>  int reserve_mem_release_by_name(const char *name);
>  
>  #ifdef CONFIG_64BIT
> -int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
> +void mseal_mmap_page_zero(void);

do_mseal() gone here, nice.

>  #else
> -static inline int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
> -{
> -	/* noop on 32 bit */
> -	return 0;
> -}
> +static inline void mseal_mmap_page_zero(void) {}
>  #endif
>  
>  /*
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 207fea89c61e..5930551d84f2 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -32,7 +32,7 @@ static bool range_contains_unmapped(unsigned long start, unsigned long end)
>  	return prev_end < end;
>  }
>  
> -static int mseal_apply(unsigned long start, unsigned long end)
> +static int __mseal(unsigned long start, unsigned long end)
>  {
>  	struct vm_area_struct *vma, *prev;
>  	VMA_ITERATOR(vmi, current->mm, start);
> @@ -66,6 +66,38 @@ static int mseal_apply(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +static int mseal(unsigned long start, unsigned long end)

mseal_range() could be indeed nicer. But do_mseal() is now a pure helper for
"SYSCALL_DEFINE3(mseal" only ...could we simply inline do_mseal into
SYSCALL_DEFINE3(mseal)?

We could do that separately, ofc.

-- 
Cheers,

David

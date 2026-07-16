Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7F424669
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214389; cv=none; b=b8qQSa5zgQqgQTJkZBSfX3PbVSe/P/TZmjRlhHgIoas6I3LnZjdn9lT7MufK1BymBrsytxW8J5ViVv2psvg39Yg9iMVJuRiGoqI5/B7tzwCDrKIpQ610POqi+MArWUDu0mJPjBjNiL6Nt6KHRPG4HPjTt20v/PmKWGHWnWie2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214389; c=relaxed/simple;
	bh=3qUYq4JFy7t3/9oYZSIq7OETDd/Y3NV9/P8/y0y6h6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+pZi+yl19Fi6MXBdgpqwM9eTCUcW6qr0BZcTsMyr1Z6qnzXY9YEv2R0x+0S3KyJ2Mt4XOyuchp7X3OCTDsCS9H3nlxd+Tadd9RNCK7xXuu4jZB7Pp+aINxw/P/ZA/z4i+ZQj7W+twiqVq14vZgtI0gk+U69NB4ZsEYgez87nSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ikMIH4Ic; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MNxsDl/3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vp74B/0y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ko63zMhl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ikMIH4Ic";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MNxsDl/3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vp74B/0y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ko63zMhl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBD4D3E2F;
	Thu, 16 Jul 2026 15:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784214384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HujAVb6RxLv5hlDKjw4a52J9PZBMkT3MwEYBIBN7m8g=;
	b=ikMIH4IcJlUgiCWe6Ktqow1P47x4dTtfrGnNl57lvOAK14l/CccNBlYLznxl4hfWYYdWU/
	buiXPf9ZKxqb3EUJMU9e7DOmYW6LavsklXFMbVpM6aF4tiJx6f83Ml7v6jFbemqGmxVauj
	iTGZ/WmvYNux3CAAD/aR1uyq5xFyz2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784214384;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HujAVb6RxLv5hlDKjw4a52J9PZBMkT3MwEYBIBN7m8g=;
	b=MNxsDl/3q0Y0Mvld+ztegXhsQVycpelLl0EwVsI+5AP1FCgVle9Q9l7LdsSzcGp4SySBdJ
	kSK+w28+S0TbmGBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Vp74B/0y";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ko63zMhl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784214382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HujAVb6RxLv5hlDKjw4a52J9PZBMkT3MwEYBIBN7m8g=;
	b=Vp74B/0yTUhb5X27/u9G11wU+b2wXaxylCbXAg3OB7INHoy1pRLTVizpxnnddzeEw45O0m
	ghLhBGMGQC4l83VQFQK0WlJQplysJaKdxHrkvHAORbkJ34U07ckZ9dR1f0geqgUjmGwjmY
	a+vfRUKBjCNFHpoJk+WiGf1+xlDTNu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784214382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HujAVb6RxLv5hlDKjw4a52J9PZBMkT3MwEYBIBN7m8g=;
	b=ko63zMhle94/EcBCSuJjv6zUQFuaUI9Jg9G7vfuB0cZBKO9uG3Z5J16psxiUwR6Z9ZW4i/
	fIG9aQXP489gU+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6653779AD;
	Thu, 16 Jul 2026 15:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tcMhMW3zWGpmaAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 16 Jul 2026 15:06:21 +0000
Date: Thu, 16 Jul 2026 16:06:20 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/mseal: limit scope of mseal address zero to
 address zero
Message-ID: <aljyYdgzRZW1kIhs@pedro-suse.lan>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EBD4D3E2F
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,pedro-suse.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Jul 16, 2026 at 02:43:10PM +0100, Lorenzo Stoakes (ARM) wrote:
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

I think pedantically load_elf_binary() should error out on mmap error, no?
Not that this personality is used in the big 2026 however...

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

Why? I think the previous name is perfectly cromulent.

>  {
>  	struct vm_area_struct *vma, *prev;
>  	VMA_ITERATOR(vmi, current->mm, start);
> @@ -66,6 +66,38 @@ static int mseal_apply(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +static int mseal(unsigned long start, unsigned long end)

I don't like that you go start - end on a function called "mseal". The actual
system call goes start - len. It just looks confusing :) So either rename it
to mseal_range(), or make it take a start, length pair.

The overall spirit of the change LGTM however. 

-- 
Pedro

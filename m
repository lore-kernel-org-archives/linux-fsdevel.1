Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E87C3A383B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072050; cv=none; b=L/3zBk+eSK89TUkhb5NwO63gds3QA4hIBgsfmo4vtbYkcVlypmHUj6MFeXZmkjQE0NEHLUGSl5QQi8CIrKF/f6FwiKKflH6fJGmx/l8kgQfG3r6NZBGdDTXEz2QzF+LMy5bm/Nl1261CwPfFctr89KWx+x0xNI/GSKHrKLTsWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072050; c=relaxed/simple;
	bh=af4SC7gxF5ARH29qhYGCZcdnSlcflSKZH1a5iNzXRoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J65v6WlMbQOOLUymMwQSI25kASOheMky7GAxTEq2rqMEelavPvGK4BYlhOzQyn2QUzM5pHHXigFRbvcjpviCc/1EkiKzAUmdIiqvPQbB47hlmuq8bGqFGCmYM6XJOcni7VjoodZdRaif+goIpabNBLCoAeMJKlEXpbOlpzZlBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RRto1dxF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=21PrhNQO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RRto1dxF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=21PrhNQO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RRto1dxF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="21PrhNQO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RRto1dxF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="21PrhNQO"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57BCC6A8F9;
	Mon, 13 Apr 2026 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776072047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IvMuYDV/SvreVKJmRPiqeUuqZL90QVQqicE/blnlBr8=;
	b=RRto1dxF17Nnwbbe84dyGPy+SSA1ILXqsMlKBggm/LmgQtugiLIbezV1pKgRUHURq8saJa
	NSh7T/UvP9UOhBEjMSmxhAhZH+1J7+A7myJIRxIuQUsOGuVAq//iuvFzk9JBLG0035XJtw
	dT4VkrOKgArs9VGsOyy+FvIplj1l6/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776072047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IvMuYDV/SvreVKJmRPiqeUuqZL90QVQqicE/blnlBr8=;
	b=21PrhNQOfug0n0XY2YdkV4yP5V/DnPAYowlAYevwmYSoVg6k3MzWtNctVg8xZJY/XLPbM0
	jYqTJS4l3BeADXAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RRto1dxF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=21PrhNQO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776072047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IvMuYDV/SvreVKJmRPiqeUuqZL90QVQqicE/blnlBr8=;
	b=RRto1dxF17Nnwbbe84dyGPy+SSA1ILXqsMlKBggm/LmgQtugiLIbezV1pKgRUHURq8saJa
	NSh7T/UvP9UOhBEjMSmxhAhZH+1J7+A7myJIRxIuQUsOGuVAq//iuvFzk9JBLG0035XJtw
	dT4VkrOKgArs9VGsOyy+FvIplj1l6/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776072047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IvMuYDV/SvreVKJmRPiqeUuqZL90QVQqicE/blnlBr8=;
	b=21PrhNQOfug0n0XY2YdkV4yP5V/DnPAYowlAYevwmYSoVg6k3MzWtNctVg8xZJY/XLPbM0
	jYqTJS4l3BeADXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D9604ADED;
	Mon, 13 Apr 2026 09:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3V/vEm+13GkxSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Apr 2026 09:20:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0A735A0AFF; Mon, 13 Apr 2026 11:20:43 +0200 (CEST)
Date: Mon, 13 Apr 2026 11:20:43 +0200
From: Jan Kara <jack@suse.cz>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.com, brauner@kernel.org, 
	bcrl@kvack.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
	linux-kernel@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs: aio: set VMA_DONTCOPY_BIT in mmap to fix
 NULL-pointer-dereference error
Message-ID: <rv7yz6zjyfv66u7yncwuzhxe4ov7om3uhkbndqvxy7avn5tjuk@f4b3pxx5blxh>
References: <20260413010814.548568-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413010814.548568-1-wozizhi@huawei.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 57BCC6A8F9
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21
X-Spam-Level: 

On Mon 13-04-26 09:08:14, Zizhi Wo wrote:
> [BUG]
> Recently, our internal syzkaller testing uncovered a null pointer
> dereference issue:
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> [   51.111664]  filemap_read_folio+0x25/0xe0
> [   51.112410]  filemap_fault+0xad7/0x1250
> [   51.113112]  __do_fault+0x4b/0x460
> [   51.113699]  do_pte_missing+0x5bc/0x1db0
> [   51.114250]  ? __pte_offset_map+0x23/0x170
> [   51.114822]  __handle_mm_fault+0x9f8/0x1680
> [   51.115408]  handle_mm_fault+0x24c/0x570
> [   51.115958]  do_user_addr_fault+0x226/0xa50
> ...
> Crash analysis showed the file involved was an AIO ring file.
> 
> [CAUSE]
> 	PARENT process		CHILD process
> t=0	io_setup(1, &ctx)
> 	[access ctx addr]
> 	fork()
> 	io_destroy
> 	  vm_munmap // not affect child vma
> 	  percpu_ref_put
> 	  ...
> 	    put_aio_ring_file
> t=1				[access ctx addr]	// pagefault
> 				...
> 				  __do_fault
> 				    filemap_fault
> 				      max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE)
> t=2	      truncate_setsize
> 	        truncate_pagecache
> t=3				      filemap_get_folio	// no folio, create folio
> 				      __filemap_get_folio(..., FGP_CREAT, ...)	// page_not_uptodate
> 				      filemap_read_folio(file, mapping->a_ops->read_folio, folio) // oops!
> 
> At t=0, the parent process calls io_setup and then fork. The child process
> gets its own VMA but without any PTEs. The parent then calls io_destroy.
> Before i_size is truncated to 0, at t=1 the child process accesses this AIO
> ctx address and triggers a pagefault. After the max_idx check passes, at
> t=2 the parent calls truncate_setsize and truncate_pagecache. At t=3 the
> child fails to obtain the folio, falls into the "page_not_uptodate" path,
> and hits this problem because AIO does not implement "read_folio".
> 
> [Fix]
> Fix this by marking the AIO ring buffer VMA with VM_DONTCOPY so
> that fork()'s dup_mmap() skips it entirely. This is the correct
> semantic because:
> 
> 1) The child's ioctx_table is already reset to NULL by mm_init_aio() during
> fork(), so the child has no AIO context and no way to perform any AIO
> operations on this mapping.
> 2) The AIO ring VMA is only meaningful in conjunction with its associated
> kioctx, which is never inherited across fork(). So child process with no
> AIO context has no legitimate reason to access the ring buffer. Delivering
> SIGSEGV on such an erroneous access is preferable to a kernel crash.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>

Thanks for the fix! I agree it would have to be a rather contrived setup to
rely on AIO ringbuffer being inherited by fork(2) for the reasons you
mention above. Plus I think AIO ringbuffer is mostly a legacy thing these
days with people moving towards io_uring so the simpler we can make the
code the better. So I'm OK with trying this simple fix and seeing whether
somebody complains. Let me add Jens to CC just in case he's aware of a
situation where this could be problematic.  Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 4fe163b8bf67..74e0e40b9636 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -397,11 +397,11 @@ static const struct vm_operations_struct aio_ring_vm_ops = {
>  #endif
>  };
>  
>  static int aio_ring_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT);
> +	vma_desc_set_flags(desc, VMA_DONTEXPAND_BIT, VMA_DONTCOPY_BIT);
>  	desc->vm_ops = &aio_ring_vm_ops;
>  	return 0;
>  }
>  
>  static const struct file_operations aio_ring_fops = {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313677;
	b=cFAqbD5Gpcgzo2+u29z7edcvRi3Cd95B1Z7psnqB0W/ApRqmOUFTaQy8UMG5xuWNC9p8
	 XHFs1g+0irkchulBUSRN88/9i7d0+j5wTIq5ZXPauZ8E62dHnewNG50L724glIBU16pY1
	 W8jgpXww1paNSC+3cK3oXW3k2vqrj0jURzUB2rFJs9c8klqoWz0m/DWORMLndCjfSiLlM
	 jPsROHAH/6fTQcuLkMTtgmYQl1qT1Lpsi3rWRdKHmeu3sA4S2M5kY7rMCJrS82vMts2Yi
	 v0A926uMjLponcmwX8Pi8CbqpAwbT3/0z6DnVq9QIZ0fxbdZ1YkeWjwK0Mc8613iDSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313677;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=ODg2UFDqxMR4SMBKAdSOXIf/FKBdj9ahq9IsfjbokI0=;
	b=jb1kyYCZtWmogq6tlOtF9A37aGV1cg5IVs8epzxzbywy0DTqwmWOgd4CYRmDcCZVdksA
	 fC37E+t9/wC0g4MVbOW+SCOeyUKnQmezV8wst+P+SW/kw5KUY+4znDg1QJre3oy1x7zsr
	 dwk7lDo8KbCeAlXh5pjf8DLbNF7Tbm+TKcuiy3Y2CT0EG+9sKpFv1vOL5eoBSTnw/4Xvj
	 JxDNuezTMfpov9q/7Qrthasp/BfrnfEVertv70FNqPh9S1Mfm9mOXgGo9s38sMIU3p1GW
	 Ye2wYdjzt1BHGHiz7hKd5lThaolFd5uIMlPgnlB13WE9pl8QY8bYJAyO1ndFln2mXuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cleAenUy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ICAGaDTX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tbbT67pL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="nKlZx/FD";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F112606A31C;
	Tue, 10 Nov 2026 12:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F112606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cleAenUy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ICAGaDTX;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tbbT67pL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nKlZx/FD
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37BE61F461;
	Tue, 10 Nov 2026 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794313675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODg2UFDqxMR4SMBKAdSOXIf/FKBdj9ahq9IsfjbokI0=;
	b=cleAenUyu82p7GD2IkbdhyP20bEeHiv9MCWGsm0Aiv/f8LEImD1EvWdBTTdO9JhtisjXHR
	ExxdXPXAeV8I+EnWyEpZiiorURtwH2Wm4odZQtTfPPreXAa67LmxZ1HmvN9E3BM7QNtDcU
	4KeMJBseUJizkUTYAQLMFuz3T3EOtBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794313675;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODg2UFDqxMR4SMBKAdSOXIf/FKBdj9ahq9IsfjbokI0=;
	b=ICAGaDTXmuJrmJVNM+1/WwP4pezIcgwixY/McCKZSI7w0N2Fyl80B71aqLiIo0zpyBKBbr
	jXzswycp8CRKgmDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794313674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODg2UFDqxMR4SMBKAdSOXIf/FKBdj9ahq9IsfjbokI0=;
	b=tbbT67pLRwGjbhPH67eiBvLFjHHgj9x2wstTb9NBa9OaUxb37D7EZAkGnDI14lQO6x7v5E
	fyUNB0q5BkqRx+7qHhfpoALjnq2e6piJEK/U+4PaTMI1QhVIgyyPNKVx/yJNRXaq9+In+Z
	FgKHeymPfWh+iDjotDpzeRlK2dmWcko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794313674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ODg2UFDqxMR4SMBKAdSOXIf/FKBdj9ahq9IsfjbokI0=;
	b=nKlZx/FDPCcSP2B+uAAFIXqbyoTZqWoQrwC//XF2bdGeUsQy78M9To25spcjkF10avjXfa
	d4YharWvNjkfutDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05DAC1339F;
	Tue, 10 Nov 2026 12:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h7E8M8kN82oVJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 12:27:54 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7C0D2224C5; Tue, 10 Nov 2026 13:27:53 +0100 (CET)
Date: Tue, 10 Nov 2026 13:27:53 +0100
From: Jan Kara <jack@suse.cz>
To: Andrea Righi <arighi@nvidia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Quan Liu <qualiu@nvidia.com>, 
	Lee Trager <ltrager@nvidia.com>, Seth Forshee <sforshee@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] pipe: Prefer mempolicy node for metadata allocations
Message-ID: <hbkxlhc5y2jkvuov5o2kjgpisx2pavuo3ad4c4ydixeic7vaq6@mpzzfmhjvtof>
References: <20261110065219.894219-1-arighi@nvidia.com>
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
In-Reply-To: <20261110065219.894219-1-arighi@nvidia.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,nvidia.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

On Tue 10-11-26 07:52:19, Andrea Righi wrote:
> Generic slab allocations can reuse partial slabs from another NUMA node,
> even when a pipe workload is bound to one node. Pipe metadata is shared
> between senders and receivers and accessed throughout the pipe lifetime.
> Reusing remote metadata can therefore make an IPC workload pay remote
> access and coherence costs on every exchange.
> 
> The target use case is a workload that binds its workers and memory to
> one NUMA node with numactl. The policy node is then a useful placement
> hint for shared pipe metadata.
> 
> Allocate pipe_inode_info and its descriptor array on the node selected
> by the caller's memory policy. Apply the same preference when replacing
> slab-sized descriptor arrays during ring resizing. An explicit node lets
> SLUB try local allocations before reusing remote partial slabs.
> 
> For descriptor arrays larger than KMALLOC_MAX_CACHE_SIZE, pass
> NUMA_NO_NODE to keep the policy-aware page allocation path. An explicit
> node would otherwise lose the MPOL_BIND nodemask on fallback. Select the
> policy node only for slab-sized arrays, avoiding an extra advance of an
> interleave policy for large allocations.
> 
> Moving a pipe's users to another node doesn't migrate its existing
> metadata, so migration can still result in remote accesses regardless of
> this change. Generic allocations may reuse remote partial slabs, making
> initial placement dependent on allocator state. In contrast, preferring
> the policy node leverages the workload's placement hint to improve
> locality when users remain on the intended node.
> 
> Testing has been performed on a dual-socket NVIDIA Vera system, covering
> hackbench, pipe transfers, pipe creation and resizing, pipe_bench, and
> targeted stress tests.
> 
> The primary hackbench reproducer is:
> 
>   $ numactl --physcpubind=0-87 --membind=0 \
>       hackbench -P -p -g 10 -f 20 -s 100 -l 100000
> 
> Results (over 10 measured runs per case):
> 
>               avg       stdev
>    before     9.811s    0.130s
>    after      5.770s    0.058s
> 
> Before this change, allocations could reuse remote pipe metadata. With
> this change, both pipe objects and descriptor arrays are allocated on
> the requested node, improving locality and reducing hackbench runtime by
> approximately 41%.
> 
> Reported-by: Quan Liu <qualiu@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

To me this makes sense so feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

But IMHO it deserves a look from MM guys since this is more of an MM thing
than a filesystem one... Added to CC.

								Honza

> ---
>  fs/pipe.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 4fa69192e6fba..2a8f9e9f70f84 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -24,6 +24,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/fcntl.h>
>  #include <linux/memcontrol.h>
> +#include <linux/mempolicy.h>
>  #include <linux/watch_queue.h>
>  #include <linux/sysctl.h>
>  #include <linux/sort.h>
> @@ -874,6 +875,16 @@ bool pipe_is_unprivileged_user(void)
>  	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
>  }
>  
> +/* Prefer the policy node over remote partial slabs, retaining fallback. */
> +static int pipe_slab_node(void)
> +{
> +#ifdef CONFIG_NUMA
> +	return mempolicy_slab_node();
> +#else
> +	return NUMA_NO_NODE;
> +#endif
> +}
> +
>  struct pipe_inode_info *alloc_pipe_info(void)
>  {
>  	struct pipe_inode_info *pipe;
> @@ -881,8 +892,9 @@ struct pipe_inode_info *alloc_pipe_info(void)
>  	struct user_struct *user = get_current_user();
>  	unsigned long user_bufs;
>  	unsigned int max_size = READ_ONCE(pipe_max_size);
> +	int node = pipe_slab_node();
>  
> -	pipe = kzalloc_obj(struct pipe_inode_info, GFP_KERNEL_ACCOUNT);
> +	pipe = kzalloc_node(sizeof(*pipe), GFP_KERNEL_ACCOUNT, node);
>  	if (pipe == NULL)
>  		goto out_free_uid;
>  
> @@ -899,8 +911,8 @@ struct pipe_inode_info *alloc_pipe_info(void)
>  	if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user())
>  		goto out_revert_acct;
>  
> -	pipe->bufs = kzalloc_objs(struct pipe_buffer, pipe_bufs,
> -				  GFP_KERNEL_ACCOUNT);
> +	pipe->bufs = kcalloc_node(pipe_bufs, sizeof(*pipe->bufs),
> +				  GFP_KERNEL_ACCOUNT, node);
>  
>  	if (pipe->bufs) {
>  		init_waitqueue_head(&pipe->rd_wait);
> @@ -1375,12 +1387,18 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
>  {
>  	struct pipe_buffer *bufs;
>  	unsigned int head, tail, mask, n;
> +	int node = NUMA_NO_NODE;
>  
>  	/* nr_slots larger than limits of pipe->{head,tail} */
>  	if (unlikely(nr_slots > (pipe_index_t)-1u))
>  		return -EINVAL;
>  
> -	bufs = kzalloc_objs(*bufs, nr_slots, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	/* Keep the policy nodemask for allocations that bypass slab caches. */
> +	if (nr_slots <= KMALLOC_MAX_CACHE_SIZE / sizeof(*bufs))
> +		node = pipe_slab_node();
> +
> +	bufs = kcalloc_node(nr_slots, sizeof(*bufs),
> +			    GFP_KERNEL_ACCOUNT | __GFP_NOWARN, node);
>  	if (unlikely(!bufs))
>  		return -ENOMEM;
>  
> -- 
> 2.56.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

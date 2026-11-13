Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567319;
	b=HMZWKhz1hFsOOn1d80xECJvyylAVE0nsKKVQO8kIaNFkEz2mQ1tIsmjZ4sibpFelbgyO
	 6uW6xGYSYmFVgaL93ZlV5UdkFIKG5gBaO4WtPTzg43bsHLBzTIBX/X++SSeBkRkanZptV
	 to0Owblewmf2m1vpR285wZOh24HToD2aIEmpHGHYyk8LhQwciLZ1XtY7phQRQQskZP/iw
	 3UJhVVNpGk7Tqa3NIC3LZppCU4l0WqvQSVh2vLRf/ERT1X1nNeY8f2jQsA2ukgyt93yKa
	 bndxrWL1kcRzOu2LhyOa10pnE/6RB5KFWIrZGF4O98QlkqR9tOTZVgD/RClpQ8W/InQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567319;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=oBrh96JneCB85QRwSH0ue44D5aaTmYW0dbY0hlT+9E0=;
	b=Gc6cTQ8s4+2TUCw39pWVDjvGhmRtJhrHoujg3SLhURKvLsb7lRio5us4kE0McFF7ZLT7
	 wP/ZnEad5QnVkHTHHT6OF02sqNN1TMvHlWbm53DqPbfJLPG0uVlU4z2JlFCY5dtY/9hYk
	 gnYJHn01PN8xXg0xIqB6ymoLZm2H9vNhS9R+dRy2EmBA+YR0HGp43FUJ4FqV2OnztL43i
	 hRacdrYoki8os1c2FhPPbmOqRDkGiA1AeR3/GvncAiIUMjQdbEeEby6aumiuRwR3420NM
	 I1jx3rg6qdpviyVidik3C66+isaDqeQOhmpFdPAGAIfGiriLpc9Bct4vkzqI3ZkQeIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=umgMFbRV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="TlBq/+CO";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=umgMFbRV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="TlBq/+CO";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028F606BDAF;
	Fri, 13 Nov 2026 10:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1028F606BDAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=umgMFbRV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TlBq/+CO;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=umgMFbRV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TlBq/+CO
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F3351F88E;
	Fri, 13 Nov 2026 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794567317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBrh96JneCB85QRwSH0ue44D5aaTmYW0dbY0hlT+9E0=;
	b=umgMFbRVOQPm7ehXwpvWXZpEFAs863cWC/2ZQwGrgu0F7Vcaar4nmsQ5kvPZk7l7K5rw/A
	yRxIm/BZccK4dRlCtO565LhfAab2lGF0Y4kvjIQ66bDesY1sioh5A3u0Bd9Z5X5mUzTXMu
	fDm/Ha4bbSr8PEme402AnjzFpzuBHB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794567317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBrh96JneCB85QRwSH0ue44D5aaTmYW0dbY0hlT+9E0=;
	b=TlBq/+COzaMY0uiXRfDSQGdNPyu/YjLzQKM37Jd2LmZKy0L85wS+kQxNPWDodjKFJhXiOE
	+XLddAk3tkl9C0Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794567317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBrh96JneCB85QRwSH0ue44D5aaTmYW0dbY0hlT+9E0=;
	b=umgMFbRVOQPm7ehXwpvWXZpEFAs863cWC/2ZQwGrgu0F7Vcaar4nmsQ5kvPZk7l7K5rw/A
	yRxIm/BZccK4dRlCtO565LhfAab2lGF0Y4kvjIQ66bDesY1sioh5A3u0Bd9Z5X5mUzTXMu
	fDm/Ha4bbSr8PEme402AnjzFpzuBHB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794567317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBrh96JneCB85QRwSH0ue44D5aaTmYW0dbY0hlT+9E0=;
	b=TlBq/+COzaMY0uiXRfDSQGdNPyu/YjLzQKM37Jd2LmZKy0L85wS+kQxNPWDodjKFJhXiOE
	+XLddAk3tkl9C0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA095134C3;
	Fri, 13 Nov 2026 10:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SbO5K5Ts9mpIHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 10:55:16 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 67FD522C8E; Fri, 13 Nov 2026 11:55:08 +0100 (CET)
Date: Fri, 13 Nov 2026 11:55:08 +0100
From: Jan Kara <jack@suse.cz>
To: Gopal Malaviya <gopalmalaviya53@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.raghav@samsung.com
Subject: Re: [PATCH] mm/readahead: don't skip the fallback after aligning
 index down
Message-ID: <ks3uy5pvacectdtlbqnz2bmchocfw2atkx6cvvfrjxsx47i4qe@rhnp4qu3ayhs>
References: <20261113072711.235264-1-gopalmalaviya53@gmail.com>
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
In-Reply-To: <20261113072711.235264-1-gopalmalaviya53@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80

On Fri 13-11-26 07:27:11, Gopal Malaviya wrote:
> page_cache_ra_order() rounds the start of the readahead window down to
> the minimum folio size of the mapping, so on a file system with blocks
> larger than the page size, index can end up below start. If adding the
> first folio then fails, for example with -EEXIST because that folio is
> already cached, the loop stops with index still below start, and the
> check before the fallback
> 
> 	if (ra->size > index - start)
> 
> wraps around, so do_page_cache_ra() is not called and nothing of the
> window is read.
> 
> For example, with read_ahead_kb 128 and 16 KiB blocks, the mmap
> read-around window for a fault on page 1042 starts at page 1026, index
> becomes 1024, and if pages 1024-1027 are cached, pages 1028-1057 are
> not read ahead.
> 
> Compare with the end of the window instead. Where index is not below
> start, this is the same check and the same number of pages as before.
> 
> Tested in a KVM guest (x86_64, 2 vCPUs, 3 GiB) on mm-hotfixes-unstable,
> with XFS with 16 KiB blocks and with ext4 on virtio-blk, read_ahead_kb
> 128. A test caches page 1026 of a file with pread() on a
> POSIX_FADV_RANDOM descriptor, then faults page 1042 through a mapping,
> and counts the cached pages of the window [1026, 1058) with mincore():
> 
>                                        before   after
>   XFS, 16 KiB blocks                      6       32
>   XFS, 16 KiB blocks, nothing cached     32       32
>   ext4                                   32       32
> 
> Tracing shows the fallback now running after the -EEXIST, as
> page_cache_ra_unbounded with index=1024 and nr_to_read=34.
> 
> Touching 1% of the pages of a cold 20 GiB file on XFS with 16 KiB
> blocks, at random, at a stride of 2053 pages, or as random runs of 2
> or 4 adjacent pages, reads the same amount before and after, within
> 5% over two runs each, at read_ahead_kb 128 and 8192.
> 
> Not tested: other block sizes, other file systems with large blocks,
> and other architectures (built for i386 only).
> 
> The problem was pointed out by the Sashiko AI review of an unrelated
> patch [1]. An AI assistant (Claude) helped with the analysis and the
> test, and drafted this changelog. I reviewed, implemented, built and
> tested the change.
> 
> [1] https://sashiko.dev/#/bug/linux-da6e8836-f808-4b39-9f04-de52995a0162
> 
> Fixes: d5ea5e5e50df ("readahead: properly shorten readahead when falling back to do_page_cache_ra()")
> Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/readahead.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6e55632902..afcde18316 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -552,10 +552,12 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  fallback:
>  	/*
>  	 * ->readahead() may have updated readahead window size so we have to
> -	 * check there's still something to read.
> +	 * check there's still something to read. Compare with the end of the
> +	 * window, as index may have been rounded down below start to the
> +	 * minimum folio size.
>  	 */
> -	if (ra->size > index - start)
> -		do_page_cache_ra(ractl, ra->size - (index - start),
> +	if (index < start + ra->size)
> +		do_page_cache_ra(ractl, start + ra->size - index,
>  				 ra->async_size);
>  }
>  
> 
> base-commit: 76f5384740b2fd9ee5d71da9d49b271d37c5a51b
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

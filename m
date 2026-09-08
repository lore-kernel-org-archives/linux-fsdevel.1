Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFF517BB1;
	Tue,  8 Sep 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864279; cv=none; b=hlkZRIcClICsods2sbMgzJqmfYdvvjnGt2PkFfP+UrMhr1kuVhX9kXQdoFBXkcksG6ZCqbnM/ctNRHfr896ey1txxbcThBRIl/hbHnISi9DkCQTyB5kMgep7AFsntYGycxevjG0XF0ChGvzTUKra6IIn27IpNZd4zAvxbFBiGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864279; c=relaxed/simple;
	bh=XpSImWaewoCn1f55R3L4P539JyJYo/ssl2r/P73WR/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLjthFTMo/F582vz5/rdpD1OUGhIzPAy0NBkaoiPaHC8orOrUnENinBIe34pgpt399k2XTDdFlyat7N4GCyKuecFtEtiM1kUB+njf4tz8ENI2Cfp8Elo7J0twasGmzjlSJo8qirKgD/Di57PIZ2mLd141xqCMk4loIZw8xNJQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSiL1IfM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CyqD+9my; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YjD3frJG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ucP47Zrk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSiL1IfM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CyqD+9my";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YjD3frJG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ucP47Zrk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 38C4C1F7A9;
	Tue,  8 Sep 2026 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788864268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQs+DsQFU/dCtQEHDb0FxIVZYriY7o9+/DEp95bYnqU=;
	b=WSiL1IfMYyYhjIpCWrWzBWwPSl1l2Zez312DGLoSd24TTL6zfnDdn1Bahknh9snO6MCLpt
	I50cxxKmVzwpDX6Ndv3pjglt7bAKXzEdDiQZlpDBdmgV1SNE7xwgnFZ6smWCS2bHRM4q2q
	Y5WKbSgYoBbne069CEmWgnbE5xbf4z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788864268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQs+DsQFU/dCtQEHDb0FxIVZYriY7o9+/DEp95bYnqU=;
	b=CyqD+9myf+sfv0MP6tinh8iKIX37T6cy7am8Kuu07HF16hVUBpyvITtVq6lhThS/CkrvkN
	v+N4X4+CxGKZ1RAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YjD3frJG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ucP47Zrk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788864264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQs+DsQFU/dCtQEHDb0FxIVZYriY7o9+/DEp95bYnqU=;
	b=YjD3frJGyCzfNz+zfYtAi/XSuslZn1+oofrWNuZNWv59Al32/+Q1gNrnZeUdhNWrkpC82B
	Pb34rlJOzCp7SUQ+4gT0j4xvMxDqORcGrSMi5JTZIMgHA7XAenKoeteGup23B69ehnhf+i
	5HLu9m8K1tazffdM0SA7KcwmLi0c3+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788864264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQs+DsQFU/dCtQEHDb0FxIVZYriY7o9+/DEp95bYnqU=;
	b=ucP47Zrkg0HjmvTtp55e/FQJDxMh0TcHBJKUR2O9UKJkSD9Pmc96tFM3fq7onRZ3XszHFZ
	kPgvClbAkPDOLwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17F111347F;
	Tue,  8 Sep 2026 10:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O9XRBQjnn2onJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Sep 2026 10:44:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8A204A12E2; Tue, 08 Sep 2026 12:44:23 +0200 (CEST)
Date: Tue, 8 Sep 2026 12:44:23 +0200
From: Jan Kara <jack@suse.cz>
To: Xin Yin <yinxin.x@bytedance.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] writeback: size foreign flushes by target wb
 dirty pages
Message-ID: <ehvmfilvbez535uxyxbbqvofo32bglhxpzaekfir4chna4ptrl@tvmig5sf5zcd>
References: <cover.1788836830.git.yinxin.x@bytedance.com>
 <a889bf70370d17fec0731b60cf393d8cc7cf145d.1788836830.git.yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a889bf70370d17fec0731b60cf393d8cc7cf145d.1788836830.git.yinxin.x@bytedance.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 38C4C1F7A9
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 08-09-26 11:23:51, Xin Yin wrote:
> Foreign dirty tracking records the bdi and wb memcg IDs of recently
> dirtied foreign inodes. When the source memcg needs foreign writeback,
> mem_cgroup_flush_foreign() queues WB_REASON_FOREIGN_FLUSH to the
> recorded target bdi_writeback.
> 
> cgroup_writeback_by_id() currently sizes this best-effort work from the
> target memcg's NR_FILE_DIRTY counter. The work is scoped to one target
> wb, so a memcg-wide dirty count can over-size a single-bdi flush when
> the target memcg has dirty pages on other devices. It can also under-size
> the flush when the target wb has dirty pages charged to other memcgs.
> 
> Over-sizing keeps the target wb busy longer and can delay later
> writeback work. Under-sizing can finish before enough pages are written
> back for the source memcg.
> 
> Use the target wb's WB_RECLAIMABLE counter and keep the existing 25%
> headroom. This keeps the budget aligned with the writeback object being
> queued.
> 
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

Yeah, this looks like an obvious win. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 7c75ed7e8979..7c2340a5dead 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1131,7 +1131,7 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  	struct cgroup_subsys_state *memcg_css;
>  	struct bdi_writeback *wb;
>  	struct wb_writeback_work *work;
> -	unsigned long dirty;
> +	long dirty;
>  	int ret;
>  
>  	/* lookup bdi and memcg */
> @@ -1160,16 +1160,13 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  	}
>  
>  	/*
> -	 * The caller is attempting to write out most of
> -	 * the currently dirty pages.  Let's take the current dirty page
> -	 * count and inflate it by 25% which should be large enough to
> -	 * flush out most dirty pages while avoiding getting livelocked by
> -	 * concurrent dirtiers.
> -	 *
> -	 * BTW the memcg stats are flushed periodically and this is best-effort
> -	 * estimation, so some potential error is ok.
> +	 * The caller is attempting to write out most of the target wb's
> +	 * currently dirty pages.  Size the work from the wb's reclaimable pages
> +	 * and inflate the count by 25%, which should be large enough to flush
> +	 * out most dirty pages while avoiding getting livelocked by concurrent
> +	 * dirtiers.
>  	 */
> -	dirty = memcg_page_state(mem_cgroup_from_css(memcg_css), NR_FILE_DIRTY);
> +	dirty = wb_stat_sum(wb, WB_RECLAIMABLE);
>  	dirty = dirty * 10 / 8;
>  
>  	/* issue the writeback work */
> -- 
> 2.20.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

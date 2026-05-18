Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009748035F
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109299; cv=none; b=C5nQNSBkOdKxKsF1XxdAGP6ViRfFNy1a/DPQmFEESxGTGbmR3Xz83tehURwXaU07vNItD2/BleYOnyNN51HVT58K0Zz5Tfm4c1Gt79ojYFReCNaI/Xq+KOgiJ49GxoMBZtRCykA5JwUWir7yJqQVyHNuIUw/N8ycpMiFzLeSHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109299; c=relaxed/simple;
	bh=yBuMak/YfReZohweV+l2yPEO//qqZF9U+Qh6/+ljYgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt5Abpq6FlGkYU1tfKNGfBA5jOWpquyP77L310pzVNH3S/4hMhdqihIrxJhCw4gCB31V59OJSVV2a0gSj6c1PIp1gw2dlhIwwrJrcdHd98h7MIwZ/2evn75N4hh/6faxEunwOCT+Vrr8ZPebyRAjBQya539p2LCgWTDkMvBfCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmcyVqjE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dU1L61d3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uS4rtJIF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ljUxbRe+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmcyVqjE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dU1L61d3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uS4rtJIF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ljUxbRe+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9C906BEF2;
	Mon, 18 May 2026 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779109296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbTcME3uXn8ESWKoTbhpKR+qA/zBC4p21mbaBnNgfhs=;
	b=tmcyVqjEk51KrTq9CDIQeVojcVL9RTiX7J3KeItJ2yBb2vBZUYKlf5I2ibwjQQ/0ZzlFl1
	A9xGXsffwgsscAp07stAw+9nB368ud+8QduzBEsnJg6pb8lK8HqjYEu34rCy5sLLcX8rOY
	icVatlproYs9WUSFn40RRId1Uwh5gKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779109296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbTcME3uXn8ESWKoTbhpKR+qA/zBC4p21mbaBnNgfhs=;
	b=dU1L61d30sbEXxVm9k1/JlGXFJmV/MWc0oK8Mrbbiar0EyKR+qy6fVJ/PpEsIjdw8zkhI6
	70tThiOLeRpiPSBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779109292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbTcME3uXn8ESWKoTbhpKR+qA/zBC4p21mbaBnNgfhs=;
	b=uS4rtJIFFBqm3ILLrcgwzietg9nfY2OUvlo6Ed/7C60D1MvpS8/0Ynn/AiMPvKrL4IvhFI
	NheLfGBX/GkU4OeJG5F6S5JsxZDCpKaPfpcnJ92cgfaIkt/V59sZFYcHfyXhD9WXzvwarF
	p2WohrltPIVkLrFEc7VKVZnKgWRgjN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779109292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbTcME3uXn8ESWKoTbhpKR+qA/zBC4p21mbaBnNgfhs=;
	b=ljUxbRe+iHAPcfGSSUw6wDEEFsjM5OXaggTmvPQaugcpYSTdXECfFyFjOll3jBOaYF1WeJ
	pTOkEUnXohADFOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1B4D593A8;
	Mon, 18 May 2026 13:01:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xYZGL6wNC2qPNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 May 2026 13:01:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D07ABA0A90; Mon, 18 May 2026 15:01:31 +0200 (CEST)
Date: Mon, 18 May 2026 15:01:31 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] writeback: drop now-unnecessary rcu_barrier() in
 cgroup_writeback_umount()
Message-ID: <q75moaoyuys22umiai3h6jnrowes37rrif2ap6v44j7vgd7qgw@lx4esnq6stjg>
References: <20260517142147.3354909-1-libaokun@linux.alibaba.com>
 <20260517142147.3354909-3-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517142147.3354909-3-libaokun@linux.alibaba.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Sun 17-05-26 22:21:31, Baokun Li wrote:
> Commit e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when
> switching inodes") replaced the queue_rcu_work() based scheduling of
> inode wb switches with a plain queue_work().  Since then no switcher
> goes through call_rcu(), so rcu_barrier() in cgroup_writeback_umount()
> has no work to wait for and is effectively a no-op.
> 
> Fixes: e1b849cfa6b6 ("writeback: Avoid contention on wb->list_lock when switching inodes")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Looks good. Just I think this should be folded in patch 1, since you have
proper Fixes tag, I don't think there's a concern this would be backported
to kernels where rcu_barrier() is still needed.

								Honza

> ---
>  fs/fs-writeback.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 1f95ddcee363..9ae290547eb2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1246,11 +1246,6 @@ void cgroup_writeback_umount(struct super_block *sb)
>  		 * will then drain it.
>  		 */
>  		synchronize_rcu();
> -		/*
> -		 * Use rcu_barrier() to wait for all pending callbacks to
> -		 * ensure that all in-flight wb switches are in the workqueue.
> -		 */
> -		rcu_barrier();
>  		flush_workqueue(isw_wq);
>  	}
>  }
> -- 
> 2.43.7
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

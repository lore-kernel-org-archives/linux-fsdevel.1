Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6664508F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418787; cv=none; b=cxXDTf3QR2QZOzJe2/VmnNCv5clIkn/5y2uYZVxC+HvNNu9BckJgVdGwRdGlc00r+8Et02VdHweN+RLhQEUboJWmpU/HfcR5Qe1P7M6z9QMOhkAX0NxzUxmcMasy54F/d2pAs1X7GcSZKUGmg1uvbG8uoHRhW6vZOFS9i4SfZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418787; c=relaxed/simple;
	bh=G+Lb4rYxVGzR05ubJ+/dnhHwwCOWOq4tNjTDozoqleI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2vU92bTREmPCvpb4OAHF0B4KIx/4iK2I6LguJpOrakujS2FxYD9oET1HGKkHXLgvj/C9KQbxYwo8CsaZWCcfZnLA2U57thHKzhCwaSHZ+16tmehkuYGkuHYGySSF1xUJcTfpoF/jjeGS/Y2ze2zKG0OGNzP9VmrHXhmq33nyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FFkEYH6L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Trg4EHCs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FFkEYH6L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Trg4EHCs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FFkEYH6L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Trg4EHCs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FFkEYH6L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Trg4EHCs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05EBD1F444;
	Mon, 19 Oct 2026 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792418783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtaRPLSr4TnnhPYMMWXrDwNDxI2MAjzskOOeXDeRIEM=;
	b=FFkEYH6LNwx95SnQnLU1grQmThJ4ssEyWj4nhytlN7YADaakDKnUDu0V72UjCNxurKSN70
	cdqQnyjuYB3WR6OpVexKdypxyWiPMUDNQkhAd8GTyQQ6dPYPlAWodJph9NPKKZbNhRTtCZ
	l4HrBm5ISYGY4s5Ay2J2Q4xl2MBXh00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792418783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtaRPLSr4TnnhPYMMWXrDwNDxI2MAjzskOOeXDeRIEM=;
	b=Trg4EHCsOh38GjU5+DfKD0QqWoO/ka3jtAKUmD1TmlwdnGskWeIkUdk+OY7pJYmilNfdb/
	Qf2QE/98gniYexBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FFkEYH6L;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Trg4EHCs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792418783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtaRPLSr4TnnhPYMMWXrDwNDxI2MAjzskOOeXDeRIEM=;
	b=FFkEYH6LNwx95SnQnLU1grQmThJ4ssEyWj4nhytlN7YADaakDKnUDu0V72UjCNxurKSN70
	cdqQnyjuYB3WR6OpVexKdypxyWiPMUDNQkhAd8GTyQQ6dPYPlAWodJph9NPKKZbNhRTtCZ
	l4HrBm5ISYGY4s5Ay2J2Q4xl2MBXh00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792418783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtaRPLSr4TnnhPYMMWXrDwNDxI2MAjzskOOeXDeRIEM=;
	b=Trg4EHCsOh38GjU5+DfKD0QqWoO/ka3jtAKUmD1TmlwdnGskWeIkUdk+OY7pJYmilNfdb/
	Qf2QE/98gniYexBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1F07136CC;
	Mon, 19 Oct 2026 14:06:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /TRdK94j1mpFUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 14:06:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65705A1413; Mon, 19 Oct 2026 16:06:22 +0200 (CEST)
Date: Mon, 19 Oct 2026 16:06:22 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, akpm@linux-foundation.org, 
	roman.gushchin@linux.dev, dennis@kernel.org
Subject: Re: [PATCH 1/2] writeback: reset dirtied_when when switching wbs
Message-ID: <bwlkranclikj4hqf4brtqeoifebayq5a6cmt4y5ylpgffqy6cu@sn5gezbcas6y>
References: <20261016115230.3640770-1-sunjunchao@bytedance.com>
 <20261016115230.3640770-2-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016115230.3640770-2-sunjunchao@bytedance.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 05EBD1F444
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,bytedance.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 16-10-26 19:52:29, Julian Sun wrote:
> When switching a dirty inode to another wb, inode_do_switch_wbs() puts
> it at the newest end of the target b_dirty list instead of searching
> for its sorted position. This requires updating dirtied_when, which
> move_expired_inodes() uses to decide where to stop scanning.
> 
> However, the switch updates dirtied_time_when instead. This leaves
> b_dirty out of order and can make the scan stop before reaching older
> inodes. It also resets the lazytime expiration timestamp, potentially
> delaying timestamp writeback.
> 
> Update dirtied_when instead, preserving both the constant-time insertion
> and the lazytime expiration timestamp. Correct the field name in the
> comment and document the distinction between the two inode timestamps.
> 
> Fixes: 9a6ebbdbd412 ("writeback: Avoid excessively long inode switching times")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Right, I've messed this up. Thanks for the fix! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c  | 6 +++---
>  include/linux/fs.h | 4 +++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e744f9f9d43f..6984f6c10a86 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -468,12 +468,12 @@ static bool inode_do_switch_wbs(struct inode *inode,
>  		if (inode_state_read(inode) & I_DIRTY_ALL) {
>  			/*
>  			 * We need to keep b_dirty list sorted by
> -			 * dirtied_time_when. However properly sorting the
> +			 * dirtied_when. However properly sorting the
>  			 * inode in the list gets too expensive when switching
>  			 * many inodes. So just attach inode at the end of the
> -			 * dirty list and clobber the dirtied_time_when.
> +			 * dirty list and clobber the dirtied_when.
>  			 */
> -			inode->dirtied_time_when = jiffies;
> +			inode->dirtied_when = jiffies;
>  			inode_io_list_move_locked(inode, new_wb,
>  						  &new_wb->b_dirty);
>  		} else {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f9d1e05e8ae6..c5dd44314170 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -815,7 +815,9 @@ struct inode {
>  	/* 32-bit hole */
>  	struct rw_semaphore	i_rwsem;
>  
> -	unsigned long		dirtied_when;	/* jiffies of first dirtying */
> +	/* Timestamp for writeback list ordering and age checks (jiffies). */
> +	unsigned long		dirtied_when;
> +	/* Start time for deciding when lazytime updates need writeback (jiffies). */
>  	unsigned long		dirtied_time_when;
>  
>  	struct hlist_node	i_hash;
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

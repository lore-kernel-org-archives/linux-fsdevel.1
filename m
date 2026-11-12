Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506744;
	b=nRGf8VcehroGaoAwoIE/cP2jejmwjXl1k1iUFhNDbdIsfh0V6udDMDmhNiHG8/EsqWbh
	 3pgBsWu0SFY9Of9EM9gsaLhuj4z5nUseEBiA1PbbXCu3v/YEaYOkdWaAusraCk3adr82m
	 C2TPyGFjvrFcy/uVxvUxQn/wEAnbNClUZEGkk3Ug5/mhmMAPlAtsPDuok7DnyJLa/MG4Q
	 wqFWcpkp0AanlIn4dSmBc6Y+IVqg2ztJZl7b4f7XoUOH0sW0wojPWM3KIH8I7yxJlunLB
	 JhO3wYyvJW2ElcJqUeMOexzcd7AGWI5O6oVmIOvr7VIZj21+0u5DukiSuVOmssvO5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506744;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=i9QD/q42PybQHngiS3RC0n1hajCpYFKsM8cvVyzPk5c=;
	b=z58H4douZlt4JHA/NZ9gfWnIztzbeJ00BpYzWTx9CWfR6r4OOE3DIispofPIykunkYXU
	 V9t5lnAs0thlU4+8m7NTn2ET/cuGB4Al/YOVR+4tzC3VKtIryF06opqgwaWjRq7P/Jxcm
	 Tg/SaeDAXjCrAmkfQPFarqmYf0a3ZAPimhxKPmrX51YiXgMxBi1a3MlCPx/uu69QrP4TE
	 fosZjhXZpMHZM/r1fK+vfq4a3FKvl8Q4htqEv6RuxZ4Saepgw9uiUMXgq7jAJ6URI+0BP
	 5xUwmdDhHgP4jbLRLi6Jtt8eUZUQwlAaj+D58oedIR66mOoGlJcTR0ZX6uBcIAFgorQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GUuLZEff;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+5HCnT2S;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=O+yZi06l;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wm3n69FU;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70705606A886
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 18:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70705606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GUuLZEff;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+5HCnT2S;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=O+yZi06l;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wm3n69FU
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80FB521FA9;
	Thu, 12 Nov 2026 18:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794506741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9QD/q42PybQHngiS3RC0n1hajCpYFKsM8cvVyzPk5c=;
	b=GUuLZEffeLMXUyyVbcBnmqiwGi+6Q7pSkmHR9Fw5dUSQBtnwWlvq+H669ZGf7EbLU/1/IN
	vgXb5EW6LTQ6BA8EwfabBq8yTJgtnLTasaKr7s1ozwNVBFr8cQVf6NrrR4KKnr8X9Ti6Lx
	FTDLKzTXY3rBEFSzVk+OWE35dTk8vjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794506741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9QD/q42PybQHngiS3RC0n1hajCpYFKsM8cvVyzPk5c=;
	b=+5HCnT2SCqvtBpcfW7BWmYx3KYcs9Oqszezfab9sFgetpdqitQ5AkDSUOtjPHvPK82l1bz
	vNEglb3k+DxqjXAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794506740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9QD/q42PybQHngiS3RC0n1hajCpYFKsM8cvVyzPk5c=;
	b=O+yZi06lJeuUbJ1ybmszXxO2lwsPLY2COIHZjvkVXjB5WZcMKDtpp64A0FTLFpcBWtA9WY
	FSfGTEaQJBI7UqIHLQLLb9zx48AfIBOMlAGFfhlfhStup+iivPhYRZNPyfXTbtljWUy+N3
	EjMt5qwnfqwTN+NVjRpea1zl1duB1Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794506740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i9QD/q42PybQHngiS3RC0n1hajCpYFKsM8cvVyzPk5c=;
	b=wm3n69FUZKE4D2VjEzkdR1JG7wOuib+V5iLl7yhcYd9pS0kG3Pigi+Pr0rEuUkpMHaqJCL
	KpFkXrXvaXFHO/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D09913432;
	Thu, 12 Nov 2026 18:05:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 11JmCfT/9WoCJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Nov 2026 18:05:40 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id B76A622B73; Thu, 12 Nov 2026 19:05:35 +0100 (CET)
Date: Thu, 12 Nov 2026 19:05:35 +0100
From: Jan Kara <jack@suse.cz>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: Avoid postponing periodic data writeback
 indefinitely
Message-ID: <j77bd4foxrzipxiyute77hoc6vgszevpre2vifpfnaqwetpavf@36z37lyzaz34>
References: <azdwnedsaesxdsp6vxjxgzg6ynrszveibmqkpznn3yuqyttlcj@5lz4p2aw5hxk>
 <20261029015217.840177-1-hongyu.jin@unisoc.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gpkvlts6ek6gczvg"
Content-Disposition: inline
In-Reply-To: <20261029015217.840177-1-hongyu.jin@unisoc.com>
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -11.30
X-Spam-Level: 
X-Spam-Flag: NO


--gpkvlts6ek6gczvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 29-10-26 09:52:17, Hongyu Jin wrote:
> From: Jan Kara <jack@suse.cz>
> 
> f2fs periodically calls sync_inode_metadata() for some inodes. The logic
> in writeback_single_inode() thus periodically calls to redirty_tail() and
> the inode's dirtied_when timestamp never gets old enough for the inode
> to be eligible for periodic data writeback. Thus dirty data from it is
> only ever written on explicit request (fsync(2), sync(2), unmount) or
> on dirty limit pressure.
> 
> The redirty_tail() logic in writeback_single_inode() actually should not
> be necessary. Since this function is used only for once-off writeback,
> there's no need for any livelock protection among inodes and
> writeback_single_inode() is only responsible for demoting inode to "less
> dirty" list based on dirty bits cleared as a result of writeback. So
> remove the redirty_tail() logic and add a comment explaining the rules.
> 
> The redirty_tail() did hide a race though, the one fixed by
> commit 846a3351ddfe ("writeback: Avoid skipping inode writeback").
> __writeback_single_inode() sets I_DIRTY_PAGES again when the mapping
> is still tagged dirty. If the inode had no I_DIRTY bits (e.g.
> write_inode_now(inode, 0) or sync_inode_metadata(inode, 0) of an inode
> with only I_DIRTY_TIME), the dirty pages come from a racing writer,
> whose __mark_inode_dirty() then finds I_DIRTY_PAGES set and does not
> queue the inode, leaving it on b_dirty_time or b_attached. Call
> __mark_inode_dirty() in that case instead, so that the inode gets queued
> on b_dirty.
> 
> Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
> Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
> Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> [hongyu.jin: let __mark_inode_dirty() queue an inode whose pages were
>  dirtied while it had no I_DIRTY bits, update comments]
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

I wasn't still happy with this solution so I was pondering for quite a
while about a cleaner solution. Finally, I've come up with a patch I like
and which should fix the race you have found. Some testing is still running
on my side but I'm attaching it already now in case you want to run testing
on your side as well. Thanks for your patience!

								Honza

> ---
>  fs/fs-writeback.c | 60 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 58a6403780aa..c7979b0cd375 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1780,7 +1780,9 @@ bool sync_lazytime(struct inode *inode)
>   *
>   * This doesn't remove the inode from the writeback list it is on, except
>   * potentially to move it from b_dirty_time to b_dirty due to timestamp
> - * expiration.  The caller is otherwise responsible for writeback list handling.
> + * expiration, or to queue it on b_dirty via __mark_inode_dirty() when its
> + * pages were dirtied while it had no I_DIRTY bits.  The caller is otherwise
> + * responsible for writeback list handling.
>   *
>   * The caller is also responsible for setting the I_SYNC flag beforehand and
>   * calling inode_sync_complete() to clear it afterwards.
> @@ -1790,6 +1792,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	long nr_to_write = wbc->nr_to_write;
> +	bool mark_pages = false;
>  	unsigned dirty;
>  	int ret;
>  
> @@ -1843,12 +1846,23 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  	 * still has dirty pages.  The flag is reinstated after smp_mb() if
>  	 * necessary.  This guarantees that either __mark_inode_dirty()
>  	 * sees clear I_DIRTY_PAGES or we see PAGECACHE_TAG_DIRTY.
> +	 *
> +	 * If the inode had any I_DIRTY bits, __mark_inode_dirty() has already
> +	 * queued it (if it is to be queued at all) and we can just reinstate
> +	 * I_DIRTY_PAGES.  Otherwise the pages were dirtied by a racing writer
> +	 * and the inode may sit on b_dirty_time or b_attached.  Setting the
> +	 * flag here would make the writer's __mark_inode_dirty() bail out
> +	 * without queueing the inode, so let __mark_inode_dirty() set it and
> +	 * queue the inode instead.
>  	 */
>  	smp_mb();
>  
> -	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> -		inode_state_set(inode, I_DIRTY_PAGES);
> -	else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
> +	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
> +		if (dirty)
> +			inode_state_set(inode, I_DIRTY_PAGES);
> +		else
> +			mark_pages = true;
> +	} else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
>  		if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
>  			inode_state_clear(inode, I_PINNING_NETFS_WB);
>  			wbc->unpinned_netfs_wb = true;
> @@ -1858,6 +1872,9 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
>  
>  	spin_unlock(&inode->i_lock);
>  
> +	if (mark_pages)
> +		__mark_inode_dirty(inode, I_DIRTY_PAGES);
> +
>  	/* Don't write the inode if only I_DIRTY_PAGES was set */
>  	if (dirty & ~I_DIRTY_PAGES) {
>  		int err = write_inode(inode, wbc);
> @@ -1946,22 +1963,31 @@ static int writeback_single_inode(struct inode *inode,
>  	 * as it can be finally deleted at this moment.
>  	 */
>  	if (!(inode_state_read(inode) & I_FREEING)) {
> +		enum inode_state_flags_enum istate = inode_state_read(inode);
> +
>  		/*
> -		 * If the inode is now fully clean, then it can be safely
> -		 * removed from its writeback list (if any). Otherwise the
> -		 * flusher threads are responsible for the writeback lists.
> +		 * __mark_inode_dirty() is responsible for promoting inode to
> +		 * the proper list (b_attached -> b_dirty_time -> b_dirty).
> +		 * Here we are responsible for demoting inode after some dirty
> +		 * bits were cleared.
> +		 *
> +		 * If the inode is now fully clean, then it can be safely moved
> +		 * to b_attached list. If the inode is dirty, we don't want to
> +		 * touch it - it should be already put to the dirty list by
> +		 * __mark_inode_dirty() and we'd just unnecessarily clobber the
> +		 * dirtied_when stamp (which is particularly problematic when
> +		 * we were called from sync_inode_metadata()). We also cannot
> +		 * touch the dirty list association when I_SYNC_QUEUED is set
> +		 * and flush worker is responsible for it. Otherwise move the
> +		 * inode to b_dirty_time list as that's the only remaining
> +		 * possibility.
>  		 */
> -		if (!(inode_state_read(inode) & I_DIRTY_ALL))
> +		if (!(istate & I_DIRTY_ALL))
>  			inode_cgwb_move_to_attached(inode, wb);
> -		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
> -			if ((inode_state_read(inode) & I_DIRTY))
> -				redirty_tail_locked(inode, wb);
> -			else if (inode_state_read(inode) & I_DIRTY_TIME) {
> -				inode->dirtied_when = jiffies;
> -				inode_io_list_move_locked(inode,
> -							  wb,
> -							  &wb->b_dirty_time);
> -			}
> +		else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)) {
> +			WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
> +			inode->dirtied_when = jiffies;
> +			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
>  		}
>  	}
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--gpkvlts6ek6gczvg
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-writeback-Avoid-postponing-periodic-data-writeback-i.patch"

From b6a15901f2e297d038751e1e91f4585238a31e64 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 26 Oct 2026 16:16:15 +0100
Subject: [PATCH] writeback: Avoid postponing periodic data writeback
 indefinitely

Hongyu Jin has reported that f2fs periodically calls
sync_inode_metadata() for some inodes. The logic in
writeback_single_inode() thus periodically calls to redirty_tail() and
the inode's dirtied_when timestamp never gets old enough for the inode
to be eligible for periodic data writeback. Thus dirty data from it is
only ever written on explicit request (fsync(2), sync(2), unmount) or
on dirty limit pressure.

The redirty_tail() logic in writeback_single_inode() is only needed do
place inode in the dirty list when the setting of I_DIRTY_PAGES in
__writeback_single_inode() raced with filemap_dirty_folio(). So be more
careful in __writeback_single_inode() to make sure __mark_inode_dirty()
always places in the inode in the proper list and modify
writeback_single_inode() to only demote inode to "less dirty" list based
on dirty bits cleared as a result of writeback.

Link: https://lore.kernel.org/all/20261023023707.263101-1-hongyu.jin@unisoc.com
Reported-by: Hongyu Jin <hongyu.jin.cn@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 74 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 15260cf2a29b..79e642aa45da 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1800,6 +1800,7 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	struct address_space *mapping = inode->i_mapping;
 	long nr_to_write = wbc->nr_to_write;
 	unsigned dirty;
+	bool pages_cleared = false;
 	int ret;
 
 	WARN_ON(!(inode_state_read_once(inode) & I_SYNC));
@@ -1839,30 +1840,42 @@ __writeback_single_inode(struct inode *inode, struct writeback_control *wbc)
 	 * after handling timestamp expiration, as that may dirty the inode too.
 	 */
 	spin_lock(&inode->i_lock);
-	dirty = inode_state_read(inode) & I_DIRTY;
+	dirty = inode_state_read(inode) & I_DIRTY_INODE;
 	inode_state_clear(inode, dirty);
+	if (inode_state_read(inode) & I_DIRTY_PAGES &&
+	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
+		inode_state_clear(inode, I_DIRTY_PAGES);
+		pages_cleared = true;
+	}
 
 	/*
 	 * Paired with smp_mb() in __mark_inode_dirty().  This allows
 	 * __mark_inode_dirty() to test i_state without grabbing i_lock -
 	 * either they see the I_DIRTY bits cleared or we see the dirtied
-	 * inode.
+	 * inode or folio tag.
 	 *
-	 * I_DIRTY_PAGES is always cleared together above even if @mapping
-	 * still has dirty pages.  The flag is reinstated after smp_mb() if
-	 * necessary.  This guarantees that either __mark_inode_dirty()
-	 * sees clear I_DIRTY_PAGES or we see PAGECACHE_TAG_DIRTY.
+	 * I_DIRTY_PAGES handling is hairy. The clearing above can race with
+	 * filemap_dirty_folio() so we don't see dirty tag yet but
+	 * __mark_inode_dirty() doesn't see I_DIRTY_PAGES cleared either. So we
+	 * have to recheck after smp_mb() and possibly reinstate I_DIRTY_PAGES.
+	 * We have to be careful with reinstating and only do that if we really
+	 * cleared I_DIRTY_PAGES. Only in that case we are guaranteed the inode
+	 * is already in the dirty list and so it doesn't need to be (nor
+	 * should be) moved. If we didn't clear I_DIRTY_PAGES, then either the
+	 * inode is already in the dirty list or we race with
+	 * filemap_dirty_folio() which will eventually call
+	 * __mark_inode_dirty() to set I_DIRTY_PAGES and place inode in
+	 * appropriate dirty list.
 	 */
 	smp_mb();
 
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+	if (pages_cleared && mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		inode_state_set(inode, I_DIRTY_PAGES);
-	else if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB)) {
-		if (!(inode_state_read(inode) & I_DIRTY_PAGES)) {
-			inode_state_clear(inode, I_PINNING_NETFS_WB);
-			wbc->unpinned_netfs_wb = true;
-			dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
-		}
+	if (unlikely(inode_state_read(inode) & I_PINNING_NETFS_WB) &&
+	    !(inode_state_read(inode) & I_DIRTY_PAGES)) {
+		inode_state_clear(inode, I_PINNING_NETFS_WB);
+		wbc->unpinned_netfs_wb = true;
+		dirty |= I_PINNING_NETFS_WB; /* Cause write_inode */
 	}
 
 	spin_unlock(&inode->i_lock);
@@ -1955,22 +1968,31 @@ static int writeback_single_inode(struct inode *inode,
 	 * as it can be finally deleted at this moment.
 	 */
 	if (!(inode_state_read(inode) & I_FREEING)) {
+		enum inode_state_flags_enum istate = inode_state_read(inode);
+
 		/*
-		 * If the inode is now fully clean, then it can be safely
-		 * removed from its writeback list (if any). Otherwise the
-		 * flusher threads are responsible for the writeback lists.
+		 * __mark_inode_dirty() is responsible for promoting inode to
+		 * the proper list (b_attached -> b_dirty_time -> b_dirty).
+		 * Here we are responsible for demoting inode after some dirty
+		 * bits were cleared.
+		 *
+		 * If the inode is now fully clean, then it can be safely moved
+		 * to b_attached list. If the inode is dirty, we don't want to
+		 * touch it - it should be already put to the dirty list by
+		 * __mark_inode_dirty() and we'd just unnecessarily clobber the
+		 * dirtied_when stamp (which is particularly problematic when
+		 * we were called from sync_inode_metadata()). We also cannot
+		 * touch the dirty list association when I_SYNC_QUEUED is set
+		 * and flush worker is responsible for it. Otherwise move the
+		 * inode to b_dirty_time list as that's the only remaining
+		 * possibility.
 		 */
-		if (!(inode_state_read(inode) & I_DIRTY_ALL))
+		if (!(istate & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
-		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
-			if ((inode_state_read(inode) & I_DIRTY))
-				redirty_tail_locked(inode, wb);
-			else if (inode_state_read(inode) & I_DIRTY_TIME) {
-				inode->dirtied_when = jiffies;
-				inode_io_list_move_locked(inode,
-							  wb,
-							  &wb->b_dirty_time);
-			}
+		else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)) {
+			WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
+			inode->dirtied_when = jiffies;
+			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
 		}
 	}
 
-- 
2.53.0


--gpkvlts6ek6gczvg--

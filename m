Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38734AA038
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403042; cv=none; b=fR8lyaFUwYvn2cB4l9WXl8SOVhDjdRXVLbslyckBnvnCj5cFwaA6Am3XOuVDi37ZFHnqWBOgfzOe5UulI9l5xjcAjO+oPKbgmXEQALTi2ZPJA+wsjJ/O2t9ub3ukzk538ek3UrUd85ORtzL7+e8ycF6s6p2PFk27BJvd/lweakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403042; c=relaxed/simple;
	bh=eXJQVX14mQlQG27RKRVNvoKjhLrdwS7TdRFV6Xri72U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CagEneDzbZC4PL4z4spDUrMQyydftWZG2/V/1+GPvmqemF6zxGf80/l9NhEnxCn+lAm5aJtMF3Q00E8h5rn4OVQ1x9yRcWfOI7XFc/KLZtcOjSd3d3hSZTJqZjPDlMKCeVLE441pjofyTCvQQZQ1HEeG3nnn7gxwYtgUNT4bYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WH7aG4VM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aaVhJAWM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u6VHnfyM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXNeOZFc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WH7aG4VM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aaVhJAWM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6VHnfyM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXNeOZFc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCDCC21C08;
	Mon, 19 Oct 2026 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792403039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09Lq3An05DWPwWxeP0P+1z2FcKSxt+uwU4M2CkK9Eew=;
	b=WH7aG4VMWqpdzzXRD5GJ5dlxyI/o4EpP4Q94+TvJH9IHtf6zS54iHiucDyKotDjUP8CYOf
	8PwpQlkbGHerat8yADcrafZBWQgMTutlnyodTHJlVlw8Tdt4oedJLgKKMPOLVriTotfhgn
	tIR1RSaUeSX1F61Fqg0c3JRghG1DeaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792403039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09Lq3An05DWPwWxeP0P+1z2FcKSxt+uwU4M2CkK9Eew=;
	b=aaVhJAWMHnFF7+W7PztBek5nPyblgTcK+EAJOCjarkm2YETBlBCmcztlnE3/526Yj4DhND
	4wjH76CgpjeF4nDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u6VHnfyM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qXNeOZFc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792403038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09Lq3An05DWPwWxeP0P+1z2FcKSxt+uwU4M2CkK9Eew=;
	b=u6VHnfyMtr8FXFmcl6a7oawp/5Dnehifq04nZUU8VkEy8cCVV6mdykSTlMcrhTNKKNJCnZ
	T9A7GXg/SiZqbSBVlHRZnk0smuNlY191IrsvgajtdWjgvuLkmFAcobgaDg9dwBz/29VSIq
	Xygu2EZyWN8pnAcTuoE7myI2T9+qMXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792403038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09Lq3An05DWPwWxeP0P+1z2FcKSxt+uwU4M2CkK9Eew=;
	b=qXNeOZFcz5kSMb+dkWrHfvw1RIyoj++ARYsiqXv9EO/F63yoXtRYtPeM/FZQBlE0kpaYQF
	KF0ROHT+RnZR5FBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFD48134B3;
	Mon, 19 Oct 2026 09:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q8gqIV7m1WrZMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 09:43:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C4D9A1413; Mon, 19 Oct 2026 11:43:58 +0200 (CEST)
Date: Mon, 19 Oct 2026 11:43:58 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Mikhail Rudenko <xyzzy@yandex-team.ru>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/7 v3] fs: Deferred inode reclaim
Message-ID: <tsjar7j52anyxrtfdqfhmp6enu4e32hsvtitk5gy3bpxvagsjx@5exi7yidgf66>
References: <20261009133253.20102-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009133253.20102-1-jack@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DCDCC21C08
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
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

Hi!

FWIW Sashiko still found some stupid mistakes I've made so I'll have to respin
this. However none of the issues Sashiko found are fundamental (just some
memory leaks, wrong memory ordering, ...) so the overall design should
stay so if someone has any comment to that, they will be still valid.

								Honza

On Mon 12-10-26 10:23:38, Jan Kara wrote:
> Hello,
> 
> here is the third revision of my patches implementing deferred inode reclaim to
> deal with MM warnings due to GFP_NOFAIL allocations from reclaim paths. This
> happens because to reclaim some inodes, filesystems have to do IO including
> complex operations using journalling and forward progress of these depends on
> successful memory allocations (which is impossible to guarantee from reclaim
> context).
> 
> Since the last revision the most notable changes include addition of automatic
> deferal of inode eviction from iput() when inode link-count is 0 and we are in
> reclaim (PF_MEMALLOC flag set). This path gets triggered e.g. by overlayfs
> whose inodes hold dentry references on upper filesystem and thus slab reclaim
> of overlayfs inodes can trigger the last dput() (and thus iput()) of already
> unlinked files. Since inode deletion is practically guaranteed to require IO
> (and thus possibly e.g. loading allocation information into memory) I've
> decided to unconditionally defer reclaim in this case instead of marking inodes
> in each filesystem.
> 
> Another bigger change in this series is that we now protect deferred inode
> reclaim from filesystem freezing. Otherwise inode eviction could block the
> reclaim worker on frozen filesystem which could stall deferred inode reclaim on
> the whole system. Deferred reclaim workers now skip reclaiming inodes on frozen
> filesystem and we block filesystem freezing while the worker is evicting
> current batch of its inodes.
> 
> The last bigger change is that mark_inode_reclaim_deferred() does not block
> when the queue of deferred inodes grows over limit anymore. Instead it queues
> task work to delay the task appropriately when returning to userspace. This
> solves possible lockups when tasks would get throttled when calling
> mark_inode_reclaim_deferred() with some locks or transaction started.
> 
> The patches have survived full fstests run on ext4 when marking all loaded ext4
> inodes for deferred reclaim to stress the deferred reclaim paths. I have also
> tested (when marking all inodes for deferred reclaim) the patches by creating a
> memcg with 128m memory limit and then scanning from 10 processes 1m inodes in
> total which heavily exercises deferred inode reclaim paths. This also verified
> efficiency of throttling of marking of inodes for deferred reclaim. Basically
> we cannot guarantee any particular limit on the number of inodes queued for
> deferred reclaim as that is bound only by their number in memory and memory
> pressure. But as the number of queued inodes grows, the tasks creating them get
> slowed down so eventually some equilibrium is hit. In my VM this was at ~10k
> inodes (only slightly above the 8k limit when throttling kicks in) but this all
> very much depends on the reclaim pressure, speed of deferred reclaim etc. so I
> don't think this is some representative number.
> 
> The first patch is a pure fix for a problem I've hit when running fstests.  The
> second patch deals with lazy timestamp updates which I've decided to handle
> better directly inside the writeback infrastructure instead of deferring
> reclaim. The remaining patches implement the inode reclaim deferal. Ext4 use of
> deferred inode reclaim is there mostly as a demonstration. Other filesystems
> need to determine which inodes need deferred reclaim and mark them as such
> which generally requires good internal knowledge of the filesystem. I'm hoping
> that once the infrastructure is there, fs developers prompted by MM warnings
> will start using it :). I know for a fact that besides ext4 e.g. gfs2 wants
> to use this infrastructure.
> 
> 								Honza
> 
> Changes since v2:
> * Some cleanups and simplifications from Andreas Grunbacher
> * Fixed couple of bugs pointed out by Sashiko
> * Added support for auto-deferring eviction from iput() when inode has 0 link
>   count and we are in reclaim path
> * Added protection of deferred reclaim from filesystem freezing
> * Throttling now doesn't happen directly in mark_inode_reclaim_deferred() but
>   on exit to userspace
> 
> Changes since v1:
> * Multiple workers to reclaim deferred inodes, related to that I've
>   moved lists of deferred inodes from per-sb to global ones
> * Added missed lazytime sync fix
> 
> Previous versions:
> Link: http://lore.kernel.org/r/20260429174850.18223-1-jack@suse.cz # v1
> Link: http://lore.kernel.org/r/20260911081309.14137-1-jack@suse.cz # v2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

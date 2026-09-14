Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BF2DAFDE;
	Mon, 14 Sep 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377135; cv=none; b=gSqv0FbFuMatEOVwZi9I2x1KZWHDDbAQVbseH7duHZkV2Lk6A0tKVmcKp6bpMjx2/3WF3GmrcJoTNtxElSuV3qiynUZHWN3b4HnaLO+1YpoXwNxf3dHT+xnQz/UHjwmOIH8HJt+k4LkBuFPahwyjUZmLSV8v3B2XX+jUnhdfyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377135; c=relaxed/simple;
	bh=bHsF0gWZQ0u+mJZASC6UmSqg3IsNKLhCor1lQd9D094=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n46UQTO6BLJAsxIUszjMh/x4+EFkUHZ1gCMizrZmRyAbczFq/iNwX52xlD+j0rxTG88DO38WmehdDS5xamLigY2nhSaUaK/erYBt2AeV524QUCEBYdRjCNGCdfX/i8X05YUYRveeVOEPEeWWqwiPv1qGCmGBn4nLcVXuBsgLx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y7+NRT7M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OmJKUsF3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bcWubnSe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=keZBVTp1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y7+NRT7M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OmJKUsF3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bcWubnSe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="keZBVTp1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BE891F806;
	Mon, 14 Sep 2026 09:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789377127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iBVz9GWyIO/JE02qU0b3s6M99JCISE+d5RzWyyO6mE=;
	b=Y7+NRT7MlJ9PlNn2qDMh+nv4P+h0fXDGXtywr8TvqYSipG4YNG/mgVne8/BUvWpNdNQRG8
	xIGScg7RBq5V2KwGa80bcv3cxFT7/EZkMCtal1fDJeOnyNHSHB3ZV5N4KBvmMmAd8JSL+4
	pz5svi7Vrwygq/TQFSLl6DPtV3+taXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789377127;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iBVz9GWyIO/JE02qU0b3s6M99JCISE+d5RzWyyO6mE=;
	b=OmJKUsF39hqmrnBZEASgpYo5TCszV1WL74tnB+eb9ik9njNza5Lh5SG1d3w2vsSnD7I3Ax
	3DdanoEZSfO4sRCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789377123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iBVz9GWyIO/JE02qU0b3s6M99JCISE+d5RzWyyO6mE=;
	b=bcWubnSeGKplCKHrXy3rShrHBFmNgfNd9Fs2SBKnfAPumo5s46NvgiAO5ppu5bpHD7PjVc
	uo+Mf8oBNXWQyd7g0LyWQ8vwZQ8Edqdug601vrjyFS4+FculockWTbETq5VCCN9DzCXUQw
	AtBHjjdks+VEGmSKijtdsJBTgefbLaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789377123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iBVz9GWyIO/JE02qU0b3s6M99JCISE+d5RzWyyO6mE=;
	b=keZBVTp1Kzg88HRuPfkjPvCeNU4f+hIyQDwA4ObAcGhaXooUVsO2AV8VEscixurePdbeTD
	nBMRsnltpr+hzvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 720A31368C;
	Mon, 14 Sep 2026 09:12:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AqbQG2O6p2rERQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Sep 2026 09:12:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00155A12E4; Mon, 14 Sep 2026 11:11:54 +0200 (CEST)
Date: Mon, 14 Sep 2026 11:11:54 +0200
From: Jan Kara <jack@suse.cz>
To: Zhaoyu Liu <zackary.liu.pro@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	axboe@kernel.dk, tz2294@columbia.edu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: check for NULL pointer before
 folio_test_dropbehind()
Message-ID: <khxav3b2kteoa5zqkhcchszjaosz5gll5ijrxnrnwhcsjex7m6@lg2x7hysbdyz>
References: <pfk6l6lsgecie4xwy5njrgtzpave4uayxbl4lkz3iekcdds7fg@bpihjzlnz7m2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pfk6l6lsgecie4xwy5njrgtzpave4uayxbl4lkz3iekcdds7fg@bpihjzlnz7m2>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Sun 13-09-26 23:20:41, Zhaoyu Liu wrote:
> Add a NULL check for bh->b_folio before folio_test_dropbehind()
> to avoid panic for non-pagecache buffer heads from jbd2.
> 
> Sample crash report:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP PTI
> CPU: 2 UID: 0 PID: 332 Comm: jbd2/vda1-8 Not tainted
> 7.3.0-rc2-next-20260907+ #3 PREEMPT (lazy)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 2024.05-2ubuntu0.3 05/07/2025
> RIP: 0010:__bh_submit+0xa2/0x240
> RSP: 0018:ffffce590064bc48 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff8ab102861960 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffce590064bc90 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000009801
> R13: 0000000000000000 R14: ffff8ab10ab90600 R15: 0000000000000000
> FS:  0000000000000000 GS:ffff8ab2e2571000   knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000109364000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  ? __pfx_journal_end_buffer_io_sync+0x10/0x10
>  bh_submit+0x15/0x30
>  jbd2_journal_commit_transaction+0x6c3/0x1840
>  ? psi_group_change+0x201/0x4e0
>  kjournald2+0xa9/0x250
>  ? __pfx_autoremove_wake_function+0x10/0x10
>  ? __pfx_kjournald2+0x10/0x10
>  kthread+0xfd/0x140
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x2a4/0x320
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
> 
> Fixes: a2c924c240e7 ("buffer: set BIO_COMPLETE_IN_TASK for dropbehind writeback")
> 
> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>

The same fix is already in VFS tree.

								Honza

> ---
>  fs/buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 427d8a817cd5..4aea0bb08609 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1106,7 +1106,7 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
>  
>  	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
>  
> -	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
> +	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
>  		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>  
>  	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

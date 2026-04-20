Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DA439B978
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705326; cv=none; b=rV7YdFS0s1cZA+t7ebl5X8Uc7rFf9P2IUt5L6s3am4XlqPLaIyW3IX0wGMA/aaupyTuNjR4vCh/+prEeZrvz87pYrXwTJfjwmDajHB34y73zf8FA5fKzGDX7dzNkQiB/sGLshAuRBP52RbVdtNRV47hpjHdzeQr+j6vQtzVmjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705326; c=relaxed/simple;
	bh=4TUTBQgStUanBHCd3swzk8WtPjFH1Vckjbe3AoUIEpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smoejr/y/0otC4mq3NMp5kvgv648/L0sruZszYFYSVbkUGoTwoHR+V3vtXP8mJ/uBFj5/yNxvtgtMug24GXqpsOPZKkIVGeuBeZ09nZfbZuu95ITVgXdgbFJqZUEQtaBZuXaoMytM0tKXq0PqPkAvrvA6Pb2IEM/b6zvoWfDMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nwbq1cEI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Bsit/cm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nwbq1cEI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Bsit/cm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nwbq1cEI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Bsit/cm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nwbq1cEI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Bsit/cm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AF5B6A7DC;
	Mon, 20 Apr 2026 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776705323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K42dMkgB+n7qlcupjzMhRHmowBIrBpHFZGu01KHY7kM=;
	b=Nwbq1cEIKcNGONkROR3FJ0m1eo+hg15XN8JeriAzsH0QX5XGUv/ikyR+bkfFmETCFr10pM
	zJVju34MaMSEZJoa6XaGjw/MzpqvE/dMq/Qnw6euV4qTGIkbR3kSwX+DwOzRd0pFRwLeax
	BG4uNpgpC8BA3tqV2qFtmlUD8gIGmtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776705323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K42dMkgB+n7qlcupjzMhRHmowBIrBpHFZGu01KHY7kM=;
	b=+Bsit/cmOZ2u/37MRGlUTcg4mKSNu9mwT/ExiwpiCiQO2/HFq+guuudBmZjEGZhnGehHU4
	MtAyyeKmJ/b1MTDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776705323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K42dMkgB+n7qlcupjzMhRHmowBIrBpHFZGu01KHY7kM=;
	b=Nwbq1cEIKcNGONkROR3FJ0m1eo+hg15XN8JeriAzsH0QX5XGUv/ikyR+bkfFmETCFr10pM
	zJVju34MaMSEZJoa6XaGjw/MzpqvE/dMq/Qnw6euV4qTGIkbR3kSwX+DwOzRd0pFRwLeax
	BG4uNpgpC8BA3tqV2qFtmlUD8gIGmtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776705323;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K42dMkgB+n7qlcupjzMhRHmowBIrBpHFZGu01KHY7kM=;
	b=+Bsit/cmOZ2u/37MRGlUTcg4mKSNu9mwT/ExiwpiCiQO2/HFq+guuudBmZjEGZhnGehHU4
	MtAyyeKmJ/b1MTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AB54593AE;
	Mon, 20 Apr 2026 17:15:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bcvUIStf5mmFCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 17:15:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E05AA0AFF; Mon, 20 Apr 2026 19:15:19 +0200 (CEST)
Date: Mon, 20 Apr 2026 19:15:19 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Xin Yin <yinxin.x@bytedance.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix inode reference leak in
 fsnotify_recalc_mask()
Message-ID: <oq6wcvgjppdzeqpuzyufgg7upoubg2272j5xndnzirtxprqmo7@dujlpmdiioqm>
References: <20260420064727.1760604-1-yinxin.x@bytedance.com>
 <CAOQ4uxiPsbHb0o5voUKyPFMvBsDkG914FYDcs4C5UpBMNm0Vcg@mail.gmail.com>
 <aeYxkwYXD23PTqMo@amir-ThinkPad-T480>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeYxkwYXD23PTqMo@amir-ThinkPad-T480>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Mon 20-04-26 16:00:51, Amir Goldstein wrote:
> [fix Jan's cc]
> 
> On Mon, Apr 20, 2026 at 03:33:30PM +0200, Amir Goldstein wrote:
> > On Mon, Apr 20, 2026 at 8:52 AM Xin Yin <yinxin.x@bytedance.com> wrote:
> > >
> > > fsnotify_recalc_mask() fails to handle the return value of
> > > __fsnotify_recalc_mask(), which may return an inode pointer that needs
> > > to be released via fsnotify_drop_object() when the connector's HAS_IREF
> > > flag transitions from set to cleared.
> > >
> > > This manifests as a hung task with the following call trace:
> > >
> > >   INFO: task umount:1234 blocked for more than 120 seconds.
> > >   Call Trace:
> > >    __schedule
> > >    schedule
> > >    fsnotify_sb_delete
> > >    generic_shutdown_super
> > >    kill_anon_super
> > >    cleanup_mnt
> > >    task_work_run
> > >    do_exit
> > >    do_group_exit
> > >
> > > The race window that triggers the iref leak:
> > >
> > >   Thread A (adding mark)              Thread B (removing mark)
> > >   ──────────────────────              ────────────────────────
> > >   fsnotify_add_mark_locked():
> > >     fsnotify_add_mark_list():
> > >       spin_lock(conn->lock)
> > >       add mark_B(evictable) to list
> > >       spin_unlock(conn->lock)
> > >     return
> > >
> > >     /* ---- gap: no lock held ---- */
> > >
> > >                                       fsnotify_detach_mark(mark_A):
> > >                                         spin_lock(mark_A->lock)
> > >                                         clear ATTACHED flag on mark_A
> > >                                         spin_unlock(mark_A->lock)
> > >
> > >     fsnotify_recalc_mask():
> > >       spin_lock(conn->lock)
> > >       __fsnotify_recalc_mask():
> > >         /* mark_A skipped: ATTACHED cleared */
> > >         /* only mark_B(evictable) remains */
> > >         want_iref = false
> > >         has_iref = true  /* not yet cleared */
> > >         -> HAS_IREF transitions true -> false
> > >         -> returns inode pointer
> > >       spin_unlock(conn->lock)
> > >       /* BUG: return value discarded!
> > >        * iput() and fsnotify_put_sb_watched_objects()
> > >        * are never called */
> > >
> > 
> > Hi Xin!
> > 
> > Ouch! nasty one.
> > Very good analysis.
> > Do you also have a reproducer?
> > 
> > 
> > > Fix this by capturing the return value of __fsnotify_recalc_mask() and
> > > passing it to fsnotify_drop_object() after releasing the spinlock, which
> > > is the same pattern used in fsnotify_put_mark().
> > 
> > The fix looks correct, but I prefer for my mental model to keep
> > fsnotify_drop_object() in one place at the end of fsnotify_put_mark().
> > 
> > Please see the suggested (only sanity tested) patch.

Thanks for the fix guys. Frankly, I don't care much between Amir's and
original version. I guess Amir's version keeps iput() constrained to a
single location so it might be somewhat safer going forward so I'll merge
that. It reminds me I should dust off my patches to remove inode references
from fsnotify code altogether. That will remove these games as well.

								Honza


> > From 8cc3e7e2e75f5c93875bffce6bf8398d94398c33 Mon Sep 17 00:00:00 2001
> > From: Amir Goldstein <amir73il@gmail.com>
> > Date: Mon, 20 Apr 2026 14:58:00 +0200
> > Subject: [PATCH v2] fsnotify: fix inode reference leak in
> >  fsnotify_recalc_mask()
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> > 
> > fsnotify_recalc_mask() fails to handle the return value of
> > __fsnotify_recalc_mask(), which may return an inode pointer that needs
> > to be released via fsnotify_drop_object() when the connector's HAS_IREF
> > flag transitions from set to cleared.
> > 
> > This manifests as a hung task with the following call trace:
> > 
> >   INFO: task umount:1234 blocked for more than 120 seconds.
> >   Call Trace:
> >    __schedule
> >    schedule
> >    fsnotify_sb_delete
> >    generic_shutdown_super
> >    kill_anon_super
> >    cleanup_mnt
> >    task_work_run
> >    do_exit
> >    do_group_exit
> > 
> > The race window that triggers the iref leak:
> > 
> >   Thread A (adding mark)              Thread B (removing mark)
> >   ──────────────────────              ────────────────────────
> >   fsnotify_add_mark_locked():
> >     fsnotify_add_mark_list():
> >       spin_lock(conn->lock)
> >       add mark_B(evictable) to list
> >       spin_unlock(conn->lock)
> >     return
> > 
> >     /* ---- gap: no lock held ---- */
> > 
> >                                       fsnotify_detach_mark(mark_A):
> >                                         spin_lock(mark_A->lock)
> >                                         clear ATTACHED flag on mark_A
> >                                         spin_unlock(mark_A->lock)
> >                                         fsnotify_put_mark(mark_A)
> > 
> >     fsnotify_recalc_mask():
> >       spin_lock(conn->lock)
> >       __fsnotify_recalc_mask():
> >         /* mark_A skipped: ATTACHED cleared */
> >         /* only mark_B(evictable) remains */
> >         want_iref = false
> >         has_iref = true  /* not yet cleared */
> >         -> HAS_IREF transitions true -> false
> >         -> returns inode pointer
> >       spin_unlock(conn->lock)
> >       /* BUG: return value discarded!
> >        * iput() and fsnotify_put_sb_watched_objects()
> >        * are never called */
> > 
> > Fix this by deferring the transition true -> false of HAS_IREF flag from
> > fsnotify_recalc_mask() (Thread A) to fsnotify_put_mark() (thread B).
> > 
> > Fixes: c3638b5b1374 ("fsnotify: allow adding an inode mark without pinning inode")
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/mark.c | 39 ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 36 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index 622f05977f86a..e256b420100dc 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -238,7 +238,12 @@ static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
> >  	return inode;
> >  }
> >  
> > -static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> > +/*
> > + * Calculate mask of events for a list of marks.
> > + *
> > + * Return true if any of the attached marks want to hold an inode reference.
> > + */
> > +static bool __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> >  {
> >  	u32 new_mask = 0;
> >  	bool want_iref = false;
> > @@ -262,6 +267,34 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> >  	 */
> >  	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
> >  
> > +	return want_iref;
> > +}
> > +
> > +/*
> > + * Calculate mask of events for a list of marks after attach/modify mark
> > + * and get an inode reference for the connector if needed.
> > + *
> > + * A concurrent add of evictable mark and detach of non-evictable mark can
> > + * lead to __fsnotify_recalc_mask() returning false want_iref, but in this
> > + * case we defer clearing iref to fsnotify_recalc_mask_clear_iref() called
> > + * from fsnotify_put_mark().
> > + */
> > +static void fsnotify_recalc_mask_set_iref(struct fsnotify_mark_connector *conn)
> > +{
> > +	bool has_iref = conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF;
> > +	bool want_iref = __fsnotify_recalc_mask(conn) || has_iref;
> > +
> > +	(void) fsnotify_update_iref(conn, want_iref);
> > +}
> > +
> > +/*
> > + * Calculate mask of events for a list of marks after detach mark
> > + * and return the inode object if its reference is no longer needed.
> > + */
> > +static void *fsnotify_recalc_mask_clear_iref(struct fsnotify_mark_connector *conn)
> > +{
> > +	bool want_iref = __fsnotify_recalc_mask(conn);
> > +
> >  	return fsnotify_update_iref(conn, want_iref);
> >  }
> >  
> > @@ -298,7 +331,7 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> >  
> >  	spin_lock(&conn->lock);
> >  	update_children = !fsnotify_conn_watches_children(conn);
> > -	__fsnotify_recalc_mask(conn);
> > +	fsnotify_recalc_mask_set_iref(conn);
> >  	update_children &= fsnotify_conn_watches_children(conn);
> >  	spin_unlock(&conn->lock);
> >  	/*
> > @@ -419,7 +452,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
> >  		/* Update watched objects after detaching mark */
> >  		if (sb)
> >  			fsnotify_update_sb_watchers(sb, conn);
> > -		objp = __fsnotify_recalc_mask(conn);
> > +		objp = fsnotify_recalc_mask_clear_iref(conn);
> >  		type = conn->type;
> >  	}
> >  	WRITE_ONCE(mark->connector, NULL);
> > -- 
> > 2.53.0
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

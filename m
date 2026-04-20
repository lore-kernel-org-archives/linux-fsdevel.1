Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CA3DB648
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695851; cv=none; b=PXbMQIswJeVToAO60NEiYnZw1lK3KTu3AGveEqepu3Cz+5CDSFb7EJRJyPI3gMTap6HCmI2p6z4Omp/9VCin/BU49qkiNBbsXcNP0UeWrLddJSJPABLY6UDpLqfPTu2LonkgR5ht/8fX9rK6Fpps8YXj+vlGKXm9UrCAs4pd1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695851; c=relaxed/simple;
	bh=sInEG5Ko4W2GlvTHE/iHJyrXZe9QoMhn7HQhO2Tni2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8yYOguhThs6ahXiwclFaT8WsPuZlX7K0lJmfAkDHaD+bdmOSb5ADOzSEX1IQB59Q3+g2o/O+3L9C8INiuiCRvjT0GRUPw5dEc65rVhNgjv/oszUJNQtXq39mNtYr5vZOOqycvLTQgFREgMnUpxhhJ5R7EkLVGSthMrkTfvkUEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bD9CusM6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ze8tr2gn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bD9CusM6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ze8tr2gn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bD9CusM6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ze8tr2gn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bD9CusM6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ze8tr2gn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 423906A7EB;
	Mon, 20 Apr 2026 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVI1OJMF4ycEICTgydIajxUVP7frcKls5gR+VTbJkjE=;
	b=bD9CusM6MD3oqav0EIsvvj8GbRs+3YsnKy40s2vsnryTACWM+b57flgj9IbjjXDyMSGtjm
	b61cOQDPpxQWAgrLSe1/hHhCy3lchvbY2c3x+yx3E+sQ8eZZMc0A9KNU2sdCmaDKPMZ3jr
	gq1uMYuF9jMbu4EHBi5wrgLm88x+Ylk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVI1OJMF4ycEICTgydIajxUVP7frcKls5gR+VTbJkjE=;
	b=Ze8tr2gnknYUPkhrKSiJ7ZRAY6YCyhCODEywL/8NR8E09LB4qAIpH8pbu1FAH+IBJ+ZlMQ
	i6t0vlBUde8D+vAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bD9CusM6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ze8tr2gn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776695842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVI1OJMF4ycEICTgydIajxUVP7frcKls5gR+VTbJkjE=;
	b=bD9CusM6MD3oqav0EIsvvj8GbRs+3YsnKy40s2vsnryTACWM+b57flgj9IbjjXDyMSGtjm
	b61cOQDPpxQWAgrLSe1/hHhCy3lchvbY2c3x+yx3E+sQ8eZZMc0A9KNU2sdCmaDKPMZ3jr
	gq1uMYuF9jMbu4EHBi5wrgLm88x+Ylk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776695842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVI1OJMF4ycEICTgydIajxUVP7frcKls5gR+VTbJkjE=;
	b=Ze8tr2gnknYUPkhrKSiJ7ZRAY6YCyhCODEywL/8NR8E09LB4qAIpH8pbu1FAH+IBJ+ZlMQ
	i6t0vlBUde8D+vAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 332EE593B2;
	Mon, 20 Apr 2026 14:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VzR+DCI65mm4cgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Apr 2026 14:37:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CBB06A0C2E; Mon, 20 Apr 2026 11:13:16 +0200 (CEST)
Date: Mon, 20 Apr 2026 11:13:16 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, jack@suse.cz, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH v3 1/2] fanotify: add restart infrastructure for pending
 permission events
Message-ID: <g5rw56zfcrt5zzimyskj7tcrmnc3q4mfpuxx5hy3wnup627kkk@fmvp76xxc2ca>
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-2-ibrahimjirdeh@meta.com>
 <CAOQ4uxg=z5im3rOw6JXrNY6-ynBEoj_tF=Fsiu81xqiCBRfOjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg=z5im3rOw6JXrNY6-ynBEoj_tF=Fsiu81xqiCBRfOjQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,meta.com:email,suse.com:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Queue-Id: 423906A7EB
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 17-04-26 13:09:59, Amir Goldstein wrote:
> On Thu, Apr 16, 2026 at 9:49 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.com> wrote:
> >
> > Add fanotify_restart_pending_events() helper that walks the
> > access_list and reinserts each pending permission event back into
> > the notification queue for reprocessing. Events are reinserted at
> > the head of the notification queue without merge or overflow handling.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx4wua5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index d0b9b984002f..787e57a00466 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1095,6 +1095,36 @@ static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t
> >         return count;
> >  }
> >
> > +/*
> > + * Reinsert pending permission events at the head of the notification
> > + * queue for reprocessing. No merge or overflow handling.
> > + */
> > +static void fanotify_restart_pending_events(struct fsnotify_group *group)
> > +{
> > +       spin_lock(&group->notification_lock);
> > +       while (!list_empty(&group->fanotify_data.access_list)) {
> > +               struct fanotify_perm_event *event;
> > +
> > +               event = list_first_entry(&group->fanotify_data.access_list,
> > +                                        struct fanotify_perm_event,
> > +                                        fae.fse.list);
> > +               list_del_init(&event->fae.fse.list);
> > +
> > +               if (group->shutdown) {
> > +                       /* Group is being shut down. Reply ALLOW for the event. */
> > +                       finish_permission_event(group, event, FAN_ALLOW, NULL);
> > +                       spin_lock(&group->notification_lock);
> 
> This looks very awkward.
> 
> We are holding the notification lock for the non-shutdown case
> throughout moving the events back into the notification_list
> (could possibly do that with list_move() if we keep a count
> of in-progress events).
> 
> Seems more reasonable to also finish all events in a single batch
> if the group is shutdown and then maybe use the same helper in
> fanotify_release().
> 
> But Ibrahim, please wait for Jan's input on this before sending v4.
> 
> There are many ways to do this, and reusing the existing
> finish_permission_event() locking semantics in this loop may be
> fine for simplicity.
> 
> It is also a matter of taste, so please wait for Jan to chime in.

So I wouldn't overcomplicate and just go for something like:

	spin_lock(&group->notification_lock);
	/* Group is exiting, fanotify_release() will remove pending events */
	if (group->shutdown) {
		spin_unlock(&group->notification_lock);
		return;
	}
	group->q_len += list_count_nodes(&group->fanotify_data.access_list);
	list_splice_init(&group->fanotify_data.access_list,
			 &group->notification_list);
	spin_unlock(&group->notification_lock);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

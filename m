Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0863AE1A8
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854220; cv=none; b=rn///TXMNiEJ6WTEpHErEBBJunTbM+WKqjNbUKSP8byMisdLGLiVxmP88eIAlemNXbQYuX1dWqttVXW+05AccBWzKxHpTIBgpftFbXDIlpklwTjMaPrIuyK9gPBCEPa2OEIQYvzCvGmnb4VnM50LWiwnRuZZ9HzV3UrJ/RkZHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854220; c=relaxed/simple;
	bh=T1ePDo45rc9N4zcvkWKyrjI7u9nV7rilHnyZlEo6Bj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQZcl673YaHx88scK7Z8cGDivKZvJutvWwpMocSnGTfN7tAPBU22h0hmUwvvyBAiGLIOyYV9fkFwdib+NvlBqYhwQUqWfCBRPDEckzPU3odD8ONq6OtEnGFyRD07X+Rn7+lFNf2IBVPZgxvfmFlRCCLmTsoHosNWwXiZ813tXYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HvtUc5qx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=br/Mt+Y/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HvtUc5qx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=br/Mt+Y/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HvtUc5qx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="br/Mt+Y/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HvtUc5qx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="br/Mt+Y/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85AD36A825;
	Wed, 22 Apr 2026 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776854217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJuLfqKpkwzhPTGmi1VsGlx5XNMVksFrskBjWmbhWs=;
	b=HvtUc5qxT952swtej4NuUtHJQKFl2NpgJ8tPN0ApmROQGpz5HWZcJy8HYHjm2Ag7mGbdq+
	QEI9nzm8NPKRdpMfiqYjJaD/Q53IzUEH8/e2N6Agrxl/McGzKuIPPTSY6Mv+gKO7IM4VTC
	4g5Lp3uQWN0ajNAws3uiqFrpccwPXzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776854217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJuLfqKpkwzhPTGmi1VsGlx5XNMVksFrskBjWmbhWs=;
	b=br/Mt+Y/8zCVw9udM9DJsrsf1JZ79UDL5ejbLBzo2P4ahe6ZOCQmjb99c81F36DzkBX+xg
	yf94OXJMtu5iTrCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776854217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJuLfqKpkwzhPTGmi1VsGlx5XNMVksFrskBjWmbhWs=;
	b=HvtUc5qxT952swtej4NuUtHJQKFl2NpgJ8tPN0ApmROQGpz5HWZcJy8HYHjm2Ag7mGbdq+
	QEI9nzm8NPKRdpMfiqYjJaD/Q53IzUEH8/e2N6Agrxl/McGzKuIPPTSY6Mv+gKO7IM4VTC
	4g5Lp3uQWN0ajNAws3uiqFrpccwPXzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776854217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAJuLfqKpkwzhPTGmi1VsGlx5XNMVksFrskBjWmbhWs=;
	b=br/Mt+Y/8zCVw9udM9DJsrsf1JZ79UDL5ejbLBzo2P4ahe6ZOCQmjb99c81F36DzkBX+xg
	yf94OXJMtu5iTrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D87A593AF;
	Wed, 22 Apr 2026 10:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E3ueHsmk6GlkewAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 10:36:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 42095A0B60; Wed, 22 Apr 2026 12:36:57 +0200 (CEST)
Date: Wed, 22 Apr 2026 12:36:57 +0200
From: Jan Kara <jack@suse.cz>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: Jan Kara <jack@suse.cz>, amir73il@gmail.com, josef@toxicpanda.com, 
	lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
Message-ID: <g2fx5drvoen4tkmnxe2mc44gihhtcwqhhvc7nbe4dbv6ay6idh@xc2zlk3s7q2g>
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
 <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
 <CAAwtZY6Bas3jLQZ_GDhbjj4pekjhT6kxAQ+5_35mzwk5_HUKhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAwtZY6Bas3jLQZ_GDhbjj4pekjhT6kxAQ+5_35mzwk5_HUKhg@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,toxicpanda.com,meta.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 22-04-26 03:22:32, Ibrahim Jirdeh wrote:
> On Mon, Apr 20, 2026 at 7:37 AM Jan Kara <jack@suse.cz> wrote:
> > > +const struct file_operations fanotify_control_fops = {
> > > +     .show_fdinfo    = fanotify_show_fdinfo,
> > > +     .release        = fanotify_release,
> > > +     .unlocked_ioctl = fanotify_control_ioctl,
> > > +     .llseek         = noop_llseek,
> > > +};
> > > +
> > > +const struct file_operations fanotify_queue_fops = {
> > > +     .poll           = fanotify_poll,
> > > +     .read           = fanotify_read,
> > > +     .write          = fanotify_write,
> > > +     .release        = fanotify_queue_release,
> > > +     .unlocked_ioctl = fanotify_ioctl,
> > > +     .compat_ioctl   = compat_ptr_ioctl,
> > > +     .llseek         = noop_llseek,
> > > +};
> >
> > The new scheme with queue fd & control fd opens up an interesting new set
> > of races which needs a deeper thought I think. As it is currently
> > implemented for example if there's a task waiting for event on queue fd, it
> > will never wake up if control fd is closed. Similar problem is there for
> > fanotify_poll(). So we need to carefully define how operations on queue fd
> > synchronize with operations on control fd and closing of it in particular.
> > Besides dealing with the hung waits (which can be dealt with by just waking
> > the notification_waitq from fanotify_release()) we also need to deal with
> > fanotify_read() moving events from notification list to access list. I'm a
> > bit unhappy with how ad hoc and fragile this looks but so far don't have an
> > idea for a cleaner solution.
> >
> 
> I wanted to ask a few more questions here about the race conditions you are
> outlining. Is it accurate that the main risk of races is primarily
> related to early control fd shutdown with this new two fd case, or are
> there other races to worry about?

No, this is my main concern.

> I added a few protections in this patch so far and wanted to check if
> there are outsanding risks:
> 1) Have queue fd also maintain a group reference as well

Yes, this is good and takes care that the group is not freed. But it still
can be fully cleaned up even if you hold a reference.

> 2) Check for control fd close (group->shutdown) in fanotify_read. I will also
> incorporate the wake up in fanotify_release you have suggested here.

Yes, I've noticed that but that check is racy...

> Regarding fanotify_read moving events from notification list to access list, do
> we need to allow pending events in fanotify_restart_pending_events
> after all to prevent potential hung waits stemming from race with shutdown?

Thinking about this some more... Won't it be easier if the queue fd held a
struct file reference of the control fd? That way the notification group
couldn't be shut down until queue fd is also closed. That will deal with
all the possible races, we don't even have to hold a notification group
reference. I don't think this behavior would be surprising to userspace and
I don't see any other possible downsides either. Amir, any opinion?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

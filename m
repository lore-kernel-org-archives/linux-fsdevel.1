Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530038D41F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305183; cv=none; b=uff2VYCnLHMsOH2TN796nS+Y6HXZm2zuglac5yUp17Ggq6igDtMz+u8YCR2MSFUArk1pJd2qEO5PfK3XAfgkIYu7Vx3z9Ni6NcyNqW4Og2IL5Uqq/0VpspvGd/2Nem+iiYZUe/hU5vIWqJkfWB/5wNHKe3MYYBOCvmkxniuzkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305183; c=relaxed/simple;
	bh=E6J0AfQdtUgQ8af3l3p1zfrONnVzjhA2IIojUfoBS5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PO/wG8vEmUyJeRL7DxAdO+AmfkG0IQtEssxWCJtHjjA3P0mKJ/fAFIWL8KQ9rD2pNV8AIvGft6Y70ty0MGeTVBx4L3VsjujWYrwxe3F0kIyfy7rk1RqZAm7PZ+b8umke7CqmqzfrqEqn+G4Yu1lpWCzPGd729Le0fuLPKM+MGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y5XHMaWG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KqifryVN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y5XHMaWG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KqifryVN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y5XHMaWG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KqifryVN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y5XHMaWG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KqifryVN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43DC16B84A;
	Mon,  1 Jun 2026 09:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780305180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3gK9fvsvIAeyvPDfPYyKS0/LpTCTS41dM3KqI6bbtE=;
	b=y5XHMaWGPB9olVKVBTOJFGABfjRNjRzLwxXSXSHiBLtk1djhEcZkYlE+OKjQB/IfWqB6le
	BN90gAxCyRCPk92Qyi/v4VyQtHu0RBrRZsX2vMijglmogczCq0U5l/YxPzCcRMZ4B0p77M
	V+9ggrTGAPs8H/OONqgJdjbc0fcmxlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780305180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3gK9fvsvIAeyvPDfPYyKS0/LpTCTS41dM3KqI6bbtE=;
	b=KqifryVNi5WFmeLknzL/HW2Rdpjm2C/1xKn/ty0n914eA6BYqR4nz7+v9vrFG7YkRrwmoM
	Cpoh/4cBR544PYBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780305180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3gK9fvsvIAeyvPDfPYyKS0/LpTCTS41dM3KqI6bbtE=;
	b=y5XHMaWGPB9olVKVBTOJFGABfjRNjRzLwxXSXSHiBLtk1djhEcZkYlE+OKjQB/IfWqB6le
	BN90gAxCyRCPk92Qyi/v4VyQtHu0RBrRZsX2vMijglmogczCq0U5l/YxPzCcRMZ4B0p77M
	V+9ggrTGAPs8H/OONqgJdjbc0fcmxlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780305180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3gK9fvsvIAeyvPDfPYyKS0/LpTCTS41dM3KqI6bbtE=;
	b=KqifryVNi5WFmeLknzL/HW2Rdpjm2C/1xKn/ty0n914eA6BYqR4nz7+v9vrFG7YkRrwmoM
	Cpoh/4cBR544PYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38444779A8;
	Mon,  1 Jun 2026 09:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id swO4DRxNHWoEPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 09:13:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C75E6A0EBE; Mon, 01 Jun 2026 11:12:59 +0200 (CEST)
Date: Mon, 1 Jun 2026 11:12:59 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: AnonymeMeow <anonymemeow@gmail.com>, brauner@kernel.org, jack@suse.cz, 
	repnop@google.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: report thread pidfds for FAN_REPORT_TID
Message-ID: <sjlh32si4zbi564na7rrpnuzropsfkqd2xsf2qouskvu5cyqvk@hy7voi7i3sfp>
References: <20260528-schmuckvoll-heilen-garen-be77b4208671@brauner>
 <20260529020035.17477-1-anonymemeow@gmail.com>
 <CAOQ4uxiGr7i=_H4XttS3kWKni1nT75BjnVNZM-0j2JnAHLY7cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiGr7i=_H4XttS3kWKni1nT75BjnVNZM-0j2JnAHLY7cA@mail.gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
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
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.cz,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Fri 29-05-26 09:21:55, Amir Goldstein wrote:
> On Fri, May 29, 2026 at 4:01 AM AnonymeMeow <anonymemeow@gmail.com> wrote:
> >
> > The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> > exclusive because by the time the pidfd support was introduced to
> > fanotify, pidfds could only be created for thread group leaders. Now
> > that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> > this restriction can be lifted.
> >
> > Also drop the pid_has_task() check to allow pidfds to be reported for
> > reaped tasks as well.
> 
> I am not objecting to this change, but as a rule of thumb, almost
> every time that
> a commit message says "Also" it means that it should have been a separate
> commit.
> 
> This is not an exception to the rule and even worse -
> This change PIDFD_STALE is an independent change of behavior
> (as observed by breakage of fanotify21) that could (maybe unlikely)
> surprise real users.
> 
> We have few options:
> 1. Make it opt-in with yet another fanotify_init flag
> 2. Enable it implicitly together (and in the same patch) with FAN_REPORT_TID
> 3. Enable it without opt-in (as you did) but as separate patch
>     that will be reverted if someone complains on "real world"
>     (i.e. not test) breakage
> 
> IMO, the path of least resistance is option 2.
> If users want to get the pidfd of tgid I suppose there should be no
> problem to get it from the pidfd of the thread. Right?
> So what FAN_REPORT_TID really means is give me a richer pidfd
> with more information about the actor than without FAN_REPORT_TID.
> 
> I'd like to get Jan's input on those UAPI choices.

In this case I agree with Christian. I don't think there's a reason to
complicate the API so I'd go for 3 - I totally agree we want this in a
separate commit to have the change of behavior clearly documented and easy
to revert. I just think the pidfd could always be stale by the time you get
to use it so I think chances for unexpected userspace confusion are
limited. 

								Honza

> > Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
> > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> > ---
> >
> > On 2026-05-28 13:51 +0200, Christian Brauner wrote:
> > > For quite a while the kernel refused to hand out pidfds for reaped
> > > processes even if the struct pid was pinned like in this case.
> > >
> > > But that makes various APIs - including this one - way less powerful
> > > than they can be. Nowadays the socket layer already hands out pidfds for
> > > reaped processes. It also stashed the struct pid. Let's do the same
> > > here.
> > >
> > > Drop the pid_has_task() change and then:
> > >
> > > pidfd = pidfd_prepare(event->pid, pidfd_flags | PIDFD_STALE, &pidfd_file);
> > >
> > > which instructs pidfs to and out a pidfd even if the task has already
> > > been reaped. Reaped pidfds can still be queried for various types of
> > > information that is kept around even if the task is long gone.
> >
> > Thanks for the review. I've updated this in v2 as you suggested.
> >
> > Also, the LTP fanotify21 test currently explicitly expects ESRCH or
> > FAN_NOPIDFD for exited processes. I will update that test case accordingly.
> 
> This sentence highlights the problematic aspect of this change.
> How would you update the test expectation?
> The test must be able to run on upstream as well as stable kernels.
> Would you test for support in FAN_REPORT_TID
> and according to the result determine the expected behavior of the
> test cases (variants) without FAN_REPORT_TID?
> Very ugly IMO.
> 
> OTH, if you take the suggestion that PIDFD_STALE is implied only
> for FAN_REPORT_TID, you can change the expectation for the
> "terminated child" test case only for TST_VARIANT_PIDFD_THREAD.
> 
> Thanks,
> Amir.
> 
> >
> > With Best Regards,
> > AnonymeMeow
> >
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
> >  1 file changed, 7 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index ae904451dfc0..b604e3da58ad 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/memcontrol.h>
> >  #include <linux/statfs.h>
> >  #include <linux/exportfs.h>
> > +#include <linux/pidfd.h>
> >
> >  #include <asm/ioctls.h>
> >
> > @@ -903,25 +904,13 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >                 metadata.fd = fd >= 0 ? fd : FAN_NOFD;
> >
> >         if (pidfd_mode) {
> > -               /*
> > -                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > -                * exclusion is ever lifted. At the time of incoporating pidfd
> > -                * support within fanotify, the pidfd API only supported the
> > -                * creation of pidfds for thread-group leaders.
> > -                */
> > -               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > +               unsigned int pidfd_flags = PIDFD_STALE;
> >
> > -               /*
> > -                * The PIDTYPE_TGID check for an event->pid is performed
> > -                * preemptively in an attempt to catch out cases where the event
> > -                * listener reads events after the event generating process has
> > -                * already terminated.  Depending on flag FAN_REPORT_FD_ERROR,
> > -                * report either -ESRCH or FAN_NOPIDFD to the event listener in
> > -                * those cases with all other pidfd creation errors reported as
> > -                * the error code itself or as FAN_EPIDFD.
> > -                */
> > -               if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID))
> > -                       pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
> > +               if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> > +                       pidfd_flags |= PIDFD_THREAD;
> > +
> > +               if (metadata.pid)
> > +                       pidfd = pidfd_prepare(event->pid, pidfd_flags, &pidfd_file);
> >
> >                 if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd < 0)
> >                         pidfd = pidfd == -ESRCH ? FAN_NOPIDFD : FAN_EPIDFD;
> > @@ -1628,14 +1617,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
> >  #endif
> >                 return -EINVAL;
> >
> > -       /*
> > -        * A pidfd can only be returned for a thread-group leader; thus
> > -        * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
> > -        * exclusive.
> > -        */
> > -       if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> > -               return -EINVAL;
> > -
> >         /* Don't allow mixing mnt events with inode events for now */
> >         if (flags & FAN_REPORT_MNT) {
> >                 if (class != FAN_CLASS_NOTIF)
> > --
> > 2.54.0
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

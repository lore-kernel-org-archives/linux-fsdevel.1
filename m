Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF083B42F2
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910833; cv=none; b=G9xAnGCfr+2An7Y+ep38WvBngp+G4THtM/kGw8jT5VKSX6J/o6wdXL7cj9VpkSIPlHEN+Fgw/VjnJd14VsXh9pHIFXYGnuM3vIXlNOKroy+J2PFvgfe7EZwWjys99aBB7dLqSeEzkQjwZg2GvPW4NoYbnm1tOfwLS52xHi007CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910833; c=relaxed/simple;
	bh=likwpcIXybgpUljWjqiVMBv9T99dws/X+K9nngjiVS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULNLWvLL1qdYGM4E48LTpCO5QZ/fnTQLgcSt15qFHygbRFULJ0HD1IO+r3wrEy3HhAxBGh6z1keOIHz48C8kzN76goz+AKMpgzVquUK9IdDQDolMtwl2t6zuxNCi6PRFHaUU3c9tMu0yqKWlisw37Ii8S/1yuVPvxnKQSl87q9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q/LzOXWq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y2XzFVfI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dcBjDm4P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PGerM/e2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q/LzOXWq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y2XzFVfI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dcBjDm4P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PGerM/e2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB8436A882;
	Mon,  8 Jun 2026 09:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780910830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKKeIv1sqtxLWuLx0lfIWotywCYqJPoKZsdFWJJkhYk=;
	b=q/LzOXWq/u7rhHIP9liqFIrlkfiuZcIFGZd5SxiAcSvCQQ/Zlxj61I130LNILf6ewUr2Uq
	ZsOVJBQragCggaTqUWjPr4ZL9DdHcGgB7Lv0iRkqta+92IC3YjMVuyLeKLrfEZKjQ+M5a4
	kGe6Nj30TBywBpnD/r2uSK9DbxuEwfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780910830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKKeIv1sqtxLWuLx0lfIWotywCYqJPoKZsdFWJJkhYk=;
	b=Y2XzFVfIuWUen07p97yucR4g7OmD2HatliZOmYYfzUHGIy4sFSTp+emxT7eqqocWfmKhIg
	0LrJnGQhcLzJ2+Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dcBjDm4P;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="PGerM/e2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780910829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKKeIv1sqtxLWuLx0lfIWotywCYqJPoKZsdFWJJkhYk=;
	b=dcBjDm4PZGdOykZzJI8nWHmAUib18+KbJJx2IlICvaX0lsBLKM2XpDyCuexUwFNHhYMb+h
	fPuUeZAC/Lr8zE1Qj17AuGTMmcw1D8Uuc7nQ3jcrZL3XgKbDCp7b77Ve+/64HYsj2pQJVK
	j9KI6OERsmejuh7PprhBUCOpht5rHCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780910829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LKKeIv1sqtxLWuLx0lfIWotywCYqJPoKZsdFWJJkhYk=;
	b=PGerM/e2NW8q+BfvYGl+PG5kpq/aGnrtDv6TIrz/Fm6tF5Jzpo6En3LKlNe8zd1cjjTjKZ
	ab9pPrxwYX1kMPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0E21779A9;
	Mon,  8 Jun 2026 09:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b1sTL+2KJmrhBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 09:27:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 572D3A10CB; Mon, 08 Jun 2026 11:27:01 +0200 (CEST)
Date: Mon, 8 Jun 2026 11:27:01 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, AnonymeMeow <anonymemeow@gmail.com>, 
	amir73il@gmail.com, repnop@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: register event pid for pidfd reporting
Message-ID: <i2gudjbai3vbyvhbbgcppt2vexnkkjqq35n53sjpx66i5k4lg3@5wu5hvzifpnc>
References: <20260530013732.50811-1-anonymemeow@gmail.com>
 <20260530105117.45792-1-anonymemeow@gmail.com>
 <dolfs6j4x4thpgluglxhlepg34l5uvvxv2sjcmuao57bxnbtjb@urx5vgczxbup>
 <20260602-patzt-sturz-segen-f1f305d61b75@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5w6nv5meznsemm7q"
Content-Disposition: inline
In-Reply-To: <20260602-patzt-sturz-segen-f1f305d61b75@brauner>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.com:email,msgid.link:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CB8436A882
X-Spam-Score: -4.01


--5w6nv5meznsemm7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 02-06-26 15:50:19, Christian Brauner wrote:
> On Mon, Jun 01, 2026 at 05:24:36PM +0200, Jan Kara wrote:
> > On Sat 30-05-26 18:51:17, AnonymeMeow wrote:
> > > pidfd_prepare() may still fail if userspace reads the event after the
> > > task has been reaped and the pid has not been registered with pidfs.
> > > Register the event pid with pidfs when creating the fanotify event if
> > > pidfd reporting was requested, so pidfd_prepare() can later create a
> > > pidfd for the reaped task.
> > > 
> > > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> > 
> > So the two patches in this series so far look good to me. This patch looks
> > OK to me as well and since the overhead of allocation etc. is only once per
> 
> It's a kmem cache so should not matter at all...
> 
> > registered task, I think it's fine but let's wait a bit whether Christian
> > agrees this is what needs to be done.
> 
> pidfs_register_pid() can only fail with ENOMEM or if the task is already
> dead. The latter cannot happen because even for a non-empty thread group
> where the thread-group leader already exited but subthreads are still
> alive the thread-group leader cannot be reaped. So the only error here
> is ENOMEM which means we should defo fail this, imho.
> 
> And yes, I think this is worth doing. Because you get a persistent
> handle on the task that generated that event + all the exit information
> even if that thask has been reaped in the meantime. I'm pretty sure if
> you're using fanotify that's a rather huge win for apps that need it.

OK, thanks for opinion. So I've somewhat massaged the error handling in the
patch AnonymeMeow. Attached is what I currently have in my tree (testing
pending).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--5w6nv5meznsemm7q
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-fanotify-register-event-pid-for-pidfd-reporting.patch"

From f1d94103161de2b233193faeeeb933a2f3c5584a Mon Sep 17 00:00:00 2001
From: AnonymeMeow <anonymemeow@gmail.com>
Date: Sat, 30 May 2026 18:51:17 +0800
Subject: [PATCH] fanotify: register event pid for pidfd reporting

pidfd_prepare() may still fail if userspace reads the event after the
task has been reaped and the pid has not been registered with pidfs.
Register the event pid with pidfs when creating the fanotify event if
pidfd reporting was requested, so pidfd_prepare() can later create a
pidfd for the reaped task.

[JK: Reworked error handling ]

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
Link: https://patch.msgid.link/20260530105117.45792-1-anonymemeow@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 8ed77901db57..de013dd132d7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -14,6 +14,7 @@
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
 #include <linux/stringhash.h>
+#include <linux/pidfs.h>
 
 #include "fanotify.h"
 
@@ -760,7 +761,7 @@ static struct fanotify_event *fanotify_alloc_event(
 	bool name_event = false;
 	unsigned int hash = 0;
 	bool ondir = mask & FAN_ONDIR;
-	struct pid *pid;
+	struct pid *pid = NULL;
 
 	if ((fid_mode & FAN_REPORT_DIR_FID) && dirid) {
 		/*
@@ -839,6 +840,16 @@ static struct fanotify_event *fanotify_alloc_event(
 	/* Whoever is interested in the event, pays for the allocation. */
 	old_memcg = set_active_memcg(group->memcg);
 
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
+		pid = get_pid(task_pid(current));
+	else
+		pid = get_pid(task_tgid(current));
+
+	/* Prepare task for creating pidfd for it even if it exits */
+	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD))
+		if (pidfs_register_pid(pid))
+			goto out;
+
 	if (fanotify_is_perm_event(mask)) {
 		event = fanotify_alloc_perm_event(data, data_type, gfp);
 	} else if (fanotify_is_error_event(mask)) {
@@ -860,17 +871,14 @@ static struct fanotify_event *fanotify_alloc_event(
 	if (!event)
 		goto out;
 
-	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
-		pid = get_pid(task_pid(current));
-	else
-		pid = get_pid(task_tgid(current));
-
 	/* Mix event info, FAN_ONDIR flag and pid into event merge key */
 	hash ^= hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HASH_BITS);
 	fanotify_init_event(event, hash, mask);
 	event->pid = pid;
-
+	pid = NULL;
 out:
+	if (pid)
+		put_pid(pid);
 	set_active_memcg(old_memcg);
 	return event;
 }
-- 
2.51.0


--5w6nv5meznsemm7q--

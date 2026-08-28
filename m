Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9B3431F5;
	Fri, 28 Aug 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938621; cv=none; b=YKvK17V4CLdXhbblNNAkgNZXlULwo6tOxV1NE9q3O6qgDCw39c1te9X9Mu4vb/P8umq9u+aZsl+4O1EsYY7B4Q4cKTYpIcdgVC3oUf2t/gGx8yazQ9BB2E13nAT0FYBAnB/oN7nIpqtgltZuQyKSkCv/T9IM5ol6AK5Qs/isq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938621; c=relaxed/simple;
	bh=9sU0BoNVUBuLNIn4TemWP2dUeXrY7o+f+xbrMaDVlaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBPYDO/mMPuKvQxFcdLaYgpsZR4L6v8/DYY27pTkGaERZANvWXPurIWgUmXy8laknH5bMgWffoQO4lGwizEoE/a+XQxkbLAYivS8PuGOzPp3UgmTPCcE7i8h+TC0jdj+Et9YIivnKVkCBU56+NRZIoX6VNVkxWqpPYhgoBFqgBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dm+RcaSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZR8TvWn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWoLZIXC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TWq1zfuC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dm+RcaSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZR8TvWn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWoLZIXC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TWq1zfuC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8738221DBA;
	Fri, 28 Aug 2026 17:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787938612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBQ9/dryn3WFrb3tzJjFqS/35QeTG6Witquds+L+naI=;
	b=Dm+RcaSdBcLN+sgMVCmOBC8+WekSPoW9Rf22pth+ZOiQ1TG8DoNGs7TujhgZ8IqmINagJq
	Krfres9UPRsutdhgCHge+eG55C/rnrNo1j0Gsb18J1CIgWqQwB1WAIqMHszeCj/y3rOmyP
	N5Shl89m1/QFroIaskn8OfrU7p3tgAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787938612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBQ9/dryn3WFrb3tzJjFqS/35QeTG6Witquds+L+naI=;
	b=wZR8TvWnmiSZAhxU2AoJ8sfm4eYjBdhLuRvDL2xOG85eylYExMeq2Q8j44GIpGphhYIsoO
	7ElWSR7RMucca+Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wWoLZIXC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TWq1zfuC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787938608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBQ9/dryn3WFrb3tzJjFqS/35QeTG6Witquds+L+naI=;
	b=wWoLZIXClODxfrLKPMUSOx98tvjVi5hCzXWQXPU6ZYJ3rMqLl+UgXc9Qvq/CZpxoW44JoZ
	Xjv6fkRiR2tYVAfjc1G+CanUhA0alBWTL+yyAd2P64GzeKOYnpbMWwkFgdMCRNbGTuKPg5
	HgNoux9MRvfP58Yp5zEpdWAaoVgybrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787938608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBQ9/dryn3WFrb3tzJjFqS/35QeTG6Witquds+L+naI=;
	b=TWq1zfuCqa1RRT2kF9N2lZPQvph2srQDbdll0HlMMcxujtouvw4/OD8AHfFHP95dztB4iw
	Q8Er1EtknrcXV6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65B2313515;
	Fri, 28 Aug 2026 17:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tpLPGDDHkWoHYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Aug 2026 17:36:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA7FAA1324; Fri, 28 Aug 2026 19:36:47 +0200 (CEST)
Date: Fri, 28 Aug 2026 19:36:47 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Daehyeon Ko <4ncienth@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
References: <20260827045007.3831259-1-4ncienth@gmail.com>
 <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com>
 <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8738221DBA
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 28-08-26 12:18:52, Amir Goldstein wrote:
> On Fri, Aug 28, 2026 at 11:05 AM Jan Kara <jack@suse.cz> wrote:
> > On Fri 28-08-26 13:24:19, Daehyeon Ko wrote:
> > > You are right that an fd-held dentry cannot satisfy the count == 1 check. I
> > > was imprecise in the report: the fd and the final unlink refer to two
> > > different hard-link dentries for the same inode.
> > >
> > > The setup is:
> > >
> > >   1. create A/x and link it as B/y;
> > >   2. open B/y, add the old-group inode mark through that fd, then unlink
> > >      B/y, leaving i_nlink == 1 while the fd retains the B/y dentry;
> > >   3. race these two calls:
> > >
> > >        unlink("A/x")
> > >
> > >        fanotify_mark(racer_group, FAN_MARK_ADD, FAN_MODIFY,
> > >                      victim_fd, NULL)
> > >
> > >      where victim_fd still refers to the already unlinked B/y dentry.
> > >
> > > So the A/x dentry checked by d_delete() is not held by the fd and can have
> > > d_lockref.count == 1. Its unlink drops the inode's last link and reaches
> > > dentry_unlink_inode() -> fsnotify_inoderemove(). At the same time,
> > > fanotify_find_path() gets the same inode through the fd-held B/y dentry and
> > > adds the racer mark.
> >
> > Thanks for explanation of the reproducer. Now it makes sense. The
> > conclusion from this is that fsnotify_inoderemove() can indeed be called
> > for still fully alive open inodes which should be (think of permission /
> > pre-content events) still generating events. That could be actually
> > breaking some assumptions of userspace although I don't think it's a
> > serious issue in practice because users of permission / pre-content watches
> > tend to use filesystem / mount watches.
> >
> > Also I think we could generate FS_DELETE_SELF twice for the inode - once it
> > will we generated as a result of d_delete("A/x"), and finish_dput() ->
> > dentry_kill() -> dentry_unlink_inode() will generate it for the second time
> > on the last close of the open through "B/y". That should be mostly harmless
> > but still it's an oddity to keep in mind and preferably avoid if we can.
> 
> I don't know. This sounds like a fundamental behavior change.
> In current upstream FAN_DELETE_SELF is a dying breath of an
> inode and no more events on this inode are expected IIUC.
> 
> Applications could be relying on this.
> In fact I have an application that almost relies on this, but IIRC
> it does one last open_by_handle_at() to make sure before calling
> the inode dead. Other applications could be less strict.
> 
> Changing behavior so events could happen after FAN_DELETE_SELF
> sounds risky.

I was probably imprecise with my wording. What I meant is that *currently*
when you have a hardlinked inode, you open and unlink through B/y and then
the unlink though A/x races with close of the B/y file, then you could get
two FAN_DELETE_SELF events if the race works out right. The only change of
behavior I was planning was avoiding this race if possible :).
 
> > Now there's the question about the best fix for the problem. I've realized
> > we cannot just remove the call to fsnotify_inode_delete() from the place
> > where fsnotify_inoderemove() is called (and rely on the call from
> > __destroy_inode()) because the connector holds inode reference and so
> > __destroy_inode() would never get called. Hrm, this is a hairy issue and so
> > far I don't see a good place to reliably trigger detaching of connector
> > from the inode. One reliable place would be iput() but that's really ugly
> > and would slow down every iput() user. The cleanest solution I can
> > currently see is to stop holding inode reference from a connector as I've
> > proposed in the past. Then we can reliably perform the cleanup in
> > __destroy_inode(). But that will be a rather non-trivial undertaking. Amir,
> > do you see some other option?
> 
> What about the option I proposed to live with the orphan marks
> Is it so bad? I mean it's confusing and removing the assertion could
> hide real bugs/races, but maybe it's worth not complicating the code
> until we move forward to re-attachable marks.

I'm not so much worried about the case when placing of the mark races with
unlink. There I agree we can somehow paper over the problem for now. What
I'm more worried about is the case where someone places a precontent /
permission mark on the inode and a malicious user does hardlink + open +
unlink trick and after unlinking the original link to the inode, he has an
open fd to the inode stripped of any notification marks which I'd say
violates the promise of precontent / permission marks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

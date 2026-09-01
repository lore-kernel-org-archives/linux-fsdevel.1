Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6153484249;
	Tue,  1 Sep 2026 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281862; cv=none; b=O7BGIpQ1dTBjr8jf+6FJ7wFz0E0NflNKW2g6qp4/0VjUPV+6b/hUXkhHGMocpWUMjQjhlP8JEggRQQiXoE4DvLXjr+tP2n/QE33Pd4jWSsZIyVxzQMtUlkNcKds/SPDBem0bBk4oimEoCB9jiAlYH69Xd3dmyeMuPMyjfAUzn1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281862; c=relaxed/simple;
	bh=aP8j808cNGEoUFVK5JBvmjXlDDXd02qy+j7hXabnXtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzygqEkEXhOVuQlXjA4wgYYn6zXMHxHQLNscMP5fdUHpleCWPHvf3ufmpDq5eXb4i6Cqgw3k1zME9+nJPotHB5BEav+yavngAvN0eegNQhcTAq5AQntgc4Llw5ORQJGkmHb4GFOGl3PyHWsiJvkEDfg69WpZFrbBtnpJVous1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0oYD57yd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=igSYNu4x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYZcxQxw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u2XLjbsp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0oYD57yd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="igSYNu4x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYZcxQxw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u2XLjbsp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6614521CE7;
	Tue,  1 Sep 2026 16:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788281854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+QNXdIhnk1gL4BxJRspZ7Kc8XhBJngLz4vooKum2fo=;
	b=0oYD57ydSALCqs1SWcH7kddx7YHZ3f/A+1ZrohwbIvZpIpO0oiKNl+I+c+ubEUdQ6mO7Ip
	NXFP8lDILUd4quYhaOrizSmiXwidZDXFDzEZBaW6gzAKf+lC61jCjF40Cd+QNXOnK2ywuF
	ZbeUs+C25QbvAhOTpFzAT9ODAUPlnVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788281854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+QNXdIhnk1gL4BxJRspZ7Kc8XhBJngLz4vooKum2fo=;
	b=igSYNu4xzHvz+cJs4NMBe2Z0WOnksBW8bMTRAwqGtFLlDjstORzbg+IEPTcF9Bs6UrPcRl
	07vDhj7woOJyGgCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WYZcxQxw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u2XLjbsp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788281850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+QNXdIhnk1gL4BxJRspZ7Kc8XhBJngLz4vooKum2fo=;
	b=WYZcxQxwPXJRsYbDYUv2fY25doPWw+qf6BpeFGr2mas48h6x8ZBD9IeZlq1Xu6n6b70nK1
	OU4mnoF9qfnz2FqoNvfhYA4djJiZtMsbQRaBU4ytx/LWeFXtcbal6YVAGtbBfQxy4GmgMv
	101Ky/uyWFhtlBgwTPb1FUg/fATEFKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788281850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+QNXdIhnk1gL4BxJRspZ7Kc8XhBJngLz4vooKum2fo=;
	b=u2XLjbspCljneqvgZBKifRTC9k6KEIu2HLWZ78Kb+2scZkDmon6GJ4UW0TZPF7b8XCeFfX
	scKR9QSzuAyz2CBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FCD113515;
	Tue,  1 Sep 2026 16:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zUmOD/oDl2otCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Sep 2026 16:57:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ACD16A13B2; Tue, 01 Sep 2026 18:57:21 +0200 (CEST)
Date: Tue, 1 Sep 2026 18:57:21 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Daehyeon Ko <4ncienth@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
References: <20260827045007.3831259-1-4ncienth@gmail.com>
 <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com>
 <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
 <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
 <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 6614521CE7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Flag: NO

On Mon 31-08-26 16:54:55, Amir Goldstein wrote:
> On Mon, Aug 31, 2026 at 1:39 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 29-08-26 17:04:19, Amir Goldstein wrote:
> > > On Fri, Aug 28, 2026 at 7:36 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > Now there's the question about the best fix for the problem. I've realized
> > > > > > we cannot just remove the call to fsnotify_inode_delete() from the place
> > > > > > where fsnotify_inoderemove() is called (and rely on the call from
> > > > > > __destroy_inode()) because the connector holds inode reference and so
> > > > > > __destroy_inode() would never get called. Hrm, this is a hairy issue and so
> > > > > > far I don't see a good place to reliably trigger detaching of connector
> > > > > > from the inode. One reliable place would be iput() but that's really ugly
> > > > > > and would slow down every iput() user. The cleanest solution I can
> > > > > > currently see is to stop holding inode reference from a connector as I've
> > > > > > proposed in the past. Then we can reliably perform the cleanup in
> > > > > > __destroy_inode(). But that will be a rather non-trivial undertaking. Amir,
> > > > > > do you see some other option?
> > > > >
> > > > > What about the option I proposed to live with the orphan marks
> > > > > Is it so bad? I mean it's confusing and removing the assertion could
> > > > > hide real bugs/races, but maybe it's worth not complicating the code
> > > > > until we move forward to re-attachable marks.
> > > >
> > > > I'm not so much worried about the case when placing of the mark races with
> > > > unlink. There I agree we can somehow paper over the problem for now. What
> > > > I'm more worried about is the case where someone places a precontent /
> > > > permission mark on the inode and a malicious user does hardlink + open +
> > > > unlink trick and after unlinking the original link to the inode, he has an
> > > > open fd to the inode stripped of any notification marks which I'd say
> > > > violates the promise of precontent / permission marks.
> > >
> > > I see. so we need a point where there are no more hardlinks and no more
> > > dentry aliases to the inode.
> > >
> > > How about we check for this condition?
> > >
> > > --- a/fs/dcache.c
> > > +++ b/fs/dcache.c
> > > @@ -471,7 +471,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
> > >         raw_write_seqcount_end(&dentry->d_seq);
> > >         spin_unlock(&dentry->d_lock);
> > >         spin_unlock(&inode->i_lock);
> > > -       if (!inode->i_nlink)
> > > +       if (!inode->i_nlink && hlist_empty(&inode->i_dentry))
> > >                 fsnotify_inoderemove(inode);
> >
> > This looks like an intriguing idea. But I think it still has a hole. Until
> > the last inode reference is put, open_by_handle() can still get you a new
> > dentry and an open file pointing to that inode.
> 
> Maybe we can close this hole, because whether open_by_handle()
> should or should not succeed in this case is not well defined,
> We can make it defined.
> Something like this?
> NFS should have a sillyrenamed link to avoid undefined behavior
> around unlinked open files.

Hum, right. That could work.

> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -459,6 +459,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
>         __releases(dentry->d_inode->i_lock)
>  {
>         struct inode *inode = dentry->d_inode;
> +       bool dead;
> 
>         raw_write_seqcount_begin(&dentry->d_seq);
>         __d_clear_type_and_inode(dentry);
> @@ -469,9 +470,12 @@ static void dentry_unlink_inode(struct dentry * dentry)
>          */
>         dentry->waiters = NULL;
>         raw_write_seqcount_end(&dentry->d_seq);
> +       dead = !inode->i_nlink && hlist_empty(&inode->i_dentry);
> +       if (dead)
> +               inode->i_state |= I_ZOMBIE;

Do we really need the I_ZOMBIE state? I think we can just check i_nlink and
hlist_empty() directly in __d_obtain_alias(), cannot we? Once this
condition is true, it cannot change until we go through
__d_obtain_alias()...

>         spin_unlock(&dentry->d_lock);
>         spin_unlock(&inode->i_lock);
> -       if (!inode->i_nlink)
> +       if (dead)
>                 fsnotify_inoderemove(inode);
>         if (dentry->d_op && dentry->d_op->d_iput)
>                 dentry->d_op->d_iput(dentry, inode);
> @@ -2244,6 +2248,12 @@ static struct dentry *__d_obtain_alias(struct
> inode *inode, bool disconnected)
> 
>         security_d_instantiate(new, inode);
>         spin_lock(&inode->i_lock);
> +       if (inode->i_state & I_ZOMBIE) {
> +               spin_unlock(&inode->i_lock);
> +               dput(new);
> +               iput(inode);
> +               return ERR_PTR(-ESTALE);

I think a failure return after security_d_instantiate() could be unexpected
so we need to do this check before calling it.

> +       }
>         res = __d_find_any_alias(inode); /* recheck under lock */
>         if (likely(!res)) { /* still no alias, attach a disconnected dentry */
>                 unsigned add_flags = d_flags_for_inode(inode);

Thanks for looking into this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

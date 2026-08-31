Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1C3E00A9;
	Mon, 31 Aug 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176455; cv=none; b=NE+ptW+DZTdkC2Qwae2d4Slqbw7CXuoEcwIUOkWzuVMlBiwospdDjx5aqJEPQIIt0aPLrHiIFq06b7xZ83G4nsWwCL0kMMsA5/P+g5NkTeMpjEc8wQfubAMY3AV86wZgyPK7boPzxQHK20K/EKXxjHvWdwAF63bQlu9e/pIzRSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176455; c=relaxed/simple;
	bh=xIcDWx7qO76O+94qcOZ2275IwdS+NOLM1XEiNpBKL5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh4dq1f6EQQlbq/izoGgFx0rFdqum/jZNQZsFznxk7wvWyzDwyQEpm6hiEbExxb28niU1eLekvs+bMaeP68IiYXLWNtbEGxRN/ho1FKm0G3lx4mnehLC+/KoUCzix0ksC3TmoUIDwgu1EX5yi2Hd1eFGJVMUQPACd/jYUsjbhZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FbiVWpKD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0E7J6h1A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXjoDg+7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1hZ1tBV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FbiVWpKD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0E7J6h1A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXjoDg+7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1hZ1tBV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D21081FD12;
	Mon, 31 Aug 2026 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788176378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTRty398GXlcqWISPVlAJ3GmdmLdx7245mBr8r7j8pA=;
	b=FbiVWpKDfjKCbDbU90n6NKF44haSISnMDWJ/Edx0mZgWsg/BEs5+cgro3Xf02eBbkSuYqX
	7v+hDkLbz2vJ8HfYXg5pcoRQz93zCDdBeiFRufZNTVqpSoka99kzPlss7r5HqgazqLanNS
	hGTkRUPa0tmi1lLqo0ym+7Yj6svVwFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788176378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTRty398GXlcqWISPVlAJ3GmdmLdx7245mBr8r7j8pA=;
	b=0E7J6h1AJiGopyyG4PmSx2V20IOhavGhLNV1ixOEukqT9bakDOWuhfzV0DUK/8X2hDqW/C
	rE3H6CEfxLZhFUBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788176374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTRty398GXlcqWISPVlAJ3GmdmLdx7245mBr8r7j8pA=;
	b=bXjoDg+72I+Kiy+NZMLGvnqq8pUP0wnvXBo7qMHpwOPX05X0FD734fqSjHwt5uz2kbdQKA
	sbzcGpaIMHL4CoF4+uPGfHZO/EfnfTg/snBGHiTZa6vYrA1smrOmYZf5phQegEGFUBZEZN
	2xyUbUxxg4G5AP2t6zh/ZuHOt89j4Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788176374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTRty398GXlcqWISPVlAJ3GmdmLdx7245mBr8r7j8pA=;
	b=U1hZ1tBV6VRSmYx1K2Li4UA7+XWAnxIxFz2867dPilUHo2Ashq4E/y5SvFf7DjY5ypBsRg
	7I2M4h/wz00mn3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B130013694;
	Mon, 31 Aug 2026 11:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mcYqK/ZnlWogVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 11:39:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3A8D8A13B5; Mon, 31 Aug 2026 13:39:30 +0200 (CEST)
Date: Mon, 31 Aug 2026 13:39:30 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Daehyeon Ko <4ncienth@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
References: <20260827045007.3831259-1-4ncienth@gmail.com>
 <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com>
 <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
 <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Sat 29-08-26 17:04:19, Amir Goldstein wrote:
> On Fri, Aug 28, 2026 at 7:36 PM Jan Kara <jack@suse.cz> wrote:
> > > > Now there's the question about the best fix for the problem. I've realized
> > > > we cannot just remove the call to fsnotify_inode_delete() from the place
> > > > where fsnotify_inoderemove() is called (and rely on the call from
> > > > __destroy_inode()) because the connector holds inode reference and so
> > > > __destroy_inode() would never get called. Hrm, this is a hairy issue and so
> > > > far I don't see a good place to reliably trigger detaching of connector
> > > > from the inode. One reliable place would be iput() but that's really ugly
> > > > and would slow down every iput() user. The cleanest solution I can
> > > > currently see is to stop holding inode reference from a connector as I've
> > > > proposed in the past. Then we can reliably perform the cleanup in
> > > > __destroy_inode(). But that will be a rather non-trivial undertaking. Amir,
> > > > do you see some other option?
> > >
> > > What about the option I proposed to live with the orphan marks
> > > Is it so bad? I mean it's confusing and removing the assertion could
> > > hide real bugs/races, but maybe it's worth not complicating the code
> > > until we move forward to re-attachable marks.
> >
> > I'm not so much worried about the case when placing of the mark races with
> > unlink. There I agree we can somehow paper over the problem for now. What
> > I'm more worried about is the case where someone places a precontent /
> > permission mark on the inode and a malicious user does hardlink + open +
> > unlink trick and after unlinking the original link to the inode, he has an
> > open fd to the inode stripped of any notification marks which I'd say
> > violates the promise of precontent / permission marks.
> 
> I see. so we need a point where there are no more hardlinks and no more
> dentry aliases to the inode.
> 
> How about we check for this condition?
>
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -471,7 +471,7 @@ static void dentry_unlink_inode(struct dentry * dentry)
>         raw_write_seqcount_end(&dentry->d_seq);
>         spin_unlock(&dentry->d_lock);
>         spin_unlock(&inode->i_lock);
> -       if (!inode->i_nlink)
> +       if (!inode->i_nlink && hlist_empty(&inode->i_dentry))
>                 fsnotify_inoderemove(inode);

This looks like an intriguing idea. But I think it still has a hole. Until
the last inode reference is put, open_by_handle() can still get you a new
dentry and an open file pointing to that inode.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

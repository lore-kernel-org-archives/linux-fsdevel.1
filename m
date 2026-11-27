Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788238;
	b=2ouNtIJXBuWuEMe2ZfCsnrlirvLJE6qM4yBO4dFhwZKFvrV+okI1pYFeqBuxV9qT+6dd
	 gvkYnComwnvwDhemnwCaQUf68bLWUulBytgRDTEPs9f+Dz8FZolH1rXGISZ3ofnUdWvHA
	 HLw1m5dDvfLRzj44nuieokTHzEcBp0e5/xO1ECA7KVuL7xRX68tID7OOUWaxTytQzXxN6
	 RsXTwf8XAt+a+jiNga6dG3l4vfoQhpdk8AUfHHERrgiYlhFXJ6dmGeqR1rsB03UH+jK0F
	 sI0uMvupuJQ+d2HIVXQTzz5xspq800alt/ggz3hguhV46QARIU9rIi0/R/6DHe5n2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788238;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=0OW9ZyYKCZqKZl7q7CogLU0g5vabU4+IWXGGAbZVYHU=;
	b=vZzYYg1VI+gucvPiTKR6qG8BD9KcPPZfddA814ZFUJBnDLdpxWAytHzcfgywARskEHL8
	 9R4qj+xg3iQa7jQPbQYu6dadk1LSM/EjoQUNwPxqMhFUuKcaVxzLhxhbsBciWckLrMQ+x
	 SY7O00cyG0ZxEvNGmX1ghKgl0YREfsd+PsCfpVDUqEgY6MvmdXnK0xggg1d6uD+MVclRH
	 dRUembXILpVnl6mGz/GJ0hBu5mJOXuBLsgcIBgs4vIdGNo0Hoan+Ol+EGO6yPX1vT88NI
	 b0b11bX9yBcSiWluEXDK+lsACo5HjDvIhp5o4WSqBwjFsdC1jtdRuvgQ1JXe5JnbeRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YYuncEyD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v5uXmNcI;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YYuncEyD;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v5uXmNcI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A5606A31C;
	Fri, 27 Nov 2026 14:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A8A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YYuncEyD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v5uXmNcI;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YYuncEyD;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v5uXmNcI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E32722961;
	Fri, 27 Nov 2026 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795788235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OW9ZyYKCZqKZl7q7CogLU0g5vabU4+IWXGGAbZVYHU=;
	b=YYuncEyDn1wtqVyok+7Q59Z450F1SQyTK3SDOw2ooP5SYrqg2sgNf0AHuNTHSfTmWFDOWn
	u1/eRz4SU3L3WjQN/kes1KlLSSvf9kvxM6nivptijw84XVi/6tSu2IP/jMGkl7n1ZTi9cJ
	6/tCDmiN+KHXxCiKBGw9TOf1t372gA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795788235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OW9ZyYKCZqKZl7q7CogLU0g5vabU4+IWXGGAbZVYHU=;
	b=v5uXmNcIicdyrsxm/th/Y76Tj3lI7oFbLoLU0bqg8g8bsX9Q0uvMtoH5t/NIgkWcbLv5G6
	VZ4RlipNmWYAvOAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YYuncEyD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=v5uXmNcI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795788235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OW9ZyYKCZqKZl7q7CogLU0g5vabU4+IWXGGAbZVYHU=;
	b=YYuncEyDn1wtqVyok+7Q59Z450F1SQyTK3SDOw2ooP5SYrqg2sgNf0AHuNTHSfTmWFDOWn
	u1/eRz4SU3L3WjQN/kes1KlLSSvf9kvxM6nivptijw84XVi/6tSu2IP/jMGkl7n1ZTi9cJ
	6/tCDmiN+KHXxCiKBGw9TOf1t372gA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795788235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OW9ZyYKCZqKZl7q7CogLU0g5vabU4+IWXGGAbZVYHU=;
	b=v5uXmNcIicdyrsxm/th/Y76Tj3lI7oFbLoLU0bqg8g8bsX9Q0uvMtoH5t/NIgkWcbLv5G6
	VZ4RlipNmWYAvOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF5B013432;
	Fri, 27 Nov 2026 14:03:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XMIiLsqNCWs0OgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Nov 2026 14:03:54 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 719225103D; Fri, 27 Nov 2026 15:03:50 +0100 (CET)
Date: Fri, 27 Nov 2026 15:03:50 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v6 0/5] Fix easy bits of the negative dentry problem
Message-ID: <64zxzak73c7rm7kog2wd3akdgpuksyayz5ncl4rbc3h4epo5pi@ujzmtg5c5245>
References: <20261123221410.3328780-1-neilb@ownmail.net>
 <179550252639.1728055.4014817916838632741@noble.neil.brown.name>
 <CAOQ4uxgF6=QoD9RoAOPmxtvkq1jWf+gG1AsJzR=Kt3ROMA=X0g@mail.gmail.com>
 <aau5z6kck6a2efcjvzrt6gno6ljs4eioncgizeh7vfbc6ipkr3@hjxzdk5pvgmt>
 <CAOQ4uxjXP4Zegb2Vgsv-yBeFmhvc8FT2bDKDcaM_t0=oJ5KpXQ@mail.gmail.com>
 <sc6xnwguimy23dexr3eosbe64xmmewn5ml5gso4m5xozw6fqlt@2hji64vi7eaw>
 <CAOQ4uxisP8YTUaexsXw4-Fxg0vand236cg5eDKirLm=kuDwSQQ@mail.gmail.com>
 <dy726gpfomckyt3se66pkdfj7qlsvmu4ysr666h3w5hxkay3l3@ibdy5kcibpjn>
 <CAOQ4uxiZtxa75j8+wSSfYZFrAvwDuo8ZfYh5+07n+mZfSsa2mA@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiZtxa75j8+wSSfYZFrAvwDuo8ZfYh5+07n+mZfSsa2mA@mail.gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 0E32722961

On Thu 26-11-26 13:24:42, Amir Goldstein wrote:
> On Thu, Nov 26, 2026 at 11:57 AM Jan Kara <jack@suse.cz> wrote:
> > So I guess we'll have to use the sequence counter in the end and we'll need
> > to be careful. Something like:
> >
> >         spin_lock(&conn->lock);
> >         gen = conn->scan_seqcount;
> >         update_children = conn->flags & FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
> >         /* Scan in progress? */
> >         if (gen & 1) {
> >                 /*
> >                  * We need to wait for scan to complete even if
> >                  * UPDATE_CHILDREN is not set as somebody might have
> >                  * started a scan for us.
> >                  */
> >                 gen++;
> >                 wait_var_event_spinlock(&conn->scan_seqcount,
> >                                         conn->scan_seqcount >= gen,
> >                                         &conn->lock);
> >                 /*
> >                  * Somebody started the scan we need while we waited? Just
> >                  * wait for it to complete.
> >                  */
> >                 if (conn->scan_seqcount == gen + 1) {
> >                         update_children = false;
> >                         wait_var_event_spinlock(&conn->scan_seqcount,
> >                                                 conn->scan_seqcount >= gen + 2,
> >                                                 &conn->lock);
> >                 }
> >         }
> >         /* Scan we needed is guaranteed to be complete */
> >         if (!update_children || conn->scan_seqcount >= gen + 2) {
> >                 spin_unlock(&conn->lock);
> >                 return;
> >         }
> >         /* We will do the scan */
> >         conn->scan_seqcount++;
> >         conn->flags &= ~FSNOTIFY_CONN_FLAG_UPDATE_CHILDREN;
> >         spin_unlock(&conn->lock);
> >
> >         fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
> >
> >         spin_lock(&conn->lock);
> >         conn->scan_seqcount++;
> >         wake_up_var_locked(&conn->scan_seqcount, &conn->lock);
> >         spin_unlock(&conn->lock);
> >
> > > > > Only the completion of the most recent walk can guarantee
> > > > > that all the children dentries are watched.
> > > >
> > > > So I don't think that's an issue. Look, if someone places a mark which
> > > > watches children of an inode, we either end up updating the children flags
> > > > or we wait for _UPDATE_CHIDREN_RUNNING to clear. So any mark update from
> > > > userspace blocks, until the children walk is done and then they all return.
> > > > We hold the group lock during the wait so the mark that makes the parent
> > > > watch children is guaranteed to stay attached to the inode and subsequent
> > > > mask updates on the inode all result in the conclusion that children are
> > > > watched (so fsnotify_parent() doesn't clear the children flags while we are
> > > > still walking).
> > > >
> > > > One catch in the above argument are oneshot marks for inotify & dnotify.
> > > > Inotify is actually fine since it grabs group lock when removing mark after
> > > > the event was sent (so the above argument holds). Dnotify doesn't grab group
> > > > lock when removing oneshot mark and so breaks the argument. I think we
> > > > should just make dnotify grab that lock to make our life simpler.
> > > >
> > > > Thoughts? Counter examples?
> > > >
> > >
> > > My thought is that this makes my head explode..
> > > I rather have a simpler mental model if possible, which is less
> > > dependent on all the callers and other locks.
> >
> > I understand. Not sure if the above satisfies your wishes but I couldn't
> > make it simpler...
> 
> It satisfies my concerns in that the logic is local and easy to follow.
> 
> Maybe it will be easier to read with a helper target variable and aim for
> conn->scan_seqcount >= target, because the gen+2 arithmetics is a bit hard
> to follow for all the cases, but not sure if the end result will be better.
> 
> Anyway, this is fine as far as I am concerned.
> I assume that you will send a patch following Neil's patches.

Yeah, once Neil's patches get to VFS tree, I can do these changes and send
a patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

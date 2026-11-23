Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427744;
	b=L40utZimWoQvWxWQFWM9/5dKkRDQCjNG9cGDmUP9/4vIdeuy/we0TbyRzhu7QaTh71cN
	 clzlzWLYjgcFkboiMdQfL2T9jHwYAukOynB/0sGXO/79Z6qG6sJQM4rayw3ffemImSPfb
	 6BnK3R+2QHhb1Cm+Ei1nHn9QwVeh4Whh4UM0aiaHNkhyjJvE4zKP4XK+JoxUUhMUOk7hp
	 d3cZ5HWDE7C1ezEOlPdW9DGAdilr/N3ToFkBFb0PNseN8EjVw+0z04PP1w0JF3Xw6vgtL
	 iTbxEWfAoBeJhHGplly3KWjNoeBN7IcHIOpklXrOWezha13NwuWs1JFCBX5ziyzp+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427744;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=rgoNuDkqEE6/XLCYK+MqMrq9yvTsYpNIi/CFbubIxQs=;
	b=AsqsnMlkqiZ3AZE13vaSQowaMuc3uV1ayHy++NmlHVOg5eZdUUP+QIMEuTa8TRlM8XiF
	 kp/WGVEnSxGRpDdJi7ZeMIoecLVRMC4MT7gl2v62GJColTyOK0u0v2uIS//2iBThWkPMB
	 mYtAtGNSBtnY1wKa4fFTMpot3rurToAVXY1Un2rRu8Ovdqsta7VmY+RPGLIvBAIfpDB/I
	 WOeoR+d037iZdQbW3ynAQAtvA2ymCAxQgwT+Gbmo92cLa3IcI1cyGF7KutqwEpFh0GBXA
	 6/1BLBHD+KkTP0p/Pj1euHCkvlW97QKMtyAAWDdgoxKBQBk77msAtDrbeD47+Ow4how==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1DCNN3MZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k1jEXeog;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MPxohavb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=K79Y+slm;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99801606A321;
	Mon, 23 Nov 2026 09:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99801606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1DCNN3MZ;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=k1jEXeog;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=MPxohavb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=K79Y+slm
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5383321F63;
	Mon, 23 Nov 2026 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795427741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgoNuDkqEE6/XLCYK+MqMrq9yvTsYpNIi/CFbubIxQs=;
	b=1DCNN3MZ4B6aQWFnfDJNKAtwTT7/VOuCv/ueinYT5R3cM91RXG6G9Sjjmw7jGqzZ1u/5DJ
	HF+7+MfJedw4sZIGpeClfjwWlWqV6plYC+0sIKIhpWX1bWcm9l9tGd+kN21KrBdsUnjQTZ
	hAMvh39nXsDB0z/PmzMjcgU3IbOS7Ls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795427741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgoNuDkqEE6/XLCYK+MqMrq9yvTsYpNIi/CFbubIxQs=;
	b=k1jEXeogzPNadSptgKWUibxBmXqgQcqUixgz2as2tHyyIH0P0ZOUGE32goJrY4pJhEg2AX
	NiM3C7nFUHZ/coDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MPxohavb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K79Y+slm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795427740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgoNuDkqEE6/XLCYK+MqMrq9yvTsYpNIi/CFbubIxQs=;
	b=MPxohavb+35oUD0xZZNVF4sXIA3YwiyZq+me2KnEwyj1k0BVsGnP8ugaPhsJmzvtyJ3FJ5
	/ylobmZRXJy28sK3tBtxSpI5+Wrt+IEyYt6ED4evaUU5Q3+BOY9Fcv2Kch/jAqSIt4OXTR
	epnn6T/M1tAECMcIs1+NRyEfZlT8f1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795427740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rgoNuDkqEE6/XLCYK+MqMrq9yvTsYpNIi/CFbubIxQs=;
	b=K79Y+slmsPJfxExDcsEktpUpRHZV6QwT5R9gxUalDh9VEw5Yg2STMUT3lx2QDMVyhOJ+Er
	Z7UxGpVTTDZ7keAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D9F113510;
	Mon, 23 Nov 2026 09:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJPqApwNBGvEPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Nov 2026 09:55:40 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id B574427634; Mon, 23 Nov 2026 10:55:39 +0100 (CET)
Date: Mon, 23 Nov 2026 10:55:39 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 2/5] fsnotify: update children flags only when adding
 mask bits
Message-ID: <gm4htzbmvnabg7pvvkzge4atqxgwjy7zlrbmofpx4ahuujw67e@excduwsuxzaz>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-3-neilb@ownmail.net>
 <mk7u4brorzgbyol7x4nyolufk3s3piqwqd5hnya3nhoq43d5ui@x5sdqeyrhde6>
 <179539972541.1728055.8282722306710793371@noble.neil.brown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179539972541.1728055.8282722306710793371@noble.neil.brown.name>
X-Rspamd-Queue-Id: 5383321F63
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,themaw.net,lwn.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,brown.name:email,suse.com:email]
X-Spam-Score: -13.01

On Mon 23-11-26 13:08:45, NeilBrown wrote:
> On Fri, 20 Nov 2026, Jan Kara wrote:
> > On Thu 19-11-26 13:57:02, NeilBrown wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > > 
> > > Since we only ever set the PARENT_WATCHED flag from
> > > fsnotify_recalc_mask(), there is never a need to update children flags
> > > when removing mark mask bits only when adding them.
> > > 
> > > Add a helper fsnotify_recalc_mask_and_update_children() to be called
> > > in cases where updating children flags may be needed (i.e. add mark).
> > > 
> > > Also avoid update children walk with mark spinlock held.
> > > This was only done by dnotify and can be easily avoided.
> > > 
> > > neilb: added update_children flag in fcntl_dirnotify() so we only
> > >   do the update when needed.
> > > 
> > > Fixes: 172e422ffea20 ("fsnotify: clear PARENT_WATCHED flags lazily")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > 
> > One question to Amir below. Otherwise I like it.
> > 
> > > +/*
> > > + * Recalculate mask and update children dentry PARENT_WATCHED flags if the
> > > + * connector started watching children.  When parent stops watching, we
> > > + * clear false positive PARENT_WATCHED flags lazily in __fsnotify_parent().
> > > + *
> > > + * The caller must make sure connector and connector->obj cannot disappear
> > > + * under us.  This is achieved by holding mark->group->mark_mutex for a
> > > + * mark on this list.  mark->lock must not be held by the caller.
> > > + */
> > > +void fsnotify_recalc_mask_and_update_children(
> > > +					struct fsnotify_mark_connector *conn)
> > > +{
> > > +	if (fsnotify_recalc_mask(conn))
> > >  		fsnotify_conn_set_children_dentry_flags(conn);
> > >  }
> > >  
> > > @@ -367,8 +383,8 @@ void fsnotify_modify_mark_mask(struct fsnotify_mark *mark, u32 set, u32 clear)
> > >  		recalc = true;
> > >  	spin_unlock(&mark->lock);
> > >  
> > > -	if (recalc)
> > > -		fsnotify_recalc_mask(mark->connector);
> > > +	if (recalc && fsnotify_recalc_mask(mark->connector) && set)
> > 
> > Amir, why is the '&& set' check here? Under normal circumstances if
> > fsnotify_recalc_mask() return's true, 'set' is true as well. We can be
> > racing with other updates to the connector list of marks and in that case our
> > fsnotify_recalc_mask() call could be the first one that noticed the marks
> > attached to the inode are now watching children and is thus resposible for
> > setting children dentry flags even if 'set' was false. So I think it can do
> > only harm...
> > 
> > And for similar reasons I believe fsnotify_recalc_mask() call in
> > fanotify_remove_mark() needs to be updated to
> > fsnotify_recalc_mask_and_update_children() as well. Standalone
> > fsnotify_recalc_mask() is simply never safe unless it is followed by the
> > update children later - perhaps make it __must_check?
> 
> Hmmm.... I had thought that the group lock would prevent these races but
> I guess not.  Maybe one mark can be in multiple groups???

Mark belongs to a single group. But fsnotify_recalc_mask() calculates mask
from all marks attached to an inode and different marks can belong to
different groups. So group->lock indeed doesn't protect us from parallel
changes to the list.

> Given that, I don't think I can form a sensible opinion on Amir's
> revised patch.  It looks OK and I think I can see what it is trying to
> achieve and how it achieves it, but I'm less confident that I can see if
> that is the thing that needs to be achieved.
> 
> So Jan - if you could review that so I can add your reviewed-by when I
> repost, that would be great.

Yes, the patch looks good to me now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

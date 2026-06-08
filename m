Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE230E838
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780921849; cv=none; b=u7xhvoo3EsEKXehRYam75uot5Q9oCLkqHZRCwK9BM7PIzwytT7lNCMxBogLD2tcj9ngVYlgeqKCt+cCxw+H44HTOEhk+8KFSAxcjPbKYBO2ke/s/K3/lrLBzc4q0g+jnXcuYkcwUeshfYBTEENp39LKdj/t6NawYyS3TW5Vqw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780921849; c=relaxed/simple;
	bh=lOjnR64XkI501gwX1UyR2pCGlV51w7oRDzQIe/41LwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ/Tn9gcplBQOAO2YlWpGQzxSJXz1xlAh7/SzTsk17TCLNCHrqY04h9LEb8AQKn1Ih2TrCZEh8AjYh7sFzfEcnKC5f5NsiOxSDROBtaLAW+y9zhxmQRjb8KDM99CrvzbzJh9DieaVgZRN2HE3LR7WLSTpQf3H6hpokhlBj2w2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uvt0F2c4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHozGo1i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uvt0F2c4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHozGo1i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uvt0F2c4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHozGo1i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uvt0F2c4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHozGo1i"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A31A6AA8E;
	Mon,  8 Jun 2026 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780921846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CEMHgzVgCoyMj1BsY5Pjq91TB7XSHuTH09mh544nWU=;
	b=uvt0F2c4cFMfCpTN5Ou+MHAnt+oHI8MFgLjw9NHCiaNgsyRLD4sMvbTI9+jcDfVKISHJqq
	WnuaqpAt/TF2g4S8w+Y2ljGSuT/6zHILwO6tbe/JZew00wjJEBRqoKzylTc/FApCQqbKMT
	73x1VW80wokYrFW0OFDWPbvzaAfaaCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780921846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CEMHgzVgCoyMj1BsY5Pjq91TB7XSHuTH09mh544nWU=;
	b=UHozGo1iaHca1zI81z6ZvU4B8RnQSFsSXRVNpKaITxMmyIT/AhBv2Oe7/hVVvSZqoRZdN+
	8IocMWqPo58bPGDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uvt0F2c4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UHozGo1i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780921846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CEMHgzVgCoyMj1BsY5Pjq91TB7XSHuTH09mh544nWU=;
	b=uvt0F2c4cFMfCpTN5Ou+MHAnt+oHI8MFgLjw9NHCiaNgsyRLD4sMvbTI9+jcDfVKISHJqq
	WnuaqpAt/TF2g4S8w+Y2ljGSuT/6zHILwO6tbe/JZew00wjJEBRqoKzylTc/FApCQqbKMT
	73x1VW80wokYrFW0OFDWPbvzaAfaaCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780921846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CEMHgzVgCoyMj1BsY5Pjq91TB7XSHuTH09mh544nWU=;
	b=UHozGo1iaHca1zI81z6ZvU4B8RnQSFsSXRVNpKaITxMmyIT/AhBv2Oe7/hVVvSZqoRZdN+
	8IocMWqPo58bPGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FCF4779A7;
	Mon,  8 Jun 2026 12:30:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6eSlC/a1JmpkQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 12:30:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 961BDA0923; Mon, 08 Jun 2026 14:30:45 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:30:45 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, AnonymeMeow <anonymemeow@gmail.com>, 
	amir73il@gmail.com, repnop@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: register event pid for pidfd reporting
Message-ID: <wudpprxslydgxcbqgteyykpqw5g7fubmjhjf23qbwuvbujmggh@ots2k4gqb7uh>
References: <20260530013732.50811-1-anonymemeow@gmail.com>
 <20260530105117.45792-1-anonymemeow@gmail.com>
 <dolfs6j4x4thpgluglxhlepg34l5uvvxv2sjcmuao57bxnbtjb@urx5vgczxbup>
 <20260602-patzt-sturz-segen-f1f305d61b75@brauner>
 <i2gudjbai3vbyvhbbgcppt2vexnkkjqq35n53sjpx66i5k4lg3@5wu5hvzifpnc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i2gudjbai3vbyvhbbgcppt2vexnkkjqq35n53sjpx66i5k4lg3@5wu5hvzifpnc>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3A31A6AA8E
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 08-06-26 11:27:01, Jan Kara wrote:
> On Tue 02-06-26 15:50:19, Christian Brauner wrote:
> > On Mon, Jun 01, 2026 at 05:24:36PM +0200, Jan Kara wrote:
> > > On Sat 30-05-26 18:51:17, AnonymeMeow wrote:
> > > > pidfd_prepare() may still fail if userspace reads the event after the
> > > > task has been reaped and the pid has not been registered with pidfs.
> > > > Register the event pid with pidfs when creating the fanotify event if
> > > > pidfd reporting was requested, so pidfd_prepare() can later create a
> > > > pidfd for the reaped task.
> > > > 
> > > > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> > > 
> > > So the two patches in this series so far look good to me. This patch looks
> > > OK to me as well and since the overhead of allocation etc. is only once per
> > 
> > It's a kmem cache so should not matter at all...
> > 
> > > registered task, I think it's fine but let's wait a bit whether Christian
> > > agrees this is what needs to be done.
> > 
> > pidfs_register_pid() can only fail with ENOMEM or if the task is already
> > dead. The latter cannot happen because even for a non-empty thread group
> > where the thread-group leader already exited but subthreads are still
> > alive the thread-group leader cannot be reaped. So the only error here
> > is ENOMEM which means we should defo fail this, imho.
> > 
> > And yes, I think this is worth doing. Because you get a persistent
> > handle on the task that generated that event + all the exit information
> > even if that thask has been reaped in the meantime. I'm pretty sure if
> > you're using fanotify that's a rather huge win for apps that need it.
> 
> OK, thanks for opinion. So I've somewhat massaged the error handling in the
> patch AnonymeMeow. Attached is what I currently have in my tree (testing
> pending).

OK, reverted that for now since I've found further versions of the series
in my huge inbox after a few days of vacation now :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63A2BB13
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925539; cv=none; b=imZgVcCyEsSs4F/cguvDaAyc1McWGdEchTyuBYddegsPuse1YBJYutRa9XIesbwwqu3GzVpIGAFTaT5TnmHvQ/airyyKvhiPes7HPUtGcVre3nrgMVA7t+o9fCtdJsV2jPqQXaZbi8D1JAtcrFitGo+xy3yOQCJbIGGa1ko9AIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925539; c=relaxed/simple;
	bh=qwPM4RcqB5ExXL4zt9d7mRJHq0m7DNX0VmUk5AtoI00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL0F2kDZH34LaZ2bVBYiFGwbGAPIoBIyOc9J1wp3U8R6wE2JV/3OW/QzTI04v7AInU4e+IqSCHQIdg3JBEyjFDe4Fv62lvvmO3+Mtq2+7EJlChoKE3W9dBbYGB4WRRebPdswgk30r8PIDpvb6urFZyZdLIQ/6ns5n0rkNxOt5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rBlEpyDZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJdvuB31; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ThEeLceO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4tKbSOMZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rBlEpyDZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJdvuB31";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ThEeLceO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4tKbSOMZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2FF15BD4B;
	Thu, 19 Mar 2026 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773925536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAbwz84gi7YY8QeBc+mewNx0FfXzY/sMdj7uJAIINco=;
	b=rBlEpyDZaFAFu0iu16qJD27liVvwz1uvjLczlHuf2I7r+EbtlMcChC9IHhGnWVY6KTLtr+
	Vfbv4SDte5npueyQVniZEQ2kZ5CGlIVLDTdcPrOEPs9mWCSHB4syU96OE5S7/n6qRjJDdu
	Jz6HaSiAGsKh1u+QUOUBoPdusAqVUfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773925536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAbwz84gi7YY8QeBc+mewNx0FfXzY/sMdj7uJAIINco=;
	b=JJdvuB31xWy86i2Pjgk7UYBoD2dOJyTPV2AXNxQO2+RspvboRgLViEqmq/n4M4N4+KzS7T
	Ao9OLZkfMwcmWwBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ThEeLceO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4tKbSOMZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773925534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAbwz84gi7YY8QeBc+mewNx0FfXzY/sMdj7uJAIINco=;
	b=ThEeLceOLqqm99BGzcEOZQwlwFmz8dxZD2nFY1aN0Q2o39O2MSvUVDhwrzTPKAxZO5HL6V
	yGVVKHUG29NVWtAnQV1D31TJuHWP/1DoB85YboydtDMzHV1WmlKLqr1GMyoB2Vyet3+nmb
	qTElNVcL3btgwym2tjnBNiEDiqFUSJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773925534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAbwz84gi7YY8QeBc+mewNx0FfXzY/sMdj7uJAIINco=;
	b=4tKbSOMZ0xjjgl1iPlJz4UiyiEZcK3+9QcnIQzLAsMZkdz/WMXSFjVoO/YiqMcIqq4T+nM
	G6mZy3Pk7hHQ7TAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9877E4273B;
	Thu, 19 Mar 2026 13:05:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id trU2JZ70u2kEHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 13:05:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 530E0A0B32; Thu, 19 Mar 2026 14:05:34 +0100 (CET)
Date: Thu, 19 Mar 2026 14:05:34 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Lai, Yi" <yi1.lai@linux.intel.com>
Subject: Re: [PATCH] fs: revert insert_inode_locked() eviction wait change
 and explain why
Message-ID: <rjpefd3vudfq3wktpidlqnohf5esige634wmdka6at3auxm2bd@yk6nn77dpkde>
References: <20260316103306.1258289-1-mjguzik@gmail.com>
 <yojtdduvndkyez7mzyah2fznxtztf5boonyxwicp6zb6zw52ao@h6g6zcxhvz3w>
 <CAGudoHEMpe6r+g8OOhFPDAiHtVDraPxA4kSmVLp469g5YZgzYA@mail.gmail.com>
 <6mknq4cxnf2dhix23gv4wqxy3vnzmhy5opxwpd72ncnpdgnnxr@omhnt5rktvir>
 <CAGudoHGQ1Bd0V2wcTRegKAzWqJqWX+CKX_gxF8bCGWQPXTo=ZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGQ1Bd0V2wcTRegKAzWqJqWX+CKX_gxF8bCGWQPXTo=ZA@mail.gmail.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A2FF15BD4B

On Tue 17-03-26 14:44:54, Mateusz Guzik wrote:
> On Tue, Mar 17, 2026 at 2:39 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 17-03-26 14:12:48, Mateusz Guzik wrote:
> > > On Tue, Mar 17, 2026 at 2:01 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 16-03-26 11:33:05, Mateusz Guzik wrote:
> > > > > It causes a deadlock, reproducer can be found here:
> > > > > https://lore.kernel.org/linux-fsdevel/abNvb2PcrKj1FBeC@ly-workstation/
> > > > >
> > > > > The real bug is in ext4, but I'm not digging into it and a working order
> > > > > needs to be restored.
> > > >
> > > > I can dig into that. I expect ext4 ends up calling find_inode() from its
> > > > ext4_evict_inode() handler or something like that? I was searching for such
> > > > occurrence for a while but I didn't find it so can you share where ext4
> > > > blocked? Because the stacktraces from the original report just show the
> > > > journalling machinery hangs but those are only side-effects of somebody
> > > > hanging in ext4 with the transaction handle started... Thanks!
> > > all traces attached
> >
> > Thanks! OK, for reference the inode has been marked as 'sync' so
> >
> > ext4_evict_inode() -> ext4_journal_stop()
> >
> > ends up waiting for transaction commit. However ext4_new_inode() calls
> > insert_inode_locked() with started transaction handle and thus waits for
> > the freeing inode with the handle started. Classical ABBA deadlock. I'll
> > think how we could sensibly fix this in ext4.
> >
> 
> Do you think fixing the actual bug is viable for 7.0? The above revert
> seems most prudent for the time being.

I have an idea for relatively easy fix within ext4. I'll discuss it today
on our ext4 developers call and if it works out, I think we can fix ext4
for 7.0. I agree if it doesn't work out, we should revert for now. I'll let
you know how it worked out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

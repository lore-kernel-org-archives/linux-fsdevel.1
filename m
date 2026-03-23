Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3037105D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774264449; cv=none; b=SeDZV4VXcKn54UaVN4S8/h/oE5hQNByw5FrbPdpGahPM0hfzPSvmFYMZ2v0SmmI4KX3oDMs37ZH4Ur+SrKe3ANq+MyemmTRKgVA3h1HH9nl7c5+ELZmqfXP+3ZL6fif+4SZ9PU34JNZXv3mvSsGzbGRCMewa7V7X2p4kyEY1Fqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774264449; c=relaxed/simple;
	bh=c9Wgv7GIdjy2KjtfCpr61ZtJrW4X3nb9Z8uk9tr6b20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTpcwFU8KPGetLA20Mtt/p+k7+Rp3pmS4DM6LE+OHS1cOviSCQ7z3DtQkTa6jSubZUWXbfbvwd/zjTgv3YyaSRBRDY1L+GF/i+iTXZ8Uk0VuVBeKKk+hwRdw+hoJuXWX9oDDQ87OVpRI4XWYhbQHj0Eykcd9fxdJoQjuW3IMtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWfMi6Qm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ltinqq0n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWfMi6Qm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ltinqq0n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWfMi6Qm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ltinqq0n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWfMi6Qm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ltinqq0n"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31CAC4D356;
	Mon, 23 Mar 2026 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774264446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KS2x8/t4BMWj1FPc/I6e4wgl+S/FBlQJnYyRX/KJlYY=;
	b=dWfMi6QmT9AOZIcMWm9BT8fcKxyKCQ8OU1KVs0iGIWKkJg+p6jlII6Hur2JYL6qkYgf0KO
	QAuDM/vLjpoyjyHddfSTjaYG36x60MqRM+mpaXZEUJFKhdBS1M0wHsm8sk1XZIunRzBQbU
	fJld8mCrgA9eQ20PihJT7EgjzLJqzII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774264446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KS2x8/t4BMWj1FPc/I6e4wgl+S/FBlQJnYyRX/KJlYY=;
	b=Ltinqq0nMAsy51jnWbTWpMXr5yA5xIuHsOemIoXXmNrj7E0TEzbWjvMO96B9+CGRsSamoJ
	/PH2g7h5Nh+G/pBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774264446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KS2x8/t4BMWj1FPc/I6e4wgl+S/FBlQJnYyRX/KJlYY=;
	b=dWfMi6QmT9AOZIcMWm9BT8fcKxyKCQ8OU1KVs0iGIWKkJg+p6jlII6Hur2JYL6qkYgf0KO
	QAuDM/vLjpoyjyHddfSTjaYG36x60MqRM+mpaXZEUJFKhdBS1M0wHsm8sk1XZIunRzBQbU
	fJld8mCrgA9eQ20PihJT7EgjzLJqzII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774264446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KS2x8/t4BMWj1FPc/I6e4wgl+S/FBlQJnYyRX/KJlYY=;
	b=Ltinqq0nMAsy51jnWbTWpMXr5yA5xIuHsOemIoXXmNrj7E0TEzbWjvMO96B9+CGRsSamoJ
	/PH2g7h5Nh+G/pBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16C4443848;
	Mon, 23 Mar 2026 11:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KaiIBX4gwWkKUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Mar 2026 11:14:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C81D2A0B2E; Mon, 23 Mar 2026 12:14:05 +0100 (CET)
Date: Mon, 23 Mar 2026 12:14:05 +0100
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>, Demi Marie Obenour <demiobenour@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
References: <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
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
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,szeredi.hu,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

Hi Gao!

On Mon 23-03-26 18:19:16, Gao Xiang wrote:
> On 2026/3/23 17:54, Jan Kara wrote:
> > On Sun 22-03-26 12:51:57, Gao Xiang wrote:
> > > On 2026/3/22 11:25, Demi Marie Obenour wrote:
> > > > > Technically speaking fuse4fs could just invoke e2fsck -fn before it
> > > > > starts up the rest of the libfuse initialization but who knows if that's
> > > > > an acceptable risk.  Also unclear if you actually want -fy for that.
> > > > 
> > > 
> > > Let me try to reply the remaining part:
> > > 
> > > > To me, the attacks mentioned above are all either user error,
> > > > or vulnerabilities in software accessing the filesystem.  If one
> > > 
> > > There are many consequences if users try to use potential inconsistent
> > > writable filesystems directly (without full fsck), what I can think
> > > out including but not limited to:
> > > 
> > >   - data loss (considering data block double free issue);
> > >   - data theft (for example, users keep sensitive information in the
> > >        workload in a high permission inode but it can be read with
> > >        low permission malicious inode later);
> > >   - data tamper (the same principle).
> > > 
> > > All vulnerabilities above happen after users try to write the
> > > inconsistent filesystem, which is hard to prevent by on-disk
> > > design.
> > > 
> > > But if users write with copy-on-write to another local consistent
> > > filesystem, all the vulnerabilities above won't exist.
> > 
> > OK, so if I understand correctly you are advocating that untrusted initial data
> > should be provided on immutable filesystem and any needed modification
> > would be handled by overlayfs (or some similar layer) and stored on
> > (initially empty) writeable filesystem.
> > 
> > That's a sensible design for usecase like containers but what started this
> > thread about FUSE drivers for filesystems were usecases like access to
> > filesystems on drives attached at USB port of your laptop. There it isn't
> > really practical to use your design. You need a standard writeable
> > filesystem for that but at the same time you cannot quite trust the content
> > of everything that gets attached to your USB port...
> 
> Yes, that is my proposal and my overall interest now.  I know
> your interest but I'm here I just would like to say:
> 
> Without full scan fsck, even with FUSE, the system is still
> vulnerable if the FUSE approch is used.
> 
> I could give a detailed example, for example:
> 
> There are passwd files `/etc/passwd` and `/etc/shadow` with
> proper permissions (for example, you could audit the file
> permission with e2fsprogs/xfsprogs without a full fsck scan) in
> the inconsistent remote filesystems, but there are some other
> malicious files called "foo" and "bar" somewhere with low
> permissions but sharing the same blocks which is disallowed
> by filesystem on-disk formats illegally (because they violate
> copy-on-write semantics by design), also see my previous
> reply:
> https://lore.kernel.org/r/7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com
> 
> The initial data of `/etc/passwd` and `/etc/shadow` in the
> filesystem image doesn't matter, but users could then keep
> very sensitive information later just out of the
> inconsistent filesystems, which could cause "data theft"
> above.

Yes, I've seen you mentioning this case earlier in this thread. But let me
say I consider it rather contrived :). For the container usecase if you are
fetching say a root fs image and don't trust the content of the image, then
how do you know it doesn't contain a malicious code that sends all the
sensitive data to some third party? So I believe the owner of the container
has to trust the content of the image, otherwise you've already lost.

The container environment *provider* doesn't necessarily trust either the
container owner or the image so they need to make sure their infrastructure
isn't compromised by malicious actions from these - and for that either
your immutable image scheme or FUSE mounting works.

Similarly with the USB drive content. Either some malicious actor plugs USB
drive into a laptop, it gets automounted, and that must not crash the
kernel or give attacker more priviledge - but that's all - no data is
stored on the drive. Or I myself plug some not-so-trusted USB drive to my
laptop to read some content from it or possibly put there some data for a
friend - again that must not compromise my machine but I'd be really dumb
and already lost the security game if I'd put any sensitive data to such
drive. And for this USB drive case FUSE mounting solves these problems
nicely.

So in my opinion for practical usecases the FUSE solution addresses the
real security concerns.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168265;
	b=ikXb5jeXXfbm2LrhAOdWQzHTnlBqw41OwRaYhjbwU9knFZKZrMFFjp5AZqE/P1XlFkYF
	 VBXdKbm1kttAtC+Z2FNQ9s+TaeTGbdEaMWOD7QrPkt/Sl4/pB1pNgdM8CibrKY+OtDajf
	 nJB8H6UspUA+dmzS3/FON9TMnFp65DgGSNJUvMMCbNZjTxH1zJo168AdbAMnKgTlqwHLd
	 SPu8OxqXsREdHQ2AH1ZxadRwfOM1EIO/pyUPLBghzUtDLLGGfkwI6MvYG4vGrq0ZsHUR1
	 b7n8kN3iNdgGXuCmCS6jcNbcES2Yl8XSpoaA/3Hal9k2hVywBioiPd3YbcLsN/dB/iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168265;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=fYwTF2rRWsG/kCUZOB3IPJ2TixsQvxHszIn4p4RAlug=;
	b=Y/QYaYcSp0qcACD/1snZPI2fElc8crELnlXJXmnD5kMLXwRSRH/hTFejSrUHaACvKP0i
	 LzuzLE3NOxwU+FSRp6zhduJ5/iBmoa0KIGW3fjgNyfK1I4WUbMJHnqospZD6b+nDwELA5
	 //NPHCZFHdcr9Ugu/7+875ItWP8RZU9NZAkrIGYQH/HhCQfUbqrY6AU6usPKibBwwHhQu
	 y6085AkVMwTxmmOF7kkwmFhBGYcnoSzVLomVve/dkdYCe/uA2OJu9KIREcI0zNV+44qu9
	 rco4j+Cn4Fclahrr6buSt5MJwcE1Hv/MTr7vJL1fcTFGJ/00or0f5fohuZfb+DyGdYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iXTTyXbc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBVSGfBK;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iXTTyXbc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBVSGfBK;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154D606A33F;
	Fri, 20 Nov 2026 09:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F154D606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iXTTyXbc;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBVSGfBK;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iXTTyXbc;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CBVSGfBK
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2343B225F9;
	Fri, 20 Nov 2026 09:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795168263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwTF2rRWsG/kCUZOB3IPJ2TixsQvxHszIn4p4RAlug=;
	b=iXTTyXbc96LPrn3J4jUN8cZX+Vuwl/fYH87FEhK5cT7U/g7lv+4WKg+gpSGBcbUtYk3NDo
	p1ZkkcFjsZvn5Ky3p3Gg1IJT7CmpeoMG+Bk1eGKB1THNuFE3Bq5tzx3q4/wbQeYKVDpj6I
	8MvHmFz40JimZcrsdUWy6hS5ROJ2KFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795168263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwTF2rRWsG/kCUZOB3IPJ2TixsQvxHszIn4p4RAlug=;
	b=CBVSGfBKopZoUS0SN3knt+mhCq1clPQJZm+RKBrWBiBhNCntHZyqaBG10iMiRHDX3Zhwkt
	lq9jo6d9rjGQGxDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795168263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwTF2rRWsG/kCUZOB3IPJ2TixsQvxHszIn4p4RAlug=;
	b=iXTTyXbc96LPrn3J4jUN8cZX+Vuwl/fYH87FEhK5cT7U/g7lv+4WKg+gpSGBcbUtYk3NDo
	p1ZkkcFjsZvn5Ky3p3Gg1IJT7CmpeoMG+Bk1eGKB1THNuFE3Bq5tzx3q4/wbQeYKVDpj6I
	8MvHmFz40JimZcrsdUWy6hS5ROJ2KFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795168263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYwTF2rRWsG/kCUZOB3IPJ2TixsQvxHszIn4p4RAlug=;
	b=CBVSGfBKopZoUS0SN3knt+mhCq1clPQJZm+RKBrWBiBhNCntHZyqaBG10iMiRHDX3Zhwkt
	lq9jo6d9rjGQGxDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F22D51348F;
	Fri, 20 Nov 2026 09:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C2EZMwYYAGtXDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Nov 2026 09:51:02 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 784DA25EEF; Fri, 20 Nov 2026 10:50:47 +0100 (CET)
Date: Fri, 20 Nov 2026 10:50:47 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v5 1/5] VFS: don't count references through ->d_parent
Message-ID: <fdopv5hxtrrkfzrrlgzqvagb5bcub5vonftyqiyksfmngkmg6d@7jqatphhjr22>
References: <20261119025942.2848130-1-neilb@ownmail.net>
 <20261119025942.2848130-2-neilb@ownmail.net>
 <cnud5otrkcthvaysgzyp3eokgqiax7dgn4hjrlayriwfie5iyh@73pmlo3vtifo>
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
In-Reply-To: <cnud5otrkcthvaysgzyp3eokgqiax7dgn4hjrlayriwfie5iyh@73pmlo3vtifo>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-16.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org,themaw.net,lwn.net];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,brown.name:email]
X-Spam-Score: -16.80

On Fri 20-11-26 10:29:12, Jan Kara wrote:
> On Thu 19-11-26 13:57:01, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> > 
> > The number of negative child dentries that a given dentry can have is
> > effectively unbounded, so counting the references through ->d_parent can
> > overflow ->d_lockref.count.
> > 
> > We only use this count so that we can know when there are no remaining
> > references including from children.  However most children appear on the
> > ->d_children list and the few remaining children (inactive
> > DCACHE_DENTRY_CURSORs) only exist in a context were a separate reference
> > is held on the parent.
> > 
> > So if we count whether d_children is nonempty (i.e.  dget() when it
> > becomes non-empty, dput() when it comes empty) and require children not
> > on ->d_children to have a reference on the parent some other way (which
> > they already do), then ->d_lockref.count will not overflow and we can
> > still know exactly when all references, including through ->d_parent,
> > are gone.
> > 
> > __d_move() allows that dentries might not be on any d_children list as
> > is the case for IS_ROOT() dentries.  Rather than track when this is the
> > case we dget() either parent if they have an empty d_children before
> > children are moved around, then dput() if they turn out to be empty
> > afterwards.  This will increment dentry if it IS_ROOT(), and then
> > decrement it afterwards, and will decrement the refcount on old_parent
> > if its ->d_children becomes empty.
> > 
> > To help with this, dput_dlock() is added which warns rather than
> > decrementing to zero (which should never happen).
> > 
> > When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> > added "before" or "behind" an existing child, so it will never be the
> > first child added, and so never needs to adjust the refcount on the
> > parent.  If it remains on the list until dput() it could be the last
> > child to be removed, in which case normal handling applies in
> > dentry_unlist() (where it has been moved from dentry_kill().  When a
> > cursor is deliberately removed from the d_children list the refcount
> > must be decremented if that leaves the list empty.
> > 
> > hlist_move_behind() and hlist_move_before() are added to simplify moving
> > a cursor within the d_children list.  This results in some duplicate code
> > as they share a common prefix with d_detach_cursor() (hlist_del)
> > which is currently factored out.  We can expect the compiler to optimise
> > this away and don't need to clutter the C code with it.
> > 
> > autofs compares d_count() with the number of known children of a dentry
> > to detect if there are any concurrent references to a dentry.  These
> > comparisons must be changed to reflect that we now only count "one" for
> > any children rather than "one" for each child.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> 
> Besides the objection about ino->count starting at 1 (which seems correct
> AFAICS in autofs_new_ino()) this looks good to me.

Oh, and Sashiko found a conversion of d_duplicate() to the new world order
was forgotten.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

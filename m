Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602969;
	b=ROqjKSctuD5LQNOj7tzSBnRsOECgN1RFhRBjqr9w9I873fo5G/9wgInxHMKVXEJTceYS
	 S09qcvHvh9HT9e8DvMVH10rtf2OsrIKXCv0sCcA6ii9SBW7aSzVGfIHVObtVrfP9HORjg
	 7qYY81yc074ngpLHCf+0u2HulF+MX77eZxqMBm8V8p+qH/Z+YaBdnGTpuXiP4PRoqPhKn
	 64A48Ubqt7oZ94AgT5n85yR4Eb5b1kKVOHDAUBBdqUntmVIj0LRbe7XJxFph4rsAB1Hm9
	 5vCEMDfmVbh8iwOqzspRWIfUop94CeCGFnOae/w9ltWrTgxdpkggsIB1WKXF/RFa4/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602969;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=0BaP2UlpUkKXvDDgDC7QgdSZm0hAS36yO9YoMcAlAI8=;
	b=tEhAIp/m6mwIxMxf53T2K30Cd1MGD862rj3yHooNgB2CeuKa4259yd6u2PrXXeTxIk58
	 ltMCo99SUnuE5QZeuOnqurzeZaU0O0/oCjhUqonDNx7r/T+9O8uqpySPU+1mH+Sjt5XiU
	 RxI4s9nF8V/l8Ze48Cx7/udByhGFgraaOh/MSzAjRBCo3HiLTondEsP4YdkC962N7JexU
	 laTD/X+lCQMbBslvbMgazGhUZgPI+0rCU+iiaABdFqlkKh4sMf5P2YSIvpohgxCu2pPTT
	 Xyw994mDLBlvqt1IqXEf1U7A0MlofTVPHBy0ixRurHeqd51mGqrP/j2GLdvBC2Cp+ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YAlqRE8R;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NPa7H9Q3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=B2btSreT;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lrVcGIXL;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5139606A326;
	Wed, 25 Nov 2026 10:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5139606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=YAlqRE8R;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NPa7H9Q3;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=B2btSreT;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lrVcGIXL
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B13371F7BA;
	Wed, 25 Nov 2026 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795602966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BaP2UlpUkKXvDDgDC7QgdSZm0hAS36yO9YoMcAlAI8=;
	b=YAlqRE8ROmPsseKVyBpyalo+TrK4yolIvUTgDIqUdtOq+tWRs6a2hWKYxJJLSEXuD9BerK
	Q4BrRzuiN8SyETIJ0gNNJkut4AgFBeQIqDTrQ/yp1df3Xov1DgXOiFFAaHX1P3wCig0CBS
	9GesHARipTg5ODMrQRv71D/x8HGCM+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795602966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BaP2UlpUkKXvDDgDC7QgdSZm0hAS36yO9YoMcAlAI8=;
	b=NPa7H9Q3CnsOuy+KZPVBpCpsNA+6ANFDrVH/fAY/YYKQb6CafTDc6KKPYAF33s2QwiAZGv
	BQu+rPVD6ue+UbBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795602965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BaP2UlpUkKXvDDgDC7QgdSZm0hAS36yO9YoMcAlAI8=;
	b=B2btSreTgXxQJIK5mxvhSVyK1/hYl73dFSoFdqzc28HxifrWThC7IFXCYPD7GSahx0Y9dB
	Ma+DEgLg0h+FdcgYjvH6hQ7ObfEJWUEc9DnO+se1yJje88jnS4U774p+aNMTf2A8Oyjp3D
	DF/Fy9iGmN93fn8jNfbg3NGcSm7Q2vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795602965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BaP2UlpUkKXvDDgDC7QgdSZm0hAS36yO9YoMcAlAI8=;
	b=lrVcGIXL4+7dSW+L5MNEiZeH0DXYZgpJ5KI1Pq/IQoh6f1czwin+bBNdEJyR9wZtmnNunT
	xv3HOGwv2nIe61Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AD36134CA;
	Wed, 25 Nov 2026 10:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K5KYGRW6Bmu5bgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Nov 2026 10:36:05 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 1B73527C04; Wed, 25 Nov 2026 11:36:01 +0100 (CET)
Date: Wed, 25 Nov 2026 11:36:01 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>, 
	Jake Edge <jake@lwn.net>
Subject: Re: [PATCH v7 1/5] VFS: don't count references through ->d_parent
Message-ID: <qhbfs7sttulndvegel3zgqns36hglh4ovlxyiuwib7lnqq4fmv@cmcediwqkhvy>
References: <20261125000836.3984402-1-neilb@ownmail.net>
 <20261125000836.3984402-2-neilb@ownmail.net>
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
In-Reply-To: <20261125000836.3984402-2-neilb@ownmail.net>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,brown.name:email];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,vger.kernel.org,themaw.net,lwn.net];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,brown.name:email,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 25-11-26 11:03:38, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> The number of negative child dentries that a given dentry can have is
> effectively unbounded, so counting the references through ->d_parent can
> overflow ->d_lockref.count.
> 
> We only use this count so that we can know when there are no remaining
> references including from children.  However most children appear on the
> ->d_children list and the few remaining children (inactive
> DCACHE_DENTRY_CURSORs) only exist in a context were a separate reference
> is held on the parent.
> 
> So if we count whether d_children is nonempty (i.e.  dget() when it
> becomes non-empty, dput() when it comes empty) and require children not
> on ->d_children to have a reference on the parent some other way (which
> they already do), then ->d_lockref.count will not overflow and we can
> still know exactly when all references, including through ->d_parent,
> are gone.
> 
> __d_move() allows that dentries might not be on any d_children list as
> is the case for IS_ROOT() dentries.  Rather than track when this is the
> case we dget() either parent if they have an empty d_children before
> children are moved around, then dput() if they turn out to be empty
> afterwards.  This will increment dentry if it IS_ROOT(), and then
> decrement it afterwards, and will decrement the refcount on old_parent
> if its ->d_children becomes empty.
> 
> To help with this, dput_dlock() is added which warns rather than
> decrementing to zero (which should never happen).
> 
> When a DCACHE_CURSOR dentry is added to d_children, it is only ever
> added "before" or "behind" an existing child, so it will never be the
> first child added, and so never needs to adjust the refcount on the
> parent.  If it remains on the list until dput() it could be the last
> child to be removed, in which case normal handling applies in
> dentry_unlist() (where it has been moved from dentry_kill().  When a
> cursor is deliberately removed from the d_children list the refcount
> must be decremented if that leaves the list empty.
> 
> hlist_move_behind() and hlist_move_before() are added to simplify moving
> a cursor within the d_children list.  This results in some duplicate code
> as they share a common prefix with d_detach_cursor() (hlist_del)
> which is currently factored out.  We can expect the compiler to optimise
> this away and don't need to clutter the C code with it.
> 
> autofs compares d_count() with the number of known children of a dentry
> to detect if there are any concurrent references to a dentry.  These
> comparisons must be changed to reflect that we now only count "one" for
> any children rather than "one" for each child.  This can be done without
> using ino->count but simply by looking at ->d_children.  So a new
> static-inline "dentry_busy()" is added which performs the
> check and is told how many unusual references to expect.
> As no locks are held, this test is racy.  And comment is provided
> explaining why the race is of no consequence.
> 
> Signed-off-by: NeilBrown <neil@brown.name>

Looks good to me although I'm not very confident autofs (but I don't see an
obvious issue there). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one nit below.

> @@ -3300,12 +3308,21 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
>  
>  	/* ... and switch them in the tree */
>  	dentry->d_parent = target->d_parent;
> +
> +	/*
> +	 * Ensure ref count on parents reflect d_children being non-empty,
> +	 * which they almost certainly are.  If either end up being empty,
> +	 * this is handled below after the moves.
> +	 */

I'd add here: "Note that old_parent->d_children can indeed be empty if e.g.
@dentry was IS_ROOT." Because otherwise one has to think too hard why the
condition is here :)

> +	if (hlist_empty(&old_parent->d_children))
> +		dget_dlock(old_parent);
> +	if (dentry->d_parent != old_parent &&
> +	    hlist_empty(&dentry->d_parent->d_children))
> +		dget_dlock(dentry->d_parent);

								Honza
> +
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

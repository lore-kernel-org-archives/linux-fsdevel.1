Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B2313E38;
	Tue, 18 Aug 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787088965; cv=none; b=FjRAxsxQXqsWBXllwok4NPl/L3b2xUS//7dG9E+BJIitaIywbk/8knJRagiCfcIE+hFJQH25NSKuh0tflYEjY1xhL+jmsXSuQDeeVsdBdy0mI+mhZ2vNYYGk6rfzm00jGzjDBkRb3q2BXX4eSLP1+mpbEsfiSGgqnMR75PXYxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787088965; c=relaxed/simple;
	bh=gvaLFg9L+2Vzj02sE84u3E/OAZmZVRYlLe1Ix1D5cfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi2H1wQmQjcDAPsRoka2jECGhYrTCmodWczVhq7sdofLyrI9q0ar35aJLbSU9ecoHEK2CdJ74hSDaRVri9u7A+3kO4zd/0BY4s/0TED66ejWrNc2WeY3ToH048EueQNUTX13Ge19ym3FfqhxH4ZBXBsolg6g2tThfi0J6qIGUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iOgJsSWo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yvplIHPe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZbZ6I6UG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bej71n4E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iOgJsSWo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yvplIHPe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZbZ6I6UG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bej71n4E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB6428477A;
	Tue, 18 Aug 2026 21:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787088957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6yk70ExfN9665Ic/WUBa9vX0twjP5vPiT1LamQ2sUY=;
	b=iOgJsSWorAtW/LQQYXeo+vmZt9ZiLXauJ7jwQkopdCQJU8LHov5r0g8OFBGpuP+DcOdfKT
	IwG8soxMNm+/7KFzioNBNb3gzd/XM8Zd9Lwfw3LZQyLELPyS2/w7v9tkl2XcTH2T2jocX6
	BTMmSuXi71or6hrxVqcq7MxWpZ4yBJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787088957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6yk70ExfN9665Ic/WUBa9vX0twjP5vPiT1LamQ2sUY=;
	b=yvplIHPeqXvKpUHbcmunRvvUKRQj+wvxxUkq45Eh2/50I2vb2FeAvwkKCdaB0WIOYZVDds
	GIBujVgbM3AD1wCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787088953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6yk70ExfN9665Ic/WUBa9vX0twjP5vPiT1LamQ2sUY=;
	b=ZbZ6I6UGEcwchK4Yde1dUzeTWrTk1TrxrEwk3JnV1XZJnyJSkEl9RMTj2zbGs7EYgA8r9Y
	77pVwiwn6XfNvRTYtx3pbCE7kPbMq+dV9LYGX38vi6LH3WGoAjlaqBIthw3vxnJyLZDQRx
	y/+iOYJaI8dBXAOK3+FC1LkxKZzWugY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787088953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6yk70ExfN9665Ic/WUBa9vX0twjP5vPiT1LamQ2sUY=;
	b=bej71n4Eb4FRojMu4NODETydeMolEf2AT1wGzxMrQrWaHRr2DTW4V3p/XHTQVyrEgR7ZK3
	7wJkQznBWUjXltCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C38E122BA;
	Tue, 18 Aug 2026 21:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IVK3LznQhGqTFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Aug 2026 21:35:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73561A13AD; Tue, 18 Aug 2026 23:35:53 +0200 (CEST)
Date: Tue, 18 Aug 2026 23:35:53 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Narek Jilavyan <njilav@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: do not cache a symlink length that disagrees with
 the string
Message-ID: <ymvbwy6meo6wkp7fmkcuimqk3k6idaurijrrzpd6uqcbxirkkb@2dpz7trwewc6>
References: <20260817081756.4176757-1-njilav@gmail.com>
 <CAGudoHEgPLtqzcsgJp5oVGWhTST0ZMVLA=kVDiLooh85N+LVWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEgPLtqzcsgJp5oVGWhTST0ZMVLA=kVDiLooh85N+LVWg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 17-08-26 17:24:56, Mateusz Guzik wrote:
> On Mon, Aug 17, 2026 at 10:17 AM Narek Jilavyan <njilav@gmail.com> wrote:
> >
> > inode_set_cached_link() stores a caller-supplied length in i_linklen and
> > sets IOP_CACHED_LINK. vfs_readlink() then uses that length directly:
> >
> >         if (inode->i_opflags & IOP_CACHED_LINK)
> >                 return readlink_copy(buffer, buflen, inode->i_link,
> >                                      inode->i_linklen);
> >
> > and readlink_copy() clamps only against the user buffer, not against
> > the string, so a length larger than the symlink body becomes a
> > copy_to_user() of adjacent kernel memory - reachable by any process
> > calling readlink() on such a symlink.
> >
> > The only thing standing behind the invariant is
> >
> >         VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
> >
> > which expands to BUILD_BUG_ON_INVALID() unless CONFIG_DEBUG_VFS is set.
> > On a production kernel it type-checks the expression and evaluates
> > nothing, so the value is stored unvalidated.
> >
> > All four in-tree callers are correct today, and notably the two whose
> > length comes from on-disk metadata (fs/ext4/inode.c, fs/erofs/inode.c)
> > both re-derive it and reject the inode rather than relying on this
> > helper.  The API should not require that of the next caller.
> >
> 
> I'm confused why you don't expect filesystems to guarantee correct
> value here, but I can agree issuing the strlen is not a big deal
> during inode setup and I'm not going to insist on NOT having it in
> prod kernels.

I don't know but to me this looks like overly defensive programming... If
we call strlen() in inode_set_cached_link(), then why pass the length to it
as an argument in the first place?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

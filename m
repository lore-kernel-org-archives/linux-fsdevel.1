Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4B4A9D52;
	Wed,  2 Sep 2026 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367976; cv=none; b=c8jBS/AnqPSq0UsktO9wGRFiDZ3OBd08yvUN9bQFBfXNcNmwwp0d4J94og8+pKIix/SmO7UT0txMCUywTK+UJXXUv0AvDALVJOmAQ34FonPMCcWshGqGqkky0aeXVELH6g4eSaf/3C3vtzdlfAvBN2iWOFCw7FH4QG38T8QmXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367976; c=relaxed/simple;
	bh=hMqA+QKEAF2IPsqscl/4sBxHSdPWplzyy+88SxdviIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlE4GFf7fHdWJ6J1zaHKTFcIenhKWzj4MubyzY8JNUjdj96AQSe46zAba7OQdV1feGPNpvBoWrhck7Ttp91QbksFxv10nDRm3i5b2UDYxjEhIKh7w09GXHjUxR3ifxpdRX4vTRPQwFAcIRyDp9/nEb++B/F1DycLB3SB7oZ9mG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/N9o7t6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1zpBRhiT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pqmmJmVX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ej5lSh39; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/N9o7t6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1zpBRhiT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pqmmJmVX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ej5lSh39"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF3641F7B8;
	Wed,  2 Sep 2026 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788367968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49vtVYxMewauCFVkl0PMYOjcGypv0dv/1vobOacUSjI=;
	b=b/N9o7t6+GGzDDmFr8DiTP2+t2Yd7az4Cg5nsZotbzV09ofHw9qi22CXg/OcZZ50r1Pqx3
	I2FjWvQA9HQ82IoYQyA0bONADSUbuj6HrVoUoSdx535oTSyyGIZK+hcKDrZ04vhN+iUOr4
	QRC5jvpvPUymNam9tt7rGM5oOFJ3cc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788367968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49vtVYxMewauCFVkl0PMYOjcGypv0dv/1vobOacUSjI=;
	b=1zpBRhiThJcVmVqg38iciunlkJvbwVf4Y0RakwXdLXud5xVS0bwaaBVYWVeTHUwVoTVV79
	B3j+48+PC+BCk/DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pqmmJmVX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ej5lSh39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788367964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49vtVYxMewauCFVkl0PMYOjcGypv0dv/1vobOacUSjI=;
	b=pqmmJmVXI+9UC2vtiOj24t9XQ8/uYhVmgpOXdyap8l7ywI0+E/ZJ4qRKzOriLZo/SWGTXs
	ngl6JIbU/9bI6WC2iJgRj7SUfjCqxGqmZVAmrvpKqAnMfU7ALadrHx73cJ8v087ozsfUVD
	zTCJpY6JIrme7LIyoHh+Cx3kMp/IgT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788367964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49vtVYxMewauCFVkl0PMYOjcGypv0dv/1vobOacUSjI=;
	b=Ej5lSh39rVYk44Su5Tmj/gFfZtRc2LEn/SbnaRxDikwJVLvNEYP66nnbmWqGy8iAMYz1Zs
	3rBBcoj9b1K4MIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88542136E6;
	Wed,  2 Sep 2026 16:52:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AexHIVxUmGpTKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Sep 2026 16:52:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 213F8A13B5; Wed, 02 Sep 2026 18:52:44 +0200 (CEST)
Date: Wed, 2 Sep 2026 18:52:44 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Daehyeon Ko <4ncienth@gmail.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] fanotify: destroy/add race leaves a mark on a detached
 connector
Message-ID: <3ds635aoslm67h5exattggmcmitru3owqrryexdq6ue5nubh4j@cmbhmsq6xdgr>
References: <yjfqzckumtd32dgqidi5sndvth2t67mjwah4kt4jiahlx2a5uf@if55sinfv5o7>
 <20260828042421.964822-1-4ncienth@gmail.com>
 <ptco7s5x7tjzp42dzlsitibdigpwucl2whwrq37tknjpo7x2lc@b7q27ldlorak>
 <CAOQ4uxgB9anyJcWem04w65VCJdxbbb2cQDZ_u8qMusw3xpB9Gw@mail.gmail.com>
 <63aj7jbfaoamdmcurlge2c2kqpliaifgq4vbythrrxpfyr5vtm@z64myom426zd>
 <CAOQ4uxh-NZ76hEFoNNGjyhodr9U=dvZuGVmYHVPGZ_=jRxCAsA@mail.gmail.com>
 <67hq7zqnvp6onwwjp24axucgxbzsko2dphielupdfzmfyk6x57@bdeef7fjkqfa>
 <CAOQ4uxiQF4M_YSBMW3h8VCKR15GV6g_K5nf=2odtYetEwKHm9A@mail.gmail.com>
 <6n6r5zvcu5ojihyb52rhejlky7xrn2a2p4l2cgfut5lsscunek@bcnpy7bifjrs>
 <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjbEY12XMmfCXTPTpASmECCXcGBQR+bS93k=4vgqzFDZA@mail.gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: AF3641F7B8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,redhat.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO

On Tue 01-09-26 23:53:48, Amir Goldstein wrote:
> On Tue, Sep 1, 2026 at 6:57 PM Jan Kara <jack@suse.cz> wrote:
> >
> > > +       }
> > >         res = __d_find_any_alias(inode); /* recheck under lock */
> > >         if (likely(!res)) { /* still no alias, attach a disconnected dentry */
> > >                 unsigned add_flags = d_flags_for_inode(inode);
> >
> > Thanks for looking into this!
> >
> 
> See attached patch (again helper named debatable).

Thanks for the patch! I have somewhat massaged the changelog and names and
sent it for inclusion to Christian. Since this is messing with dcache code,
it should better go through his tree (plus I want to give him a chance to
stop this somewhat hacky workaround ;)).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

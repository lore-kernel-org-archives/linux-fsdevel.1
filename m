Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF9417BD2;
	Fri, 25 Sep 2026 09:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328519; cv=none; b=BKMJPJhODURDMRuYky75l77OO23/6q8+OFQwTFyjm7/0nGjGbalXJ2LGYFxjJpozvMXAV1WFnwtjvF9EOO25N5vcP578DD3KolBg2SFOxn0dy4CWgAf+7CHpKP3dZqYBBtO4d0P4FYMwn1DMCuVanIJ6o9o1OsQupm2o5Jxuzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328519; c=relaxed/simple;
	bh=Qc5pDZjOAhOX5TAoIZwbqk6TAj7i4L9QmcLs6PkTAc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idnVppY3hz8BSLNsR9m++FscLjTiruTbwVHJiCrxIzY9eRtgLj5OSPfqgDfmfJxcm1lTTO1i0MoY7n5kWVmxO3XVUBzErOXH0twbluaHNdkT2tsIGSCb021oevpP2s/8PWcPRMFUyptg6wCFoXDD+ysSURpQD5TSQpapUF2fBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b4CRTSRl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LVSDoN1f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mbsbGF2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5CQADYVb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b4CRTSRl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LVSDoN1f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mbsbGF2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5CQADYVb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7889421D4B;
	Fri, 25 Sep 2026 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790328511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OrDb7ZMzcUu7IdYWKOA315s2wYHco9eBsTPt1Wx+JE=;
	b=b4CRTSRlaFLrxaARiG99KlM2Q8kRbv71GEUQ+9nxwfJol3wahIjLRDTgOfdEoPHDhoJfbh
	daCLj+amXD+7eV37yP8zjqqT87EAGcb2i6xA4isW/PH3nE5+mCqYRUVkco1ro5iRvPg5k0
	7bwFQZjTL3HSb+nvzdY8yDLAMRWfP2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790328511;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OrDb7ZMzcUu7IdYWKOA315s2wYHco9eBsTPt1Wx+JE=;
	b=LVSDoN1fnHqeui5hf2+5HVbissbq9ZdGW+TEJKiZPIf7yWrxZPxJGm3WrLmVH8DpiM0atG
	LFn7x1EE/ZjRdpCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790328507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OrDb7ZMzcUu7IdYWKOA315s2wYHco9eBsTPt1Wx+JE=;
	b=mbsbGF2fvRhR6AwA1Lm3/ezzdF6ht5Ez2yVdA0grvW8d8ybWYaLQRgmLQUPaS11KhkMLuU
	F9Baz13U5B8zt5xnyqjFOW2nDjflpBtLYpa+Sj1iziP3UwtLs33x94noB7QnwbVzjv1OOm
	IBY/zDGt7poyV5h3W+lk5kdA5eUXZlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790328507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OrDb7ZMzcUu7IdYWKOA315s2wYHco9eBsTPt1Wx+JE=;
	b=5CQADYVbxpSLMldnxWjk1fMjo34Un5oyGSuG2OkHEZK4PwcvnSRXa+WonzRVdLxUShW2gS
	FXOjU+WDdLcYbTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B67C138A7;
	Fri, 25 Sep 2026 09:28:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e/KUAbs+tmpBKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 25 Sep 2026 09:28:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0D35A13DA; Fri, 25 Sep 2026 11:28:18 +0200 (CEST)
Date: Fri, 25 Sep 2026 11:28:18 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: jack@suse.cz, benquike@gmail.com, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: reject short directory records in
 isofs_read_level3_size()
Message-ID: <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
References: <20260919222553.3792320-1-benquike@gmail.com>
 <20260923175215.1577791-1-matthias.goergens@gmail.com>
 <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf>
 <20260924151356.3287733-1-matthias.goergens@gmail.com>
 <20260925043804.2091174-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925043804.2091174-1-matthias.goergens@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,zeniv.linux.org.uk,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[archive.org:url,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO

On Fri 25-09-26 12:38:04, Matthias Goergens wrote:
> Hi Honza,
> 
> On Thu, Sep 24, 2026 at 11:13:56PM +0800, Matthias Goergens wrote:
> > Either way, I'll first check a set of real images for empty directory
> > blocks, so we know the check doesn't reject discs that mount today.
> 
> Empty directory blocks do occur: about 1% of the disc images I checked
> on archive.org have them, mostly from Easy CD Creator 4.0 to 4.2 and
> Nero, and always at the end of a directory.  One of them hangs on
> for_next, see [1].  Two more examples, with the bytes used in each
> block of the directory:
> 
>   https://archive.org/details/Anime_Transformer  DM_BXL2.iso
>     /XTRAS    2022 1526 empty   (Easy CD Creator 4.2)
>   https://archive.org/details/comdex-edu  Comdex_05.iso
>     /IMAGES   2012 2048 empty   (Nero)
> 
> So a general check in readdir or lookup would stop those discs from
> mounting.

OK, thanks for checking! BTW how did you do the check. Have you've downloaded
all the images? Anyway, despite this being contrary to ECMA-119 standard I
agree we shouldn't start refusing such images if they worked in the past.

> In isofs_read_level3_size() it would reject none of them: no empty block
> on those discs follows a record with the multi-extent flag, so the walk
> always ends first.  What refusing buys is limited to crafted images,
> where a flagged record followed by empty blocks makes the walk skip
> block after block until a read fails, because the 100-section limit
> counts records, not blocks.
> 
> No other reader I looked at rejects them: Microsoft's published CDFS
> sample, GRUB, libarchive, libcdio, 7-Zip and libisofs all skip empty
> blocks inside a multi-extent chain and stop at the end of the directory,
> and GRUB fixed an unbounded walk that way in 4e0bab34ece7 ("fs/iso9660:
> Add check to prevent infinite loop").  Windows Server 2022 and 2025 also
> join the sections across an empty block and return the whole file.
> 
> So I'd suggest following their lead: skip empty blocks in the walk as
> readdir and lookup do, and stop at the end of the directory.
> isofs_read_level3_size() doesn't know where the directory ends today,
> though.  isofs_lookup() does and could pass it down through
> __isofs_iget(), but inodes reached from an NFS file handle can't, so
> those would still need a bound such as counting skipped blocks towards
> the 100-section limit.  If that is more plumbing than you'd like, the
> counting alone would do.  What would you prefer?

Yes. I was actually looking at propagating the directory size to
__isofs_iget() yesterday before sending my replay and concluded we cannot
easily do that in all the cases. I don't think it makes sense to plumb the
directory size for the cases where we can do it - unless the image is
corrupted we don't need it and unreliable check doesn't help for corrupted
images. So yes, just keep the code skipping empty blocks and I'd just limit
the number of sections + empty blocks to 100. No sane disk image should
exceed that.

> Whatever the bound, only a zero length at the start of a block should
> count as an empty block.  A multi-extent record can end one block with
> padding and its next section start the following one; that has to keep
> working.

Agreed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

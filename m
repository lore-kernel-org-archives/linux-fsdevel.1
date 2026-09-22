Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1252CCEA;
	Tue, 22 Sep 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071733; cv=none; b=nVUHTqZnp2SFZerB2RWlgcKnvAKU04PNgym+iHRIKnwPcUr2Ky9l33FDLZCvYFDt8vIQNanytZhu9Ou8mj77sle5eatRcWk3vPXl+ACf9mLJGlDyuiuXkPMj6r3vuMWFw9kjX4VG4aQqY6WVjfQMHZAsmx+O1woT7pqqDBn4yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071733; c=relaxed/simple;
	bh=bnBnvz700ObWFBMmstbFv5RrIk6wzvP7IxWZLIVbPGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk94lgqnLZIQ1DOUGDTIl7d7cgWsaQ6cDySV90bP/XUr1+G2Mwh4kB4c4Py9+p+oE5zGaxExeRWE+rnUKWwxo44Loo8ydl7BgIkN/M5RNYuFvTTl3JEx/FYUU2v66m5rXEKLBa73ThiDmBp6wNwQ3PnMSXARqGSmr0brm7vJknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQxWHg1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQxWHg1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D92D1F00893;
	Tue, 22 Sep 2026 10:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790071727;
	bh=5vvTBgRGRQPteyqPEvtCbFkzoZdZ7d4+0R2e6ugnvIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aQxWHg1Chir2YJjvDa5di2pL2hWDomkzhRSOfBs1p1jA17MsviUhLxn0uCzAems0A
	 UYsR4mlCxKGXCz2TDibbWlS3S7Sah3vy6GX6wdIhHCWSjZF2fGqfkOioF7+h9CEcLt
	 fxRX6evsysBFxzVhmE5BdyyGDntFkuqGrlXKS1XU1KgKayNn/AHNuNuPGkOwPMFsXI
	 AveGCnyBuPlxAGjVrpUglbu/Kpmsk1m73KQFYfvmeUaYyj0KxqCGTN+QyJyfAratTU
	 TWMWSygnZoxr68KqaGsb9BqdbtFVIO+fNTaqwsPei971k3VUn7bjwOLsO2LMqm2C22
	 qsw2fliwnQhZw==
Date: Tue, 22 Sep 2026 12:08:43 +0200
From: Thorsten Blum <blum@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: Reduce hardlink hash allocation sizes
Message-ID: <arJTq4TiVgyVLGA3@kernel.org>
References: <20260919213859.24667-3-blum@kernel.org>
 <cbvwd3loa6edt7tjnd24vuv4dqnu6gul2ysbaooftx7d7o7zlo@xwg2ixm5ac37>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbvwd3loa6edt7tjnd24vuv4dqnu6gul2ysbaooftx7d7o7zlo@xwg2ixm5ac37>

On Tue, Sep 22, 2026 at 11:45:37AM +0200, Jan Kara wrote:
> On Sat 19-09-26 23:39:00, Thorsten Blum wrote:
> > Each hardlink hash entry reserves N_ALIGN(PATH_MAX) bytes for its name.
> > This makes every allocation larger than 4 KiB, placing it in the
> > kmalloc-8k bucket even for short names.
> > 
> > Use a flexible array with the already validated cpio name_len to reduce
> > allocation sizes.
> > 
> > Also use const for the read-only name parameter.
> > 
> > Signed-off-by: Thorsten Blum <blum@kernel.org>
> 
> ...
> 
> > @@ -106,14 +106,15 @@ static char __init *find_link(int major, int minor, int ino,
> >  			continue;
> >  		return (*p)->name;
> >  	}
> > -	q = kmalloc_obj(struct hash);
> > +
> > +	q = kmalloc_flex(struct hash, name, nlen);
> >  	if (!q)
> >  		panic_show_mem("can't allocate link hash entry");
> >  	q->major = major;
> >  	q->minor = minor;
> >  	q->ino = ino;
> >  	q->mode = mode;
> > -	strscpy(q->name, name);
> > +	strscpy(q->name, name, nlen);
> >  	q->next = NULL;
> >  	*p = q;
> >  	hardlink_seen = true;
> 
> What about the space for terminating \0 ? This way the stored 'name' will
> be actually one character shorter because strscpy() will overwrite the last
> character by \0. Or do I miss something?

do_name() guarantees that collected[name_len - 1] == '\0' before calling
maybe_link(), so name_len already includes the NUL terminator and no
character is overwritten.

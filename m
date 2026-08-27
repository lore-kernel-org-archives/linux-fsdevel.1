Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1B30E0FE
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859348; cv=none; b=mUdn2ffW+epMuuK7IaVvMu+iXPJr0lGX8ziZTZoCL3cgyL53RtGFEhgQQU35q80RgRXA4EbGw1YKYD21dErs/rkvpkv/LREhaF6pXY8Pm6MbuK3iQA98y5kHcixrAKwhyxuPScWfFbsJSKNtG67UldInQ5nOzLOl9DlhnXj/RZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859348; c=relaxed/simple;
	bh=FVwPN8Sg+S95IgThEhLAyOBX0B3MnGJOPG0Ej4wIdak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXNIVtzg5kOE7b43u/oG1YbahPqe/57m+upJK4BvO+OkOmYtKdanxaVEpwZq7cu1DjHR9swlo/kEaoVfnqwDye2zhi5KH2kGNXYReHi81E3DfolSBzDpdVFb4qxz9QkJAAlci0B7Rd2t2QuZFXysGBfF+7G5oYWc+uFUcmwke94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oVpcSOr3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uQuSEzBD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kYD+cp4f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nogfd0Va; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oVpcSOr3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uQuSEzBD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kYD+cp4f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nogfd0Va"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B5D51F790;
	Thu, 27 Aug 2026 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787859340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXx+9P8swJ39okusGIO4hdANV8c+U4eCVnyoHi7iSGE=;
	b=oVpcSOr3lRJn+XlluOosp4kqMxTd5DgRvCXhz7WNc75DrG/ScCkJmCsN6YHko/kUvEDJ+z
	6pv8/j08CEDYRSFlQHGzPQSRBLHUVgAF52tO9MYfAy7Ip69X3Ec9RZNNNKYB6xCGb45GWO
	XHt3rrTNvInfsLBww/Z5XY6dapMYuCE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787859340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXx+9P8swJ39okusGIO4hdANV8c+U4eCVnyoHi7iSGE=;
	b=uQuSEzBDq5oKYLeYQdu8tyxlyc/HSVL9oXEsNe5Et+ID8ocSZXG00BGCnShz+jmS6/vXEw
	zWe/l5H6zQ83yiDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787859336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXx+9P8swJ39okusGIO4hdANV8c+U4eCVnyoHi7iSGE=;
	b=kYD+cp4fS7GG1ZgIB4xsVVuM0/5BQkADmEgIqc6cVcuOi7LDgvjo9Iu5PEQc1qWHBFGuqa
	n/vfBbARs4whbGx1onmj+AphYaFHu1JeMtguDwzvjNtk7uKjeksvPiNnrBOc0e3VioBx0l
	vH5Wm39QJldd+h+bejzcQz/ifmTjvvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787859336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXx+9P8swJ39okusGIO4hdANV8c+U4eCVnyoHi7iSGE=;
	b=Nogfd0VaW4/xVj13upltp4cV6K4edIcNxgvNOHXxzYf7XU6QvzRENp/LaGe5ZqL4jOCFVt
	KqpUnEEdYPjS6CDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06C8E1352D;
	Thu, 27 Aug 2026 19:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yw60OYeRkGr/WQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 27 Aug 2026 19:35:35 +0000
Date: Thu, 27 Aug 2026 20:35:34 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Matthew Wilcox <willy@infradead.org>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	vdubeyko@coreweave.com
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
Message-ID: <apCQPaalWMaB5D-p@pedro-suse.lan>
References: <20260826225614.486112-1-slava@dubeyko.com>
 <ao9_az3JPNhHooMl@casper.infradead.org>
 <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, Aug 27, 2026 at 11:35:12AM -0700, Viacheslav Dubeyko wrote:
> On Thu, 2026-08-27 at 01:06 +0100, Matthew Wilcox wrote:
> > On Wed, Aug 26, 2026 at 03:56:07PM -0700, Viacheslav Dubeyko wrote:
> > > Christoph Hellwig has detected that taking the page lock around
> > > the kmap/modify/kunmap section is not enough on its own:
> > > writeback drops the page lock before the write actually completes,
> > > so a mutator that only waits on the lock can still start rewriting
> > > a page whose old contents are still in flight to the device.
> > > Mark the allocation file's mapping with mapping_set_stable_writes()
> > > and call folio_wait_stable() right after taking the page lock in
> > > both functions, so a mutator also waits out any writeback that was
> > > already in progress when it acquired the lock.
> > 
> > Why would you indirect through the stable mechanism rather than just
> > calling folio_wait_writeback() directly?
> 
> The HFS+ allocation file (block bitmap) is represented by sbi-
> >alloc_file inode and mapping represents the block bitmap space. If one
> thread is calling hfsplus_block_allocate() or hfsplus_block_free(),
> then it tries to modify the content of folios/pages in this mapping.
> But writeback could happen in the background in another thread. It
> sounds like "folio's contents to stay unchanged while writeback is in
> progress". This is why folio_wait_stable() was suggested. Do you mean
> that it is not exactly correct approach? Do you think that

Why do you want to do this? It's definitely unusual for filesystems (AFAIK)?
It sounds like you're trying to guarantee some sort of consistency in your
writes, without journaling, but I can't tell exactly why.

(FWIW, if you're trying to do this for metadata consistency reasons, I
really don't think this works, because not only do you not know if data
hits the disk, but you also don't know if other writes (e.g inodes) hit
the disk, etc)

-- 
Pedro

Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E03BED42;
	Wed, 30 Sep 2026 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766794; cv=none; b=Tzj4Krvhh92pSjhv6ugVMb8SJprK9UFIB5ARF/8Au5+Sa6D75pQxpBB2BcZS7IlaZcRCXYMdY33IHftiGY1HmDy6AcJfV6GP3qvjx91KqOakj5EIImhlVonJ96fWKZHHxCAntgwOVqgYbmQMsJP1XcCi0EfPT7uG/rKLM9b5Swk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766794; c=relaxed/simple;
	bh=HCN2jr2A1MK/DojBSS2GHsoErO9YBbFI6yl8PU3zZQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5DJC/FbQQOYPIhbcWvBuo26PyLf3vGikbDf3nDYRG7PgsbgCBJpC9Jc2MfKPyyX5Wz1l8creXReJAHi68tfBFDudFFcBqpM2hn+HCFRAzlJPYKbxuij04fpwzzEtX1yqCeAya08VlFIjnY0AVppygkSSMPDBjwW+5JhagoD3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=APSYSy+6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G2kptKsM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=axv1hXdx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96G+LUCY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="APSYSy+6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G2kptKsM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="axv1hXdx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96G+LUCY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC18321D5A;
	Wed, 30 Sep 2026 11:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790766786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RlWAC1FOPXiYK+mass3+oE6Lbhbou709kgHAdPXZrEs=;
	b=APSYSy+6o7PqcbV2k/NT186elLlttJsYQGwmaBY7BCqADCTVADYwS6aAIdFeQEuKeqcNZi
	CSgX4eXDVHvoVRIIcNfjnmRnHmqSsOlXsIgVEmw9oTmk0/XPg6mc7YwKRAfdOpvcbAYGib
	2D3/i2yB0lfA8GRNzPEb9nHpX9VSCy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790766786;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RlWAC1FOPXiYK+mass3+oE6Lbhbou709kgHAdPXZrEs=;
	b=G2kptKsMS/Ym9y1vZ3AEahHtzD9j/a/BhCyTvSd8NQnO8sQTOjf+qKapicETYMJBZKOhbh
	dGPoWEwYF6MHARAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790766781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RlWAC1FOPXiYK+mass3+oE6Lbhbou709kgHAdPXZrEs=;
	b=axv1hXdxDS87OVauNh7uelcfwmNXv3zH0PwNeiXdMVu6mx5nDUhTVi8KD/Xw4lmWdXOdpj
	ow4GYNNRjrn7+ZI4YnWdtPCeKwoUx34ovCs0HasZ2lIdute9uohjIB8RWTndYTTMQf0PD+
	z+SWwKG3qnlQI1UxBoXDXjkxp1TTrTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790766781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RlWAC1FOPXiYK+mass3+oE6Lbhbou709kgHAdPXZrEs=;
	b=96G+LUCYea67mNryWh7SXd5upwm/m9HUI5vRFMTEw48i7wI/drBTKvX+AzuAKjY/Yw2dKp
	y1tSFE7sgLFc1nDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5C6613722;
	Wed, 30 Sep 2026 11:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6VN9KL3uvGonKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Sep 2026 11:13:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4EBFBA13AD; Wed, 30 Sep 2026 13:13:01 +0200 (CEST)
Date: Wed, 30 Sep 2026 13:13:01 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] isofs: bound the name conversion and return long
 Joliet names whole
Message-ID: <uxcpgccobifwkptga6ukhm2colgm757q6rnmmpacsk3lbolbds@pdt7bl5wgmhu>
References: <20260926042916.3277409-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926042916.3277409-1-matthias.goergens@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO

On Sat 26-09-26 12:29:12, Matthias Goergens wrote:
> Honza, this reworks v1 along the lines of your review, on top of your
> for_next: both converters take the buffer size, the callers pass it, and
> the buffer shrinks to what they need, without size asserts.  But on long
> Joliet names it deliberately goes the other way: 1/4 returns them whole
> instead of cutting them at NAME_MAX, and 2/4 reports the longer limit in
> statfs.  1/4 also corrects the v1 history of the PAGE_SIZE bound.
> 
> 1/4 is also a fix.  get_joliet_filename() keeps the converted length in
> an unsigned char, so a Joliet name longer than 255 bytes of UTF-8 wraps
> and is listed under a garbled short name that cannot be looked up.
> PowerISO and UltraISO write such names by default (up to 110 UTF-16
> units, 330 bytes for CJK).
> 
> Such names are rare: in the Joliet trees of a few thousand archive.org
> images, mostly CJK, Thai or Indic, none is longer than 255 bytes.  The
> images I wrote with PowerISO and UltraISO (under wine), a crafted image
> with 111-unit names, and the survey scripts are at
> 
>   https://github.com/matthiasgoergens/linux/tree/isofs-joliet-long-names
> 
> (or I can post them here).
> 
> Why whole: as with empty directory blocks [1], I'd follow Windows.
> Joliet is Microsoft's extension, discs with such names are made with
> Windows tools for people who read them on Windows, and Windows returns
> the names whole, including 111-unit names in records that leave out the
> padding byte.  Scripts and CI logs:
> 
>   https://github.com/matthiasgoergens/isofs-windows-probe
> 
> On Linux, vfat and exfat already return names of up to 765 bytes and
> report a limit of 1530 in statfs, vfat since f68e542f3478 ("fat: Fix
> statfs->f_namelen"), and the VFS itself only limits a name to PATH_MAX
> (verify_dirent_name()).  So what breaks is what breaks with vfat today:
> copying such a file to ext4 or tmpfs fails with ENAMETOOLONG, which cp,
> tar and rsync report before carrying on; readdir_r() and inotify readers
> sized by the man page fail; and fanotify reports the event without the
> name and hits the WARN_ON_ONCE() in fanotify_info_copy_name(), for which
> I have sent a fix [2].  1/4 has the full list.  Cutting at NAME_MAX
> avoids all of this, but lists names that Windows does not show and that
> can collide within a directory.
> 
> If you still prefer NAME_MAX, I have that version ready and tested the
> same way: there 1/4 cuts long names at NAME_MAX on a character boundary,
> 2/4 is dropped, and 4/4 shrinks the buffer to NAME_MAX + 1.
> 
> Testing: a KASAN and UBSAN kernel under qemu, 19 images mounted with no
> iocharset, utf8, iso8859-1, cp932 and euc-jp, each with and without
> norock.  Only the four images with names over 255 bytes change, and only
> with no iocharset or utf8: their long names are now listed whole and
> open.  Everything else lists, looks up and reads as before.  Under a
> Debian userspace, ls, find, cp, tar, rsync, Python, readdir_r(), inotify
> and fanotify behave on the long-name images, including a crafted one
> with 111-unit names, as they do on a vfat with 765-byte names.  This
> replaces v1 2/2's claim, whose test never ran the Joliet or zisofs code.
> 
> v1: https://lore.kernel.org/all/20260922155524.1993425-1-matthias.goergens@gmail.com/
> [1] https://lore.kernel.org/all/cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n/
> [2] https://lore.kernel.org/all/20260926020851.2938961-1-matthias.goergens@gmail.com/

Thanks! The patches look good and I've added them to my tree. I've just
added the following hunk to your last patch to document the situation in
the code:

+       /*
+        * Rockridge can produce names of NAME_MAX size, Acorn extensions at
+        * most 227 chars.
+        */
+       BUILD_BUG_ON(JOLIET_NAME_MAX < NAME_MAX || JOLIET_NAME_MAX < 227);

I've also noticed we are somewhat inconsistent with the terminating \0
character. In particular get_joliet_filename() -> utf16s_to_utf8s() doesn't
null-terminate the returned string. Similarly isofs_name_translate()
doesn't result in null-terminated string. Other functions do terminate it
(which isn't really necessary AFAICS). It would be nice to clean this up if
you're interested.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

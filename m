Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA1367B65;
	Thu, 24 Sep 2026 12:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253370; cv=none; b=RDAOs+9Zb0OJe+b2GMD91xv3oY33mtB09Ndk8/1TZXhBIMb+nZvIKARPJYKIGgj9/D8bIAmaj728e+l3YLjYoSwmTMCqc2SGhw0CAgfQBTa1nXODnd4X0HZ5hnjdcavabObjShvWrfqFBvMfiFQxjx8B1kpJZVgtqvF+zeM8sWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253370; c=relaxed/simple;
	bh=SQgbufLiAyRGEpqTG3AhyTQh3dayUmXB4YEgMtGkIgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr4goNsatorBBPV2JTj5dUfzQ7Gij5gIZwYfOyqooUozk9ispVkdLjyK9BMuvTrf+lcwDKOr88ID4zhHFrI7kb/0BH/38DN+ygI3vbEbKMcJs4tqBICirke/LV/MiE9bALc3h4CpUAdAI9GV42BILUmVTbX1ANjY/0awUSc+/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e3Yny60Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eYBWK9bq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZQo37tpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zqXGyx9Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e3Yny60Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eYBWK9bq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZQo37tpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zqXGyx9Q"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27080200E9;
	Thu, 24 Sep 2026 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790253362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEXrYu7VMjyhQsjS5bstXK6xP97EMfT/69TR8N1Zah8=;
	b=e3Yny60ZegKYJWkdZvBSpROt/kuKp4kiIJQfN6aQARaNe1QYsvHeet2z8MBviQsZi3nd4b
	BcAlAknPNVsLPTKMAvbGxV24wPPxOf41PMbuFaDj/IacWfi9VuQGxn+pSiNNJbs397ME1y
	UG1S4l6gYKKiQdNneV/zeMyOP6yMALc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790253362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEXrYu7VMjyhQsjS5bstXK6xP97EMfT/69TR8N1Zah8=;
	b=eYBWK9bq7EYn8Kha6pV9EsAJcRAgVcXL3G7VtRGSjmdJ1iUDbTHJn/JtIBbTn6+DLvXHKx
	R/8OMlj3aCZ58oDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790253358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEXrYu7VMjyhQsjS5bstXK6xP97EMfT/69TR8N1Zah8=;
	b=ZQo37tpJ+/N8lW8/1/ck6QGHTY59k02HK9sXEKcbZ8MSY0GxOITt0A/F547mELd23qrraU
	rMYnInQmTkNkQCrMWF0PBmwcYRVh6ABsFKua2T19j3vKU+oEZvxPoi3mJzoMN2i2h2gRJC
	gX9H/m6fdG8CWg+XeJhff1Gonl/ybJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790253358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qEXrYu7VMjyhQsjS5bstXK6xP97EMfT/69TR8N1Zah8=;
	b=zqXGyx9Q+9z62D4Lwg1GnzPt/2r+0w9+LjTUvWJn/VYJAVtwG5aydt5NV5MpMi73ZAiV8K
	Gqkns/gy46/AofCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 707A413939;
	Thu, 24 Sep 2026 12:35:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jFcPESoZtWrPbwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 12:35:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EA7D0A132E; Thu, 24 Sep 2026 14:35:49 +0200 (CEST)
Date: Thu, 24 Sep 2026 14:35:49 +0200
From: Jan Kara <jack@suse.cz>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] isofs: size the name conversion buffer from a named
 constant
Message-ID: <bxzzdqzrxc7cc6kwvsmavn2b3al4filf7e6dtbwe7s4wk73fxq@2bz34y7npgvh>
References: <20260922155524.1993425-1-matthias.goergens@gmail.com>
 <20260922155524.1993425-2-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922155524.1993425-2-matthias.goergens@gmail.com>
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 22-09-26 23:55:23, Matthias Goergens wrote:
> isofs_readdir() and isofs_lookup() each allocate a 1024-byte scratch
> buffer that four converters write into: get_rock_ridge_filename(),
> get_joliet_filename(), get_acorn_filename() and isofs_name_translate().
> None of them is told how big it is.
> 
> get_joliet_filename() gets this wrong today.  It passes PAGE_SIZE as the
> output limit to utf16s_to_utf8s(), four times the buffer it is actually
> given.  That was correct until commit b2eb2e288604 ("isofs: Drop support
> of directory entries straddling blocks"), which shrank the allocation
> from a page to 1024 bytes in both callers without updating the bound.
> 
> No overflow is possible today: de->name_len is a single byte, so the
> largest name any converter can produce is 763 bytes, on the Joliet
> iocharset path ((255 >> 1) units, each expanding to at most
> NLS_MAX_CHARSET_SIZE bytes, plus a terminator).  But nothing says so,
> and joliet.c says the opposite.
> 
> Give the buffer a name, use it at both allocation sites and as the
> Joliet bound, and have each converter assert that its own worst case
> fits.  Shrinking the buffer, or NLS_MAX_CHARSET_SIZE growing, now fails
> the build instead of silently overflowing:
> 
>   fs/isofs/joliet.c:46:1: error: static assertion failed:
>     "(255 >> 1) * NLS_MAX_CHARSET_SIZE + 1 <= ISOFS_NAME_BUF_SIZE"
> 
> This follows fs/ntfs3, which couples its name buffer to the on-disk
> length field the same way (fs/ntfs3/dir.c: static_assert(NTFS_NAME_LEN *
> 4 < PATH_MAX)).
> 
> No functional change.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

So when touching this, let's do this properly :). Isofs driver should never
return filename longer than NAME_MAX bytes. It's violating POSIX,
expectations of glibc and although VFS should be able to cope, something is
practically guaranteed to break somewhere down the road either in kernel or
userspace.

Isofs directory records have the maximum length of 255 characters so
filenames in directory entry can be at most 223 characters long - that's
the practical limit for isofs_name_translate(), get_acorn_filename() can
add 4 more but that's still well within the NAME_MAX limit and probably we
don't need to treat that in a special way.

get_rock_ridge_filename() has an internal bound check for NAME_MAX when
parsing 'NM' entries - that might better be limited by the buffer size
passed externally.

get_joliet_filename() - you're handling that in patch 2 so let's do the
discussion there.

After get_rock_ridge_filename() and get_joliet_filename() get the buffer
size and respect it, we can just shrink the buffer to NAME_MAX+1 bytes and
be done with it. No need for any size asserts or similar weird things.

								Honza


> ---
>  fs/isofs/dir.c    | 9 ++++++++-
>  fs/isofs/isofs.h  | 9 +++++++++
>  fs/isofs/joliet.c | 9 ++++++++-
>  fs/isofs/namei.c  | 2 +-
>  fs/isofs/rock.c   | 3 +++
>  5 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
> index c7ca7603e97a..87c64612ef7f 100644
> --- a/fs/isofs/dir.c
> +++ b/fs/isofs/dir.c
> @@ -50,6 +50,13 @@ int isofs_name_translate(struct iso_directory_record *de, char *new, struct inod
>  }
>  
>  /* Acorn extensions written by Matthew Wilcox <willy@infradead.org> 1998 */
> +/*
> + * isofs_name_translate() copies at most de->name_len[0] bytes one for one,
> + * and get_acorn_filename() may append "," plus three hex digits and a NUL.
> + * de->name_len is a single byte.
> + */
> +static_assert(255 + 5 <= ISOFS_NAME_BUF_SIZE);
> +
>  int get_acorn_filename(struct iso_directory_record *de,
>  			    char *retname, struct inode *inode)
>  {
> @@ -237,7 +244,7 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
>  	char *tmpname;
>  	struct inode *inode = file_inode(file);
>  
> -	tmpname = kmalloc(1024, GFP_KERNEL);
> +	tmpname = kmalloc(ISOFS_NAME_BUF_SIZE, GFP_KERNEL);
>  	if (tmpname == NULL)
>  		return -ENOMEM;
>  
> diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
> index dacb9cdae4fd..2af41cc23f38 100644
> --- a/fs/isofs/isofs.h
> +++ b/fs/isofs/isofs.h
> @@ -5,6 +5,15 @@
>  #include <linux/iso_fs.h>
>  #include <linux/unaligned.h>
>  
> +/*
> + * Scratch buffer for converting an on-disk name to its in-kernel form.
> + * Allocated by isofs_readdir() and isofs_lookup(), written by
> + * get_rock_ridge_filename(), get_joliet_filename(), get_acorn_filename()
> + * and isofs_name_translate().  Each of those asserts that its own worst
> + * case fits, next to the code that does the writing.
> + */
> +#define ISOFS_NAME_BUF_SIZE 1024
> +
>  enum isofs_file_format {
>  	isofs_file_normal = 0,
>  	isofs_file_sparse = 1,
> diff --git a/fs/isofs/joliet.c b/fs/isofs/joliet.c
> index c0f04a1e7f69..b1f4a105ee87 100644
> --- a/fs/isofs/joliet.c
> +++ b/fs/isofs/joliet.c
> @@ -38,6 +38,13 @@ uni16_to_x8(unsigned char *ascii, __be16 *uni, int len, struct nls_table *nls)
>  	return (op - ascii);
>  }
>  
> +/*
> + * The worst case is the iocharset path: de->name_len is a single byte, so
> + * at most 255 >> 1 UTF-16 units, each of which uni2char() may expand to
> + * NLS_MAX_CHARSET_SIZE bytes, plus the terminator.
> + */
> +static_assert((255 >> 1) * NLS_MAX_CHARSET_SIZE + 1 <= ISOFS_NAME_BUF_SIZE);
> +
>  int
>  get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, struct inode * inode)
>  {
> @@ -49,7 +56,7 @@ get_joliet_filename(struct iso_directory_record * de, unsigned char *outname, st
>  	if (!nls) {
>  		len = utf16s_to_utf8s((const wchar_t *) de->name,
>  				de->name_len[0] >> 1, UTF16_BIG_ENDIAN,
> -				outname, PAGE_SIZE);
> +				outname, ISOFS_NAME_BUF_SIZE);
>  	} else {
>  		len = uni16_to_x8(outname, (__be16 *) de->name,
>  				de->name_len[0] >> 1, nls);
> diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
> index 010682f5901a..0146aef58b10 100644
> --- a/fs/isofs/namei.c
> +++ b/fs/isofs/namei.c
> @@ -153,7 +153,7 @@ struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned i
>  	struct inode *inode;
>  	char *tmpname;
>  
> -	tmpname = kmalloc(1024, GFP_USER);
> +	tmpname = kmalloc(ISOFS_NAME_BUF_SIZE, GFP_USER);
>  	if (!tmpname)
>  		return ERR_PTR(-ENOMEM);
>  
> diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
> index 2628f31bd3a5..7d95443917ea 100644
> --- a/fs/isofs/rock.c
> +++ b/fs/isofs/rock.c
> @@ -204,6 +204,9 @@ static int rock_check_overflow(struct rock_state *rs, int sig)
>  /*
>   * return length of name field; 0: not found, -1: to be ignored
>   */
> +/* get_rock_ridge_filename() bounds the name it builds by NAME_MAX, plus a NUL. */
> +static_assert(NAME_MAX + 1 <= ISOFS_NAME_BUF_SIZE);
> +
>  int get_rock_ridge_filename(struct iso_directory_record *de,
>  			    char *retname, struct inode *inode)
>  {
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

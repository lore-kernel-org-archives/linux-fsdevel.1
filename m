Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99237477E36;
	Tue, 16 Jun 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630352; cv=none; b=UlVcyV22KVor/rfh3icRZVHoEHgIn/pDKw3BESJo+0dxaVG7mOFtEtxL2KzwIVJYdnSJEACaBhi3Powdx1CcS6fpFVPWEACh1K4COHPdgjqFe9Sh6sN3KSMWnCc1WjBsFj/S4M4gpKROsUpa1sUwmry64awP1l9twZ4cl2uEv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630352; c=relaxed/simple;
	bh=AkKPx2yXOf+yRJAOA0i7tCW6FNDGa/rHfBJeJn2A7bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3jpU2yNuYbEZE5jmceht9dnkgUT8XPQad6t66eA0ixpDTbYGVhTxDKGzfAVazW/0AclKKbskIn8UlL4l1rBzSEI6AohfJDQkNYSV+49jjH5+s4EedtiTuiMCDoxbeXMoZy96L5SWf8YY1cumtNuQiY5V/1wMnul8VJ90GQd5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=NngHtZFh; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Ab6b6YlI; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="NngHtZFh";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Ab6b6YlI"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B036526F768E;
	Wed, 17 Jun 2026 02:19:07 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1781630347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRdr7p703XLF9CUN79pxvEpHGa46lmrj3ItZwZIgYRo=;
	b=NngHtZFhzm2eLBU0MK/BdbnQ2XoGEH6Jd9XlXCmSZ6PPf5y98QmbDMBmzjxmrjBPFY2qon
	8w1EX40uQ3oYYYInE62ED8MeRbmf5hbuKYyYuuHOtGC5zqAvEe8IOUu71glrKm3JzxvLwS
	EzfKMNGo4Z6zEUE1V3b2J7SaX89ZcZfHtV868XAIzTvPbGb6iw76Z0JQ38ouDD5pvvhDzx
	R0V0GoyyU0V7yxan+hrkE0g4LPZbDa19/l4GflzvI34dmHVBttkm+CFI+2PYdgIoYEUhya
	N5nMq7sXbg3qgEK1ygUQXhvnP0ADoiKnrkWA9lBgLnDVBWD9BHxHXXWY0SgMXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1781630347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XRdr7p703XLF9CUN79pxvEpHGa46lmrj3ItZwZIgYRo=;
	b=Ab6b6YlIjyanwrsHl/EeMrrWwe9yphqz811FiVrcS8Q4vB2qLfAbTM1q98zFqD8L4pNlbB
	0/THUVcv2rh9BWAw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 3F825E003B8;
	Wed, 17 Jun 2026 02:19:07 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 24EB922000BF; Wed, 17 Jun 2026 02:19:07 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matteo Croce <technoboy85@gmail.com>, Timothy Redaelli
 <tredaelli@redhat.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v4] fat: stop reading directory entries past the
 end-of-directory marker
In-Reply-To: <20260616163346.32603-1-technoboy85@gmail.com>
References: <20260616163346.32603-1-technoboy85@gmail.com>
Date: Wed, 17 Jun 2026 02:19:07 +0900
Message-ID: <87mrwu4d4k.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matteo Croce <technoboy85@gmail.com> writes:

> The FAT specification[1] (FAT Directory Structure -> "DIR_Name[0]") states:
>
>     If DIR_Name[0] == 0x00, then the directory entry is free (same as for
>     0xE5), and there are no allocated directory entries after this one
>     (all of the DIR_Name[0] bytes in all of the entries after this one
>     are also set to 0).
>
>     The special 0 value, rather than the 0xE5 value, indicates to FAT
>     file system driver code that the rest of the entries in this
>     directory do not need to be examined because they are all free.
>
> Linux did not honour this. fat_get_entry() kept advancing past the 0x00
> terminator; if the trailing on-disk slots were not zero-filled (buggy
> formatters, read-only media written by other operating systems, on-disk
> corruption) the driver surfaced arbitrary bytes as real directory
> entries. On a typical affected image, `ls /mnt` returns ~150 bogus
> entries with random binary names, multi-gigabyte sizes, dates ranging
> from 1980 to 2106, and a flood of -EIO from stat().
>
> Earlier attempts (v1..v3, see [2][3][4]) added `de->name[0] == 0` guards
> at each call site. As Hirofumi pointed out on v3, those guards reject
> the entry but fat_get_entry() has already advanced *pos past it; the
> next readdir() resumes after the marker and walks straight back into
> the garbage. His suggestion was to centralise the check.
>
> This patch:
>
>   * Adds fat_get_entry_eod(), a small wrapper around fat_get_entry()
>     that returns -1 when name[0] == 0 and seeks *pos to dir->i_size.
>     Per spec every slot after the 0x00 marker is also zero, so jumping
>     to the end of the directory is correct: subsequent reads return -1
>     from fat_bmap() without re-fetching trailing zero slots, and
>     callers persisting *pos across invocations (notably readdir's
>     ctx->pos) keep reporting end-of-directory on re-entry.
>
>   * Converts the read/search paths to use the new wrapper:
>       fat_parse_long(), fat_search_long(), __fat_readdir(),
>       and fat_get_short_entry() -- the last covers
>       fat_get_dotdot_entry(), fat_dir_empty(), fat_subdirs(),
>       fat_scan(), and fat_scan_logstart() transitively.
>
>   * Leaves fat_add_entries() and __fat_remove_entries() on raw
>     fat_get_entry(): the write paths legitimately need to operate on
>     free/zero slots. fat_add_entries() additionally detects an
>     allocated entry past a 0x00 marker (the spec violation that
>     produces the garbage) and treats it as filesystem corruption:
>     fat_fs_error_ratelimit() is called -- which honours the configured
>     errors= mount option (panic / remount-ro / continue) -- and the
>     operation returns -EIO so we don't write fresh entries into an
>     already-corrupt directory.
>
> [1] https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
> [2] https://lore.kernel.org/lkml/20181207013410.7050-1-mcroce@redhat.com/
> [3] https://lore.kernel.org/lkml/20181216231510.26854-1-mcroce@redhat.com/
> [4] https://lore.kernel.org/lkml/20190201001408.7453-1-mcroce@redhat.com/
>
> Reported-by: Timothy Redaelli <tredaelli@redhat.com>
> Suggested-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

Thanks.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/dir.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 4f6f42f33613..c6cca5d00ffd 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -130,6 +130,31 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
>  	return fat__get_entry(dir, pos, bh, de);
>  }
>  
> +/*
> + * Like fat_get_entry(), but honour the FAT end-of-directory marker:
> + * a dirent whose first name byte is NUL terminates iteration per the
> + * spec, which also guarantees that every following slot is zeroed.
> + * Skip straight to the end of the directory so the next call returns
> + * -1 from fat_bmap() without re-reading the trailing zero slots, and
> + * so callers that persist *pos across invocations (e.g. readdir's
> + * ctx->pos) keep reporting EOD.  Release *bh and set it to NULL to
> + * match fat_get_entry()'s contract that *bh is NULL on the -1 return.
> + */
> +static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
> +			     struct buffer_head **bh,
> +			     struct msdos_dir_entry **de)
> +{
> +	int err = fat_get_entry(dir, pos, bh, de);
> +
> +	if (err == 0 && (*de)->name[0] == 0) {
> +		brelse(*bh);
> +		*bh = NULL;
> +		*pos = dir->i_size;
> +		return -1;
> +	}
> +	return err;
> +}
> +
>  /*
>   * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
>   * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
> @@ -327,7 +352,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
>  
>  		if (ds->id & 0x40)
>  			(*unicode)[offset + 13] = 0;
> -		if (fat_get_entry(dir, pos, bh, de) < 0)
> +		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
>  			return PARSE_EOF;
>  		if (slot == 0)
>  			break;
> @@ -489,7 +514,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
>  
>  	err = -ENOENT;
>  	while (1) {
> -		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
>  			goto end_of_dir;
>  parse_record:
>  		nr_slots = 0;
> @@ -601,7 +626,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
>  
>  	bh = NULL;
>  get_new:
> -	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
>  		goto end_of_dir;
>  parse_record:
>  	nr_slots = 0;
> @@ -885,7 +910,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
>  			       struct buffer_head **bh,
>  			       struct msdos_dir_entry **de)
>  {
> -	while (fat_get_entry(dir, pos, bh, de) >= 0) {
> +	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
>  		/* free entry or long name entry or volume label */
>  		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
>  			return 0;
> @@ -1302,6 +1327,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  	struct msdos_dir_entry *de;
>  	int err, free_slots, i, nr_bhs;
>  	loff_t pos;
> +	bool saw_eod;
>  
>  	sinfo->nr_slots = nr_slots;
>  
> @@ -1310,12 +1336,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  	bh = prev = NULL;
>  	pos = 0;
>  	err = -ENOSPC;
> +	saw_eod = false;
>  	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
>  		/* check the maximum size of directory */
>  		if (pos >= FAT_MAX_DIR_SIZE)
>  			goto error;
>  
>  		if (IS_FREE(de->name)) {
> +			if (de->name[0] == 0)
> +				saw_eod = true;
>  			if (prev != bh) {
>  				get_bh(bh);
>  				bhs[nr_bhs] = prev = bh;
> @@ -1325,6 +1354,13 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  			if (free_slots == nr_slots)
>  				goto found;
>  		} else {
> +			if (saw_eod) {
> +				fat_fs_error_ratelimit(sb,
> +					"allocated dir entry found after end-of-directory marker (i_pos %lld)",
> +					MSDOS_I(dir)->i_pos);
> +				err = -EIO;
> +				goto error;
> +			}
>  			for (i = 0; i < nr_bhs; i++)
>  				brelse(bhs[i]);
>  			prev = NULL;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

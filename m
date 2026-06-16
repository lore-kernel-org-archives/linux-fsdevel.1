Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1642981C;
	Tue, 16 Jun 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607589; cv=none; b=UoxJmTJyDPgKrjNHOF7+JWakCaP3+AKJY6K88c169JlH2xK9CVBb4lQh4Kh2paq5Q7hLW4bUJdIfCJDrJAMGO9XjDuHcbsn0wqFbqpbYSqAO7wEtiCsvnfRud7WrcPkycRTQ/713emkFpp3K+YlKmlpTAzeUqzpNwfT+vzGGyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607589; c=relaxed/simple;
	bh=YE7247dljL6Zkjk7NmaGXHMM8RpVrxUhGuMCVY8yPDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ha9gDtpOI0WVP6OobQ77CsgWYEKbKCHPxpPcQC9uYnJf6mF8iu4aFzvZV7L2Z2j3jpWPfx/JCO1hfIHECwgCDCskHW+6ZBmTD1xtefJXwDpjVjX+pfszrei+TkwEnWbTuitJZEQUVUNyLjq34OF061oYamf4ZYdunm32Bapb3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=r4B+skvy; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=/CgdbIWW; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="r4B+skvy";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="/CgdbIWW"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 8C8D526F7662;
	Tue, 16 Jun 2026 19:59:37 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1781607577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pI5baVHQ66eEV5f5Ud+HcIzBUVIdedKNXY7A8xvaxY=;
	b=r4B+skvyfjqhwbA0fwwfjfFW0YRQrEhobVJ5NnTX3CbG+xLPOpx+3SGP59Mq2D///eb6HZ
	s96w6Xsfb2r/XpQbIIxPh4Oi0GSJ5Wbkffs/iM0M/XYfh01RhRb2vXkxaGOFaVwC3n/gKB
	adjBu+7ZVhhxqJUDcpyymhy8ITnj18w+C7iAuxfnq2gD3YpcULQVr55AHTKb/Q/WVj7ZJD
	lY+etoS2/9junro18yOx/BIW63Gm1qkBlSVqE9zLJHxvuw+xdsu7RJjp++zbh9at1lPJhP
	EuPL20BHXhnHDtUER3VTXQEG130AMgOTC4FtbRselNwyAkCU/frQpfzHrDaYKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1781607577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7pI5baVHQ66eEV5f5Ud+HcIzBUVIdedKNXY7A8xvaxY=;
	b=/CgdbIWW8dqGeLmiJic6K7Pyb25gKSnq00UHAXYPe4RwuDR67rO9itF2bkYPxoEPXTZ58c
	4mi/k1C4r9t9a2CA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 1A8F5E00743;
	Tue, 16 Jun 2026 19:59:37 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 0962E2200085; Tue, 16 Jun 2026 19:59:37 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matteo Croce <technoboy85@gmail.com>, Timothy Redaelli
 <tredaelli@redhat.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Matteo Croce <teknoraver@meta.com>
Subject: Re: [PATCH v3] fat: stop reading directory entries past the
 end-of-directory marker
In-Reply-To: <20260613172816.18034-1-technoboy85@gmail.com>
References: <20260613172816.18034-1-technoboy85@gmail.com>
Date: Tue, 16 Jun 2026 19:59:37 +0900
Message-ID: <878q8e699i.fsf@mail.parknet.co.jp>
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

There are some strange behavior though (e.g. seek after name[0] == 0,
then readdir()), the strange should only be on already a corrupted image.

Well, if we found a serious issue with this, there is possibility to
revert later though. Looks good for me.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/dir.c | 41 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 4f6f42f33613..c7d0bc5de697 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -130,6 +130,28 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
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
> + * ctx->pos) keep reporting EOD.
> + */
> +static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
> +			     struct buffer_head **bh,
> +			     struct msdos_dir_entry **de)
> +{
> +	int err = fat_get_entry(dir, pos, bh, de);
> +
> +	if (err == 0 && (*de)->name[0] == 0) {
> +		*pos = dir->i_size;
> +		return -1;
> +	}
> +	return err;
> +}
> +
>  /*
>   * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
>   * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
> @@ -327,7 +349,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
>  
>  		if (ds->id & 0x40)
>  			(*unicode)[offset + 13] = 0;
> -		if (fat_get_entry(dir, pos, bh, de) < 0)
> +		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
>  			return PARSE_EOF;
>  		if (slot == 0)
>  			break;
> @@ -489,7 +511,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
>  
>  	err = -ENOENT;
>  	while (1) {
> -		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
>  			goto end_of_dir;
>  parse_record:
>  		nr_slots = 0;
> @@ -601,7 +623,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
>  
>  	bh = NULL;
>  get_new:
> -	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
>  		goto end_of_dir;
>  parse_record:
>  	nr_slots = 0;
> @@ -885,7 +907,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
>  			       struct buffer_head **bh,
>  			       struct msdos_dir_entry **de)
>  {
> -	while (fat_get_entry(dir, pos, bh, de) >= 0) {
> +	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
>  		/* free entry or long name entry or volume label */
>  		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
>  			return 0;
> @@ -1302,6 +1324,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  	struct msdos_dir_entry *de;
>  	int err, free_slots, i, nr_bhs;
>  	loff_t pos;
> +	bool saw_eod;
>  
>  	sinfo->nr_slots = nr_slots;
>  
> @@ -1310,12 +1333,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
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
> @@ -1325,6 +1351,13 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
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

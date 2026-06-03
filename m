Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9F3921DD;
	Wed,  3 Jun 2026 06:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780467824; cv=none; b=OevFEyhplscbgiBqqhrTAAI8An+lvBZi0Eh9YZvhq6yeHMYFX+AiRxPbOfUIVe5t4sUXWJlg7RAK7V82tuKPrQ3GmTn8dt6DCnTwaBN5T4VS7fwC8RJDDbqcgd3pRYf+QzdUeDFTotrUWDe1gvXlQfP1TT1Sn6hGPGqhXVlYTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780467824; c=relaxed/simple;
	bh=uYhm8QNvG9IY2xc+IVP403TIQlnk+21WVCrKgs5QZ4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ceDd+IIvQIzOPZQ9hokXDsy+QYl1v7UvHjG05X8mDZc2uwfJwCj3VLBQKw1WL16jaRzAP7NpgJODphvw12/HH4vWJk5vXOQ0K8mam+aTJDPJTt9SFttKJmyiOjTTq/sm2Km85jxbAaIOjQo0zEikBN7uiexX1V2J/v96ldrOmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=fgwiTfmg; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=fg5DOj7V; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="fgwiTfmg";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="fg5DOj7V"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 7A5E526F765F;
	Wed,  3 Jun 2026 15:15:31 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1780467331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLTIoFL4HfKf9H/T2PmOj2xMWqfyVB0ymdXuUth9B1A=;
	b=fgwiTfmgGkfgqLcrJWA18EV38w3s1NDZZ7RRFAhrNofns6CYTrlNR/uAm8ehFF8xNm7EP0
	hHz0Y346IqoTvPjjdeozPTSy6B5Tn2ZVr5QyC57gWIuaEwHPAYwCKa2u4rHKV5luuclg+O
	ZfonB2sMXIJDjbrv0Nbfhw5OYVAsDaFw98wfWGhBrdBRDukAOc4Oz4FC7O/su0CjhnzBmE
	ROKBRmOsSN513n7VQhopFjibFij4HMGvfzuOCGMB9AKHuaaEEzp1cEY0YJRA3fbRiN4h+G
	NvMHE4ur3AquN6aoVA9PZGXquFk2aVacbGhyBzSl9yxmnrsqPbwzLd9N2K4cnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1780467331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLTIoFL4HfKf9H/T2PmOj2xMWqfyVB0ymdXuUth9B1A=;
	b=fg5DOj7VIhnPlBQ4LM7NUJnv2RNyNZ9xJm0Qf8Dnf2crnoUC4UKnnleXLzQoBhxttHVkhl
	W4Y3VIqH133J3cCA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id E566EE002D5;
	Wed, 03 Jun 2026 15:15:30 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id D51B52200151; Wed, 03 Jun 2026 15:15:30 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Timothy Redaelli <tredaelli@redhat.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: stop reading directory entries past the
 end-of-directory marker
In-Reply-To: <20260514203436.13789-1-teknoraver@meta.com>
References: <20260514203436.13789-1-teknoraver@meta.com>
Date: Wed, 03 Jun 2026 15:15:30 +0900
Message-ID: <87y0gwi1z1.fsf@mail.parknet.co.jp>
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
> Linux doesn't honour this: if the trailing on-disk slots is not zero-filled
> (buggy formatters, on-disk corruption, etc.) fat_get_entry() keeps on
> advancing past the 0x00 terminator and the driver parses arbitrary bytes as
> real directory entries.
> On a typical affected image, `ls /mnt` returns ~150 bogus entries with
> random binary names, multi-gigabyte sizes, dates ranging from 1980 to 2106,
> and a flood of -EIO from stat().
>
> Earlier attempts (was "vfat: don't read garbage after last dirent"[2][3][4])
> added `de->name[0] == 0` guards at each call site.
> As Hirofumi pointed out on v3, those guards reject the entry but
> fat_get_entry() has already advanced *pos past it. The next readdir()
> resumes after the marker and walks straight back into the garbage.
>
> This patch:
> Adds fat_get_entry_eod(), a small wrapper around fat_get_entry()
> that returns -1 when name[0] == 0 AND rewinds *pos to the marker.
> converts the read/search paths to use the new wrapper.
> Leaves fat_add_entries() and __fat_remove_entries() on raw fat_get_entry():
> the write paths legitimately need to operate on free/zero slots.
> Additionally, log a rate-limited warning suggesting fsck if it sees an
> allocated entry after a 0x00 marker.
>
> [1] https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc
> [2] https://lore.kernel.org/lkml/20181207013410.7050-1-mcroce@redhat.com/
> [3] https://lore.kernel.org/lkml/20181216231510.26854-1-mcroce@redhat.com/
> [4] https://lore.kernel.org/lkml/20190201001408.7453-1-mcroce@redhat.com/

> Reported-by: Timothy Redaelli <tredaelli@redhat.com>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  fs/fat/dir.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 4f6f42f33613..109330da77b1 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -130,6 +130,26 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
>  	return fat__get_entry(dir, pos, bh, de);
>  }
>  
> +/*
> + * Like fat_get_entry(), but honour the FAT end-of-directory marker:
> + * a dirent whose first name byte is NUL terminates iteration per the
> + * spec. *pos is rewound to the EOD slot so callers that persist *pos
> + * across invocations (e.g. readdir's ctx->pos) keep reporting EOD.
> + */
> +static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
> +			     struct buffer_head **bh,
> +			     struct msdos_dir_entry **de)
> +{
> +	loff_t saved = *pos;
> +	int err = fat_get_entry(dir, pos, bh, de);
> +
> +	if (err == 0 && (*de)->name[0] == 0) {
> +		*pos = saved;

This rollback seek position to previous. But actual name[0]==0 means
all dirents have name[0]==0 after it (never be used). So it can skip
until the end of this dir.

So why this rollback the seek position to previous, not seek to the end
of dir?  If it points the end of dir, this would work as just
optimization, not bug workaround?

Thanks.

> +		return -1;
> +	}
> +	return err;
> +}
> +
>  /*
>   * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
>   * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
> @@ -327,7 +347,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
>  
>  		if (ds->id & 0x40)
>  			(*unicode)[offset + 13] = 0;
> -		if (fat_get_entry(dir, pos, bh, de) < 0)
> +		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
>  			return PARSE_EOF;
>  		if (slot == 0)
>  			break;
> @@ -489,7 +509,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
>  
>  	err = -ENOENT;
>  	while (1) {
> -		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
>  			goto end_of_dir;
>  parse_record:
>  		nr_slots = 0;
> @@ -601,7 +621,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
>  
>  	bh = NULL;
>  get_new:
> -	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
>  		goto end_of_dir;
>  parse_record:
>  	nr_slots = 0;
> @@ -885,7 +905,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
>  			       struct buffer_head **bh,
>  			       struct msdos_dir_entry **de)
>  {
> -	while (fat_get_entry(dir, pos, bh, de) >= 0) {
> +	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
>  		/* free entry or long name entry or volume label */
>  		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
>  			return 0;
> @@ -1302,6 +1322,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  	struct msdos_dir_entry *de;
>  	int err, free_slots, i, nr_bhs;
>  	loff_t pos;
> +	bool saw_eod;
>  
>  	sinfo->nr_slots = nr_slots;
>  
> @@ -1310,12 +1331,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
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
> @@ -1325,6 +1349,12 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  			if (free_slots == nr_slots)
>  				goto found;
>  		} else {
> +			if (saw_eod) {
> +				fat_msg_ratelimit(sb, KERN_WARNING,
> +					"allocated dir entry found after end-of-directory marker (i_pos %lld); please run fsck",
> +					MSDOS_I(dir)->i_pos);
> +				saw_eod = false;
> +			}
>  			for (i = 0; i < nr_bhs; i++)
>  				brelse(bhs[i]);
>  			prev = NULL;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

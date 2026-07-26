Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB431E4BE;
	Sun, 26 Jul 2026 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785055217; cv=none; b=naYKxVCgU+MEasucJyLuMjbxFgz7mrOTnQQV/xhsproUZShTvJ0mkGU0udb0Oc0dAbJnZ1AIXfHMd24gdPTJyLS+eTrWZ2R6Zp8UKrxvHyfWdzW5Z24Anls+nERwtrpudpLtq5uPaZm5pRBgDyE7lVaSTnpE2JdU/87wHVLLZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785055217; c=relaxed/simple;
	bh=d+RkS//xRuYHOfhel/YV9vb563Nyh0tGRqDl4j0QY64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYY4clI7lN4p8bRHVL2VTZM9LVjzxcTF7FKd6nuzKrgkXeCm9V4+q+EVNqpJMztVw61u2E8F+zHFx+kac4SoWQu16bKkZ/5WR+8o1fQtX4QOBr/xCWukh+XTSG5amtyZUhJZ0qvk9URB0jYuOwEtHscGaw6aQCgR/s8B/HK8DGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=zPjNXeJj; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=kbCkurGT; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="zPjNXeJj";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="kbCkurGT"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id DCE1726F7658;
	Sun, 26 Jul 2026 17:31:08 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1785054669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMJyO8dEXZLWd6Gl9OdczdV+6e2wsZt0C4EdkERFJkI=;
	b=zPjNXeJjxCHZecntaXJAimk/UL1aUn/w3C+UGTApAhN67bJA8cBk1iuylZfgEKf70bNReD
	aRnUUgT/GzRJC/88yqV2+WJQpphEvNhMRiqykFRw+RCcPoO2l/I7VLKLyHDsQLsSbDx8Vs
	QHW5GI+f3yQT84ZsxB/pwCMoPg6PM0P9joc8XQ0u9OLftIJ0X3IV66kWEEh99EVeo64fsP
	6Imq5hNKVJBNceaOoxoZMkKIkOXOU8ibz+3TjUrxankUz3AO7EKELWwfhI1nkA+2b/5CNV
	DFj2T8/u6mKipfjSni9I3g3Sfr6Zv655ogCIXW+CviXUFScRI6PzTECCmdMIdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1785054669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uMJyO8dEXZLWd6Gl9OdczdV+6e2wsZt0C4EdkERFJkI=;
	b=kbCkurGT/rQgiYo9kQ+vME1NMcy2FthKH0MgqXwf0U29E/j/kNjRo8sc1u+x2JuXE/QyRT
	Xkn6e7f01bUtkgAw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 68143E000FB;
	Sun, 26 Jul 2026 17:31:08 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 5F8DA2200086; Sun, 26 Jul 2026 17:31:08 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Cihan Karadag <cihan.cihan@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,  Shuah
 Khan <shuah@kernel.org>
Subject: Re: [PATCH] fat: preserve reserved lcase bits across rename
In-Reply-To: <20260723010227.88190-1-cihan.cihan@gmail.com>
References: <20260723010227.88190-1-cihan.cihan@gmail.com>
Date: Sun, 26 Jul 2026 17:31:08 +0900
Message-ID: <87v7a2gnjn.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cihan Karadag <cihan.cihan@gmail.com> writes:

> The lcase field of struct msdos_dir_entry
> (include/uapi/linux/msdos_fs.h) has only two bits the kernel
> interprets, CASE_LOWER_BASE and CASE_LOWER_EXT; the rest are reserved
> and other implementations may use them to carry their own metadata
> (e.g. the Windows EFS "encrypted file" bit pattern).
>
> vfat_rename() currently loses those reserved bits in both of its
> paths: when the destination name doesn't already exist, a brand new
> directory entry is built from scratch with a freshly computed lcase
> byte, zeroing anything outside the two known bits; when the rename
> overwrites an existing destination, the destination's own (unrelated)
> reserved bits are left in place instead of the source file's.
>
> Add vfat_overwrite_lcase_reserved_bits() and call it once new_i_pos is
> established inside vfat_rename(), overwriting the surviving entry's
> reserved lcase bits with the original file's, so the metadata is
> carried over across the rename instead of being lost.
>
> Tested by booting the patched kernel under QEMU and replaying the bug
> report's own before/after FAT32 images: the renamed entry's lcase byte
> now matches the source's reserved bits instead of being zeroed.

A bit strange design. It is mixing different lifetime, one is for dirent
and one is for inode.

Well, so, windows normal FAT really reserve those bits too over rename?
And implementation side, vfat_overwrite_lcase_reserved_bits() doesn't
race with fat_write_inode()?

If it has to reserve the inode lifetime bits, I feel it should write via
fat_write_inode().

Thanks.

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215093
> Signed-off-by: Cihan Karadag <cihan.cihan@gmail.com>
> ---
>  fs/fat/namei_vfat.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index e909447873e36..d4677c1eaabc3 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -931,6 +931,38 @@ static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
>  		mark_inode_dirty(dir);
>  }
>  
> +/*
> + * Overwrite the reserved lcase bits (those not used by the
> + * kernel) of the entry at i_pos with those from the source
> + * lcase byte.
> + */
> +static int vfat_overwrite_lcase_reserved_bits(struct inode *dir, loff_t i_pos,
> +					      unsigned char src_lcase)
> +{
> +	/* lcase bits the kernel actually assigns meaning to */
> +	const unsigned char lcase_unreserved_bits = CASE_LOWER_BASE | CASE_LOWER_EXT;
> +	struct super_block *sb = dir->i_sb;
> +	struct buffer_head *bh;
> +	struct msdos_dir_entry *de;
> +	sector_t blocknr;
> +	int offset, err = 0;
> +
> +	fat_get_blknr_offset(MSDOS_SB(sb), i_pos, &blocknr, &offset);
> +	bh = sb_bread(sb, blocknr);
> +	if (!bh)
> +		return -EIO;
> +
> +	de = &((struct msdos_dir_entry *)bh->b_data)[offset];
> +	de->lcase = (de->lcase & lcase_unreserved_bits) |
> +		    (src_lcase & ~lcase_unreserved_bits);
> +
> +	mmb_mark_buffer_dirty(bh, &MSDOS_I(dir)->i_metadata_bhs);
> +	if (IS_DIRSYNC(dir))
> +		err = sync_dirty_buffer(bh);
> +	brelse(bh);
> +	return err;
> +}
> +
>  static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		       struct inode *new_dir, struct dentry *new_dentry)
>  {
> @@ -974,6 +1006,17 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			goto out;
>  		new_i_pos = sinfo.i_pos;
>  	}
> +
> +	/*
> +	 * The kernel only interprets some of the lcase bits; make
> +	 * sure the rest carry over from old_dentry's lcase instead
> +	 * of being silently clobbered.
> +	 */
> +	err = vfat_overwrite_lcase_reserved_bits(new_dir, new_i_pos,
> +						 old_sinfo.de->lcase);
> +	if (err)
> +		goto error_inode;
> +
>  	inode_inc_iversion(new_dir);
>  
>  	fat_detach(old_inode);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

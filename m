Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A29EEC3;
	Wed, 30 Sep 2026 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755955; cv=none; b=M2bfg8Vzws8laRRMRPgbykz24QyGzD5lgtZXKmgyZ0UAzaDrwRO59vTZJiV5RdOmFMRcxTv9jvRWdMYoKA7XgQ04FjWvhkXhYs4mQ7CaUe3sxqbr/45WC5izFq0sKDrKI8XtSaJka07QvHUyQmNUYT/qbjBoHi+DvH/mmwNN3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755955; c=relaxed/simple;
	bh=Anwn6hszy2ELtXFl4DR/48BVDXFZ6ag5MQ2PJTLhFlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=auuRKv8rCmBtnxyKvjXC60j9S8YcP+6nXKvgUL1lgGlR/HlQ+ZkJTrs1NLa4qMuqzrJ0hSacC2xQojwAvxBmwo8euFfuTAKWSFRtjWkfXc5eNhgrrE57zE0mJBsfUL1xHp10TS2JGtjywjbTmk72YMF0nAfsminxKI5txEtAzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=omBeHPVb; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=AdJ+4GGc; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="omBeHPVb";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="AdJ+4GGc"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id BB04526F7667;
	Wed, 30 Sep 2026 17:02:35 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1790755356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaDezkVPIiwfGLy0lBpmC5GnKotdnVUlWnUUFMWHpNU=;
	b=omBeHPVblXMLN8ahapmj9ruxT+QvXBINtz6BFVk9lfag66IljcZ0U5VOCoarc/5/AdcVQG
	6+HtbpRnr3+rTeb0+YfCSbxe225WZ+MOfymD2S3K60Aw8PfAppPEi/yyibzV6iHA7bcjFE
	wHhuOV4MH4/J8s880br+r9cKF7eI9VHjIF2nCerGAzd5LndtjtbwCktNZn8T9b4SjT/Jkc
	9MkZ/UmzMEwAqwajLQ27Nwjo7O3/IYERGDyG8a5sVfBqStKk1rc/V8NOz9tooD1QDxQs8W
	Chnpb34CxnHxMC5cOEIwvIevKkTuJFN3AxZAaLpkS0aWBALQehB4Yvh0Oxwp5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1790755356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaDezkVPIiwfGLy0lBpmC5GnKotdnVUlWnUUFMWHpNU=;
	b=AdJ+4GGcSV7CJqJz5GUK1RB5jJmqD9K9q6D0uCmmD/YlOEiC73ph/s9QyApr2pD/nlUDQ4
	3Onc/1yh4NuUDiAQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 83A51E00636;
	Wed, 30 Sep 2026 17:02:30 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 7423322000F8; Wed, 30 Sep 2026 17:02:30 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH] fat: validate dotdot buffers in VFAT and MSDOS rename
 and rollback
In-Reply-To: <20260929090029.742579-1-krystianmkaniewski@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
Date: Wed, 30 Sep 2026 17:02:30 +0900
Message-ID: <87ld8j4161.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> During cross-directory rename operations with synchronous directory updates
> enabled in VFAT and MSDOS, updating the ".." directory entry writes the
> buffer via sync_dirty_buffer(). If this write fails due to an I/O error,
> the block layer clears the BH_Uptodate flag. When rename enters its error
> rollback path, it attempts to update the ".." directory entry again with
> the same buffer head, which calls mmb_mark_buffer_dirty() and triggers a
> "!buffer_uptodate(bh)" warning in mark_buffer_dirty().
>
> Fix this by introducing fat_update_dotdot_de() and
> fat_sync_update_dotdot_de() in fs/fat/dir.c, used by both VFAT and MSDOS
> cross-directory rename and rollback paths. The helpers lock the buffer head
> and check buffer_uptodate() before modifying the entry. If the buffer is
> not uptodate, unlock it and return -EIO, preventing mmb_mark_buffer_dirty()
> from being called on a non-uptodate buffer. fat_sync_update_dotdot_de()
> preserves the unconditional buffer sync in the MSDOS rename rollback path.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: Gemini:gemini-3.8-flash syzbot
> Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
> Link: https://syzkaller.appspot.com/ai_job?id=f915c371-eb83-48b9-af21-45cf1fd21ba0
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
>
> ---
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 35bdb6294..cee06e635 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -941,6 +941,40 @@ int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
>  }
>  EXPORT_SYMBOL_GPL(fat_get_dotdot_entry);
>  
> +static int __fat_update_dotdot_de(struct inode *dir, struct inode *inode,
> +				  struct buffer_head *dotdot_bh,
> +				  struct msdos_dir_entry *dotdot_de,
> +				  bool force_sync)
> +{
> +	lock_buffer(dotdot_bh);

This looks like unnecessarily wait the completion of buffer I/O, isn't
it? I guess, it is ok to give up to revert if surely I/O error, because
the reverted buffer will be the I/O error again.

Thanks.

> +	if (!buffer_uptodate(dotdot_bh)) {
> +		unlock_buffer(dotdot_bh);
> +		return -EIO;
> +	}
> +	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
> +	mmb_mark_buffer_dirty(dotdot_bh, &MSDOS_I(inode)->i_metadata_bhs);
> +	unlock_buffer(dotdot_bh);
> +	if (force_sync || IS_DIRSYNC(dir))
> +		return sync_dirty_buffer(dotdot_bh);
> +	return 0;
> +}
> +
> +int fat_update_dotdot_de(struct inode *dir, struct inode *inode,
> +			 struct buffer_head *dotdot_bh,
> +			 struct msdos_dir_entry *dotdot_de)
> +{
> +	return __fat_update_dotdot_de(dir, inode, dotdot_bh, dotdot_de, false);
> +}
> +EXPORT_SYMBOL_GPL(fat_update_dotdot_de);
> +
> +int fat_sync_update_dotdot_de(struct inode *dir, struct inode *inode,
> +			      struct buffer_head *dotdot_bh,
> +			      struct msdos_dir_entry *dotdot_de)
> +{
> +	return __fat_update_dotdot_de(dir, inode, dotdot_bh, dotdot_de, true);
> +}
> +EXPORT_SYMBOL_GPL(fat_sync_update_dotdot_de);
> +
>  /* See if directory is empty */
>  int fat_dir_empty(struct inode *dir)
>  {
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index 61338413d..d51d3c11e 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -339,6 +339,12 @@ extern int fat_scan_logstart(struct inode *dir, int i_logstart,
>  			     struct fat_slot_info *sinfo);
>  extern int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
>  				struct msdos_dir_entry **de);
> +extern int fat_update_dotdot_de(struct inode *dir, struct inode *inode,
> +				struct buffer_head *dotdot_bh,
> +				struct msdos_dir_entry *dotdot_de);
> +extern int fat_sync_update_dotdot_de(struct inode *dir, struct inode *inode,
> +				     struct buffer_head *dotdot_bh,
> +				     struct msdos_dir_entry *dotdot_de);
>  extern int fat_alloc_new_dir(struct inode *dir, struct timespec64 *ts);
>  extern int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
>  			   struct fat_slot_info *sinfo);
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index d46d1a385..31faaeae8 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -527,14 +527,10 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  	}
>  
>  	if (update_dotdot) {
> -		fat_set_start(dotdot_de, MSDOS_I(new_dir)->i_logstart);
> -		mmb_mark_buffer_dirty(dotdot_bh,
> -				      &MSDOS_I(old_inode)->i_metadata_bhs);
> -		if (IS_DIRSYNC(new_dir)) {
> -			err = sync_dirty_buffer(dotdot_bh);
> -			if (err)
> -				goto error_dotdot;
> -		}
> +		err = fat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
> +					   dotdot_de);
> +		if (err)
> +			goto error_dotdot;
>  		drop_nlink(old_dir);
>  		if (!new_inode)
>  			inc_nlink(new_dir);
> @@ -565,12 +561,9 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  	/* data cluster is shared, serious corruption */
>  	corrupt = 1;
>  
> -	if (update_dotdot) {
> -		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
> -		mmb_mark_buffer_dirty(dotdot_bh,
> -				      &MSDOS_I(old_inode)->i_metadata_bhs);
> -		corrupt |= sync_dirty_buffer(dotdot_bh);
> -	}
> +	if (update_dotdot)
> +		corrupt |= fat_sync_update_dotdot_de(old_dir, old_inode,
> +						     dotdot_bh, dotdot_de);
>  error_inode:
>  	fat_detach(old_inode);
>  	fat_attach(old_inode, old_sinfo.i_pos);
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index da3e89c0b..56da78455 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -909,16 +909,6 @@ static int vfat_sync_ipos(struct inode *dir, struct inode *inode)
>  	return 0;
>  }
>  
> -static int vfat_update_dotdot_de(struct inode *dir, struct inode *inode,
> -				 struct buffer_head *dotdot_bh,
> -				 struct msdos_dir_entry *dotdot_de)
> -{
> -	fat_set_start(dotdot_de, MSDOS_I(dir)->i_logstart);
> -	mmb_mark_buffer_dirty(dotdot_bh, &MSDOS_I(inode)->i_metadata_bhs);
> -	if (IS_DIRSYNC(dir))
> -		return sync_dirty_buffer(dotdot_bh);
> -	return 0;
> -}
>  
>  static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
>  {
> @@ -981,8 +971,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		goto error_inode;
>  
>  	if (dotdot_de) {
> -		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
> -					    dotdot_de);
> +		err = fat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
> +					   dotdot_de);
>  		if (err)
>  			goto error_dotdot;
>  		drop_nlink(old_dir);
> @@ -1014,8 +1004,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	corrupt = 1;
>  
>  	if (dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
> -						 dotdot_de);
> +		corrupt |= fat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
> +						dotdot_de);
>  	}
>  error_inode:
>  	fat_detach(old_inode);
> @@ -1103,14 +1093,14 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>  
>  	/* update ".." directory entry info */
>  	if (old_dotdot_de) {
> -		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
> -					    old_dotdot_de);
> +		err = fat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
> +					   old_dotdot_de);
>  		if (err)
>  			goto error_old_dotdot;
>  	}
>  	if (new_dotdot_de) {
> -		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
> -					    new_dotdot_de);
> +		err = fat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
> +					   new_dotdot_de);
>  		if (err)
>  			goto error_new_dotdot;
>  	}
> @@ -1137,14 +1127,14 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>  
>  error_new_dotdot:
>  	if (new_dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
> -						 new_dotdot_bh, new_dotdot_de);
> +		corrupt |= fat_update_dotdot_de(new_dir, new_inode,
> +						new_dotdot_bh, new_dotdot_de);
>  	}
>  
>  error_old_dotdot:
>  	if (old_dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
> -						 old_dotdot_bh, old_dotdot_de);
> +		corrupt |= fat_update_dotdot_de(old_dir, old_inode,
> +						old_dotdot_bh, old_dotdot_de);
>  	}
>  
>  error_exchange:
>
> base-commit: 93f51579e7df248780214094418f205253383cc5
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

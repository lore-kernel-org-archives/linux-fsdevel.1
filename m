Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16835519A2;
	Thu, 15 Oct 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090502; cv=none; b=fxNh1354qBsNJ0G04r5k6bqnSaxfS87kzUObmPEVqnG385NtFAoSW1pAPKXy6zGrLs85KvKGgevoOG6tZ1LSkfDxJA0HIOnrqkDj5aJG9rs25wCJ8JbiHN8CIav7NItA7aU2kQRtYakg/yU7VHRsjxAdjD9zpkdrPA+ZTgW9wYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090502; c=relaxed/simple;
	bh=JtG2hrxozi+9CYMqN8TVt99CiZc61hxPSPk2vQRqZ9c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFzNPHruYsTTvdf9pCg3M7O6uiw7yfk/naDwoZnEBDQe8qILGghyPX/E0w6xYPFUenKbLdLSTFVUmPIGSFUyWLLE5Dc4aHvmfWG+V+4uYsut5+9tIjW5TPashmXUYRwAsvGFJWERo9OL1lSgwRF8nZhrWtkCq2wjIoWPQVGMhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=ptqPhPWn; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=a6V0M+YN; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="ptqPhPWn";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="a6V0M+YN"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id C28A326F7667;
	Fri, 16 Oct 2026 03:54:47 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792090488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNzY+QnXWDcIIPDI69FbfYKJ6FOdPQ+E4LlErZDEwPo=;
	b=ptqPhPWng4I/ER/pwM0mzysd7JlQa/RPbZpXaXXFSBoohvygcl7FX/aj+OY/n3746w2LWL
	WPwET7NsrrCvjGe6w4xknwd5mpC9rHVM9l3/d0pKYBhlVj8icP2d/UqxotHGLnsLOO0SDL
	Md5ZDbfVFBFt8a8hN308U4sp18LbC3hRufluyFujdmNNZeSM3FH0WOh0DNrY8k7sxAer3U
	u3Phu6Dv8g40ZwV9ZAFezc/fEkkn4I7bemYWfgHHvTwCKJz7a5XVIm0gOX5OOYvPFWO9Yk
	8JUh1JFxH8RX3nWhoZezfxUSzrMV2t1b9d3dyM+EEnCwu7n6y+qaj6Vy80eNBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792090488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNzY+QnXWDcIIPDI69FbfYKJ6FOdPQ+E4LlErZDEwPo=;
	b=a6V0M+YNFSYRjhYlPYGNk24EJqWXDp6SLSfE8K3p6VouV/9PLmi5Kwf5eLld7WHnQO4Jc5
	vmtuwI/dV5AIGHCw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 47B1AE00144;
	Fri, 16 Oct 2026 03:54:47 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 3226722000D5; Fri, 16 Oct 2026 03:54:47 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] fat: make rename recovery safe after metadata write
 errors
In-Reply-To: <20261014082315.190262-1-krystianmkaniewski@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
	<87ld8j4161.fsf@mail.parknet.co.jp>
	<1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
	<87bj90m6dq.fsf@mail.parknet.co.jp>
	<20261014082315.190262-1-krystianmkaniewski@gmail.com>
Date: Fri, 16 Oct 2026 03:54:47 +0900
Message-ID: <87qzhqvloo.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> A failed synchronous FAT metadata write clears BH_Uptodate. Rename
> recovery can then modify and dirty the same retained buffer, which
> triggers the !buffer_uptodate warning in mark_buffer_dirty().
>
> Stop on-disk rollback after a failed dotdot update or old-entry removal,
> where a complete rollback can no longer be guaranteed. At an
> inode-position failure no dotdot update or source-entry removal has
> started, so rereading the affected entry block and restoring the changed
> entry slots can still complete the rollback.
>
> Read a retained new-entry buffer again before removing the entry.
> Replacement and exchange recovery use inode writeback, which reacquires
> the directory-entry buffer. When the second exchange position write
> fails, the first has already reached disk, so attempt both restorations
> even if retrying the failed block also fails.
>
> Report recovery errors returned by these steps as corruption and preserve
> the original forward error.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---
> Changes in v3:
> - Give up the on-disk rollback entirely after a failed dotdot update or
>   old-entry removal, as suggested by OGAWA Hirofumi, instead of tracking
>   buffer aliases and reverting what is still possible.
> - After a failed inode-position write, read the retained new-entry buffer
>   again with bh_read() before removing the entry, and write a replaced
>   target entry back through inode writeback.
> - New subject, since rollback is no longer skipped per buffer.
>
> v2: https://lore.kernel.org/all/1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com/
>
>  fs/fat/namei_msdos.c | 39 ++++++++++----------------
>  fs/fat/namei_vfat.c  | 66 +++++++++++++++++---------------------------
>  2 files changed, 39 insertions(+), 66 deletions(-)
>
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index d46d1a3..0aab2b1 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -441,7 +441,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  	struct fat_slot_info old_sinfo, sinfo;
>  	struct timespec64 ts;
>  	loff_t new_i_pos;
> -	int err, old_attrs, is_dir, update_dotdot, corrupt = 0;
> +	int err, old_attrs, is_dir, update_dotdot, rollback_err = 0;
>  
>  	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
>  	old_inode = d_inode(old_dentry);
> @@ -533,7 +533,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  		if (IS_DIRSYNC(new_dir)) {
>  			err = sync_dirty_buffer(dotdot_bh);
>  			if (err)
> -				goto error_dotdot;
> +				goto error_no_rollback;
>  		}
>  		drop_nlink(old_dir);
>  		if (!new_inode)
> @@ -543,7 +543,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
>  	old_sinfo.bh = NULL;
>  	if (err)
> -		goto error_dotdot;
> +		goto error_no_rollback;

What is wrong to try to revert dotdot_bh?

>  	inode_inc_iversion(old_dir);
>  	fat_truncate_time(old_dir, &ts, FAT_UPDATE_CMTIME);
>  	mark_inode_dirty(old_dir);
> @@ -561,37 +561,26 @@ out:
>  	brelse(old_sinfo.bh);
>  	return err;
>  
> -error_dotdot:
> -	/* data cluster is shared, serious corruption */
> -	corrupt = 1;
> -
> -	if (update_dotdot) {
> -		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
> -		mmb_mark_buffer_dirty(dotdot_bh,
> -				      &MSDOS_I(old_inode)->i_metadata_bhs);
> -		corrupt |= sync_dirty_buffer(dotdot_bh);
> -	}
> +error_no_rollback:
> +	/* Do not continue an on-disk rollback that cannot be completed. */
> +	rollback_err = err;
>  error_inode:
>  	fat_detach(old_inode);
>  	fat_attach(old_inode, old_sinfo.i_pos);
>  	MSDOS_I(old_inode)->i_attrs = old_attrs;
>  	if (new_inode) {
>  		fat_attach(new_inode, new_i_pos);
> -		if (corrupt) {
> +		if (!rollback_err) {
>  			mark_inode_dirty(new_inode);
> -			corrupt |= sync_inode_metadata(new_inode, 1);
> +			rollback_err = sync_inode_metadata(new_inode, 1);
>  		}
> -	} else {
> -		/*
> -		 * If new entry was not sharing the data cluster, it
> -		 * shouldn't be serious corruption.
> -		 */
> -		int err2 = fat_remove_entries(new_dir, &sinfo);
> -		if (corrupt)
> -			corrupt |= err2;
> -		sinfo.bh = NULL;
> +	} else if (!rollback_err) {
> +		/* Read the entry block again if a failed write invalidated it. */
> +		rollback_err = bh_read(sinfo.bh, 0);

Why do this read the bh from on disk?

> +		if (rollback_err >= 0)
> +			rollback_err = fat_remove_entries(new_dir, &sinfo);
>  	}
> -	if (corrupt < 0) {
> +	if (rollback_err < 0) {
>  		fat_fs_error(new_dir->i_sb,
>  			     "%s: Filesystem corrupted (i_pos %lld)",
>  			     __func__, sinfo.i_pos);

Same above questions for vfat with msdos.

Thanks.

> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index da3e89c..f10828c 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -938,7 +938,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	struct fat_slot_info old_sinfo, sinfo;
>  	struct timespec64 ts;
>  	loff_t new_i_pos;
> -	int err, is_dir, corrupt = 0;
> +	int err, is_dir, rollback_err = 0;
>  	struct super_block *sb = old_dir->i_sb;
>  
>  	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
> @@ -984,7 +984,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
>  					    dotdot_de);
>  		if (err)
> -			goto error_dotdot;
> +			goto error_no_rollback;
>  		drop_nlink(old_dir);
>  		if (!new_inode)
>   			inc_nlink(new_dir);
> @@ -993,7 +993,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
>  	old_sinfo.bh = NULL;
>  	if (err)
> -		goto error_dotdot;
> +		goto error_no_rollback;
>  	vfat_update_dir_metadata(old_dir, &ts);
>  
>  	if (new_inode) {
> @@ -1009,34 +1009,25 @@ out:
>  
>  	return err;
>  
> -error_dotdot:
> -	/* data cluster is shared, serious corruption */
> -	corrupt = 1;
> -
> -	if (dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
> -						 dotdot_de);
> -	}
> +error_no_rollback:
> +	/* Do not continue an on-disk rollback that cannot be completed. */
> +	rollback_err = err;
>  error_inode:
>  	fat_detach(old_inode);
>  	fat_attach(old_inode, old_sinfo.i_pos);
>  	if (new_inode) {
>  		fat_attach(new_inode, new_i_pos);
> -		if (corrupt) {
> +		if (!rollback_err) {
>  			mark_inode_dirty(new_inode);
> -			corrupt |= sync_inode_metadata(new_inode, 1);
> +			rollback_err = sync_inode_metadata(new_inode, 1);
>  		}
> -	} else {
> -		/*
> -		 * If new entry was not sharing the data cluster, it
> -		 * shouldn't be serious corruption.
> -		 */
> -		int err2 = fat_remove_entries(new_dir, &sinfo);
> -		if (corrupt)
> -			corrupt |= err2;
> -		sinfo.bh = NULL;
> +	} else if (!rollback_err) {
> +		/* Read the entry block again if a failed write invalidated it. */
> +		rollback_err = bh_read(sinfo.bh, 0);
> +		if (rollback_err >= 0)
> +			rollback_err = fat_remove_entries(new_dir, &sinfo);
>  	}
> -	if (corrupt < 0) {
> +	if (rollback_err < 0) {
>  		fat_fs_error(new_dir->i_sb,
>  			     "%s: Filesystem corrupted (i_pos %lld)",
>  			     __func__, new_i_pos);
> @@ -1067,7 +1058,7 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>  	struct inode *old_inode, *new_inode;
>  	struct timespec64 ts = current_time(old_dir);
>  	loff_t old_i_pos, new_i_pos;
> -	int err, corrupt = 0;
> +	int err, rollback_err = 0;
>  	struct super_block *sb = old_dir->i_sb;
>  
>  	old_inode = d_inode(old_dentry);
> @@ -1106,13 +1097,13 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>  		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
>  					    old_dotdot_de);
>  		if (err)
> -			goto error_old_dotdot;
> +			goto error_no_rollback;
>  	}
>  	if (new_dotdot_de) {
>  		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
>  					    new_dotdot_de);
>  		if (err)
> -			goto error_new_dotdot;
> +			goto error_no_rollback;
>  	}
>  
>  	/* if cross directory and only one is a directory, adjust nlink */
> @@ -1135,24 +1126,17 @@ out:
>  
>  	return err;
>  
> -error_new_dotdot:
> -	if (new_dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
> -						 new_dotdot_bh, new_dotdot_de);
> -	}
> -
> -error_old_dotdot:
> -	if (old_dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
> -						 old_dotdot_bh, old_dotdot_de);
> -	}
> -
> +error_no_rollback:
> +	/* Do not start a partial on-disk rollback after a failed ".." write. */
> +	rollback_err = err;
>  error_exchange:
>  	vfat_exchange_ipos(old_inode, new_inode, new_i_pos, old_i_pos);
> -	corrupt |= vfat_sync_ipos(new_dir, new_inode);
> -	corrupt |= vfat_sync_ipos(old_dir, old_inode);
> +	if (!rollback_err) {
> +		rollback_err |= vfat_sync_ipos(new_dir, new_inode);
> +		rollback_err |= vfat_sync_ipos(old_dir, old_inode);
> +	}
>  
> -	if (corrupt < 0) {
> +	if (rollback_err < 0) {
>  		fat_fs_error(new_dir->i_sb,
>  			     "%s: Filesystem corrupted (i_pos %lld, %lld)",
>  			     __func__, old_i_pos, new_i_pos);

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE183A3830;
	Sun, 11 Oct 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744165; cv=none; b=mlDL5lKpLLXE8h0PmdF/wGskd3xsKCoS87sPBqNPXzuBrBy40eGkg6jghiWO7JlQGIIScDQWU0ytvbg1zt/7AL8tl75W0MqAzYkokeXMQ7585XgAKxWZCLScHy/dN9N+qWEq0UHvFLuBjA1SuHIy+PAyGM+WAt2ISvplMjLGGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744165; c=relaxed/simple;
	bh=z+ezEJpkazeXVXbfnxJHjKTfTRi06YJYZXcweNrq3gw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F61kSkV8F2GrsLZYibHsP7yrCGyGSHsDgiNw8hlyFxubnGV9YtUjXIXonmtOXWo0Qfa8EdhhJLR4w10cR9tcz2PKYyiUgMsoGfeI4hIiIAPsxlwSDtyln89Vk1fxGQhSm+23Gwnu4SE3+88GG1eumZrumuk7CEw6Hse6Pqk7w2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=kBacK/+i; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=tTAo7z+v; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="kBacK/+i";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="tTAo7z+v"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 3BDBE209679B;
	Mon, 12 Oct 2026 03:36:34 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1791743794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lM2chcgZ8txGIN0k4S09o6d+5tX7+e4gPd+2E7+lAO4=;
	b=kBacK/+ijoTT4PdX0V/MoVXpJrizZ/K/kuw0mpw/rmB7c4uf9PT3QRYLFn1cCOYeolOIgL
	vWHIieFfgteE4uXeA0qzSpEi+uAmuj5SqIH+R6LNJzBGCi/JUlUeTx0xfByhBkNPu7kIk0
	zPehpW170JI5maVAvyPKUj20CcJ+2y92L7t45d29IUXt50E6iwKfYEQq/8PG/fjWrypqy+
	X4QMRne7P79vX+J8Zooq2/qpmJJlGsf4dQ8q20oRdL7KCZ4w8JV+EfcJYN7PwIraI75mQw
	LYWiRPklw79nF+q9AHWER0hqKdfU/9fJCMC2+B1p4fKFfgMPtXqMdlzAXNQyzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1791743794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lM2chcgZ8txGIN0k4S09o6d+5tX7+e4gPd+2E7+lAO4=;
	b=tTAo7z+v3A1V00Q3GNZDrXSEJoNZRVH3LhdJYb1w5VHtYwBjc8byWRA2VE5KL7CsZ/4TDQ
	TxDXonIzR9+JI3Aw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id B657DE00134;
	Mon, 12 Oct 2026 03:36:33 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A919E22000EE; Mon, 12 Oct 2026 03:36:33 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] fat: skip rename rollback on buffers with failed I/O
In-Reply-To: <1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
	<87ld8j4161.fsf@mail.parknet.co.jp>
	<1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
Date: Mon, 12 Oct 2026 03:36:33 +0900
Message-ID: <87bj90m6dq.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> A synchronous directory-entry write can fail after clearing BH_Uptodate.
> The rename error path then attempts rollback by modifying and dirtying the
> same buffer. mark_buffer_dirty() warns on the resulting !buffer_uptodate
> buffer, and retrying the write cannot repair the underlying I/O failure.
>
> Once a synchronous update fails, record whether the new entry shares that
> buffer and do not touch it again. Before fat_remove_entries() releases the
> old-entry buffer, record aliases so later failures also avoid rolling back
> through it. For RENAME_EXCHANGE, restore the first ".." update only when it
> does not share the buffer on which the second update failed.
>
> Keep the existing forced synchronous MS-DOS rollback when it targets a
> different buffer. For skipped rollbacks, retain the original error and
> report filesystem corruption through fat_fs_error().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---
> Changes in v2:
> - Avoid buffer locking and waiting in the normal update path, as suggested
>   by OGAWA Hirofumi.
> - Give up rollback after a synchronous failure on the affected buffer.
> - Track buffer aliases before fat_remove_entries() releases the old buffer.
> - Keep forced synchronization for an MS-DOS rollback on another buffer.

Is this trying to revert as many as possible even if partial? If so, it
would not help actually, and complex. Maybe we can give up whole if
partially revert?

Thanks.

>  fs/fat/namei_msdos.c | 28 ++++++++++++++++++++-----
>  fs/fat/namei_vfat.c  | 50 +++++++++++++++++++++++++++++---------------
>  2 files changed, 56 insertions(+), 22 deletions(-)
>
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index d46d1a3851f25..079f8bb61647f 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -441,6 +441,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  	struct fat_slot_info old_sinfo, sinfo;
>  	struct timespec64 ts;
>  	loff_t new_i_pos;
> +	bool dotdot_in_old_bh, new_in_old_bh;
> +	bool new_bh_failed = false;
>  	int err, old_attrs, is_dir, update_dotdot, corrupt = 0;
>  
>  	old_sinfo.bh = sinfo.bh = dotdot_bh = NULL;
> @@ -532,14 +534,20 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  				      &MSDOS_I(old_inode)->i_metadata_bhs);
>  		if (IS_DIRSYNC(new_dir)) {
>  			err = sync_dirty_buffer(dotdot_bh);
> -			if (err)
> -				goto error_dotdot;
> +			if (err) {
> +				corrupt = err;
> +				new_bh_failed = sinfo.bh == dotdot_bh;
> +				goto error_inode;
> +			}
>  		}
>  		drop_nlink(old_dir);
>  		if (!new_inode)
>  			inc_nlink(new_dir);
>  	}
>  
> +	/* Remember aliases before fat_remove_entries() releases the buffer. */
> +	dotdot_in_old_bh = dotdot_bh == old_sinfo.bh;
> +	new_in_old_bh = sinfo.bh == old_sinfo.bh;
>  	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
>  	old_sinfo.bh = NULL;
>  	if (err)
> @@ -564,12 +572,22 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  error_dotdot:
>  	/* data cluster is shared, serious corruption */
>  	corrupt = 1;
> +	if (dotdot_in_old_bh || new_in_old_bh) {
> +		/* Give up rollback on the buffer whose write failed. */
> +		corrupt = err;
> +		new_bh_failed = new_in_old_bh;
> +	}
> +
> +	if (update_dotdot && !dotdot_in_old_bh) {
> +		int dotdot_err;
>  
> -	if (update_dotdot) {
>  		fat_set_start(dotdot_de, MSDOS_I(old_dir)->i_logstart);
>  		mmb_mark_buffer_dirty(dotdot_bh,
>  				      &MSDOS_I(old_inode)->i_metadata_bhs);
> -		corrupt |= sync_dirty_buffer(dotdot_bh);
> +		dotdot_err = sync_dirty_buffer(dotdot_bh);
> +		corrupt |= dotdot_err;
> +		if (dotdot_err && sinfo.bh == dotdot_bh)
> +			new_bh_failed = true;
>  	}
>  error_inode:
>  	fat_detach(old_inode);
> @@ -581,7 +599,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
>  			mark_inode_dirty(new_inode);
>  			corrupt |= sync_inode_metadata(new_inode, 1);
>  		}
> -	} else {
> +	} else if (!new_bh_failed) {
>  		/*
>  		 * If new entry was not sharing the data cluster, it
>  		 * shouldn't be serious corruption.
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index da3e89c0b16ac..b6a32f39a6f88 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -938,6 +938,8 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	struct fat_slot_info old_sinfo, sinfo;
>  	struct timespec64 ts;
>  	loff_t new_i_pos;
> +	bool dotdot_in_old_bh, new_in_old_bh;
> +	bool new_bh_failed = false;
>  	int err, is_dir, corrupt = 0;
>  	struct super_block *sb = old_dir->i_sb;
>  
> @@ -983,13 +985,19 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	if (dotdot_de) {
>  		err = vfat_update_dotdot_de(new_dir, old_inode, dotdot_bh,
>  					    dotdot_de);
> -		if (err)
> -			goto error_dotdot;
> +		if (err) {
> +			corrupt = err;
> +			new_bh_failed = sinfo.bh == dotdot_bh;
> +			goto error_inode;
> +		}
>  		drop_nlink(old_dir);
>  		if (!new_inode)
>   			inc_nlink(new_dir);
>  	}
>  
> +	/* Remember aliases before fat_remove_entries() releases the buffer. */
> +	dotdot_in_old_bh = dotdot_bh == old_sinfo.bh;
> +	new_in_old_bh = sinfo.bh == old_sinfo.bh;
>  	err = fat_remove_entries(old_dir, &old_sinfo);	/* and releases bh */
>  	old_sinfo.bh = NULL;
>  	if (err)
> @@ -1012,10 +1020,19 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  error_dotdot:
>  	/* data cluster is shared, serious corruption */
>  	corrupt = 1;
> +	if (dotdot_in_old_bh || new_in_old_bh) {
> +		/* Give up rollback on the buffer whose write failed. */
> +		corrupt = err;
> +		new_bh_failed = new_in_old_bh;
> +	}
>  
> -	if (dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(old_dir, old_inode, dotdot_bh,
> -						 dotdot_de);
> +	if (dotdot_de && !dotdot_in_old_bh) {
> +		int dotdot_err = vfat_update_dotdot_de(old_dir, old_inode,
> +						       dotdot_bh, dotdot_de);
> +
> +		corrupt |= dotdot_err;
> +		if (dotdot_err && sinfo.bh == dotdot_bh)
> +			new_bh_failed = true;
>  	}
>  error_inode:
>  	fat_detach(old_inode);
> @@ -1026,7 +1043,7 @@ static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			mark_inode_dirty(new_inode);
>  			corrupt |= sync_inode_metadata(new_inode, 1);
>  		}
> -	} else {
> +	} else if (!new_bh_failed) {
>  		/*
>  		 * If new entry was not sharing the data cluster, it
>  		 * shouldn't be serious corruption.
> @@ -1105,14 +1122,18 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>  	if (old_dotdot_de) {
>  		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
>  					    old_dotdot_de);
> -		if (err)
> -			goto error_old_dotdot;
> +		if (err) {
> +			corrupt = err;
> +			goto error_exchange;
> +		}
>  	}
>  	if (new_dotdot_de) {
>  		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
>  					    new_dotdot_de);
> -		if (err)
> -			goto error_new_dotdot;
> +		if (err) {
> +			corrupt = err;
> +			goto error_old_dotdot;
> +		}
>  	}
>  
>  	/* if cross directory and only one is a directory, adjust nlink */
> @@ -1135,14 +1156,9 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>  
>  	return err;
>  
> -error_new_dotdot:
> -	if (new_dotdot_de) {
> -		corrupt |= vfat_update_dotdot_de(new_dir, new_inode,
> -						 new_dotdot_bh, new_dotdot_de);
> -	}
> -
>  error_old_dotdot:
> -	if (old_dotdot_de) {
> +	/* Both entries may share the buffer whose write failed. */
> +	if (old_dotdot_de && old_dotdot_bh != new_dotdot_bh) {
>  		corrupt |= vfat_update_dotdot_de(old_dir, old_inode,
>  						 old_dotdot_bh, old_dotdot_de);
>  	}
>
> base-commit: 93f51579e7df248780214094418f205253383cc5

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

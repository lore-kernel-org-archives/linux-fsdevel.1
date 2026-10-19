Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792426580;
	b=bXHMq7dbhu2yFO1L0hXm2Bkv3tMbOzNjJSAGjxGscJO6qJkuaJuiJRM+f9by70y6x5jo
	 PvT52E6R7gdUK2bl2BmsXweVK8+TfHY4tAJkEa8H913M4RG7TMq9zWvvaUtGDg+CZwZ2u
	 cHp95STwir/T4odoGvSllqfsPqMJ7BBxLMKqOSX+5qjuVyhIvZM1F8fl6A3WIVumzT3bJ
	 ELuyGIKjrln648tyz2jwYxWn2ZzO+q8HtbM6W2nyily2SWTSmB2ft3aOt1q1y208YGxQ4
	 JqwO5z8lr6NCom3pB7il3bc3XCssla/0Fk6SIJhLS/XCGTzrY2/p+Gige/KvAm+uDHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426580;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=U+tNFdMrtGJ7UXrgqf4t9vdI/NRpKFRzfQPtifY5ebM=;
	b=VFIEvYPWW4sgC9cQcXnbpnQP/klXI//3g3zyt8MIhMR57Uav1V6x/GSYAxetxF6ukhAj
	 rf4cU97dA3Y046Yw5YNBDpADnspid/HRCdM+UIqMkp0srJcT58L3ah5RJbA08Gt1uqdtC
	 e7Ks5BqBfltfE7bF90gU6qVqU8LeYx3vn3w/oW8/mPFgdYrvBicpoob6RGmlR4rd3bBZZ
	 LTrBge/eVkKPWz00LdAaa7VaycQYfvnyu7Pbi4SrdcqzuVKlX+XNtfxiA+s6FCETjdqPG
	 0iNAceK7ZjDf8e8A/xBvBjDJfcsVL3m9ReyV8E2FvSBghBMKYyT2JEknA6SZoyd1xfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=temperror header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b="E/fJLEI3";
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=NKaz5b5v;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E123606A31A;
	Mon, 19 Oct 2026 16:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E123606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=E/fJLEI3;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=NKaz5b5v
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 0FC9D26F7699;
	Tue, 20 Oct 2026 01:15:59 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1792426559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+tNFdMrtGJ7UXrgqf4t9vdI/NRpKFRzfQPtifY5ebM=;
	b=E/fJLEI3wmXSab9vfYOruXzi54ytXo1B2fbkLmBG1jXZZULyL3ywX0HzE7YV5L+Gm7YmKP
	6dBgr5uHnba0mxAKmx5JtIuBPeeWyEr0V6LjS/DuGTLPZfeQ/bSEfLrRskmGXL3lrwPW4J
	lIGgRfgKcLB9hk999fHnsj54IRyMfTItYtDjH86mO0uhcynLLzL8mMKkntkfAir7GiKdrf
	w61xgC+yXSt24e7GtwaqG5/t2q5WFRmpLYfrKISRuJK0DG+QwbyjgXvHncbMBkbRgDnFiQ
	XPFnAVzPU6IIp2RuLbHjAZa+6g/Vv1TgVeGeCYHBnZfHTYuqf+KXv9VRsuWGuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1792426559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+tNFdMrtGJ7UXrgqf4t9vdI/NRpKFRzfQPtifY5ebM=;
	b=NKaz5b5vMmG3mea50pG6hwDzjpzg0TvAIRX1qLhJ42XGnWUskJAxO3OMDnjEvpgBQG1jk3
	dUPZOCMSoLdv/CCw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 76DF4E0036A;
	Tue, 20 Oct 2026 01:15:58 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 6FD2F22000A9; Tue, 20 Oct 2026 01:15:58 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] fat: make rename recovery safe after metadata write
 errors
In-Reply-To: <20261019145146.539233-1-krystianmkaniewski@gmail.com>
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
	<20260929090029.742579-1-krystianmkaniewski@gmail.com>
	<87ld8j4161.fsf@mail.parknet.co.jp>
	<1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
	<87bj90m6dq.fsf@mail.parknet.co.jp>
	<20261014082315.190262-1-krystianmkaniewski@gmail.com>
	<87qzhqvloo.fsf@mail.parknet.co.jp>
	<55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
	<87cxt921rc.fsf@mail.parknet.co.jp>
	<f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com>
	<875wz11xfg.fsf@mail.parknet.co.jp>
	<c820357a-a7cf-4f4b-ab23-91530a12218b@gmail.com>
	<878q3uhv4h.fsf@mail.parknet.co.jp>
	<20261019145146.539233-1-krystianmkaniewski@gmail.com>
Date: Tue, 20 Oct 2026 01:15:58 +0900
Message-ID: <87wlrdy8ch.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:

> A failed synchronous FAT metadata write clears BH_Uptodate. Rename
> recovery can then modify and dirty the same retained buffer, which
> triggers the !buffer_uptodate warning in mark_buffer_dirty().
>
> Stop on-disk rollback after a failed dotdot update or old-entry removal,
> where a complete rollback can no longer be guaranteed.
>
> An inode-position write can also fail through another associated metadata
> buffer. In that case the retained new-entry buffer remains uptodate, so
> remove the added entry directly. Check the buffer state and dirty the
> entry while holding the buffer lock. If the entry buffer itself failed
> writeback, leave it untouched instead of reading it again and submitting
> another write from FAT.
>
> Keep the existing replacement and exchange inode-position recovery. When
> recovery starts after an exchange position write fails, attempt both
> restorations so a failure of one does not suppress the other.
>
> Report recovery errors as corruption and preserve the original forward
> error.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
> Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
> ---
> Changes in v4:
> - Trust a final block-layer write error. Do not reread or retry the retained
>   new-entry buffer from FAT when it is no longer uptodate.
> - Remove the added entry directly when its retained buffer remains uptodate.
>   Hold the buffer lock across the state check, entry mutation and dirty mark.
> - Keep failed dotdot writes and failed old-entry removal on the v3
>   no-rollback path.
>
> v3: https://lore.kernel.org/all/20261014082315.190262-1-krystianmkaniewski@gmail.com/
>
>  fs/fat/dir.c         | 27 +++++++++++++++++--
>  fs/fat/fat.h         |  2 ++
>  fs/fat/namei_msdos.c | 37 +++++++++----------------
>  fs/fat/namei_vfat.c  | 64 ++++++++++++++++----------------------------
>  4 files changed, 62 insertions(+), 68 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 35bdb62944a2e..70433361359cb 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -1066,7 +1066,9 @@ static int __fat_remove_entries(struct inode *dir, loff_t pos, int nr_slots)
>  	return err;
>  }
>  
> -int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
> +static int fat_remove_entries_internal(struct inode *dir,
> +				       struct fat_slot_info *sinfo,
> +				       bool require_uptodate)
>  {
>  	struct super_block *sb = dir->i_sb;
>  	struct msdos_dir_entry *de;
> @@ -1079,8 +1081,15 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
>  	 */
>  	nr_slots = sinfo->nr_slots;
>  	de = sinfo->de;
> -	sinfo->de = NULL;
>  	bh = sinfo->bh;
> +	if (require_uptodate) {
> +		lock_buffer(bh);
> +		if (!buffer_uptodate(bh)) {
> +			unlock_buffer(bh);
> +			return -EIO;
> +		}
> +	}
> +	sinfo->de = NULL;

Looks like strange to check buffer_uptodate() (or
buffer_write_io_error()?) at here. Why lock_buffer is required (rename
locks are not enough? which race?), and why not checked at rename error
path?

>  	sinfo->bh = NULL;
>  	while (nr_slots && de >= (struct msdos_dir_entry *)bh->b_data) {
>  		de->name[0] = DELETED_FLAG;
> @@ -1088,6 +1097,8 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
>  		nr_slots--;
>  	}
>  	mmb_mark_buffer_dirty(bh, &MSDOS_I(dir)->i_metadata_bhs);
> +	if (require_uptodate)
> +		unlock_buffer(bh);
>  	if (IS_DIRSYNC(dir))
>  		err = sync_dirty_buffer(bh);
>  	brelse(bh);

[...]

> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index d46d1a3851f25..6c833ed1affb3 100644
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

Hm, I may be confused more or less though, do we have to give up whole
if dotdot_bh and here are failure? Maybe we give up only if old_sinfo.bh
was the cause of I/O error actually? Checking and tracking the error
state is too complex or something?

>  	inode_inc_iversion(old_dir);
>  	fat_truncate_time(old_dir, &ts, FAT_UPDATE_CMTIME);
>  	mark_inode_dirty(old_dir);
> @@ -561,37 +561,24 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
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
> +		/* Do not retry a write error reported for this buffer. */
> +		rollback_err = fat_remove_entries_if_uptodate(new_dir, &sinfo);
>  	}
> -	if (corrupt < 0) {
> +	if (rollback_err < 0) {
>  		fat_fs_error(new_dir->i_sb,
>  			     "%s: Filesystem corrupted (i_pos %lld)",
>  			     __func__, sinfo.i_pos);

[...]

> @@ -1067,7 +1056,7 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
>  	struct inode *old_inode, *new_inode;
>  	struct timespec64 ts = current_time(old_dir);
>  	loff_t old_i_pos, new_i_pos;
> -	int err, corrupt = 0;
> +	int err, rollback_err = 0;
>  	struct super_block *sb = old_dir->i_sb;
>  
>  	old_inode = d_inode(old_dentry);
> @@ -1106,13 +1095,13 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
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
> @@ -1135,24 +1124,17 @@ static int vfat_rename_exchange(struct inode *old_dir, struct dentry *old_dentry
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

Here gives up whole if a buffer had error too?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

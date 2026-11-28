Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852266;
	b=JoSPQtrKin/jm7/ppqxjkl0/Si29FArF/CPpldN/L22JLwgnhYO09YhRv02ezVIrwS0g
	 OeUegsO/WmH32Sg8x3m9P7BbYso0A6NpeiGj5ffSz+PxBmvuSld3sp0WYrRNlLGTjcEh3
	 G1xvkM7N1zeeLRN6lnfD4t8gPcKR3i/8jqkxuN37zjUY2YW8Ev031pYSMNvFKMB7f4Q38
	 x9H2B1jnm/zMb+ObMLb9Kjed4gyEEuoUY0Hupx/UgVYR8tyW6jlesFmTK+1o7wUAfPjvY
	 bPphAhURrQE6dEVnWzTEkLginj/XMP9ka94tR1HkiQu1mma7I2n8TwOEaOhfuhzjA8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852266;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=98031xNii7Sl8gn1ue6ZuB2M2pAzYOkrCW/79fWX61c=;
	b=VaCtVvVQvXxuzV6gC/eituUQJw+l80yqB3ENmiFGH0qCjGQBo7treJIKswOkS8mLA+fo
	 peNGrSUjYNpOrWevPd6I8zfIoI1v+ewr4P8zV3ToNCdRSMQxg9oO3mXlimHiD+J3M9c1j
	 Z3eP9hjkne2W174Gy2p89562xT6U1UqpUtEOBLuTpJ1240TBNn7GCvIW9atgoBu13tDlX
	 YTUmZB0omGEmWk9mGkZsL1DVLPHDnxw3SpObiBjl13ueWe/wQkpyoWeAZ6nbO0KywQoqx
	 xJLnPT0iYzo00jzGxlfl65pHsALpLlh6zg2FFaFK3Lfon6Mn5jTxWZVJkma7X34BjsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=WjqSyvQ3;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=AR7jz+8F;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F2606A31C;
	Sat, 28 Nov 2026 07:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B4F2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=WjqSyvQ3;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=AR7jz+8F
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B280B20BD2A0;
	Sat, 28 Nov 2026 16:50:56 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1795852256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98031xNii7Sl8gn1ue6ZuB2M2pAzYOkrCW/79fWX61c=;
	b=WjqSyvQ3uqs/M0wppCJ9gWFDBAZDxACvOXZ84U1WTBMMQStM0tzj9pNZQV4QY3MWXp8qyf
	QiYiSimjYrwfIeF+oj1cj1NxbVP9xzL6ksVOUBeLeW+jBXjdLIUVP0Up3UEHvWkdtrDwR4
	RctbaO5bTFxKhnypPCOTyVGrMwTxwnMc7pBQWhvN6Mf44SxNGG3xdm5Q+0+fovQUbOwcRK
	S78LJydQykYgmqzvGvGIv0+dDphVVn2p+EwAb0BZRiEyL3Vax6SjUV/M0cE12pdNfWkEPP
	VFmFpS1BaghmTAcgDiCsCYxFBWEqOvkin+ULuK9xgDWGAt5gdp0D9nVZY+zAHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1795852256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98031xNii7Sl8gn1ue6ZuB2M2pAzYOkrCW/79fWX61c=;
	b=AR7jz+8FVqlYNYzH4xiy+sUvLhw1i1U9z6egzVFtP2w8e9tL05OvifTOXZV+BW2KwoTx8w
	N4QOdMnhckRbm1BQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 3EAB4E002C5;
	Sat, 28 Nov 2026 16:50:56 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 327992200208; Sat, 28 Nov 2026 16:50:56 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fat: support O_TMPFILE on vfat
In-Reply-To: <20261126-work-fat-tmpfile-v1-2-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
	<20261126-work-fat-tmpfile-v1-2-3bca7b2dbc20@kernel.org>
Date: Sat, 28 Nov 2026 16:50:56 +0900
Message-ID: <87a4mtqtr3.fsf@mail.parknet.co.jp>
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

Christian Brauner <brauner@kernel.org> writes:

> Currently, vfat doesn't implement ->link() since FAT has no hard links
> and link(2) fails with EPERM. But O_TMPFILE is only half a feature
> without linkat(). Worse, implementing just ->tmpfile() would break
> userspace that works fine right now. systemd's
> open_tmpfile_linkable_at() only falls back to a named temporary file if
> opening with O_TMPFILE fails. If the open succeeds link_tmpfile_at()
> calls linkat() and gives up if that fails. bootctl writes loader.conf,
> entries.srel and the boot loader binaries to the ESP like that.
>
> So add a ->link() that only gives an O_TMPFILE its first name.
> vfs_link() refuses to link an inode without links unless it is
> I_LINKABLE and it checks that under the inode lock. So an inode without
> links that makes it into vfat_link() is an O_TMPFILE that may be
> linked. Everything else still gets EPERM.
>
> Linking does what vfat_rename() does for a new name: add the directory
> entry, attach the inode at its position and let the inode write fill in
> the start cluster and the size.
>
> If the system crashes while an O_TMPFILE is open its clusters stay
> allocated but no directory entry refers to them. The same thing happens
> to an open file that was unlinked. fsck.fat finds them as lost
> clusters, with -a it saves them to FSCKnnnn.REC files. ext2, minix and
> udf implement O_TMPFILE without orphan handling as well.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fat/namei_vfat.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
> index 791f2d7b85092..31b4a293c0493 100644
> --- a/fs/fat/namei_vfat.c
> +++ b/fs/fat/namei_vfat.c
> @@ -938,6 +938,50 @@ static void vfat_update_dir_metadata(struct inode *dir, struct timespec64 *ts)
>  		(void)sync_inode_metadata(dir, 1);
>  }
>  
> +static int vfat_link(struct dentry *old_dentry, struct inode *dir,
> +		     struct dentry *dentry)
> +{
> +	struct inode *inode = d_inode(old_dentry);
> +	struct super_block *sb = dir->i_sb;
> +	struct fat_slot_info sinfo;
> +	struct timespec64 ts;
> +	int err, err2;
> +
> +	/* No hard links on FAT, only give an O_TMPFILE its first name. */
> +	if (inode->i_nlink)
> +		return -EPERM;
> +
> +	mutex_lock(&MSDOS_SB(sb)->s_lock);
> +
> +	ts = current_time(dir);
> +	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
> +	if (err)
> +		goto out;
> +	inode_inc_iversion(dir);
> +
> +	fat_attach(inode, sinfo.i_pos);
> +	err = vfat_sync_ipos(dir, inode);

Please add "FIXME: this sync should be done within vfat_add_entry()"

Thanks.

> +	if (err)
> +		goto out_detach;
> +	brelse(sinfo.bh);

[...]
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852385;
	b=UMmUkDv8iPCPANbCN5Bf4nOER6Jdb/SgMG9ZdaRIYgdg3LMK7drK+7BMcvZd4sREl9q+
	 QxrQyRJNgnnzLouMP77XbdeLsfroa9jnoJtVvLJQchjoyMN92NX6rHomCyh5R0nmE01pp
	 lTpOOjF9NUdMdZJY60Fnp8DozkFQYMqbC7TKM5vLfdVsbw6cIJuUm69LLTOyXnKLI5qrB
	 ADaEPAuSlN7uW4bl4JUZqwMC7bTKkfO9Ga9E29d2ghBpe6WDL6ddf1X1/wJvFhHwp2g+T
	 gxhNZjBASffoMYvEldSZi7L6lBRJJN1bifstepeLqmv/5AivsUmTcMuXcmx5WdN2iwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852385;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=wXVEGbdJRwHK0RZHrEYmDaMXKttxQnaY0pTFcjJ+chc=;
	b=LG0R/6Zgl18T0yB2FnOkCq2vqMEj4q1YQ9j5mRBWwQLjuUbTSrr76ewpKbWE4kp77Dq8
	 0fo6ErO8rpdjLZ/RWm70QB8peM26u1LuUTe4gHHuNTgILUeaGPZIzYCcPvbhzuZFiscnX
	 sSCLARc53Y3mgbg/W0hTGdICvSL9BxXnB3Dpo3sgWIaVMHHdDYfMoDrYRMTepkkBv3TSU
	 u4cGVzr+x0xq5kklV4nX4du0QY0dfMUkBkpv6XygobpX0TtkM0Kcd52gKhGl5IVPYbpJT
	 GQuZs1vcCG8XDwYGRW/hKgRGY3NiwqsKW1XkCiTRdCZo8UumIwg88CaNPkHFjUYr3Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=6iKyfIYj;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=mAT+81VA;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D70606A31C;
	Sat, 28 Nov 2026 07:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03D70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=6iKyfIYj;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=mAT+81VA
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 70CF820BD2A0;
	Sat, 28 Nov 2026 16:53:03 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1795852383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXVEGbdJRwHK0RZHrEYmDaMXKttxQnaY0pTFcjJ+chc=;
	b=6iKyfIYjQ+KVZMr1Bm3C8ygiGDkFarFToT2SxeOQ+G5o+cGVNRRaO0bitFAHa2uoUJnN0o
	S+0i97NMEnv838rIk/YTTpYCDnl+/XE8bTZFtVvipYWTKB8auhtIHYYf6wZplHlUlOv8vg
	ZECOYTUf3Ol8Yh4i+agzAcx1+3Rr4CWXtw4xaWkoipCoQx0+pWnLSsKOQ9swicyj5KK0EI
	Z66icQ58Qnk+MS0umX7PMnvxPvbmq8XoJy0+KscQecH/DAAHNEdHv2bSbwYzZTVbsqngyf
	Cpd4DjGRO794S6jywY2U12IjcjM5ivXyeVmDgXlI829qVgxkH/eUrmMtl3vLbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1795852383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXVEGbdJRwHK0RZHrEYmDaMXKttxQnaY0pTFcjJ+chc=;
	b=mAT+81VAjHDdwVg9gASfBs5FXPRsTC8FkTFjveUX07D99QgQBqMnuk/fSCCsYaXZsW6dtu
	LPFjJh76KpsVVHAQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id E6ED2E002C5;
	Sat, 28 Nov 2026 16:53:02 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id D3CFE2200208; Sat, 28 Nov 2026 16:53:02 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fat: support O_TMPFILE on msdos
In-Reply-To: <20261126-work-fat-tmpfile-v1-3-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
	<20261126-work-fat-tmpfile-v1-3-3bca7b2dbc20@kernel.org>
Date: Sat, 28 Nov 2026 16:53:02 +0900
Message-ID: <8733slqtnl.fsf@mail.parknet.co.jp>
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

> Do what vfat does. msdos_link() creates the directory entry the same
> way msdos_create() does and handles ATTR_HIDDEN like do_msdos_rename().
> With the dots mount option a leading dot means the file is hidden and
> __fat_write_inode() writes the attributes from i_attrs. So i_attrs has
> to agree with the new name.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fat/namei_msdos.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
> index 5a43d042eb01f..5709650a29986 100644
> --- a/fs/fat/namei_msdos.c
> +++ b/fs/fat/namei_msdos.c
> @@ -439,6 +439,74 @@ static int msdos_unlink(struct inode *dir, struct dentry *dentry)
>  	return err;
>  }
>  
> +/***** Give an O_TMPFILE its first name */
> +static int msdos_link(struct dentry *old_dentry, struct inode *dir,
> +		      struct dentry *dentry)
> +{

[...]

> +	err = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
> +				msdos_name, &MSDOS_SB(sb)->options);
> +	if (err)
> +		goto out;
> +	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
> +	/* Have to do it due to foo vs. .foo conflicts */
> +	if (!fat_scan(dir, msdos_name, &sinfo)) {
> +		brelse(sinfo.bh);
> +		err = -EINVAL;
> +		goto out;
> +	}

Maybe this part is better to share with others?

> +	ts = current_time(dir);
> +	err = msdos_add_entry(dir, msdos_name, 0, is_hid, 0, &ts, &sinfo);
> +	if (err)
> +		goto out;
> +	inode_inc_iversion(dir);
> +
> +	old_attrs = MSDOS_I(inode)->i_attrs;
> +	fat_attach(inode, sinfo.i_pos);
> +	if (is_hid)
> +		MSDOS_I(inode)->i_attrs |= ATTR_HIDDEN;
> +	else
> +		MSDOS_I(inode)->i_attrs &= ~ATTR_HIDDEN;
> +	mark_inode_dirty(inode);
> +	if (IS_DIRSYNC(dir)) {
> +		err = sync_inode_metadata(inode, 1);

Please add "FIXME: this sync should be done within msdos_add_entry()"

Thanks.

> +		if (err)
> +			goto out_detach;
> +	}
> +	brelse(sinfo.bh);

[...]
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

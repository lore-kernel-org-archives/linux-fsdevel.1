Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852781;
	b=ShPscVTbErgggoU4C79HFJKIIix6/EVBsAGG8qd2s6vIEwY9b/j6MZi5DnTfuYL0w1qA
	 hvmksHdnB2hfyeLccBpN5Bgv5WnHNDevcCjGoyhkp+/HP8UbWiN1gZ7P2GLtX93t/lw3n
	 JkziCyq0/PZ7NBfq6eRhSHiiNNGjXRSRJSY4SM1q09tELBqyqmJVmhArx9nX3bI5sg2+O
	 W5omFA6zCFjx4zMLaovbryxOuLIOv1hiHLs+FSYcep3lMgJNv4BgAPUBupJZHBei3LHLZ
	 KXhZtLbWavlHOB9G6jIFtvgdzxEd69ZZfgbAvr/PB4XUiIKAIfACocuqnSip+IJ0Cow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852781;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+HZuVZZRdtJL/BcumFSc+IgHWRdR98eB19PT2Twps/U=;
	b=R8SwivNyw4P8eKcBwW5My1lq5mxLR0IwSu76TRx30xyKbeU9RLLP8WlYIm4/0gEiR0OP
	 wc6HQ64YhxzjR/XjVHYPsT2c++LGTekXGcElNIbn943YQqIWF8+Rm/bA7pdgihLSftt2s
	 DyW9WQSxmCPy+xiOsXu8MFJCRE1mo+7hp7WeKlfEHCNTTLj0CNn0tSTYriVUox6PHxQW9
	 CmkhCMK0cPIs4dR8dh9Qby+vG0yUIRNOXuYTfVsx6kXprxnMM9lyIt1AQchiSJdgcdeG4
	 Of42PxS1LenwCNHKyX3j9sfHdmwKHYFpZeQ1ODv4BtYBzNtvZNd40cSSZQWVOoQy5pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=lmx2aQIZ;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=jwo7qFCJ;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0D606A31C;
	Sat, 28 Nov 2026 07:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFB0D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=lmx2aQIZ;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=jwo7qFCJ
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id DA25B20BD2A2;
	Sat, 28 Nov 2026 16:49:38 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1795852179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HZuVZZRdtJL/BcumFSc+IgHWRdR98eB19PT2Twps/U=;
	b=lmx2aQIZKZxLTtmnYx0zgIIkYtGqlAEEW5u0SIZq4Yxv7l6lQC63W5EhWY7paHRxRuTjTi
	TB9eFDK5ycsvnwImjLTPVWoInmtDw27/dx6p6XaaWDI3UDqqHLAIcrgGTpggI5BlEWO2v6
	ItoIqC9vIs8KGuYk4MyamyxaiiskgwYLbfztvn4FbWLfqlL9UU/2Y6fXDa0vrQsJg6wJXN
	Nd7X7R0K8sj4wOAgIvlDfwP7GpbYQIX9w/fL1AEcMrMuUYudgtBH9XpeTKi9YyHpuD0mMG
	yN4cSQDRr2B4iZ5dOUYYWMieioCvpnpuQ+u7jkenlyW4Kb4u7sFEfZ/GAAJmgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1795852179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+HZuVZZRdtJL/BcumFSc+IgHWRdR98eB19PT2Twps/U=;
	b=jwo7qFCJ5W8G9eLSiOfvJZftVd3bncJhpZ3t8mevl9WRoHz3O0pQe5AV43plVbdB6JapQc
	6TIIYnCyFxLw27CQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 6025DE0000E;
	Sat, 28 Nov 2026 16:49:38 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 56CA52200208; Sat, 28 Nov 2026 16:49:38 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fat: add fat_tmpfile()
In-Reply-To: <20261126-work-fat-tmpfile-v1-1-3bca7b2dbc20@kernel.org>
References: <20261126-work-fat-tmpfile-v1-0-3bca7b2dbc20@kernel.org>
	<20261126-work-fat-tmpfile-v1-1-3bca7b2dbc20@kernel.org>
Date: Sat, 28 Nov 2026 16:49:38 +0900
Message-ID: <87ecc5qtt9.fsf@mail.parknet.co.jp>
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

> FAT already knows how to deal with a file that is open but has no
> directory entry. When an open file is unlinked fat_detach() resets
> i_pos to 0. From then on __fat_write_inode() has nothing to write, the
> data still goes to the file's cluster chain, and fat_evict_inode()
> frees the chain when the last reference is put.
>
> An O_TMPFILE is a file that starts out in that state. So build the
> inode like fat_build_inode() does, from a directory entry that only
> exists in memory, but don't attach it. fat_build_inode() itself can't
> be used for this. It would attach the inode at i_pos 0 and the next
> O_TMPFILE would find it through fat_iget().
>
> The mode is ignored, just like in vfat_create() and msdos_create(). On
> FAT it's derived from the mount options.
>
> Nothing uses fat_tmpfile() yet. vfat and msdos need a ->link() method
> first and wire it up in the following patches.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fat/fat.h   |  2 ++
>  fs/fat/inode.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> index a8a3ca4f465bf..cc706d89d1b96 100644
> --- a/fs/fat/fat.h
> +++ b/fs/fat/fat.h
> @@ -423,6 +423,8 @@ extern void fat_detach(struct inode *inode);
>  extern struct inode *fat_iget(struct super_block *sb, loff_t i_pos);
>  extern struct inode *fat_build_inode(struct super_block *sb,
>  			struct msdos_dir_entry *de, loff_t i_pos);
> +int fat_tmpfile(const struct mnt_idmap *idmap, struct inode *dir,
> +		struct file *file, umode_t mode);
>  extern int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>  			  void (*setup)(struct super_block *));
>  extern int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index 642e690632d83..1481ef1a3efac 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -626,6 +626,37 @@ struct inode *fat_build_inode(struct super_block *sb,
>  
>  EXPORT_SYMBOL_GPL(fat_build_inode);
>  
> +/* Like an open file that got unlinked: no directory entry, i_pos is 0. */
> +int fat_tmpfile(const struct mnt_idmap *idmap, struct inode *dir,
> +		struct file *file, umode_t mode)
> +{

[...]

> +	inode = new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;
> +	inode->i_ino = iunique(sb, MSDOS_ROOT_INO);
> +	inode_set_iversion(inode, 1);
> +	err = fat_fill_inode(inode, &de);
> +	if (err) {
> +		iput(inode);
> +		return err;
> +	}
> +	insert_inode_hash(inode);

This part is almost copy of fat_build_inode(). Maybe it is better to add
as a new helper function to share with fat_build_inode().

Thanks.

> +	d_tmpfile(file, inode);
> +	return finish_open_simple(file, 0);
> +}
> +EXPORT_SYMBOL_GPL(fat_tmpfile);
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

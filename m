Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878204;
	b=Uq7jRQFtBNKV7fqNA1v2at66rOFh0gCBG9LbrXVvBX/JPZt793yEzs2Ec+rv34IYGWD2
	 lWXukotEr5ZtKqWQgbQ6qcFn+wIDZQdkhXwGoVY/FL3JPJdimwqjoxFkn77PFQxd2Xn43
	 pzfBhCrPlU3IJArNcwWZipSBUiG6+A2pnzpOHUxiulAHcbL6jHDqjxgf/0QLtQ/T8/1OM
	 mqvA3e06w4usFVpj01jsc14a18K/xAkIzJuTL03uI60Y5Su8FNi+hY5bCQ9OcHC3I1h4L
	 GyApZPiA1C0PZyIbKL3tGynCyV1+8//lpWme9A6VMHGr1D5B6MT5czieP4rfdqPL/Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878204;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=pqDhL0mZmrAAU8TfpH2WqTbopxyUAU5fjm2RrXWWcfw=;
	b=V980pbIaDPQebrqiw73cj4NdRSXyV6ZYKACguS6HVq/AhFHhioWo5BThgeBpmW0k+1Q4
	 li8UFzh7Q6tobBQKQ+Zh+8xXFNaL249ONV1zJ07UCy6lXJeBbvUNGO0nWf0pyj1VBMtk0
	 bZuD/sAitAK0yix3Xk6l0DVG/QDFLcUSEAa/x51ZHhxxhdqFJbWdLUItAHN/aIP48EgKJ
	 KvtqjNpEq4sPhR+esYx5XSh8zsvghOnn5t1w2PHkRJsTvKl3d2k30Ks1gh1MfAcwHLA7a
	 LPeqayQt7ZQiDGxFgIhSF9Sm+uRufrny4f36WsXtB3Q3OSEz9VaxflWFUZ+gzS+qzCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=KiHJsMik;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB68606A31B;
	Thu,  5 Nov 2026 11:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AB68606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=KiHJsMik
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pqDhL0mZmrAAU8TfpH2WqTbopxyUAU5fjm2RrXWWcfw=; b=KiHJsMikL8ksNuHjOiFWbIg2h+
	JmiJY82emVXq9Uc4uj4ijepXejPEGouZA5cdmTPU4sCrCHZL0WvjJzLkk3VCguhVZwCov94mMu+9N
	HYRgRrJx+0s9U6mz5v9IS12dZnXMV1QJArd2NvJ8OBTwp3oo8V1sMW1etTBJxcDVcYdjYw2cJ+uBb
	ay89Bx8ITfMZC5Pl9pGsJ+Be7sonISILCroYOk9Y8Pks+EM4uEkf4aHHEhwzphfftNlpR5/bItDa2
	ChzZgAK4elo5aWf9uXLPNJP2QejoaEsQ5Rvs8J0r8P9tYH0qSl7bLcD0pzx5UePvb/FbhKoq3ZDTZ
	oNLOQN3w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOvf3-008Sys-04;
	Thu, 05 Nov 2026 11:29:41 +0000
Date: Thu, 5 Nov 2026 03:29:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com, Ran Hongyun <ranhongyun1@huawei.com>
Subject: Re: [PATCH v2] configfs: fix slab-UAF Write in config_item_put
Message-ID: <auxn5snXPQJLR2z1@gmail.com>
References: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com>
X-Debian-User: leitao

On Fri, Oct 23, 2026 at 05:29:06PM +0100, Drif Abdelmalek Mohamed Said wrote:
> syzbot reported:

Please drop this full log, given we have a link to the syzbot report.

> This is a race between a thread creating a symlink and another one
> doing rmdir on a parent (or ancestor) directory of symlink creation dir.
> 
> configfs_symlink() takes a reference on parent_item, the directory the
> link is created in, and then drops the directory inode lock around
> get_target(). While the lock is dropped, a concurrent rmdir can remove
> the group that parent_item belongs to.
> 
> If parent_item is a default group embedded in a larger object, such as
> nvmet_port.subsys_group, the reference on the embedded item does not
> keep the containing object alive. rmdir frees the object, and the final
> config_item_put(parent_item) in configfs_symlink() then decrements a
> kref inside freed memory.
> 
> Fix this by not holding parent_item across the unlocked window. Drop
> the reference before inode_unlock() and look it up again from
> dentry->d_parent after inode_lock(). configfs_get_config_item() returns
> NULL if the parent dentry was unhashed in the meantime, in which case
> release the target references and return -ENOENT.
> 
> Re-looking up parent_item is not sufficient on its own.
> configfs_get_config_item() only fails if the parent dentry has been
> unhashed, and the rmdir path in another thread may skip that: if
> simple_rmdir() failed, the earlier d_drop() was skipped, so the dentry
> can stay hashed even though the directory has already been detached.
> 
> Such a directory was created as a default group (CONFIGFS_USET_DIR), so
> configfs_rmdir() takes the CONFIGFS_USET_DIR branch and calls
> configfs_detach_group(). detach_groups() then marks each child inode
> S_DEAD (d_inode(child)->i_flags |= S_DEAD). Check IS_DEADDIR(dir)
> after retaking the inode lock and before taking a reference on the
> parent, and return -ENOENT. This also rejects a detached directory
> whose dentry is still hashed.

This is LLM-heavy and hard to follow, would you be able to make it a bit
more human?

> ---
> v2: Added check for dead dir, this would be helpful when configfs_remove_dir skips
> unhashing the dentry.
> v1: https://lore.kernel.org/all/20261017123748.4430-1-drifabdelmalekmohamedsaid@gmail.com/T/
>  fs/configfs/symlink.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index 89178f5d371a..7d746a10c369 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -196,11 +196,26 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
>  	 *
>  	 *  AV, a thoroughly annoyed bastard.
>  	 */
> +
> +	/* Put the reference back, retake and check after relocking*/

Nit space before */

> +	config_item_put(parent_item);
> +	parent_item = NULL;

Why do you need to set it to NULL here?

>  	inode_unlock(dir);
>  	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
>  	inode_lock(dir);
>  	if (ret)
> -		goto out_put;
> +		goto out_put; /* config_item_put on NULL, no problem */

This comment is not necessary.

Thanks for the patch,
--breno

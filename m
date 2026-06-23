Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A254652;
	Tue, 23 Jun 2026 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219072; cv=none; b=PqGKVuKeBt+1Sou42g/73i0P2w//zplCZtBrYd2l3MCEbBsBXg0ROsFtjXYKcDjo1oZF5Fq+WtKW0xcoskb5uKnlGR5KQqSXyR2E3a+g3wmeNjX+6PznKmsH1KkW8ljChA3nwqlImzuwG9/hlHS3W/FaZ/hzPBztfTczIETmObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219072; c=relaxed/simple;
	bh=n0onqu2lNVvigXhvhU6yD7ENF58nxs5ldu7UTpQUBGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM4OCkHoNV89wIBkAPSjLYebyGj0lvHDDYbjuxDzMQuKsUtTnoMJQ1JQQNAGt8iNcV+29czBxIeGornIoCA0wXYK5yZtF2Wh7uP70/oPWkUlYG5kGxZMV5p7r6Nk2Gxn7QDwDGNqZN/icUy48iMtJGZcYU9TOCifA8u+wUF6iY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=LiQFJplK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="LiQFJplK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mh9BxkZKhF75YYaZJCyW42tNBJ5dFvL68uL9K+9zjR8=; b=LiQFJplKKHlTJAvsfdhJX3hvsj
	tkg2tYRKP2kQq4n3/eG8v0tGk7rT48aWRyFLOHYQDL1DCKDc6AO7fCMDJylL+jWJIU8nmWfmQzM7P
	gy6FLJ/ky8mtRPdIYMtWiT7PakXOBXH9FCYzAoN2xbpUhtoPCOx+cD/7YrUAAO12SUvfAFuQgiRoO
	zrl4zoYHahQ9RIYGvTDc9mi4E8/NXop40u8jW5AM6mJAn9jY6l5PtDjFCwGAn9flN57RUD5yjQlU1
	XMjq1zebAI1xwW5Nl3jtIA+V84cLg3fh6tlVvHzhuXoGe0fuhaeXX83E7S7CJOc2XU3Kd+8Yd/bz8
	7ckSV4xQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wc0aa-001ey8-11;
	Tue, 23 Jun 2026 12:50:52 +0000
Date: Tue, 23 Jun 2026 05:50:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC v3 01/12] fs/configfs: rework configfs_is_root()
Message-ID: <ajqASYHIzw3k7Okn@gmail.com>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
 <20260623-configfs-ns-v3-1-841c100fd5dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623-configfs-ns-v3-1-841c100fd5dd@kernel.org>
X-Debian-User: leitao

hello hannes,

On Tue, Jun 23, 2026 at 11:15:46AM +0200, Hannes Reinecke wrote:
> In preparation for making configfs namespace-aware rework
> configfs_is_root() to not rely on static structures but
> rather use the information in the structures themselves.> 

Thanks for the cleanup.  The approach looks fine: CONFIGFS_ROOT is
only ever set on the single static configfs_root dirent.

Nit: "namespace-aware rework configfs_is_root()" reads as if a comma is
missing -- "... namespace-aware, rework configfs_is_root() ...".





> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  fs/configfs/configfs_internal.h | 2 +-
>  fs/configfs/mount.c             | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
> index acdeea8e2d69ac9d621e1a42b039719811c31757..6261e1f3ec201a58a5d46b08dfbced8c2a44d82b 100644
> --- a/fs/configfs/configfs_internal.h
> +++ b/fs/configfs/configfs_internal.h
> @@ -63,7 +63,7 @@ extern spinlock_t configfs_dirent_lock;
>  
>  extern struct kmem_cache *configfs_dir_cachep;
>  
> -extern int configfs_is_root(struct config_item *item);
> +extern bool configfs_is_root(struct config_item *item);
>  
>  extern struct inode * configfs_new_inode(umode_t mode, struct configfs_dirent *, struct super_block *);
>  extern struct inode *configfs_create(struct dentry *, umode_t mode);
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index 4929f343118946eaa55a539db4192e9c6621a8dc..88da7b428e52f2f4ab139ad3907101f685d617b1 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -47,9 +47,14 @@ static struct config_group configfs_root_group = {
>  	},
>  };
>  
> -int configfs_is_root(struct config_item *item)
> +bool configfs_is_root(struct config_item *item)
>  {
> -	return item == &configfs_root_group.cg_item;
> +	struct configfs_dirent *sd;
> +
> +	if (!item->ci_dentry)
> +		return false;
> +	sd = item->ci_dentry->d_fsdata;
> +	return !!(sd->s_type & CONFIGFS_ROOT);

The old helper was a pure pointer comparison and never touched item, so it
tolerated a NULL or not-yet-attached item.  The new one dereferences
it (item). I suppose that item is never being called as NULL?!

Thanks
--breno

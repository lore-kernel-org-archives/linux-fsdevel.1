Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0E376BF4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783072249; cv=none; b=CuEVS7FaX3ILxWUze9ot5HhHuIp6m1coaaS2wxYdLRgPElMaM7sGoaL5/fc4BgZcAHVLAq7kR9qlR7/enSVZZOe4U9nF3o7gP4gH+TgeHOi7rlJQNkN4H4fNSBTZJgTEqUVcVX+rXOSInHBLC6Y3183cSsLKVoQWqehJS0JTaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783072249; c=relaxed/simple;
	bh=0YwdjChBnI94lW4aRaIjYiAtccToo1VnxN7X2OtSJ6A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=lx+/Nyg8CS3tPJlMxjokb8HrH/Ch+jD3ib9oWU3fB4dpthUsNDrRhhNi8Zirot3U4hg2Yv1f9riDX9xR7D0+xnSfaAc38cf2QVR+Tw3KxWQR7qqO7DXn2jzXiHnjHKiUVuOIH1vWMMYytv6BEdzBFbUZYXaER75p+f8Rm36gG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbnBehc9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbnBehc9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877F61F000E9;
	Fri,  3 Jul 2026 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072245;
	bh=mGzAbcXb51nevHCEtSaUb2JBrut5XEXCoOvelu+qTac=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YbnBehc9kQ+DRHg1lEyrfFxPzi387OmHWPWF7sUsovwQIdHatTS5J82eEY5zOpw2O
	 KLQQ+w9OjOObRZP5ERBncrvoDeW6LXBxRig9oryheDbMi1GftzvZNQQ5Ib41dxhRf8
	 xUINxfUZjPudnq6ftna454gKnISgHXQ1fenrKHXgglvs4ckLg6iCKTBxJF68sVlpe6
	 ijLW4NQ67+ANqTBDBq6SxWBlINWoLq0Nlc6GIqaLYDL2Y3HvGZ2l8JCB2ayDOcZboG
	 WvDFfuOYWeTmIeX7RFPs7vwVRw3E6OgoBYP2lyw+1pbGnsGmOX43O4AIWmGUwtw3lc
	 cy8cc6hqkD56g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] VFS: move delegated_inode retry loop into
 lookup_open()
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
In-Reply-To: <20260702111529.3559835-3-neilb@ownmail.net>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-3-neilb@ownmail.net>
Date: Fri, 03 Jul 2026 11:50:41 +0200
Message-Id: <20260703-aufgreifen-exempel-gesurft-4f2b223c0faa@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0YwdjChBnI94lW4aRaIjYiAtccToo1VnxN7X2OtSJ6A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5t37xbjqrU3KAoyhKf0rDKg+3iolTol+UaSbO//a/c
 v2nNvatHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJe8bwP99Vet0KFS8946h+
 vSp+rXMscVsTbX7nn1lXdbZRmM9mBsN/N3kbf7O/agvf/dYT3sHFLnR4+SqO0wf4ju8zV1n9apY
 fGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> By moving this retry into lookup_open() we no longer need to pass around
> the delegated_inode pointer.
> 
> Various variable assignments need to be moved out of the declaration
> block so that they can be repeated after the "goto retry".
> 
> Signed-off-by: NeilBrown <neil@brown.name>
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 55404fe0e269..cb33a01d16eb 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4397,17 +4397,23 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>   * An error code is returned on failure.
>   */
>  static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> -				  const struct open_flags *op,
> -				  struct delegated_inode *delegated_inode)
> +				  const struct open_flags *op)

I think encapsulating got_write and delegated_inode in lookup_open()
removes the need to follow state across multiple function functions. So
that seems like a good win to me.

-- 
Christian Brauner <brauner@kernel.org>

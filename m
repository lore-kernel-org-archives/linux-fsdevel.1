Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D654CF496;
	Sun, 18 Oct 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290024; cv=none; b=ZFJ8ETlJKPDrjSMxmF6eL6u7l0lRh/eOAYvgQcy4zR8Cqxapm7Qb+pyPr8gE4V7UZJ7b0GKD/u5ws3f53ySNdjICO0R9pVFi1d9e/9J/KLgVwBRYIq24wm1gA3S0hNRJg/1X01Z9PM+zGjDwwHG7+eJoWgh4ykl0eG/vP+BWlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290024; c=relaxed/simple;
	bh=4kwc1QYKBJYhCHoM467+RKJmBKF3hvlYJxRSnGdF+PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezXkwoBIKuOO/+ZeX6ioBTk+VEZSbjoMjoGw/UxtUI+uSzLfx6TcyXKS8WXceqoVPHFpuPbSHytcqk9ji8Jk+uTQPPkkQq+h0lROxhBkheoSTcWv0XdKaipq72i71H3SJP1rVwJ6sq63FfAs/+PH94tldw9JLofw2ENAc9nhgpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=foXTMe/B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="foXTMe/B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HsdYOKJFCGE7LaEBaLKNX8p+jHBdg59f86rUkY0OYU0=; b=foXTMe/BC7SHF2pYTFnMdSo0YZ
	i3wFgzpbIDduWet2qDVSh8brvMm9YAeq9c64DdGbiMZmBHJGAxgzeEcZI3oz40MeZxE5dDcd1tAFy
	sxlLWtGEiUzjuZgpcF5Sc7qaJ5Cqj6CkxtCfjVzzz8nJREQRSEKRYVK7j1LPATOeaPHYPLtQJmx+6
	6/dQl/MTkwQbmoNENzn6TbUmvsJQIw1gZa/AXVUMfxmTMUpuUUaP2FYhkp4cjhsxciVEweWUttYGy
	QlmNKPOIiH3XbYkT9CpWSlTK7flbogsSjGtRcn38fvVz38aQIJxFFPosQv5Zor2W7FA5pqR8sAGGz
	EhfcT/gw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIGVX-00000002ccL-0YOK;
	Sun, 18 Oct 2026 02:20:19 +0000
Date: Sun, 18 Oct 2026 03:20:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	NeilBrown <neil@brown.name>, Alexander Larsson <alexl@redhat.com>,
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
	lkmm@lists.linux.dev
Subject: Re: [PATCH 3/9] fs: drop the caller's umount(2) reference under
 mount_lock
Message-ID: <20261018022019.GB3535232@ZenIV>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
 <20261012-work-mount-gp_on_demand-proposal-v1-3-43f60221a7d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-3-43f60221a7d0@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 12, 2026 at 05:39:16PM +0200, Christian Brauner wrote:

> +DEFINE_FREE(mntput_no_expire, struct mount *, if (_T) mntput_no_expire(_T))

You probably want to make it clear in commit message that this is _not_ the
decrement-under-lock referred to by the subject...

>  static int do_umount(struct mount *mnt, int flags)
>  {
> +	struct mount *ref __free(mntput_no_expire) = mnt;

... since it's outside of guard(mount_writer()) scope, thankfully (it would
obviously break under mount_lock).

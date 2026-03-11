Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52B638B142;
	Wed, 11 Mar 2026 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773267186; cv=none; b=nM34My3/W8MnCcY5IM7gVozLeDcwTwJwQtVWXXAiLSXmHS3gT4c8T8Dh2saIJiClMnKdc+9b7IVBprp2mpdKUQBR7B+31EX+ukEwCluAd71sTk71pxOSFD274w4uRua5LAH95lx1nMlfgC5BhIpoKPTMIDRTtfYjFPlTgqj6YiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773267186; c=relaxed/simple;
	bh=3fOHYetrexW5eyi81XaJfk6w2FgZkXn7haVvR5QBY7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKpuWo1aqUCpRJnf5Ol6Hr+fshiWM7M6XHZgsO+UDYtbrebphD+J0Q1XF4Fv4tykXuFR67r+8Kb3yth3BaIdlf1mAAWXhW6zEKN3TSsZ5h2ag55FOCcwEcxhH9O1kESMT9DbH8Y8GRr8UWXtXeUhUAsXkSDujfgyh3VV4RM85bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ehBwcqC3; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ehBwcqC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773267181;
	bh=3fOHYetrexW5eyi81XaJfk6w2FgZkXn7haVvR5QBY7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehBwcqC3VTBZAW5MEGW23tiseZ+np02isUp0Hb3jnzv/Me553KtShQzPBiFjkVTkQ
	 rOAgLJp4fEhXsRcpnScJvocHS1vP3QE34nzgaTyDpjhYCnFrSNaDR9N0Lsakxy/LUD
	 qStvRfzoVId9fdkuyoy3uAIpFJM16sdLawCoyJzE=
Date: Wed, 11 Mar 2026 23:13:01 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC v3 21/26] fs: add kthread_mntns()
Message-ID: <679ceaa7-9ff4-41aa-b602-1c1e4fc129aa@t-8ch.de>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
 <20260311-work-kthread-nullfs-v3-21-3dd2cbe92ad0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-work-kthread-nullfs-v3-21-3dd2cbe92ad0@kernel.org>

On 2026-03-11 22:44:04+0100, Christian Brauner wrote:
> Allow kthreads to create a private mount namespace.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namespace.c        | 30 ++++++++++++++++++++++++++++++
>  include/linux/mount.h |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 854f4fc66469..e23d2fa7e255 100644

(...)

> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index acfe7ef86a1b..69d61f21b548 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -106,6 +106,7 @@ int do_mount(const char *, const char __user *,
>  extern const struct path *collect_paths(const struct path *, struct path *, unsigned);
>  extern void drop_collected_paths(const struct path *, const struct path *);
>  extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
> +int __init kthread_mntns(void);

The usage of '__init' needs an '#include <linux/init.h>', otherwise
compilation fails in some cases. Or drop the '__init' altogether, as
it has no meaning in a declaration anyways.

>  extern int cifs_root_data(char **dev, char **opts);
>  
> 
> -- 
> 2.47.3
> 

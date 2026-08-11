Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED133B14D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463069; cv=none; b=V1dHYJASRMCOeiJeS2V5NPfTLjTXoXpEKAqQ3vTBP7MNG8DoPUG7rHqCqTClEjJX0iiaLY2JU/Y737TrClYVzr9Om1fcJ1skT7A47z9wgszcLtebt7In+imHIq78qsT8H/WFdXNdO8LuAFzWkQuINLjZsovmQ+5xb2imMk81pWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463069; c=relaxed/simple;
	bh=Ni/ioRPwldSPIEn/GUcF9i8TE14QXF9+SEso4yzQ8Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI2szAMe2s+e7H8Q2NUPKynZv3lWML9Nr0D0UoXKT0XHoRgjqV9K1sNRfTzSNtVpAYwKWvwZQakLNyUbJPA51SN9WVNzsO8bH6uN5dsOlAlaAt5bRYOULzVRI2CUTTx7zF3M8kAVQAwa9oKdKbc2N9LtACdh2RLj7eomUhjhE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJF9ag/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJF9ag/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88301F00A3A;
	Tue, 11 Aug 2026 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786463067;
	bh=CFBgsLHMpPk8z90VQkLH1K1Iex607Whn5k4Eb5qr7XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OJF9ag/ly6TENKVM8oiFA9gGHVKCGFwbRuWP1EfYJ6oVLY7jHA1zSQ6K+z1EhuBkz
	 iOld8msMy2q3SBlka354waQFjFQluZL8xEZ2lTfgOARK7O+YXpdxVWNGKO1v5Tqhwc
	 DvmLB6O5NNjnONTFUKTVSEzkBq6Qi9gl6+y4hmhcvp6YNOrKLXAGiapJQXplQzVW8N
	 7o0GWt2oq10XvUzaJt25nAlSe1Qt921fU6h4ClbRiTVFr2dUDZLiYmkoug6OCWyLxj
	 dg0tCaFwd1tjFE1W1pRN6tP60Q6IKaUThH5iidgTbwtnMefmcHfImvgPr0mfiEAo1C
	 DypUfnjH/MXjg==
Date: Tue, 11 Aug 2026 23:44:20 +0800
From: Gao Xiang <xiang@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <antDVPzz0tbn2kTU@XiangdeMacBook-Pro.local>
Mail-Followup-To: Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
References: <20260811071241.389589-1-gscrivan@redhat.com>
 <20260811071241.389589-2-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811071241.389589-2-gscrivan@redhat.com>

(+ cc vfs maintainers)

Hi,

On Tue, Aug 11, 2026 at 09:10:50AM +0200, Giuseppe Scrivano wrote:
> vfs_get_super() already implements the common get_tree pattern of
> looking up an existing superblock via a test callback and initialising
> a new one with fill_super otherwise, but it is private to fs/super.c
> and only reachable through the get_tree_nodev()/get_tree_single()/
> get_tree_keyed() wrappers, none of which let a filesystem supply its
> own test callback.
> 
> Rename it to get_tree_super() and export it so filesystems that need a
> custom superblock matching policy can reuse it directly instead of
> open-coding sget_fc() + fill_super().  No functional change.
> 
> This is a preparatory fix for the next patch.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

With the new vfs_get_super() helper, it seems much cleaner compared
to the previous versions.

Since this series interacts with the other erofs ongoing patches.
So I hope at least [PATCH 2/2] can be routed into the erofs tree to
avoid unnecessary conflict resolving.

Maybe the simplistic way is vfs maintainers can ack this vfs patch so
that both patches can go through erofs tree for the next cycle
directly.


> ---

...

> +/**
> + * get_tree_super - Get a superblock, optionally sharing an existing one
> + * @fc: The filesystem context holding the parameters
> + * @test: Comparison function to find a matching existing superblock, or NULL
> + * @fill_super: Helper to initialise a new superblock
> + *
> + * If @test is non-NULL and matches an existing superblock, that superblock is
> + * reused; otherwise a new anonymous superblock is created and initialised with
> + * @fill_super.  Passing NULL for @test always creates a new superblock.
> + */
> +int get_tree_super(struct fs_context *fc,
>  		int (*test)(struct super_block *, struct fs_context *),
>  		int (*fill_super)(struct super_block *sb,
>  				  struct fs_context *fc))
> @@ -1278,12 +1288,13 @@ static int vfs_get_super(struct fs_context *fc,
>  	deactivate_locked_super(sb);
>  	return err;
>  }
> +EXPORT_SYMBOL(get_tree_super);

btw, some people prefer EXPORT_SYMBOL_GPL() for this kind of helpers.

Thanks,
Gao Xiang

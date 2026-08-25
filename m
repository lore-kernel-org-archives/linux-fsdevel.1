Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E23FFAC6
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663287; cv=none; b=V8BQVwGxveIbdlABpFUEuwmFuvJaMifzl4PAXiUlAIlcp09yHoCnF35OYlDs8+wUoWpb4X9F8rcrtPFOIXrvA4SYiOsB/xK0t9QlOj1QpORlEgTQztQJZr56gHCaH7DC/TF6jSX700OEFrSjMXytWkSwV4iPcuS12kfktivLYn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663287; c=relaxed/simple;
	bh=TqhUuls0o1za1Exni5eCp4wzUNyIr3Dvogmn5hQMzaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB51+SInkh0Bl0TqkGEgqHfuD6NjQr0FZQlVJbcxoRdhsCFTFtgtiAU0bFtFLlirbgXa9itW5C9jnvdKMXmOncBJ0C+mcOENKRL2sRpbcHrOJbZdfRvb1qCuy9tBUlsnD7l7cRO2mBRYR5yqGfyiWUoX57Vu98PEDOntyYwGSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXnEpZwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXnEpZwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B771F000E9;
	Tue, 25 Aug 2026 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787663286;
	bh=e3Z35nT9ig35NqUBVaCr/ENh+yH0JwTsr32Pd2D9w54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WXnEpZwna6XBIwOC66tzfPeEqnNYCgsl+javvuC4rprU5QEztq5VTzsDjj27t08B1
	 oM0d4FPhOfsOUiHVQIXWRIb3xFVViashnMze2/ufIt8iQ8yWv8Qb9zPT0eovGBd3bq
	 18gf8k1BG8eAmMYEPsLQ1TQbYm89g3rnjg19/Fvi6magr2hAGp9GWIlNf0jPyMDFC4
	 +EfiM7n6DWqBDUkF/hqUICBz5lOh0fUnMyCRjK2jhqybKHJCN4crHUmsg7kAft74iu
	 fWamfqeZ5Us1lMnZanBkKEUbPDGCxDT3v2F5Tq01r9n2kaCHQJWO7nGC3aSLXgdFOl
	 EmsYS98lOa4wg==
Date: Tue, 25 Aug 2026 21:07:59 +0800
From: Gao Xiang <xiang@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Gao Xiang <xiang@kernel.org>, Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <ao2Tr6HQoVFHmRaq@192.168.5.19>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
References: <20260811071241.389589-1-gscrivan@redhat.com>
 <20260811071241.389589-2-gscrivan@redhat.com>
 <antDVPzz0tbn2kTU@XiangdeMacBook-Pro.local>
 <20260825-gorilla-zuhilfenahme-unfug-4b81185496a3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825-gorilla-zuhilfenahme-unfug-4b81185496a3@brauner>

Hi Christian,

On Tue, Aug 25, 2026 at 02:32:48PM +0200, Christian Brauner wrote:
> On Tue, Aug 11, 2026 at 11:44:20PM +0800, Gao Xiang wrote:
> > (+ cc vfs maintainers)
> > 
> > Hi,
> > 
> > On Tue, Aug 11, 2026 at 09:10:50AM +0200, Giuseppe Scrivano wrote:
> > > vfs_get_super() already implements the common get_tree pattern of
> > > looking up an existing superblock via a test callback and initialising
> > > a new one with fill_super otherwise, but it is private to fs/super.c
> > > and only reachable through the get_tree_nodev()/get_tree_single()/
> > > get_tree_keyed() wrappers, none of which let a filesystem supply its
> > > own test callback.
> > > 
> > > Rename it to get_tree_super() and export it so filesystems that need a
> > > custom superblock matching policy can reuse it directly instead of
> > > open-coding sget_fc() + fill_super().  No functional change.
> > > 
> > > This is a preparatory fix for the next patch.
> > > 
> > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> > 
> > With the new vfs_get_super() helper, it seems much cleaner compared
> > to the previous versions.
> 
> I'll add this patch to the vfs-7.3.super tree post -rc1 and then you can
> pull it in. Thanks!

I guess you meant vfs-7.4.super? If yes that would be fine, I'm willing
to land this feature for 7.4 too.

Thanks,
Gao Xiang

> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFCF42A168
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661176; cv=none; b=RyzJeWobDiolBE8Mo8nmfiEYH+vtDW6sV/Uf9Iw2Igxho8MzKNOeA7E2wZQGd6eE7X5vzyBuhqTKF6rksYG1+o5G/nlAPVuvQPJN22a0eYmn6V9aKtKG067K6QLLsgcI1J2AuPjOPx+qJR6jwJ8H4q3vJqUgYZdNaR+kzUPJWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661176; c=relaxed/simple;
	bh=fYDA2dKKVVkG56JucsURHzY5W7B3/hiZVWownLyLMsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9Btt6fixCCsm7hUyGq+O++2VP0azevvVL6II5vJT7tMhD2myGIIVVKR7lg+YZrJ0YlCYlC6uHlz6IO8kT6cBGDxnCqai4KLJyVI2pbcaORz/T6bx7Iy4IwVcwWPFV1FIQmb1YI5GrCGUO7kf5NcbDhDiGiwxxrwfrSYDbWg7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQitDpqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQitDpqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ED01F000E9;
	Tue, 25 Aug 2026 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787661172;
	bh=SpXwlqfpTMSqPr0d90JklGo6OIEhYzopHmqlFENWmWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQitDpqjc9v1jX9R0zuwAqvDhnoeB4zVdMoM2mfkvZ3tl8spDoHHcIvHNpPkdifWg
	 8DQYd+tgNFbYtLodunNYY68F3u8GnLUf/TVDG/t5J/m1GQ4xI+MXNqlDWTPYu/06GS
	 gfBnm9LfjhROvo72q19a3Zqk+zRTwpMCxNcJTDiZPpmsFwZjx9p3FPstVIyBClP8Jl
	 e+gsftCO5KQfsxJoolMFhyYjjvFdbzc2s1UbhmF7+r+gMl+Z3tLMWRY8fHbLlT13cg
	 AxhTgpx2XQoRpA/klvQtCYZbvDHawGDVXo5MemJ2xhlj+X9slrbHQfXaWXeyIztK9Y
	 0LpdF4ka0vtJQ==
Date: Tue, 25 Aug 2026 14:32:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <xiang@kernel.org>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 1/2] fs: rename vfs_get_super() to get_tree_super()
 and export it
Message-ID: <20260825-gorilla-zuhilfenahme-unfug-4b81185496a3@brauner>
References: <20260811071241.389589-1-gscrivan@redhat.com>
 <20260811071241.389589-2-gscrivan@redhat.com>
 <antDVPzz0tbn2kTU@XiangdeMacBook-Pro.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <antDVPzz0tbn2kTU@XiangdeMacBook-Pro.local>

On Tue, Aug 11, 2026 at 11:44:20PM +0800, Gao Xiang wrote:
> (+ cc vfs maintainers)
> 
> Hi,
> 
> On Tue, Aug 11, 2026 at 09:10:50AM +0200, Giuseppe Scrivano wrote:
> > vfs_get_super() already implements the common get_tree pattern of
> > looking up an existing superblock via a test callback and initialising
> > a new one with fill_super otherwise, but it is private to fs/super.c
> > and only reachable through the get_tree_nodev()/get_tree_single()/
> > get_tree_keyed() wrappers, none of which let a filesystem supply its
> > own test callback.
> > 
> > Rename it to get_tree_super() and export it so filesystems that need a
> > custom superblock matching policy can reuse it directly instead of
> > open-coding sget_fc() + fill_super().  No functional change.
> > 
> > This is a preparatory fix for the next patch.
> > 
> > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> 
> With the new vfs_get_super() helper, it seems much cleaner compared
> to the previous versions.

I'll add this patch to the vfs-7.3.super tree post -rc1 and then you can
pull it in. Thanks!

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627832A1CF;
	Sat, 21 Mar 2026 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774081327; cv=none; b=WSyf5Jx1ySX3rVqgWjn1NjlIUn1Vj5Y6re1+OpbdpYyIHadB1yYEcShwNQy4aZEbyClqAIvBUn7NSGlekkgdLhJOWh9wMYt232gxJexLA2En4ZBYUVTrpXaHy61pyGlyR/a/4ReXNiKDuvJ5U18qC1i7w9S7cSQ8zz6GI/sRKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774081327; c=relaxed/simple;
	bh=aYGVhw+bI1i5SdyrK8fXu3FVyLp6nUJUN4Q7yEdNUjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+X/rHbtV3oPzfCr7vzopYH0YNENQRO8KFnsVOWRk4moBwaoqZoMdDXDF3AyblqqpXnqTv9F7qAzN25yjky82eBX/B0wLugpMnQrcJbRQm/i2f3+CzHgogY3r27pZGaRqkHRLEso7bU+Xu5wSpr51oQBj3aj6XMoihRwzpvAwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlVgfnPe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlVgfnPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E06C19421;
	Sat, 21 Mar 2026 08:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774081327;
	bh=aYGVhw+bI1i5SdyrK8fXu3FVyLp6nUJUN4Q7yEdNUjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlVgfnPexykPVd4CrxH9guuYRTchgHHxD+JyWzMDm7jD8ZHuC54q6OC0SX5faiELv
	 4BdCdUYXZvQBe8u1OU3ADfkGd1q1bkGzS0jRbPdsJFKFwsEyW5zxUX9prMLED6LeNi
	 urCCfQMjbjP8EGF1tUgmSIKGFLG5TELAieqQ6uPINDgat7Xy4dEbpUKQgobHlWimHn
	 KyvDWZFJWScQO9tpSIkSZEHKdRyWM7eSl61oS+7mJqgPup7Olnwa6/41D0e0QeAc7z
	 hnB6Yz6VkHeMCgtSmq+N6FcbpjIJrZFAaHD3Q2YExvpBNW8wvJti2+Fz2KRpZcJKI3
	 232dwBwzM5fzw==
Date: Sat, 21 Mar 2026 09:22:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, mszeredi@redhat.com, 
	raven@themaw.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/namespace: fix double hlist_del_init of mnt_mp_list
 in get_detached_copy()
Message-ID: <20260321-preschen-karitativ-508756cc870f@brauner>
References: <20260321062412.1120693-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321062412.1120693-1-kartikey406@gmail.com>

On Sat, Mar 21, 2026 at 11:54:12AM +0530, Deepanshu Kartikey wrote:
> get_detached_copy() builds a new anonymous mount namespace for
> open_tree(OPEN_TREE_CLONE) by iterating all mounts in the cloned tree
> and calling mnt_add_to_ns() for each. However, child mounts in the
> cloned tree have their mnt_mp_list linked into the original mountpoint's
> m_list via mnt_set_mountpoint(). mnt_add_to_ns() only updates the
> namespace RB tree and never removes mnt_mp_list from that list.
> 
> When both the original and new anonymous namespaces are torn down on
> process exit, put_mnt_ns() -> umount_tree() -> __umount_mnt() calls
> hlist_del_init() on mnt_mp_list for each mount. Since the same mount
> belongs to two namespaces, hlist_del_init() is called twice on the same
> node, corrupting the list and causing a general protection fault.
> 
> Fix this by calling hlist_del_init() on mnt_mp_list and clearing mnt_mp
> for each mount inside the loop in get_detached_copy(). This detaches
> them from the original mountpoint's m_list. Clearing mnt_mp also
> prevents __umount_mnt() from passing a stale pointer to
> maybe_free_mountpoint() during teardown.
> 
> Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
> Tested-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
> Fixes: 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
> Signed-off-by: Deepanshu kartikey <Kartikey406@gmail.com>
> ---

Both the analysis and the fix are unfortunately very wrong.
The original cuplrit is how we create partial mount namespace copies.
I have a fix for that ready to go later.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C893CCFB4
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534702; cv=none; b=MRYNjzxcwcOXULItLysmK0tlrKoDUi5uVETCQ2RB+JNfENLkQ6Dc2sNSwRFUqcRIjRy0LA5FC8vPU8HvLFQOIpQQ1xl3SMU5kXN5aYNnXrz89gpZAWvIH0WoPFRcufGb6MnAFx4ezsnGQrPfXGaArc1zh4e11TZcXt9Cd090OvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534702; c=relaxed/simple;
	bh=uuz2W5qH3lpIDOyeYNv+3H93/4LFb77agzVmZ1D5SWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkD2zaoxrGSf2uvb++ojUmm3GSOEVl5cde/eOghknjLDSWKdG7nfIH7ULHdUTwULcMDu2TOAL8MnYG2fBPIB9ME5/wc8GO/9NgrQ0RqnFbX9sb1f6eqv/zxZ1bGYxqBBDfQ0eN9Lb1JE6ch2yvF6/r0mqcyes2j+VebYQambMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCE8+FGf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCE8+FGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F83BC116C6;
	Thu, 26 Mar 2026 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774534701;
	bh=uuz2W5qH3lpIDOyeYNv+3H93/4LFb77agzVmZ1D5SWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCE8+FGfSFrJH5ZDg4ox2WkSb8ZGQgKjayzeBkLeBWcXvlmAEEQM5LzSicol6ObJ2
	 G/KipizgmM1TDuPvhVWeNzgZqwG1x9vkD1Vo+Yd7cg623xf2cQSmhvCdJa8Qe5IsMX
	 ZUTQx/Egh/MKZfkPIjWcKgdS/lfQNRs6Rw9yZ/Pge3q5moGBxKGwlN7FEoODSWMXO8
	 h41HL2TIZV9PzwXZrzjIhXehT4rmCQHT2iS46xP2phWsUgUkt+bmH2RzCdviyiXN/1
	 loEzsLOyB/OnZf+FoEiSOS+9pmzqKeHy+dSh1NP58AMR1GiNys3kThTfjDTBimq2i1
	 UYpX4g0gj65uQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Sterba <dsterba@suse.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Subject: Re: trivial ->setattr cleanups
Date: Thu, 26 Mar 2026 15:18:09 +0100
Message-ID: <20260326-vorfuhr-ehedrama-1007afa3e4ff@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325063711.3298685-1-hch@lst.de>
References: <20260325063711.3298685-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=brauner@kernel.org; h=from:subject:message-id; bh=uuz2W5qH3lpIDOyeYNv+3H93/4LFb77agzVmZ1D5SWU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQeddDQ6uAXWZrnsUjrm7hBS1uB5+Vli2L+9BqcKN++/ ObRbnmXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlwGTP84fa39774+XJAH3/E 9aBsx/9HXddmuKk++bp3nZuez7Oy34wMu7xfd2ltElWpsWe/Iz5P8/GjhXqvDhY8iDZdMUll6+9 5PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 07:36:47 +0100, Christoph Hellwig wrote:
> I've been looking into changes to ->setattr and noticed that we still
> have a few instances where the method has the ages old notify_change
> name.  Fix this up and include dusting off outdated comments.
> 
> Diffstat:
>  adfs/adfs.h       |    4 ++--
>  adfs/dir.c        |    2 +-
>  adfs/file.c       |    2 +-
>  adfs/inode.c      |    6 ++----
>  affs/affs.h       |    2 +-
>  affs/dir.c        |    2 +-
>  affs/file.c       |    2 +-
>  affs/inode.c      |    5 ++---
>  affs/symlink.c    |    2 +-
>  hfs/inode.c       |   21 ++-------------------
>  proc/base.c       |   22 +++++++++++-----------
>  proc/fd.c         |    6 +++---
>  proc/generic.c    |    8 ++++----
>  proc/internal.h   |    4 ++--
>  proc/namespaces.c |    4 ++--
>  proc/proc_net.c   |    2 +-
>  16 files changed, 37 insertions(+), 57 deletions(-)
> 
> [...]

Applied to the vfs-7.1.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.misc

[1/5] hfs: update comments on hfs_inode_setattr
      https://git.kernel.org/vfs/vfs/c/d1312979f155
[2/5] adfs: rename adfs_notify_change to adfs_setattr
      https://git.kernel.org/vfs/vfs/c/9c71de5f4ddc
[3/5] affs: rename affs_notify_change to affs_setattr
      https://git.kernel.org/vfs/vfs/c/d0fdc1c0d0f6
[4/5] proc: rename proc_setattr to proc_nochmod_setattr
      https://git.kernel.org/vfs/vfs/c/690005b0b1e6
[5/5] proc: rename proc_notify_change to proc_setattr
      https://git.kernel.org/vfs/vfs/c/2ecd46d161fa

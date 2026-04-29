Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66EC23C50A;
	Wed, 29 Apr 2026 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472278; cv=none; b=DYqBf3/i5wxPjTy7UOUqfFD1/Jq4T85g3YLc4dl3lfgsx3AQ2hfIf+6HjSu6PCNtu5NZx7yRBJZrb4XsiOwYpu7UtzxDUaoUMoZ9b5n3dzvadWorEi1N2LUDSdznuV7TdeUMUiokNqnZK0V114HAT5BFRTuvhCxAqus67kkXRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472278; c=relaxed/simple;
	bh=HNzjiYS49TpmpEftdTXqNK0ZxbVEl1HShY7RAtreUJ8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppk93vsdiwL0g/jDFJszfBu16IJNj1VD/irCqsvyMMM0JfPf+Yr5+fiP0x6eyeOaxTR5/mo2hhvP/r9BVexm3d/gyJv8261/sZ3lF6+UT2L3ghVMlEC9J6oWZRXZCrbKL3WdcybN2tKHBsVWnXCpUfdYMuBf33F6j+WH+BJJI3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju07misK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju07misK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABFFC19425;
	Wed, 29 Apr 2026 14:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472278;
	bh=HNzjiYS49TpmpEftdTXqNK0ZxbVEl1HShY7RAtreUJ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ju07misKppk0keR+5HuKS1HD6975MN2wgw43AtEOHFFWEqbce7JNf8RuVquC6gHKR
	 V5LXNlvDv3758KXMFFoQ0OJTBgH6QscFBUuM5Xb5c8YB+VDtOqDfbH2ERyA4t9qht1
	 fxVtZh0eAW0whWsWYZgC5YOJKKaT/wLNTe29D+TQBqZKB4rvwkj3OZm2x0XpHYQOzU
	 zPYHtNBY/QuClHvW/DczQhBKQlGWWHciybXF6jj0IAplW5uHPeJAMII142HMQikvmd
	 hYyGjBjQg4O8oDyQmaD4WTM8lt4cSgQ6QEKz0rVlqOBw1DH/nl6v1PXzc9l/i44ATR
	 dGf9U4Iw0+71g==
Date: Wed, 29 Apr 2026 07:17:57 -0700
Subject: [PATCHSET v8 6/8] fuse: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
In-Reply-To: <20260429141253.GQ7739@frogsfrogsfrogs>
References: <20260429141253.GQ7739@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

When iomap is enabled for a fuse file, we try to keep as much of the
file IO path in the kernel as we possibly can.  That means no calling
out to the fuse server in the IO path when we can avoid it.  However,
the existing FUSE architecture defers all file attributes to the fuse
server -- [cm]time updates, ACL metadata management, set[ug]id removal,
and permissions checking thereof, etc.

We'd really rather do all these attribute updates in the kernel, and
only push them to the fuse server when it's actually necessary (e.g.
fsync).  Furthermore, the POSIX ACL code has the weird behavior that if
the access ACL can be represented entirely by i_mode bits, it will
change the mode and delete the ACL, which fuse servers generally don't
seem to implement.

IOWs, we want consistent and correct (as defined by fstests) behavior
of file attributes in iomap mode.  Let's make the kernel manage all that
and push the results to userspace as needed.  This improves performance
even further, since it's sort of like writeback_cache mode but more
aggressive.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * fuse: enable caching of timestamps
 * fuse: force a ctime update after a fileattr_set call when in iomap mode
 * fuse: allow local filesystems to set some VFS iflags
 * fuse_trace: allow local filesystems to set some VFS iflags
 * fuse: cache atime when in iomap mode
 * fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse: update ctime when updating acls on an iomap inode
 * fuse: always cache ACLs when using iomap
---
 fs/fuse/fuse_i.h          |    1 +
 fs/fuse/fuse_trace.h      |   87 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |    8 ++++
 fs/fuse/acl.c             |   30 +++++++++++++---
 fs/fuse/dir.c             |   38 ++++++++++++++++----
 fs/fuse/file.c            |   18 ++++++---
 fs/fuse/fuse_iomap.c      |   12 ++++++
 fs/fuse/inode.c           |   19 +++++++---
 fs/fuse/ioctl.c           |   68 +++++++++++++++++++++++++++++++++++
 fs/fuse/readdir.c         |    5 ++-
 10 files changed, 262 insertions(+), 24 deletions(-)


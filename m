Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C7D13B584;
	Wed, 29 Apr 2026 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472247; cv=none; b=NNe8b1eMBbNTSS+1+U44N5MZL1TPWBnjUWEpNFpQyzYP3c0Jg/4yRlu2RnlZ87m95kBpzAAXYVEhi5RELfBu5KDqzFkV5l/6dYUZvBGQw2PsT5KBzmukawZdkN0u2TuYbFv3jaCHK3SdUITr5IvA59OxQ4x3mU4TTOBa870RG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472247; c=relaxed/simple;
	bh=/SChfcz97x5WAVQx9coURP7qsofG4EFQ/d7WjKsFVFE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV7PHWEOyTPq/f7ztsF1L3tYI7mV7rBsYdev+yWaLmlh5kGFfJj2ODM59FQE4CnOn/ntiRSpxti2XUwT6TKsOPSdZ8OxEjeyVuDP/xvkQaiSD0ixvzPc3GniNNAG1GD8nJwLLj71RWKrvmJ5z4GCRhUji9Z62TJ6NGPbxYvsTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6tGShx3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6tGShx3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4AEC19425;
	Wed, 29 Apr 2026 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472247;
	bh=/SChfcz97x5WAVQx9coURP7qsofG4EFQ/d7WjKsFVFE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g6tGShx39mzM+a938lESteFWVw7xR4FYhaXABhfCTy7xgcCfGNq8NxrRSrrpTSdwT
	 J9jWLsiZyzh1ZY7+xL1RtJhRpyGrrUhCu5BZGjpTwFRRtLc6/fgBYUqU1lr6Sy4O4U
	 d9CbvNnk7DpF+st90vUTrPwjDmonhHvDWawbcOjMu2NKHAJc6iKcBbDSOutCw0M+ZQ
	 EG4lVSQBoE8N72sqLeJIkwmCTKRcXqbNeSzmcu5Y6EZFMJV90IrG8Ot4EWRtYzk/B9
	 N+mbdnbhqXDrZhvwcR9/Z/SnOIL4dDP+46t3qWb66f/1/kBDkTPXtI6q4WcB86gwgN
	 EuoWAs2bGcutA==
Date: Wed, 29 Apr 2026 07:17:26 -0700
Subject: [PATCHSET v8 4/8] fuse: allow servers to use iomap for better file IO
 performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
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

This series connects fuse (the userspace filesystem layer) to fs-iomap
to get fuse servers out of the business of handling file I/O themselves.
By keeping the IO path mostly within the kernel, we can dramatically
improve the speed of disk-based filesystems.  This enables us to move
all the filesystem metadata parsing code out of the kernel and into
userspace, which means that we can containerize them for security
without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
---
Commits in this patchset:
 * fuse: implement the basic iomap mechanisms
 * fuse_trace: implement the basic iomap mechanisms
 * fuse: make debugging configurable at runtime
 * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse: enable SYNCFS and ensure we flush everything before sending DESTROY
 * fuse: clean up per-file type inode initialization
 * fuse: create a per-inode flag for setting exclusive mode.
 * fuse: create a per-inode flag for toggling iomap
 * fuse_trace: create a per-inode flag for toggling iomap
 * fuse: isolate the other regular file IO paths from iomap
 * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse: implement direct IO with iomap
 * fuse_trace: implement direct IO with iomap
 * fuse: implement buffered IO with iomap
 * fuse_trace: implement buffered IO with iomap
 * fuse: use an unrestricted backing device with iomap pagecache io
 * fuse: implement large folios for iomap pagecache files
 * fuse: advertise support for iomap
 * fuse: query filesystem geometry when using iomap
 * fuse_trace: query filesystem geometry when using iomap
 * fuse: implement fadvise for iomap files
 * fuse: invalidate ranges of block devices being used for iomap
 * fuse_trace: invalidate ranges of block devices being used for iomap
 * fuse: implement inline data file IO via iomap
 * fuse_trace: implement inline data file IO via iomap
 * fuse: allow more statx fields
 * fuse: support atomic writes with iomap
 * fuse_trace: support atomic writes with iomap
 * fuse: disable direct fs reclaim for any fuse server that uses iomap
 * fuse: enable swapfile activation on iomap
 * fuse: implement freeze and shutdowns for iomap filesystems
---
 fs/fuse/fuse_i.h          |   73 +
 fs/fuse/fuse_iomap.h      |  110 ++
 fs/fuse/fuse_iomap_i.h    |   45 +
 fs/fuse/fuse_trace.h      |  974 ++++++++++++++++++
 include/uapi/linux/fuse.h |  235 ++++
 fs/fuse/Kconfig           |   48 +
 fs/fuse/Makefile          |    1 
 fs/fuse/backing.c         |   47 +
 fs/fuse/dev.c             |   42 +
 fs/fuse/dir.c             |  141 ++-
 fs/fuse/file.c            |  122 ++
 fs/fuse/fuse_iomap.c      | 2380 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |  180 +++
 fs/fuse/iomode.c          |    1 
 fs/fuse/trace.c           |    3 
 15 files changed, 4331 insertions(+), 71 deletions(-)
 create mode 100644 fs/fuse/fuse_iomap.h
 create mode 100644 fs/fuse/fuse_iomap_i.h
 create mode 100644 fs/fuse/fuse_iomap.c


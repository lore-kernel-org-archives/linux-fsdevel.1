Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5873ED13B;
	Tue, 19 May 2026 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229532; cv=none; b=jbgzUwskLXqAmVUCps/h5maXM0hwGNIVCR9+ugrl15Qcl8dGzcWkqbEa1SGT+odtwZumXktDY0rQ0RynummoAIFNCOYRmJifJBCrqvUWWNVepfCr6Jd+ub5av9g5WfmHJAEXV+tHmc/9FvUe2yYohnwZoZfdLy6b6lYaXZBtk08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229532; c=relaxed/simple;
	bh=7HJT0KO35MgVTlc+CLGl66AajkueS6+jYDIU0JjynXw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qr1YuGGvonfq9VGyldoP2vsTOcYtPugXg590y/wvYqgnzDFpqkE1C5mxmCKnYLiUwW5bqhB7jnWCv/7gVorwiGCa9c7cyIERBgUrV5mP0GbIE+ggShljO8t3rXSq4xCWZpr7H32IyqrDlnyUn3Ub2aZ0Ka2g8CMoUElPnH1Zft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lieFRJMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lieFRJMm"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CD3E41F00893;
	Tue, 19 May 2026 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229529;
	bh=mNiS0rWlaG0j7Zhr03/1uDwdgemnt0W5iHwQp4h0KjQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=lieFRJMmvbHB7JUd/XIHFlqSK8WOe7xh75FbDvzvEU3TjXEWsMOinVG1Zx1zRyNZ7
	 rCZpueMBN+eoxpg1LrUGbV2WQHmxU7ziHcJO5aRYzW4c1HqBZVF8idQHoxq968okdR
	 GZnxQx+mBooDypuMD7IJvxu0I/7A/Vy5/P0lO83E5P3COLmO1C+RcxOYLpGUbD6wor
	 ew2XmhrYFKTqXqE5BVcFiUCjgqA3ItAx598uJbsK/tUVngOoKHt+iZfGsEXtn70Qod
	 l/Mij37DWkfzyRzGB+Sz6Exdc/BuxAuRquhcvPCyh/sh1ieg5kWdOy6hMjnrlewrBm
	 yjxZq8e4TiX9Q==
Date: Tue, 19 May 2026 15:25:29 -0700
Subject: [PATCHSET v9 4/4] fuse: discovery and configuration of iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
In-Reply-To: <20260519222229.GB9544@frogsfrogsfrogs>
References: <20260519222229.GB9544@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Now that we have established the key file IO codepaths with iomap, we
need a mechanism for fuse servers to detect if the running kernel driver
supports iomap.  If the fuse server indicates that it wants iomap, the
kernel driver can then ask the server about what sort of behaviors it
wants.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-config
---
Commits in this patchset:
 * fuse: advertise support for iomap
 * fuse: query filesystem geometry when using iomap
 * fuse_trace: query filesystem geometry when using iomap
 * fuse: use an unrestricted backing device with iomap pagecache io
 * fuse: disable direct fs reclaim for any fuse server that uses iomap
 * fuse: allow privileged mount helpers to pre-approve iomap usage
 * fuse: invalidate ranges of backing devices being used for iomap
 * fuse_trace: invalidate ranges of block devices being used for iomap
 * fuse: set iomap backing device block size
---
 fs/fuse/fuse_i.h                                   |   17 +
 fs/fuse/fuse_iomap.h                               |   19 +
 fs/fuse/fuse_trace.h                               |   74 ++++
 include/uapi/linux/fuse.h                          |   78 ++++
 Documentation/userspace-api/ioctl/ioctl-number.rst |    2 
 fs/fuse/dev.c                                      |   37 ++
 fs/fuse/fuse_iomap.c                               |  417 ++++++++++++++++++++
 fs/fuse/inode.c                                    |   46 ++
 mm/page-writeback.c                                |    1 
 9 files changed, 680 insertions(+), 11 deletions(-)


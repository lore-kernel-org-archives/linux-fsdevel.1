Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF6175A75;
	Wed, 29 Apr 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472231; cv=none; b=uPLMKxumz9zA3TZBRAUp7AEXnBjw1D1nwpB6y0hMTzDP6qYUEUbHHTX4NGbrQi3tTjcETrpUq+6iioohI+JIxkeHiYXOJZhyXn8r6/eKGMmDxM6AIFh/E2RBUeNDAA6cFGG1Lx6NsDv37saAlWnIu0ckQuuDFM8umNiBXH0S/aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472231; c=relaxed/simple;
	bh=UJZIjtLDQtB03raL/aPNWIOBYh2KT5S4I6TFvYkTbpA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHlfbErcEShmYIlFeXLshyqGwSOn5A967OGtS5Fg00buU6pj2hNNCEUwsG27L0Qt6pe/jQq57p047MiGv3s3qWhMnaJ5qN90WM734Kpu4XWY59iZQp/UyLx/6kxJN98RhYCm6+XnvmlklINLVT3kUYWsjlYf3uK0AZnycJMfOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0VRj9uB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0VRj9uB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3038CC2BCB8;
	Wed, 29 Apr 2026 14:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472231;
	bh=UJZIjtLDQtB03raL/aPNWIOBYh2KT5S4I6TFvYkTbpA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g0VRj9uBbrqQodnHePzHGbFycAuu+JCDwI9RmBCcP29OMjVLXG06/u14IfgeeKAPG
	 Gm/rIhPfBJGUQYNw5J9XCAllUNUle7nxkaTanjQ+aRVphzrbYOiar0ecYgQXjsGRKY
	 ayCUVobVsAGCcNrbXjJFdwi4GxNQK0VmmwvP3Uvp3u0B0DrcZIX10siyswpQT7Mnc5
	 8P1XDQ7bty3VjMNuyAc3MaWtcCCngVFp0nac4sAf+wUHAYPGSW7qq9NMFxSQOJFQZK
	 nTIzCqWIK59oN8/DW3T+8Qw/sJ5ZbVcekilYclyN82278CYGHtXazhXKqTwn/5tZWV
	 Q9KrebKhhcHRQ==
Date: Wed, 29 Apr 2026 07:17:10 -0700
Subject: [PATCHSET v8 3/8] fuse: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747204594.4101743.18108570914300152558.stgit@frogsfrogsfrogs>
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

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-prep
---
Commits in this patchset:
 * fuse: move the passthrough-specific code back to passthrough.c
 * fuse_trace: move the passthrough-specific code back to passthrough.c
---
 fs/fuse/fuse_i.h          |   25 ++++++++++-
 fs/fuse/fuse_trace.h      |   35 ++++++++++++++++
 include/uapi/linux/fuse.h |    8 +++-
 fs/fuse/Kconfig           |    4 ++
 fs/fuse/Makefile          |    3 +
 fs/fuse/backing.c         |  101 ++++++++++++++++++++++++++++++++++-----------
 fs/fuse/dev.c             |    4 +-
 fs/fuse/inode.c           |    4 +-
 fs/fuse/passthrough.c     |   38 ++++++++++++++++-
 9 files changed, 188 insertions(+), 34 deletions(-)


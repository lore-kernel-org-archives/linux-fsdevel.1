Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991F23C50A;
	Wed, 29 Apr 2026 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472263; cv=none; b=iUcdFAqp72WVu5XphDKHBUA0b8oWDOEstdicweyCA9KzFZQihhZT08R6SwbyZnyxfn+KCNbCqNeVGDL2kpjHzMDN/iGhKtN2azvrm/1/m4jhT/bNF9pIMQB0Nzev5iYcolHs6A0YjLzSzIt2VwJfLIPU0IayEDmzHKnEE725hDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472263; c=relaxed/simple;
	bh=7XIko+RzUGeXSQWx5FGVqdcYvhFjE91G6hr5QPs4bao=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfdRcPEn2ZjmObKfgYgqrsA41kKsVczvHzypAhewJdxxCcsT6WZGrNn6ZnBS7qpaKhFa67sUyCpwo3HEX6odIukXFhPX2FTEJDJyqp7S50eQn79FFVUAeJk+ET600EXB3iepUxedIobWQq3X2qzs37h5HhYRMssO3GYKiCudxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7gv2Opk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7gv2Opk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A37C19425;
	Wed, 29 Apr 2026 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472262;
	bh=7XIko+RzUGeXSQWx5FGVqdcYvhFjE91G6hr5QPs4bao=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N7gv2Opkg66hOFzHGcerNOAD4ZIeugMkUbOiUjW5w0f450ocuHzrEeZcRegKgdeGI
	 1XCAhjjzlQ+Cf+3RV3uWNhwEbORXjKmp0s0n/d64TDZXCB4OsraWGjabYyFWcLva6Y
	 vGZNVg5VpcbyiEtJhjnyWpQIQgwGofhX1MoWhPVUhMfewE+kNjJiB0TnwqBvV1RZvN
	 t0ob3ExrR+BoRwj7zaUTIon2LFrpOKvZbkbPnMxM/92E4tV3X1jocMa7+E5eUpTKgL
	 3XLpP0bVsWQfZgiuCgeYBSm1/MC0sMx0nm88CxA/jJqou9IQjh/vG4gHJVASihiOw1
	 iRV2WtqULs1og==
Date: Wed, 29 Apr 2026 07:17:42 -0700
Subject: [PATCHSET v8 5/8] fuse: allow servers to specify root node id
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
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

This series grants fuse servers full control over the entire node id
address space by allowing them to specify the nodeid of the root
directory.  With this new feature, fuse4fs will not have to translate
node ids.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-root-nodeid
---
Commits in this patchset:
 * fuse: make the root nodeid dynamic
 * fuse_trace: make the root nodeid dynamic
 * fuse: allow setting of root nodeid
---
 fs/fuse/fuse_i.h     |    9 +++++++--
 fs/fuse/fuse_trace.h |    6 ++++--
 fs/fuse/dir.c        |   10 ++++++----
 fs/fuse/inode.c      |   22 ++++++++++++++++++----
 fs/fuse/readdir.c    |   10 +++++-----
 5 files changed, 40 insertions(+), 17 deletions(-)


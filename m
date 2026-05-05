Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264573A5E9A;
	Tue,  5 May 2026 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958819; cv=none; b=SnYHJcEjqYoP5Br1FHJY9Yha4ZZzXtGu2dHbogOCk/T13dD2EHlQT4Ww23UEXbvDSxgX87b8afsh4DpQpV4kt9oIgG8P8HYDp3LmtunPuppfCpAnjvLgEBbiReH7z3xPM3rf5ZSh123QTV7h7NnSEfZle5NzKwMPh5OIVAD5gZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958819; c=relaxed/simple;
	bh=n5W+B82QyRVdME3yxHoNt+tq2tB8DubZ1+iFgiMKxcg=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:In-Reply-To:
	 References:Content-Type; b=rd6gwj1JRhGEXawc3nvKwHwgWcPrz94lvM0//CmepKunbwtNhGzvPtdk043+FO4FHRCcN21QEWLgcRZ0DRvTpigSOP2BIHF8c1fQLu/GPkagRlP1R0UYVqtccpxZd9Owb7aPeGHtPHdmoytcHun0ZQuj0AX5w3LD9t+DpLTMsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky2fMMRa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky2fMMRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC0CC2BCB4;
	Tue,  5 May 2026 05:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958818;
	bh=n5W+B82QyRVdME3yxHoNt+tq2tB8DubZ1+iFgiMKxcg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ky2fMMRawFYRCfwkgOCdbyfuqWvyHwVj2Tu7jssmERlxPZ/4GetMxPi0buN9qo0uF
	 Nq0JZEnQ67V+57gVLvBUC8dMdMaOmYBF9KeNPv9OaqE3Sh9f1yIlW5dH1lOkhsMk91
	 6iFSD63cfsQO8kce++ILsF1Ad/u24eZzyiRDdwAiM1ZKTvJzSrnLk/GIjBvYLbrtjk
	 Vw0fwATnA5DMwZr1drZFYmEtld+UnmMBxmj48cubem7/GxF4mXHXFTm0rqFdNuUmgl
	 /HO1XSkwgx528aIgkGvVwE4LP/SyXBc7htR6sUFMyP1swImlHvR+3uIEY85YnmcXmr
	 yiutLolKIvqsA==
Date: Mon, 04 May 2026 22:26:58 -0700
Subject: [GIT PULL 2/2] libfuse: new mount service container fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: bernd@bsbernd.com, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <177795854322.1134010.3316596782061965376.stg-ugh@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260505052133.GR7765@frogsfrogsfrogs>
References: <20260505052133.GR7765@frogsfrogsfrogs>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Bernd,

Please pull this branch with changes for libfuse.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit ce2feba31ef7ab81807dcba3ae8f64d314ffd14a:

libfuse: always send the subtype to the kernel when using fsconfig() (2026-05-04 16:22:43 -0700)

are available in the Git repository at:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container-fixes_2026-05-04

for you to fetch changes up to e3db9d31953fc5640999adcc8b74a54dfde0e651:

example: fix cppcheck complaints about constifying pointers (2026-05-04 16:22:44 -0700)

----------------------------------------------------------------
libfuse: new mount service container fixes [02/10]

This is a collection of bug fixes and cppcheck cleanups for the new fuse
service container code.

With a bit of luck, this should all go splendidly.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (10):
util/mount.fuse.c: loop in waitpid
fuse_service: handle weird behavior during SCM_RIGHTS fd transfers
examples: improve documentation of the new systemd service fuse servers
example/single_file: sync backing fd when statx wants us to fsync
example/single_file: fix ctime handling
libfuse: fix cppcheck complaints about constifying pointers
libfuse: fix cppcheck complaints about constifying pointers in user-visible ABI
util: fix cppcheck complaints about constifying pointers
fuser_conf: fix cppcheck complaints
example: fix cppcheck complaints about constifying pointers

example/single_file.h   |  6 +++-
include/fuse_service.h  | 18 ++++++------
example/service_hl.c    | 20 +++++++++++--
example/service_ll.c    | 20 +++++++++++--
example/single_file.c   | 31 ++++++++++++++++----
lib/fuse_service.c      | 76 +++++++++++++++++++++++++++++++++----------------
lib/fuse_service_stub.c | 17 ++++++-----
util/fuser_conf.c       |  9 +++---
util/fuservicemount.c   |  2 +-
util/mount.fuse.c       |  4 ++-
util/mount_service.c    | 68 ++++++++++++++++++++++---------------------
11 files changed, 183 insertions(+), 88 deletions(-)


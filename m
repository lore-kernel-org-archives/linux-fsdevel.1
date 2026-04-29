Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60042277C9D;
	Wed, 29 Apr 2026 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472372; cv=none; b=Z9VsHa4W0dy6QXvlQckd9yjh+V0kroMY639e0FyjoNYKZnGtUopBp8mGfi5QFE9ebLl/kw8opAOIRRqn/hwc1v8vYMq7bsj35q4QgmcBg21n7EkPjgdTHVVAnEguT23J3iYHhvAAI/ca6T2kiH3juO5mgtULMPYd1ItBE2gcoNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472372; c=relaxed/simple;
	bh=/nVcpwnyFbjxldB444KbpIXwlBaCAl5v4S3AiO8gVp8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9AkcUdtLFQj2zotCtVxJnm2gTxRhcegUPOJ/Vexh9jV7ve/J0zMRHo/z9RwWzHvEQ20i2K0GOLW9iuVtXjb/+rrrPXbdebjA6BbEsPU/WNKSDakB2btrRBuRcQanIvzkzbnZ6gs6xqSiDDMSZ2ypkI6G4MBjEfd1VgtNqYYneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6/99oLz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6/99oLz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16179C19425;
	Wed, 29 Apr 2026 14:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472372;
	bh=/nVcpwnyFbjxldB444KbpIXwlBaCAl5v4S3AiO8gVp8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=d6/99oLzWcV5mJ7MZ7MmLX0r0M19HwKuMDLxA8dU5omP2mO6U9s6cjN9JUNMl56AD
	 gKs9lOwm6kSCwGVV6+50b7rvnAcEzVmBqK57R8wo/05TYp87946FRoprN+Dk24+jsW
	 NFuBMIc/sdqhmj4F7136IXaisPcYKSdJkI6zp6SkzsB/V6Wzi4AatccWMBygPncizU
	 dC9LmeKrjhljJk2Psew1r9hl5rVy5wnFLArCtURTvrdu67cu/TWjXFUF/aicdO+sQW
	 oHj5BECLLDv0nnauTLDmg1ughjLFDtbq3u+zFkX4NIFXjs1OK4hv/wAWV1BWBsDJKH
	 jLt/fZavZ+wmg==
Date: Wed, 29 Apr 2026 07:19:31 -0700
Subject: [PATCHSET v8 4/6] libfuse: add some service helper commands for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747212630.4105892.8288935565208062403.stgit@frogsfrogsfrogs>
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

There are a few privileges that fuse-iomap servers need to ask of the
kernel, such as asking for iomap support, being able to configure loop
devices if a passed in filesystem path actually points to a regular
file, and setting the block size once we've parsed the superblock.
Because fuse-iomap services are supposed to run with zero privileges,
these three things must be performed by the fuservicemount program,
which presumably has more privilege (and the correct mount ns) than
the fuse server itself.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * mount_service: delegate iomap privilege from mount.service to fuse services
 * libfuse: enable setting iomap block device block size
 * mount_service: create loop devices for regular files
---
 include/fuse_kernel.h       |    8 +++
 include/fuse_lowlevel.h     |   22 ++++++++
 include/fuse_service.h      |   17 ++++++
 include/fuse_service_priv.h |   14 +++++
 lib/fuse_lowlevel.c         |   19 +++++++
 lib/fuse_service.c          |   48 +++++++++++++++++
 lib/fuse_service_stub.c     |    6 ++
 lib/fuse_versionscript      |    3 +
 util/mount_service.c        |  119 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 254 insertions(+), 2 deletions(-)


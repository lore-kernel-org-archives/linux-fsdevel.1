Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CA442050
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311581; cv=none; b=W3wngmcNE1Ic9W3ot/Z74RYBMpGypmVV0b757QTw4aXn0bjGUQO4BRfhJjhxGJBhDo6VkMyt77BLWiZ+6ElR2MS50a97Qu2QAKQbtwvzehvKpeadwQJTs4OTW+rLunnRCJEx65ajVFUW1JkEZUnalsgBodlGNJpa29+QlJ00DgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311581; c=relaxed/simple;
	bh=dfdDcLuVJ1WubZ3KG9CKYDHmniXpx0oGw8/poIVGs8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E00H5aIpvwsJa5j66/jnY+QD1yc2Ax6X2ErRswzn6LFxRjNqWW9JNNyFZhJ5H91HXq/wsSe/y6Y7x55YFc0/RCPBg9zeHU/emT9tFMOgOruc7y6tlK/V7hu1M24v7d0E/mR+8vWSiWXwAwLU4c4USLw6t5BszHSRNLyiknxTzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldxwk0zT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldxwk0zT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2BDC4CEF7;
	Tue, 24 Mar 2026 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311581;
	bh=dfdDcLuVJ1WubZ3KG9CKYDHmniXpx0oGw8/poIVGs8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ldxwk0zT+5zEO5e1ibBnvTcCf/ASm/wnx4PxnsE2PM8uYAsvtPCLHaaz8ZWIaHRc3
	 gXc/PJMlFAgMbgoxVQQn2G4eIlwcfoW22vFRi5g64kSXCbmax0HDW7D5J59Re4VYAI
	 NR9J9kIwbh11c2Al+2UsR3gNpd2mOYciUqRX41xFF8kaVHE+x6PExE51CegKgcRnbU
	 vnnJXi/m/Ck2iyoPiDZZcUdLvCU3KYGKvit0+9vsZLZPJgghWMVX/sgGcDr9AmSFpm
	 IOviiFKQ0xelI3k7bop0oyFXQKEFutmsBIVK6mTrOAeP4UGWjZYTSTgsUJEAt784qd
	 s/pPsHypk90mw==
Date: Mon, 23 Mar 2026 17:19:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH 00/19] libfuse: Add support for synchronous init
Message-ID: <20260324001940.GR6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>

On Mon, Mar 23, 2026 at 06:44:55PM +0100, Bernd Schubert wrote:
> I'm taking Darricks example here and posting API changing libfuse
> changes to linux-fsdevel. We should consider to create a fuse

O^o

> specific list if that is too much. The existing
> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
> of spam filtering.

Yeah, it'd be nice to have a separate list, fsdevel is drinking from the
firehose.

> The first few patches in this series are just preparation, after that
> follow the important parts:
> 
> 1) New daemonize API, see that commit for details. In short, the existing
> fuse_daemonize() was not sufficient for complex daemons and is impossible
> to use with sync-init and the current way to start fuse-io-uring ring
> threads.
> 
> 2) Support for privileged daemons, still rather straight forward, but
> requires the startup of a worker thread that handles requests until
> mount is complete.
> 
> 3) Privileged daemons - requirement is to update the API with fusermount,
> because fuse_session_mount_new_api() needs to obtain the /dev/fuse file
> descriptor, then start the worker thread with that fd and then continue
> the actual mount through fusermount.

Heh, I'll get back to the last part tomorrow.

--D

> To: linux-fsdevel@vger.kernel.org
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Joanne Koong <joannelkoong@gmail.com>
> 
> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
> ---
> Bernd Schubert (19):
>       ci-build: Add environment logging
>       Add 'STRCPY' to the checkpatch ignore option
>       checkpatch.pl: Add _Atomic to $Attribute patttern
>       Add a new daemonize API
>       Sync fuse_kernel.h with linux-6.18
>       mount.c: Split fuse_mount_sys to prepare privileged sync FUSE_INIT
>       Add FUSE_MOUNT_FALLBACK_NEEDED define for -2 mount errors
>       Refactor mount code / move common functions to mount_util.c
>       Move mount flags to mount_i.h
>       conftest.py: Add more valgrind filter patterns
>       Add support for the new linux mount API
>       fuse mount: Support synchronous FUSE_INIT (privileged daemon)
>       Add fuse_session_set_debug() to enable debug output without foreground
>       Move more generic mount code to mount_util.{c,h}
>       Split the fusermount do_mount function
>       fusermount: Refactor extract_x_options
>       Make fusermount work bidirectional for sync init
>       New mount API: Filter out "user="
>       Add support for sync-init of unprivileged daemons
> 
>  .github/workflows/checkpatch.yml |   2 +-
>  checkpatch.pl                    |   3 +-
>  doc/README.daemonize             | 186 +++++++++++
>  doc/README.fusermount            | 359 +++++++++++++++++++++
>  doc/README.mount                 |  86 +++++
>  doc/README.sync-init             | 184 +++++++++++
>  example/passthrough_hp.cc        |  18 +-
>  include/fuse_daemonize.h         |  71 +++++
>  include/fuse_kernel.h            |   1 +
>  include/fuse_lowlevel.h          |  24 ++
>  include/meson.build              |   3 +-
>  lib/fuse_daemonize.c             | 292 +++++++++++++++++
>  lib/fuse_i.h                     |  27 +-
>  lib/fuse_lowlevel.c              | 342 +++++++++++++++++++-
>  lib/fuse_versionscript           |   4 +
>  lib/helper.c                     |  13 +-
>  lib/meson.build                  |   6 +-
>  lib/mount.c                      | 380 +++++++++++++++-------
>  lib/mount_bsd.c                  |   1 +
>  lib/mount_common_i.h             |  29 ++
>  lib/mount_fsmount.c              | 417 ++++++++++++++++++++++++
>  lib/mount_i_linux.h              |  87 +++++
>  lib/mount_util.c                 |  34 ++
>  lib/mount_util.h                 |  11 +
>  meson.build                      |  19 +-
>  test/ci-build.sh                 |  16 +
>  test/conftest.py                 |   7 +-
>  test/test_want_conversion.c      |   1 +
>  util/fusermount.c                | 671 +++++++++++++++++++++++++++++++--------
>  util/meson.build                 |   2 +-
>  30 files changed, 3024 insertions(+), 272 deletions(-)
> ---
> base-commit: 9eba0f3c9e8b5af7b252093bb6f81f086bb35563
> change-id: 20260323-fuse-init-before-mount-8f5b09a1acf1
> 
> Best regards,
> -- 
> Bernd Schubert <bernd@bsbernd.com>
> 
> 

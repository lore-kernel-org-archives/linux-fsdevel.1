Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35915ECCC;
	Wed,  3 Jun 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445692; cv=none; b=mr4FAWlb1jpkFc5Uxpj5XlLN/TeUvuZpBFk+cfgt8Q85HXCLkA0JBYGEek6iTITO9l4Ewgkgyi7VK+k91Y+SLe40Y5u5kiBbR8pdqMrPI26eRheSIbZCyW/O/vy3Ue1TqI9QrKsX5Bu1WySSbYSn3+OEKxDF2XSIVm0fczjylrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445692; c=relaxed/simple;
	bh=RTitsIen/o6vL/dUfs6mEVt//9GjF0tk8LWKw6srQMw=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=hN2gi/OXN7chkpbZBvvFm1irfZj5x82pvOh3A2AyfCQw6i/yAZMbfxv0TjLe9FjOtsLIsnjAuXmIlQAJfg1Sq1NhApWdrakVGzbxgLv4AxHDvhqlTakK4d0r6HWa+YJtFZ9QJ+gDsG8drYhjfS65JRE95HhPNCur8E1y7WxuHt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYUand6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYUand6N"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C279A1F00893;
	Wed,  3 Jun 2026 00:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780445690;
	bh=p46Te7J3Box5Onk/FtMNgfLNiFzKv2ljcelkJAyFfPg=;
	h=Date:Subject:From:To:Cc;
	b=gYUand6Nco+R54ZxfWezbQikEtfDiJEWXb/beISwZ/VglXWjFHmgJeTNQ/7rWV4m0
	 8DkGMJF//IlSEkge3BpOd+M3EgP56kGteYkKSBKTbDaa9n3rkRNCKrHgIIUKjgy+zW
	 sd98xvZlN6GEFVphaUMFcEAzhEHsC6wB2/pPmuSUyMmnp50K+SDAu7IVpR2LIDH+Oz
	 siqMIWRPZlfH0mMZL9i3xzX36dSt14GHe6Oc0UhNdZILbUT302YRA4KmQr0l3z3TIN
	 U+nmz8WsCoNFDstEVDPYD0NJF83ehgf/QUSg+hkvKn7Jm4z0x2oMUrb6p4QJT29sFU
	 8wqsO+6MjwBZA==
Date: Tue, 02 Jun 2026 17:14:50 -0700
Subject: [PATCHSET v2] libfuse: more random fixes for fuse service containers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Message-ID: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here are some miscellaneous fixes for libfuse.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * fsmount: don't truncate ms_flags in set_fsconfig_ms_flags
 * mount_service: don't pass the chopped buffer to apply_fsconfig_mount_opts
 * mount_service: call the new fsmount ms_flags helpers in the right order
 * mountservice: improve checking of protocol version
 * mountservice: don't print bdev preparation error when quiet mode is enabled
 * mountservice: advertise fuseblk support
---
 include/fuse_service.h      |    8 ++++++++
 include/fuse_service_priv.h |    4 +++-
 lib/fuse_service.c          |   35 +++++++++++++++++++++++++++++------
 lib/fuse_versionscript      |    1 +
 lib/mount_fsmount.c         |    5 ++++-
 util/mount_service.c        |   33 ++++++++++++++++++++-------------
 6 files changed, 65 insertions(+), 21 deletions(-)


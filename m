Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2B74C14;
	Thu, 11 Jun 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140352; cv=none; b=j2i58ZsuT9BdyL2xiI5hFeRgEFgnWnbhNu5yZWOfjEAE2JfxBlGEYEcaGJPpIYcezWCXBgLWGMopbkk5iR3fg1C3smSPmWFXUKRLpuRZq4AHaA0rH2r6pjb7WDvejFmppeL/wfMEjlJSGnuvOdvoyOkJLunP9ZYZeUVaUCXt49E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140352; c=relaxed/simple;
	bh=wESWZ2v7Bba+w/LRD5CqkwGpKrsXHxjwoevZFQTqR5g=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=m0LkA6HI8D8MKJth/RLTUaPQ71VcoChL3yGmPfoHjo6VgXU+2qPOtlyjG1Y23+2hvQAdAchqiuJ0faZer2T0yy1P2Cf07sLA2rTTK1MQkiVnaircPGPm584aXFyRNkqC5n0fKEGrIR3Oj9Ld4YgNXHDKLfkV2/i7Nk8HdSvs2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUJjVdgE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUJjVdgE"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 881791F00893;
	Thu, 11 Jun 2026 01:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140351;
	bh=dTNoxLl54oBuHJhcuvng8eTF6JrLNX17n3l6q4ruU3w=;
	h=Date:Subject:From:To:Cc;
	b=TUJjVdgEXnY5EwrbVeEiYSCLxOyoUXVX2VVu/HXbPstgj7VxYY4uxtQivDk1CD6Xx
	 t075t5u0JbO2sCITyygkLp34lfsQ7gyzW+wM1RuRxEh+4OKTQGs2+r9GjdcD8268nE
	 OycUQ2l/6x4ZzAQjwdGU6T7LB9rlIvcct04BXB4qfEfRMoYMEuCQGzsCcuOnH/iEaS
	 kwSbhUnMdr5tEIjkO5MCkhjje1EYqXTaOFsX3q+V04GOFs9zkawFoah58pdwQtoqUh
	 qDywWTMfhWOKMXU8Mcuzj9HZ5TXnE1EGwFp63tbi7bThvdq1EtN7fesMr35RozQrhz
	 PFiwh9WH0g/yA==
Date: Wed, 10 Jun 2026 18:12:31 -0700
Subject: [PATCHSET v3] libfuse: more random fixes for fuse service containers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
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

v3: correct complaints from maintainer, remove umount command
v2: add a few more patches

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
 * libfuse: remove unmount command from the service api
---
 include/fuse_service.h      |   16 ++++---
 include/fuse_service_priv.h |    9 +---
 lib/fuse_service.c          |   86 +++++++++++++---------------------------
 lib/fuse_service_stub.c     |   10 ++---
 lib/fuse_versionscript      |    2 -
 lib/mount_fsmount.c         |    5 ++
 util/mount_service.c        |   93 ++++++++++---------------------------------
 7 files changed, 71 insertions(+), 150 deletions(-)


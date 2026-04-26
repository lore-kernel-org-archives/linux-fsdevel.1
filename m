Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506852222C5
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777221318; cv=none; b=lny2pWzhRLsL8RjE1SE0Wn8Ps2gSWJ4b88/JWihx96QJ70co7JbiS4GTTDmloPCnDvL1gVsq4qUQMmSFVIK94d2KjDsauo2CYWsPigTIIJ3nbIiILrhAqsR2AF8QH2NJpwvf/jHb3C9YrixqO/5Fdhj7lTAcx95sG0/GrRXKhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777221318; c=relaxed/simple;
	bh=wgsGwtQgl3/TOyt/X61eyngzg+BV68ZwWvix9clxdbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2BtUFBx/JbTiq7BrUcwPpPiUCtnfz+hh8sIUGWhDJ9b7/iufKse1JqWgVgzuFyBy4sn8kMkuPJIDALusXHdSkjZK9gOEw4XSpE5ONVhdp817f62yia9SB6J5j9hw9Ub+at5fJoY+f6xb9mW3OH1HMM92aghZEUzUlUgurUXND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=GImyECnm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvuExcyS; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="GImyECnm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvuExcyS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 89EAAEC045E;
	Sun, 26 Apr 2026 12:35:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 26 Apr 2026 12:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777221314;
	 x=1777307714; bh=YopMbZdvoRW6SyRPRA35xgUC22bgnBIET2QlW5gu5ko=; b=
	GImyECnmccSQ2KZXRwCCeXNWKSc4FycW6XS+Oz8syxlsESdjQ0aFlCzzS5Y/3noY
	qU18txJu80O9JJCj4khLykXK+jX/XuaQ1j6N3mEG112h2wkM9962D8KxvxEdjlHN
	NmWBjsPypghHNrn5JYLwhkoiE8SFVtz5WPk+3nhUWu5DY5Ahcu3evyd3oD2S3eCa
	D1FB1rDC+gdBG3qfDulbYaszEKz6e1traFLGyV4dUMs5oHMz1HU8DG99FgqshCqL
	DbN9EcrGlAXbt7RM2UtQkrxn1Jci8rcdcVsHs9rr0fY3n0NGg8x7SIAb1lxN20R7
	ctvVGIgd1AeHZewt80okzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777221314; x=
	1777307714; bh=YopMbZdvoRW6SyRPRA35xgUC22bgnBIET2QlW5gu5ko=; b=H
	vuExcyS55bvDsZHGKINfyU/HA9qv4H3RVNux1GCRNWs9SXKknBIv8ZQywHS5g18b
	zBkr/VJSospzAfoLnLqCR0frzW1FClnaaW0BQOOsnD3+OF0AfhO7uFBRFpVyDJp1
	iUyH6LhFY0d/OV5AB4MPfWvsPdeixrOYCdX8deiMuuutSG7PmucjTunZStsmrEt5
	3gjYON8wSQgNpgZqJqaLO2toZA2E9/VBwlZJClRno862bHXCVabF5s0mgNJpXNDB
	BlsyYzOCaBtvfWqb5+Pzgc0arkljFFW0GLxCU3INUqI5hHgI0E2cO7qNR9h7leiv
	Cb/AZ3jzW9tCbtYWfEOkw==
X-ME-Sender: <xms:wj7uaeKMl0hAQs5BsRoLTygfX1AHi4s3I8-kb-2mlPIlBW170WT55w>
    <xme:wj7uaW12IXzQmz6JGdbNOMpN25uY3qQNoCi-FofWBhmaNrIIrhRGD_G8WL4SK3zIj
    dRXcPj1uX_565Vz_avccOCvMo1zGJ5_MwGbWnFOy8KrPK0hWzM>
X-ME-Received: <xmr:wj7uac4u1uSe0FZJcfHPm-weD6s_lQoj7mnkdgwD2U2Zr9D2v2jc7J-94QK_8Cp0MIUkW2jz7UF5EZxUAg-JAmISSGYXjEeo-PHulB7fp8pE0I4Xgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepueehffekueejkeetleeiveduveeiveegveeutdfgudejtdfgjeekheekvddu
    tedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhotghkvghtrdhinhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegs
    shgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghs
    tghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehnvggrlhesghhomhhprgdrug
    gvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehfuhhs
    vgdquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:wj7uaX9hdPk7OPCLncvfIgwa2W5tnW-eDjlTwrB691Tw9c5oBP1S8w>
    <xmx:wj7uabX4Ez3-X3slEiNv2lbxXGZzTKCgtWurARfycuo3vy68jK4I5A>
    <xmx:wj7uaSp-OL5OuH85VpVO2W_UY1eXCMwVsEb6FiSELM1VP2bd0BI5WA>
    <xmx:wj7uadkxrA0d_PhIUIbRJG2r1fmCn2kxuBEs38XPlFm2XiKjX8zy3w>
    <xmx:wj7uaZcjopluOi-lipfAMqsw4o1p-3dgTCeVVkeOBkDdcpg7dt1Rbam_>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 12:35:13 -0400 (EDT)
Message-ID: <eed525ff-8f83-4882-a5db-574d2d3a913e@bsbernd.com>
Date: Sun, 26 Apr 2026 18:35:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v5] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 joannelkoong@gmail.com, miklos@szeredi.hu, fuse-devel@lists.linux.dev
References: <20260422231518.GA7717@frogsfrogsfrogs>
 <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/26 01:18, Darrick J. Wong wrote:
> Hi all,
> 
> This patchset defines the necessary communication protocols and library
> code so that users can mount fuse servers that run in unprivileged
> systemd service containers.  That in turn allows unprivileged untrusted
> mounts, because the worst that can happen is that a malicious image
> crashes the fuse server and the mount dies, instead of corrupting the
> kernel's memory.
> 
> v5: Refactor socket IO into helpers, tighten the security checks in
>     mount_service.c, always set nosuid/nodev for unprivileged mounts,
>     use posix_spawnp in mount.fuse, restructure sample programs and hl
>     library code to avoid the need for unmounting during startup
> v4.1: fix various cppcheck/codecheck complaints
> v4: fix a large number of security problems that only matter when the
>     mount helper is being run as a setuid program; fix protocol
>     byteswapping problems; add CLOEXEC to all files being traded
>     back and forth; add an umount command; and strengthen mount socket
>     protocol checks.
> v3: refactor the sample code to reduce duplication; fix all the
>     checkpatch complaints; examples actually build standalone;
>     fuservicemount handles utab now; cleaned up meson feature detection;
>     handle MS_ flags that don't translate to MOUNT_ATTR_*
> v2: cleaned up error code handling and logging; add some example fuse
>     service; fuservicemount3 can now be a setuid program to allow
>     unprivileged userspace to fire up a contained filesystem driver.
>     This could be opening Pandora's box...
> v1: detach from fuse-iomap series
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.
> 
> --D
> 
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container

Hi Darrick,

going to look for your previous pull request - kernel tree doesn't help
me for libfuse ;)

Bernd

> ---
> Commits in this patchset:
>  * Refactor mount code / move common functions to mount_util.c
>  * mount_service: add systemd socket service mounting helper
>  * mount_service: create high level fuse helpers
>  * mount_service: use the new mount api for the mount service
>  * mount_service: update mtab after a successful mount
>  * util: hoist the fuse.conf parsing and setuid mode enforcement code
>  * util: fix checkpatch complaints in fuser_conf.[ch]
>  * mount_service: enable unprivileged users in a similar manner as fusermount
>  * mount.fuse3: integrate systemd service startup
>  * mount_service: allow installation as a setuid program
>  * example/service_ll: create a sample systemd service fuse server
>  * example/service: create a sample systemd service for a high-level fuse server
>  * nullfs: support fuse systemd service mode
> ---
>  example/single_file.h                            |  191 ++
>  include/fuse.h                                   |   34 
>  include/fuse_service.h                           |  243 +++
>  include/fuse_service_priv.h                      |  161 ++
>  lib/fuse_i.h                                     |    3 
>  lib/mount_common_i.h                             |   22 
>  lib/mount_util.h                                 |    8 
>  lib/util.h                                       |   35 
>  util/fuser_conf.h                                |   62 +
>  util/mount_service.h                             |   49 +
>  .github/workflows/install-ubuntu-dependencies.sh |    4 
>  README.md                                        |    3 
>  doc/fuservicemount3.8                            |   32 
>  doc/meson.build                                  |    3 
>  example/meson.build                              |   26 
>  example/null.c                                   |   51 +
>  example/null.socket.in                           |   15 
>  example/null@.service                            |  102 +
>  example/service_hl.c                             |  224 ++
>  example/service_hl.socket.in                     |   15 
>  example/service_hl@.service                      |  102 +
>  example/service_ll.c                             |  313 +++
>  example/service_ll.socket.in                     |   15 
>  example/service_ll@.service                      |  102 +
>  example/single_file.c                            |  970 ++++++++++
>  include/meson.build                              |    4 
>  lib/fuse_service.c                               | 1220 +++++++++++++
>  lib/fuse_service_stub.c                          |  106 +
>  lib/fuse_versionscript                           |   18 
>  lib/helper.c                                     |  160 ++
>  lib/meson.build                                  |   17 
>  lib/mount.c                                      |   72 +
>  lib/mount_util.c                                 |    9 
>  meson.build                                      |   53 +
>  meson_options.txt                                |    9 
>  test/ci-build.sh                                 |   14 
>  util/fuser_conf.c                                |  396 ++++
>  util/fusermount.c                                |  363 ----
>  util/fuservicemount.c                            |   65 +
>  util/install_helper.sh                           |    6 
>  util/meson.build                                 |   24 
>  util/mount.fuse.c                                |  169 ++
>  util/mount_service.c                             | 2111 ++++++++++++++++++++++
>  43 files changed, 7197 insertions(+), 404 deletions(-)
>  create mode 100644 example/single_file.h
>  create mode 100644 include/fuse_service.h
>  create mode 100644 include/fuse_service_priv.h
>  create mode 100644 lib/mount_common_i.h
>  create mode 100644 util/fuser_conf.h
>  create mode 100644 util/mount_service.h
>  create mode 100644 doc/fuservicemount3.8
>  create mode 100644 example/null.socket.in
>  create mode 100644 example/null@.service
>  create mode 100644 example/service_hl.c
>  create mode 100644 example/service_hl.socket.in
>  create mode 100644 example/service_hl@.service
>  create mode 100644 example/service_ll.c
>  create mode 100644 example/service_ll.socket.in
>  create mode 100644 example/service_ll@.service
>  create mode 100644 example/single_file.c
>  create mode 100644 lib/fuse_service.c
>  create mode 100644 lib/fuse_service_stub.c
>  create mode 100644 util/fuser_conf.c
>  create mode 100644 util/fuservicemount.c
>  create mode 100644 util/mount_service.c
> 


Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2A2F39C7
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777238485; cv=none; b=K1bXHu0aJBnnrTT+LRb5RRqjFQv7uknbsSpvmsFx2EPbeFKWUwbSeghiBTaGp4JKu1HwBIlL9hbmiGDnKzy4BDe6a1knyBYavIjOeGbgtdzNAYC8Z4dQubYkhPTlnNQGFPJcR+awgoKShfs5KFRH8xNTXFd2gIt9zLDtJNYIOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777238485; c=relaxed/simple;
	bh=daeHzHD5FNZ9eqYIpkPXbkavh+Co0XRQWbRhIkurwco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C06hDaaUjOvHFtB58PYHpjuP4+MdvXPEJ2t7sWTP1qMIxD5MvOvHuMD02VpIDKNn3rM4eZfQRGW5pRd4XbiuuKgQocqGhrwDZSr9YV2crEQJp6zRO+bH9yA2pEjhlSmtcqr/WacWQqWyunLnfGe/tfA+ZNLs5MUFC6FzULlPGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=YSQ+X5tN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHO8R1ph; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="YSQ+X5tN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHO8R1ph"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 00831EC0549;
	Sun, 26 Apr 2026 17:21:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 26 Apr 2026 17:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777238482;
	 x=1777324882; bh=j0rOpMQdLcpPE5xaz140RI/X4cK77fpWqGuQBLM3s0Y=; b=
	YSQ+X5tNckRCUfBsI0C+1h5RTe+N/2wg8ejnx+o0HLTbKOPZSvHl4dWe2Jn/hJQb
	Ldb2qeDAMJY7IrLEwTkWFD9Kd5S7YyQA8pcwUh6MTp0nebxmiTBt1bMEs/bfQ09y
	1M87Fp4/h8PD6q/T8xDnhfpRUas1R6k8q8tDLODHWsDqVMyse0/sZ0W5uPr9AXSe
	asgulQdn4KSP47MHy/Wd4Lvz3cUi6ivoWHLCBp3169uV0Oz90pZNGyPS01SrnHbf
	lG0cqbJG+SOcqI6Qxj3Aht3NpWdAWyZXQsb+sZo4T2OKNONZXE8jegGVSqgCcxDM
	lV+otgDEuxCenXAHn5zkLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777238482; x=
	1777324882; bh=j0rOpMQdLcpPE5xaz140RI/X4cK77fpWqGuQBLM3s0Y=; b=f
	HO8R1ph6HkRqKVjrUKe0rrpla/vpPmsIbl+QlTXEXzxww9vped6wD+5m3sOCZKIa
	Wsmc/5nqmteQGUOTezTAzXkK0dbO4nHB/uuOUHG+s1HfrzoccynLKeUAJi6TdBdc
	ZtW2DC4Pr57SY5swt880wHFUuwosulUm/160UbByPcmQrojtUJCc8OjGCOwEZzkS
	MSx6ippTdMEA7qQUj8ri3p+U//lrqQY0NjtKOJ++vlyNZrY32EsFKZ5WPURQ4Iyp
	iK9ZUny3ckMk7aoSFdahbhDylPIXEcEq5z3xcXMI1533KzPcLTIXuGNg9Dh8TMnh
	CjuNoEeIxaM1Xb1EF93og==
X-ME-Sender: <xms:0oHuaXK2-CW4Q9v-09uD1pFsT6LJ8_OVoGLn6mgJQnTrRjhUM-UbEA>
    <xme:0oHuaUeK1Y-fFqSqd1u_bi75d7zDz_0aUYDF0h_st3OCbevM-Wewo2P8TTaNa1kpg
    GA8yaoTjsuY5PlOVbMPadhMPvXrG3hLUg7XIMMYtS_uxOtPeCyVww>
X-ME-Received: <xmr:0oHuaW95EYquw07PfTAyTNwGT9GAlaz8dD0cWpTnFyjlu57JZjkApz8e89qeuBoPoV4uFsqrEpoAUf_8NmFeAL5CpeUCcviyw-FjbgxqortE_8xcSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepjefgieelkeehteffudeitdelleeilefffeduheejfefghffhvedvtdfhhfeh
    iefgnecuffhomhgrihhnpehsohgtkhgvthdrihhnnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfi
    honhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggrlhesghhomhhprgdruggv
    vhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehfuhhsvg
    dquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:0oHuaRqNDkD0wPnyD9KGz-J9JSSXkNzv_TDbt0f87i8wymOAFT0t6w>
    <xmx:0oHuabDm9wbWOHT7-wavqOoKF1t_ctRimm8N8woWFcL9JE0VyrTqOA>
    <xmx:0oHuaTxd3flkvs3Zd_N4IaCx5iOTMkuveHl8mSydRka9cVkL1aItRA>
    <xmx:0oHuaY12mCvH66BaT-yYbKemncEJB8zZf-bbUdIHFfNRQmBU1G-Syw>
    <xmx:0oHuadAxzP7MQ0H-5tN_viAVnGgu1B7fwxQ4wTcGIrO3pB6PVBDEdDYl>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 17:21:21 -0400 (EDT)
Message-ID: <5b50e0a7-fe4b-4af4-a765-a91d21ab3852@bsbernd.com>
Date: Sun, 26 Apr 2026 23:21:21 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] example/service: create a sample systemd service
 for a high-level fuse server
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
 miklos@szeredi.hu, fuse-devel@lists.linux.dev
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <177689988756.3820166.5462739027142309789.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <177689988756.3820166.5462739027142309789.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/26 01:22, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a simple high-level fuse server that can be run as a systemd
> service.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  example/single_file.h        |   38 ++++++
>  example/meson.build          |    6 +
>  example/service_hl.c         |  224 +++++++++++++++++++++++++++++++++++
>  example/service_hl.socket.in |   15 ++
>  example/service_hl@.service  |  102 ++++++++++++++++
>  example/service_ll.c         |    1 
>  example/single_file.c        |  271 +++++++++++++++++++++++++++++++++++++++---
>  7 files changed, 640 insertions(+), 17 deletions(-)
>  create mode 100644 example/service_hl.c
>  create mode 100644 example/service_hl.socket.in
>  create mode 100644 example/service_hl@.service
> 
> 
> diff --git a/example/single_file.h b/example/single_file.h
> index d8a91adbf875ef..86edb51afb3384 100644
> --- a/example/single_file.h
> +++ b/example/single_file.h
> @@ -124,6 +124,7 @@ ssize_t single_file_pread(char *buf, size_t count, off_t pos);
>  
>  /* low-level fuse operation handlers */
>  
> +#ifdef USE_SINGLE_FILE_LL_API
>  bool is_single_file_child(fuse_ino_t parent, const char *name);
>  bool is_single_file_ino(fuse_ino_t ino);
>  
> @@ -149,5 +150,42 @@ void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
>  
>  int reply_buf_limited(fuse_req_t req, const char *buf, size_t bufsize,
>  		      off_t off, size_t maxsize);
> +#endif
> +
> +/* high-level fuse operation handlers */
> +
> +#ifdef USE_SINGLE_FILE_HL_API
> +bool is_single_open_file_path(const struct fuse_file_info *fi, const char *name);
> +
> +int single_file_hl_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
> +			   off_t offset, struct fuse_file_info *fi,
> +			   enum fuse_readdir_flags flags);
> +
> +int single_file_hl_statfs(const char *path, struct statvfs *buf);
> +
> +int single_file_hl_statx(const char *path, int statx_flags, int statx_mask,
> +			 struct statx *stx, struct fuse_file_info *fi);
> +
> +int single_file_hl_getattr(const char *path, struct stat *stbuf,
> +			   struct fuse_file_info *fi);
> +int single_file_hl_chmod(const char *path, mode_t mode,
> +			 struct fuse_file_info *fi);
> +int single_file_hl_utimens(const char *path, const struct timespec ctv[2],
> +			   struct fuse_file_info *fi);
> +int single_file_hl_chown(const char *path, uid_t owner, gid_t group,
> +			 struct fuse_file_info *fi);
> +int single_file_hl_truncate(const char *path, off_t len,
> +			    struct fuse_file_info *fi);
> +
> +int single_file_hl_opendir(const char *path, struct fuse_file_info *fi);
> +int single_file_hl_open(const char *path, struct fuse_file_info *fi);
> +
> +int single_file_hl_fsync(const char *path, int datasync,
> +			 struct fuse_file_info *fi);
> +#endif
> +
> +#if !defined(USE_SINGLE_FILE_LL_API) && !defined(USE_SINGLE_FILE_HL_API)
> +# warning USE_SINGLE_FILE_[HL]L_API not defined!
> +#endif
>  
>  #endif /* FUSE_SINGLE_FILE_H_ */
> diff --git a/example/meson.build b/example/meson.build
> index e948f6ba74fdfa..19a383f7cd2c74 100644
> --- a/example/meson.build
> +++ b/example/meson.build
> @@ -19,6 +19,12 @@ if platform.endswith('linux')
>      configure_file(input: 'service_ll.socket.in',
>                     output: 'service_ll.socket',
>                     configuration: private_cfg)
> +
> +    single_file_examples += [ 'service_hl' ]
> +    configure_file(input: 'service_hl.socket.in',
> +                   output: 'service_hl.socket',
> +                   configuration: private_cfg)
> +
>  endif
>  
>  threaded_examples = [ 'notify_inval_inode',
> diff --git a/example/service_hl.c b/example/service_hl.c
> new file mode 100644
> index 00000000000000..9c4f3ae7a6cf3c
> --- /dev/null
> +++ b/example/service_hl.c
> @@ -0,0 +1,224 @@
> +/*
> + * FUSE: Filesystem in Userspace
> + * Copyright (C) 2026 Oracle.
> + *
> + * This program can be distributed under the terms of the GNU GPLv2.
> + * See the file GPL2.txt.
> + */
> +
> +/** @file
> + *
> + * minimal example filesystem using high-level API and systemd service api

Could you add a bit more context?

- Shows how to build a high level FUSE filesystems that can be managed
by systemd
- Enables on-demand filesystem mounting via socket activation
- Allows running FUSE servers with minimal privileges (unlike
traditional FUSE which needs mount permissions)


Thanks,
Bernd

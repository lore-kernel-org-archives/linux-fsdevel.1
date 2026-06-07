Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DA2E7362
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780867326; cv=none; b=leGZTRlp5hjymf7oDqwFMAHZjRFAw3nYELb5FXC0hn+Bvu4TIrXd4h3FZqAgW+5c06pwzDh5nE13fnP5SbBOigF8ihTBMSegbPYKo1tRN+g1lQAR8QESSA/59/M9ZE/8DW2ODxvfru82s7sNSV39CUdkw+bu0xDnC1+Pji95evg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780867326; c=relaxed/simple;
	bh=9/t8TQC0LhYRtQQAfU1vQtfIPZbaVprYeumBQ0YkP6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eesCnB07iIwL7BtfMu0Lv9jlcCrdaKSdcCALy2mNfPqcxJ7ZqoXxaSxXQPiqwkKV+oVyOknDTnNdGmgcimPAnHkWH7oUh5FuSa1Ob75i8cv6Nf28qSzO9MyoJNifBPAyGYc5XN++ntPthLk8ZCebQ1r9xqdUQRQwrR4Tk7IbFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=L1UlL9CO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAa5WOjq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="L1UlL9CO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAa5WOjq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6910E140004D;
	Sun,  7 Jun 2026 17:22:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 07 Jun 2026 17:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1780867323;
	 x=1780953723; bh=16h7VWs/CXTplT9EuLaOczvUspL1w+5USl6ftBNRwXw=; b=
	L1UlL9COGk0J4nWX87afobw9uKhh1mqOseVjtoFze/BtQKR34OYZyFIeVn+KaXBS
	2MLGjc6J8GvLORiT5uSl2fp1O/TCNn57B53Gb9yk+rGVICopopKEuktqofryfRE3
	OgmIu67j4pmC2L5istoEnHTaGz5AHqsmA28IUw/cFzGnW3gHCcv2QfE1T6RGokca
	8MIP6M/HfO0JD08gkviaXxiR9xyNrpQow6G3HuP+D6g1rXg+JyO/RzxYygij4pQ1
	3AN/rA9SkgmVRkB6eJIGqidxqRVGx/rcVZBBw1oYjS0baaZlIbLlD7LJ2MwQiutY
	vCD9GL4Zk4xGnJbGjHsWQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780867323; x=
	1780953723; bh=16h7VWs/CXTplT9EuLaOczvUspL1w+5USl6ftBNRwXw=; b=P
	Aa5WOjq8fU8quyPqCTe2drExMd9MBdyNWdFwUbNgaxQ23TrQa3j6IlpRn7H9v9P3
	jYosXoAlgujHcSvd2G7fQUaboWelSBOKg92+tGj3fqiUEFnYW6QHn3KdHPrfW9uZ
	YLRmwFd/1U9DBIMVMJR7EEAh5emrpzAbiXVXimilNcyW3mUYBgDrfx8u/F3rvpWa
	/QkW2l0nW6SxVs85uc9JPWspT7BJsWmnO+sPgTj+i0V8oX7uCoJ105OuG+yLmZBw
	S0F8YCvelgTwk+YqKYFV/nf5eOOKFZPrxB6mykDLH0BJrToy2bLPEMFVfFR4rSgj
	cc43ZJ+oOyAfi74jbloag==
X-ME-Sender: <xms:--AlagtyX5mMejwHiM8rFBfZas6a-2WO8NvS0IG981R_bhASsav3-w>
    <xme:--AlakXsniToGGt1jNXMwRPxHUF_l-FF5TzIQmtqfhK36gE2JLlOCi_J8x1MS54y2
    qW0lq2Rw3_9rnn9FYKpjJjQipuzip0oCUl_l7X1DiPz-sgYNt1e>
X-ME-Received: <xmr:--AlaosYHhDVlRkrYU9-cld7EghgJrxSLH55-weWW9shR71LwkI64xNMng0LffOy248T77wC-f4INv6lxNdMyuX4fObSrSnb2BbiQ8B_IsjDhcXA0A>
X-ME-Proxy-Cause: dmFkZTG0qq395WOaSgRwQWM6gv4Glc4XHrssqvkX8x5FOnO0OH3H4A6FweF2uJmGUmfNbl
    IGm6vnho4QYVoio/mlwFfXzJF3isZ145oqCo20NxyAPDzzIhmxXwUXJfjpeIsakn13Wqwo
    vO4f2c2gVrvy+z+Zk0YjVh5SBagWNF2OG7r5dZrS/eKY/R4h/G5vVKLf2qthJVpfywlfB9
    8Uf1fXuNb9qb1Ib06YjfS7o1KBF0bZus91sQhk5wWPo+0pzJBCk13TKDuQyNA7y7yDmRrd
    5RwFABpIrY2YrtrOWQ2cCK9IObujn1z7XpmtDdKtBdRyLs1YojSJ5y2qLV1NA2fmzJo6Kx
    3b/2fbpk90CzRukU263GeKt7FXkc3h7DR4ueDCthCN6/j8xXH5Pdb+/hzsYw2WX7ke0KjM
    eq+WcxVybV8ZWhgDR6QtyGrPQpZzzXBWG1PIDxbNIKOroBb9mDyYirzT5QcTp3ECTvXgq4
    c7tLH0TLZKy6JM2QD3i6XqtKpqhDKXWtdy4aZuZSvhmo1RU6oMz9b/r45LGlpQLUp2sAw9
    E5fdl1rz3sDxzhayQ2FM9D8bBigmStLFG/wy9Jnu6lgbNnWRJvKeyc9Fxfug+jENL9xxls
    3ILe4ZGQjMJ4YjgYoTNeBT8tS/hBt7AkQqFnbtHi/QxSQjIvjCGgkqciW49Q
X-ME-Proxy: <xmx:--AlagVf1H75KZjAkTO4dfNlHa-WI621xGis5JTM0PotLh-NZrLZaw>
    <xmx:--AlarmzlR9_AJH3MlNngTaUq-FLrVe0JapDgtK3F94HZmYOcNZtrA>
    <xmx:--AlapbJq3x6OLIvRtOo6bsjX_M1jA0mPeE1O_Dk6OnCi9WROTL-sg>
    <xmx:--AlauOmqS-6nRKGVglawpieM72P4qeTwOaLpggpely9r2TcqJd3cQ>
    <xmx:--AlakTxP7x8EPAFwFSdakbO_BdNM1XWhTQTqyEABzNgUw3EgEx7Nyat>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jun 2026 17:22:02 -0400 (EDT)
Message-ID: <0e1c9217-dfbc-4644-8e3b-994a5843a75b@bsbernd.com>
Date: Sun, 7 Jun 2026 23:22:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mountservice: advertise fuseblk support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <178044567804.1435997.11438899616254127750.stgit@frogsfrogsfrogs>
 <178044567930.1435997.15363968498209622419.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <178044567930.1435997.15363968498209622419.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/26 02:16, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Amazingly, permission for the use of the "blkdev" mount option (aka
> mounting with fuseblk.SUBTYPE instead of fuse.SUBTYPE) rests solely on a
> getuid()==0 check in userspace.  That /might/ be an indication that the
> kernel also won't allow this, but as that's the criteria, let's
> advertise fuseblk explicitly so that a fuse server can discover the
> capability before calling fuse_service_session_mount().
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_service.h      |    8 ++++++++
>  include/fuse_service_priv.h |    4 +++-
>  lib/fuse_service.c          |   10 ++++++++++
>  lib/fuse_versionscript      |    1 +
>  util/mount_service.c        |    5 ++++-
>  5 files changed, 26 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/include/fuse_service.h b/include/fuse_service.h
> index bd89189cfe5d5b..0536312dc7120c 100644
> --- a/include/fuse_service.h
> +++ b/include/fuse_service.h
> @@ -61,6 +61,14 @@ static inline bool fuse_service_accepted(const struct fuse_service *sf)
>   */
>  bool fuse_service_can_allow_other(const struct fuse_service *sf);
>  
> +/**
> + * Will the mount service helper accept a fuseblk mount?
> + *
> + * @param sf service context
> + * @return true if it will, false if not
> + */
> +bool fuse_service_can_fuseblk(const struct fuse_service *sf);
> +
>  /**
>   * Release all resources associated with the service context.
>   *
> diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
> index 8560b1ac610143..cfbc444bf5dcbd 100644
> --- a/include/fuse_service_priv.h
> +++ b/include/fuse_service_priv.h
> @@ -54,8 +54,10 @@ struct fuse_service_packet {
>  #define FUSE_SERVICE_MAX_PROTO	(1)
>  
>  #define FUSE_SERVICE_FLAG_ALLOW_OTHER	(1U << 0)
> +#define FUSE_SERVICE_FLAG_FUSEBLK	(1U << 1)
>  
> -#define FUSE_SERVICE_FLAGS		(FUSE_SERVICE_FLAG_ALLOW_OTHER)
> +#define FUSE_SERVICE_FLAGS		(FUSE_SERVICE_FLAG_ALLOW_OTHER | \
> +					 FUSE_SERVICE_FLAG_FUSEBLK)
>  
>  struct fuse_service_hello {
>  	struct fuse_service_packet p;
> diff --git a/lib/fuse_service.c b/lib/fuse_service.c
> index 7fd10211dbeab4..2d7232c3484aea 100644
> --- a/lib/fuse_service.c
> +++ b/lib/fuse_service.c
> @@ -51,6 +51,9 @@ struct fuse_service {
>  
>  	/* can we use allow_other? */
>  	bool allow_other;
> +
> +	/* can we use fuseblk? */
> +	bool can_fuseblk;
>  };
>  
>  static int __recv_fd(const struct fuse_service *sf,
> @@ -505,6 +508,8 @@ static int negotiate_hello(struct fuse_service *sf)
>  
>  	if (flags & FUSE_SERVICE_FLAG_ALLOW_OTHER)
>  		sf->allow_other = true;
> +	if (flags & FUSE_SERVICE_FLAG_FUSEBLK)
> +		sf->can_fuseblk = true;
>  
>  	size = __send_packet(sf, &reply, sizeof(reply));
>  	if (size < 0) {
> @@ -612,6 +617,11 @@ bool fuse_service_can_allow_other(const struct fuse_service *sf)
>  	return sf->allow_other;
>  }
>  
> +bool fuse_service_can_fuseblk(const struct fuse_service *sf)
> +{
> +	return sf->can_fuseblk;
> +}
> +
>  int fuse_service_append_args(struct fuse_service *sf,
>  			     struct fuse_args *existing_args)
>  {
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index e09f53bbf3f7dc..b89a7f1f3df3d9 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -236,6 +236,7 @@ FUSE_3.19 {
>  		fuse_service_accept;
>  		fuse_service_append_args;
>  		fuse_service_can_allow_other;
> +		fuse_service_can_fuseblk;
>  		fuse_service_cmdline;
>  		fuse_service_destroy;
>  		fuse_service_exit;
> diff --git a/util/mount_service.c b/util/mount_service.c
> index df22c1182541b7..6a6a8b608b7c6e 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -367,7 +367,10 @@ static int mount_service_send_hello(const struct mount_service *mo)
>  	struct fuse_service_hello_reply reply = { };
>  	ssize_t size;
>  
> -	if (getuid() == 0 || user_allow_other)
> +	if (getuid() == 0)
> +		hello.flags |= htonl(FUSE_SERVICE_FLAG_FUSEBLK |
> +				     FUSE_SERVICE_FLAG_ALLOW_OTHER);
> +	else if (user_allow_other)
>  		hello.flags |= htonl(FUSE_SERVICE_FLAG_ALLOW_OTHER);
>  
>  	size = __send_packet(mo, &hello, sizeof(hello));
> 

This breaks the FreeBSD build

2026-06-07T20:28:41.0670421Z cc  -o lib/libfuse3.so.3.19.0 lib/libfuse3.so.3.19.0.p/fuse.c.o lib/libfuse3.so.3.19.0.p/fuse_loop.c.o lib/libfuse3.so.3.19.0.p/fuse_loop_mt.c.o lib/libfuse3.so.3.19.0.p/fuse_lowlevel.c.o lib/libfuse3.so.3.19.0.p/fuse_opt.c.o lib/libfuse3.so.3.19.0.p/fuse_signals.c.o lib/libfuse3.so.3.19.0.p/buffer.c.o lib/libfuse3.so.3.19.0.p/cuse_lowlevel.c.o lib/libfuse3.so.3.19.0.p/helper.c.o lib/libfuse3.so.3.19.0.p/modules_subdir.c.o lib/libfuse3.so.3.19.0.p/mount_util.c.o lib/libfuse3.so.3.19.0.p/fuse_log.c.o lib/libfuse3.so.3.19.0.p/compat.c.o lib/libfuse3.so.3.19.0.p/util.c.o lib/libfuse3.so.3.19.0.p/fuse_daemonize.c.o lib/libfuse3.so.3.19.0.p/mount_bsd.c.o lib/libfuse3.so.3.19.0.p/fuse_service_stub.c.o lib/libfuse3.so.3.19.0.p/modules_iconv.c.o -Wl,--as-needed -Wl,--no-undefined -shared -fPIC -Wl,-soname,libfuse3.so.4 -Wl,--version-script,/home/runner/work/libfuse/libfuse/lib/fuse_versionscript -pthread -Wl,--start-group -ldl -lrt -Wl,--end-group
2026-06-07T20:28:41.0697146Z ld: error: version script assignment of 'FUSE_3.19' to symbol 'fuse_service_can_fuseblk' failed: symbol not defined
2026-06-07T20:28:41.0717197Z cc: error: linker command failed with exit code 1 (use -v to see invocation)
2026-06-07T20:28:41.0839610Z [41/85] cc -Itest/readdir_inode.p -Itest -I../test -Iinclude -I../include -Ilib -I../lib -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -MD -MQ test/readdir_inode.p/readdir_inode.c.o -MF test/readdir_inode.p/readdir_inode.c.o.d -o test/readdir_inode.p/readdir_inode.c.o -c ../test/readdir_inode.c


Thanks,
Bernd

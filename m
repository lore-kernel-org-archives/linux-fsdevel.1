Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.18.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783648;
	b=naKjvjUIJ0RRWppwGxkcmlyt4xrobP+FOiQmBRG08Ok/pcX57ZEuGr6PUIGa4gOcbEG6
	 syZivubLVc35d+DFlUgiLD8jyuN5U0BPJw54EQMdTOQ95FOtAwM1kcVxmeE0EPnrsFCCR
	 TB2gnAAv2jxujiPtx+u5+7YBf7TbeO68sETto3KOAjRPUkaD73FlCafFA8PIMQ7WrkoMu
	 ZK9O004dNgqBNA1LI2tXM/LzJrgp0jHaEfE3vcdlPOD/hGjsoSz4wKsFvuPj1kpV4u26r
	 u6TiGTlJ7numYvj8HZ5crT61Vycx9YCgchuG1Vwjj4kd8yrc13OWZoN75JSsU91sZkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783648;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=Ke/6sf8Ea2Tla5L1frSg4Yoc51vyMvUXa7DBMW9I2JE=;
	b=VRvqP5YahXII5mZDchvn3k9WoMpoJAjoIwCkFDSMvIZFSDYe28gTXqN1FXLCG0vKchoH
	 s0n4m6RA/TQLOVhbuqDjfYf3o0vMz1/0X3KRrhO21dzOaTNeQr1KsUcmh/pIkkj7BjvU8
	 vAHWUv2mShBWzI58zVJupfgywb+rQO4ZUf9T0x6vXI/pUaAKwnTOV1iOLEFMgLoqGqNe4
	 04UOVmDB7jqiDeK1+OQEbUwSpElOqbBoVohUJTpCA26bDuVOEO0hj/aYXd5dAbpL22jwz
	 ksImemzEMzerWz2jnBQ59QVO9nxG+kxOxhKEtOgZI69jDVPUut2zATAWgJ1i3KFb5Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alarsen.net;
	spf=pass smtp.mailfrom=alarsen.net;
	dkim=pass header.d=alarsen.net header.i=@alarsen.net header.a=rsa-sha256 header.s=joe header.b=e9t9yYP2;
	arc=none smtp.remote-ip=144.76.18.233
Received: from mail.alarsen.net (mail.alarsen.net [144.76.18.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA72606A31A;
	Fri, 23 Oct 2026 19:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AA72606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=alarsen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alarsen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alarsen.net header.i=@alarsen.net header.a=rsa-sha256 header.s=joe header.b=e9t9yYP2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
	t=1792783636; bh=Ke/6sf8Ea2Tla5L1frSg4Yoc51vyMvUXa7DBMW9I2JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9t9yYP2Lu65mJk7/wzPaRWgSrwnjnGCK3a10AlZAxEZwi9E5THQlTP6EWhgcw+cX
	 F/CEg1sqyEupWVlWNs1tG7hqCF9ei2MoVoTyJ8xH/WDU03K7SVJxTzYFJMsdgNK4cN
	 SbBKYwF89sSnnPmX6JIt+3gtq0l/yXt0SPuZM+yjjNb8E2b3I8KoREqj7gtThrFADk
	 KhRPZ7b8m/qDtqa9tBmlxxf/sWY7lC4C5QCmPgiqWXC2WH7GPWnbBVMEFzadOekZfJ
	 Nuf/9va4kn/z5okTLuhV/ZFPvsCpr893dky6xEy1sSMEfwVzCl1bNoKELz5JFMFViZ
	 NwshpWTz37Kxw==
Received: from oscar.alarsen.net (unknown [IPv6:fd8b:531:bccf:96:aab4:2de0:7c01:55dd])
	by joe.alarsen.net (Postfix) with ESMTPS id 17444182FDF;
	Fri, 23 Oct 2026 21:27:16 +0200 (CEST)
Received: from oscar.localnet (localhost [IPv6:::1])
	by oscar.alarsen.net (Postfix) with ESMTP id 0BAFF1CF;
	Fri, 23 Oct 2026 21:27:16 +0200 (CEST)
From: Anders Larsen <al@alarsen.net>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: Re: [PATCH] fs: remove qnx4 filesystem
Date: Fri, 23 Oct 2026 21:27:15 +0200
Message-ID: <1875223.VLH7GnMWUR@oscar>
In-Reply-To: <20261023160806.103901-1-breno3011alves@gmail.com>
References: <20261023160806.103901-1-breno3011alves@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On 2026-10-23 18:08 Breno Rodrigues Alves wrote:
> The qnx4 filesystem driver has been orphaned and unmaintained for
> decades.  Write support was removed in 2009 as it was never fully
> implemented and was broken.  The remaining code is read-only and has
> no active users.
> 
> Remove the driver entirely, along with its Kconfig entry,
> MAINTAINERS entry, and CREDITS entries.
> 
> The QNX4_SUPER_MAGIC value in include/uapi/linux/magic.h is kept for
> userspace ABI compatibility.  The UAPI format headers (qnx4_fs.h,
> qnxtypes.h) and defconfig cleanups will be sent separately.
> 
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
> ---
>  CREDITS          |   3 -
>  MAINTAINERS      |   8 -
>  fs/Kconfig       |   1 -
>  fs/Makefile      |   1 -
>  fs/qnx4/Kconfig  |  16 --
>  fs/qnx4/Makefile |   8 -
>  fs/qnx4/bitmap.c |  45 -----
>  fs/qnx4/dir.c    |  81 ---------
>  fs/qnx4/inode.c  | 436 -----------------------------------------------
>  fs/qnx4/namei.c  | 115 -------------
>  fs/qnx4/qnx4.h   | 106 ------------
>  fs/qnx6/Makefile |   2 +-
>  12 files changed, 1 insertion(+), 821 deletions(-)
>  delete mode 100644 fs/qnx4/Kconfig
>  delete mode 100644 fs/qnx4/Makefile
>  delete mode 100644 fs/qnx4/bitmap.c
>  delete mode 100644 fs/qnx4/dir.c
>  delete mode 100644 fs/qnx4/inode.c
>  delete mode 100644 fs/qnx4/namei.c
>  delete mode 100644 fs/qnx4/qnx4.h
> 
> diff --git a/CREDITS b/CREDITS
> index 882aad786df9..49296288adf4 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -947,7 +947,6 @@ S: France
>  
>  N: Frank "Jedi/Sector One" Denis
>  E: j@pureftpd.org
> -D: QNX4 filesystem
>  
>  N: Peter Denison
>  E: peterd@pnd-pc.demon.co.uk
> @@ -1341,7 +1340,6 @@ E: mid@zigamorph.net
>  
>  N: Richard "Scuba" A. Frowijn
>  E: scuba@wxs.nl
> -D: QNX4 filesystem
>  
>  N: Fernando Fuganti
>  E: fuganti@conectiva.com.br
> @@ -2392,7 +2390,6 @@ D: Scalability, Time subsystem
>  
>  N: Anders Larsen
>  E: al@alarsen.net
> -D: QNX4 filesystem
>  
>  N: Paul Laufer
>  E: paul@laufernet.com

As far as I can see in the git history, CREDITS entries are usually left
untouched when a driver or a subsystem is removed.
(Alternatively, you must remove the entire entry, not just the Description
line)

Other than that
Acked-by: Anders Larsen <al@alarsen.net>



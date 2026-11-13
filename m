Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564334;
	b=MPbwjYweVX67vauIfs0djK5rGu2n1FpltHv4GUsUickZvSP5Q1ClJD419YwxgATKEyki
	 fIUm1q5WXmuMIlM7syp5c5Q6iX46MKmE6ctmDJGcZ/JEOnxitPu2Oi3+FVEapWb6rNwXq
	 TVd4mYvALQgAfgpnQD5sXIF2u5/3evnAxNOCdMCw5yzNnn26J1S2D5hjfa7XkEPbxoUkY
	 1Xv2Aq63bQWFpoL6ie0moAwWttTvo3He0oYZPlkGTkl+/KRq19F+WGfZ2+17Mh9Lk1Jga
	 YkOQQMy8KCZfGnQDh8jlknQyc1LNc6p+F/ZY8wxD3oslht/UZI8hAblluJLh54x9UbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
	b=XRdtg6BHqVcCg+IEAfgXULoLYm97de/Q6R/B9wuaxzREk4ketxyzXdJvfDiwo9+BtFd8
	 9O5a7iTXFaX3y/t0gEBKSO+vL5also1MCvpBkVx+wQo3DJJFsgTfhACp4SQE0ct+P9koh
	 ACp8Ct7CfJWEt6cQoJecXpls0VGWkcG4RCJdnXnpsCINB0WOYfHjNVuiV7+mRof2fD4Ts
	 tgHRGBkToX14ak27t7LGNhgaPmkGQb2OcciJfzAiFs/BzJmnKfxVv5JsLCEXrHrPC+PbW
	 hBwNee6vd2UP4SDgICZDFueSlKEXQuvhuqioXZoosm4x5Hbqv7uaD420gdvzg5iQXfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QG9grDi1;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D87606A88A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D87606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=QG9grDi1
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b7bfefba55so1543206a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564333; x=1795169133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=QG9grDi1333EJ5vFrDKveygehwnROLgKvX8KCpfSFWXv+I4eyfqnua8R6KtrAOOR2l
         +HS5JCIdHH4GFYhxTGpcul1UYrqBxVEKVYtZXX+QuFjz3atGFob21cLqAoqZi5JADlHj
         naEBbS2xDydM14fm4tN8GtiKEyyXhNYXhFZ3I5ZySehDVmQo9RyEp8Ng8zKyI33PSYjC
         lTyIPU+8AziQI1Gig31BVdjw6dAVORszr2VJptJ60UUsagtzV6Rq+xhfECkHhjnaX72r
         CaBJBa1VgM+UMc6r/RVDCNlq7Fp9h/YsxbVqvvWGNdAmSmDIEy12RhSNOsQRohbebR7n
         4UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564333; x=1795169133;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=QaIkdqCZAJYV8h+uvs7ErSy5t3l19n9hmytT1QB6bSBk10aAZ56K6gu82Y6j7/v3VV
         bTVyItZ7Qhr6r3Gkd36s28APZxe/AnxDsctVMHjQHT2eTQs+RlUL85XqYbqgLNk/bpSv
         xdr+Lr/F/M4AtCXv6DHBVczf0Ow8uVyyFD8ZIu8iqLtcfDh2FVEKbHkM1U3qL5iwBRYk
         sPdpjAJFI9mbqR69lhjJ1KjBViWlrAeZWk3isjItRfFIjGgScUlFpTcIpVpTLXgeBFXI
         qqsQ6f7E3HFwRbhp7zePx02ve8q39zEpUsQnnqsIPVZ1BOmJ1imBtCrujqNtOY7zHsbk
         Wp8g==
X-Forwarded-Encrypted: i=1; AL+hErGRkFPaXBtg4qGMcKvuZQfltxXCKDyYGVxAsS5TXmgmK1YAkSFploGtoZsg/202nq7BVzUwAetG1HdNCy0L@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bv8lKolBxj/NGNSGBz1ubWOaxrLx5AZYyUkZ8VzjBrE6dKHBr
	cVw39BCbkMzZF7Xedf/C0IyTQz+bey9BLi9qUCq0nUlzfGotJswdWWJJdfhgoC7Q00ujG7/DSYK
	EKBqhnaMhKAs=
X-Gm-Gg: AYBFou20Oo1SHbeuHBg1oVBJXJV2q11iFAvbN+b4Ji51M0v6ZywATkZK6RmE+BoqJVT
	50/bdFz53CDfVD67+NzlE2tAcmUVcwucrAz4n7RGHKUmkeeJNUQqlIQk7ZyMD7BZONTVJZdvrol
	kygQ+Jch0PkoPRhaFTfR6QpaPMctzB9ahmN6mJspJLp7VFLe6gRvMNOndBsprn5d/JnBRboxrI3
	cfSahiQDv+8w6fqvl1uCLdvSvZh5F21NZFIOE5N5qeyAOFlyIQsrvnxz7YIQd7IeE0hCV7zwL5Y
	owdmVXAbILyKTASW7MBxUbM0IYrcnT16QMXltcGOlnMTd5aozJ3u4tet49dutHZ3DzhEdOCH8Sh
	GcrpFIXjVh9rJSgZdpSsTdA5PBpyrx727Z/eAtj9EYrzuFRjC549SNaB7+iuOoYvsXWeh+o5MlA
	5zImOrRjcnWwu7boTZNciylNFbCF9kZrxQE/i4GSgQXwnKB3TaXHX/Wo9JTdIeV6LzaxhfeU0jH
	Wcuwv4SxsrFxbroD1fUeI6cyEIRHsR/lgxw/14orHutoRURfrTSIt4lN5yc+FDSAzI7yVKlUy0v
	h2dpnVndz6aYnx0vBN0eVX+usfejKkyoWMUuVSOZHSGw07/kt1EkYh1ejkMN4BZ5364NkQfg9rp
	gHpyMIyG1
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}

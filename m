Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564223;
	b=qAX1PgKy+ovIIEBuYJxmAwmxPOMl8Mukqk3IUqLn6YMZy9stSTGI2rkGWbWn3gBekGhw
	 BtE/vXXdEoLtG8LfPEU9KLQqhO3+i90CgU6nCwG3N17BpenEsgPj+M2dqNXdRG/Z/1+cS
	 cLN8yPNCpE8+DH5+4HOPVFHTmwdclGj089mKPV/Nw3oJk49f1sMFOKPok25mKq6sh3a7b
	 FKg3neRwZiAG2n3d8PrnSern66zLbYD9/HVUKa3HgvDMqriKbTZyT4ftP0AGq67B+UlYG
	 vQ/PCVGacns+Pb7YrdtSY69wQbPMhDLuF9TO7Y6S2er46zHtR2rKge97bQwdx4+s4sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
	b=AxPwtQnrIQf5yQGY/XlsGNfokQHcOsMKTw6lK3E1/OPLbD5QqNrlK5PcTi7L/VzJZZ6q
	 TKoLhke5rM4Kkpwnl4lMoIsrElKm/v+pR5EQ2lOvYxDhZJ00dZzj3/oJIAIVTU/y/4UOU
	 yVWY0VEXT0OrbslBtSn7hKPNQs1ggdOtYcV1xxNA3LkIsz3+GGVrEt9nKUHmAmJKoW36e
	 Q9sPyEFAjzfnN7xvjJ1OYMMlp56ZP57mNe4CFT+JVRiSwxQwr/S+CvJDJfy+7xvqoqsGT
	 dIOBHB9Ou40Dd/yYsKhHmUNnzyloJD8bLCiJrnBj9ckDLv3A65FG3nqHsu76FI0gdjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="YppAuU/f";
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7402606A8B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7402606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YppAuU/f
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c40e30c26a4so170617966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=YppAuU/f77eWMTZ8F/Y/RTjltBDd6igz4EttMolmckndL9mvAt3euwqVCnUFPcnj1L
         wpVFClVgg0YlcE6bTABHQT1NnQyujG09t70SZ+IGoHQq0qQgGGwB+4JQikI2kaQwvi8W
         H3KupRONVF9kXu90kRN/xwbfNoANJajav9pnhnb3IMIJ4A6DWEq+8017kOKRrUT+YN/m
         jRUDmGHXRq1c+43Y1O2K5XEGEQl+nQ8YkAZ+/5vrEItOhIamTuHGEOkZUAeGsE8baOwB
         Dj4haSBpRwT/bMXANPqkevI0ogqYaGkZDRE/CPrkXlmZ9T16K5sayD5Snik8DtXgYcT5
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=crvXplV1Q9jCumoSVHb+yPddGSky6nx3H207dDS0VnrV4Gwaz65/Fj8gEuNAfbkvlE
         RN5lfx+EkJZm6CDkvHkcwASqBxoEBkUlU7sfM0i/t76hxJfEhyJtt4qg8NzKZCxDjvw7
         H3BzSA+KxtRrn69XGSVbt+rNM6ybGtfK2KAHleJJwzPDLOmvwP/itTCdKoRMVChj0fO9
         X0rajCf91hSDZ8pVAgGGWGIAxFkwajzz7KV4DDLIxF8Yhb9TYk63ShVsOarda25dLS14
         XyI+zd8JLb1NMhPlCytP6c1fAySbHaOH9dtjCV3JogsDSAZMFMZmaxvTJydwNBqWVQNl
         8s/w==
X-Forwarded-Encrypted: i=1; AL+hErFBX2U/WoAYzfNz5rh56xodj3B6LuJ/frcK3sAS/u2nz99Zhd9dLYEeYM8It5ZiVV7yNtMSA3bICDgXyFjt@vger.kernel.org
X-Gm-Message-State: APuU4Z9xLzk8R/zJORFkpbRNSsQHOx9BTWbh+KJCisJrFN6BkIsY1WgL
	jHILtN7Ll5MLhvYaEMJ3wJ7n4ClWMcMjP6gsTrAJi3DytIUZlr9YjTeMoEXL9QdJ6Qe6
X-Gm-Gg: AYBFou07QR49S1OLu+mLcYJiLgmk/jvlmeJph4gF1M1oBUyR3emshaM/3U3IyJDYqTB
	OoWzYvzV6eFNXwc27E2qeAP3yjTIVb7M6T18/y4wPdMopRg6N5zJ1TjdSqHl/jcowOJndIUIk98
	r2CdR0nVIZmLjVofyey4Xr5855cBpeIVpzHe6xctnmD7ctyLl72E5R42Lr7BAL+/jz5Zg5Or2P1
	ZEt1JMUA64i/RockzPzAH98M2RiIT/6SriLxywvS3wDJXyZmnKOy5saOSpAsCcW2We5s7DzW/Xf
	6lKvFCHamMjqBNSl5YRMDEg91m4XSbhz0b9lxDnGMWw63aH14pM6Gj+KyAPltpXN9cr6CNRfdxP
	s0XFhu/Run0dcJa8elUSB7eU0pJqFjsc6N/l1HDo8jcczxV0yeUOHk3yDHNc2uZVfe0ryio9Bw5
	raZ1MJCKWDtFQPSeDKqht0ELscWz7GqF6a+L+m/2xxXaH01xFZFTbF745cpQkmLziHx4enSaCaj
	mV7on8Iw9CHZksIFNnc9RzSL+BmM2JKLF7DAhlA2cPZfBr7AfY0At3+C6RZg2dz4uo5ZhJaIFFv
	dy9LwG0z5waq4wM4ji6qe3/nzciLvX/A54iFbIo2hN7C01ER+Y/L5YPeDCRkLT0=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
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
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}

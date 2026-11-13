Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564824;
	b=LQerZZwvgoPHZdPdg8j4rRVQ85SRhbx5mPHCW48C9VmWVJcBLRADrhGedCU4a5prWyYI
	 7j+DGLU8qhxF9R7UdwoJnBp46zTYuFmiG0mW1iqkBdm327gM6zErmqVMKvOd1FTVxhgVc
	 NaO9E4+zCGhNDhsR0208kQ5F7IIFpT2BZLdwNIYR73KZG1mE2Uq93PwxSpl9KTTy5W4Ru
	 opOw/V6C4XUcdFyzBme6tNIzf2mSloiPYw5K054n1UKZ5sw1eAK8bFn+rpjtsBzsUX6a2
	 PXjZttEP6Pn+usLeRvIjqDb2Oz5/hr2a52P8ljM8dh9HKTCCH7dOXCQ3N2jIiA/ZJMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
	b=sVChOEgBITpMWzttcvWLsx8qPSIXT01Glznz4hWxsh4ROYDK+GEwBE6BcAGN7kqacS7t
	 2MQq6l2WSq/gJhc6vrp6KtEeWtQMDwGmoWwaElooj9zitFNqHEPvCU8V+C+oWz+dpubDh
	 Pus71jnU2C82j3rwdeKDDv+0MiWUBnU+2aG10nig5FnTXysvogRJ+5XYbp6vQudBqtwKs
	 vLNltF9+/8BNdpiPz+A+lYW5TP6Q6Ie2DIXqFvlhFT5AcXbraMBoHh3h7lH7pcXfvnHXc
	 SIKI3YmgaYJMxfBaUPXyqau4IEGo9He55j0D5WGmaF3pbPxrxqsdy4uHDSP1UtOFxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS;
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58A60A2604
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB58A60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tBSDp3uS
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b7221c0f2cso1490868a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564822; x=1795169622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=tBSDp3uSBFgypsbtBQgsadIQZQK7UWodMC4WHZVi1N1ipHHYu6WywVfCa4AZ6QIaRM
         wIcOajhLTVFUJp4yf9/N65gePrg5n4K0AYKI0yA+7KNwnMoUY/irx0jTqY91Kx7jR9xZ
         Pm03fPe9TdsIWGPKhcU7A4Ssshd7c8Dhe1zzS2a/pwsZLiwc6FmAy6ptf2LWGhArJX18
         uzRhPjO9k+hyhG0ceM77HGUPCflD5+7VnbyODCgVUFUm1PdMwYT1gZdGgKWe2z5NHlJg
         Ao5qYJPp+rBAoBURzi6iHuHACVVyoOXqBDLcaaEy2+qVTTu+93IkZN11FbEDMtWMDX2T
         mB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564822; x=1795169622;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ycFr7tcHP3BtNSevVHScuCcUOF/OuOrXOdu+rsUd7U8=;
        b=uqFrSt4wo+VgcQW+xy4GzOafE/eF6329rz5IRpEARJdeVefJagOLMEvODc2PTOxgqQ
         nvrUl11q3MAuOEHaZHFpURArzpx5q1dLBrZ6gPyGoCEaPoxXKB/nQ2i1M0Lxe17iRADB
         JJkd4A52nLtthtrE+hbgqaIYjWE1tqLN7U5jSqzHKp6D8nLujQCQ1fO98Sl08sO6qSfx
         oGLK/Kl4LzSoddNPvFpWKQTmFAcGYb+aH0QJ06Sy59cRtOwM5UhOYmhAwEBHuFLVz+Xv
         IaktkljcDDJgiqMgFlatW4wvIB3jCL11NYJQNp97RjCU6g6zWnmlQrW17e+8tUcy0mR0
         ek+A==
X-Forwarded-Encrypted: i=1; AL+hErE6IlI1XmY8cTP00K3Gv9yYxV55L8gcIwLdVbGNqEiK4szHkoK7MOxjyuXeyKhIjRp7K6dmhEILNoPgCf1l@vger.kernel.org
X-Gm-Message-State: APuU4Z/napJMbK2f+Z2S4nkGeX+pPaAQ7JTeO6cJkzZ47dnr9H9dI1/A
	NyRTl7+xdVseUs3BzXyUyEInxTxhVTJBaeiC7rsR8DgTvTc1BNtNDoRUNSuBe8jIHzoC
X-Gm-Gg: AYBFou1ac0U9HTW/EW2TCiIKSvHs63OA1Xf7Fz0guWrp/F6lc0PafNZCIyFsarCAhWd
	lUm9iedtht4dxvIMf6roQdKzBojr2L+Arc3SuHwu4fpm7jOwRe3S8TWNN2vg5VoNKrT9k96018K
	i+2QNZihDxMHrR1a+BG9nAv6ZGztsbneEFNJMxH8xpzHT7ZBtuBCQDa4Wub2ltjLLl1/oBYBJaq
	IHDcR4Dq8gO6T3qItvOcICl5j30V6yqH1g6CCi8lAUNWKD1KJXCiq22hYxBo8l8eYCNXv0Cb8Vj
	PVDBLB2pBHJweOEGXtj8kRd1HPBHnp/I2J7uaTCeWIij0uSHdYpKLfqNd/2LwmSL49gDzye2923
	zVDCnYJSHaWJjCjYvX/S6q2DHsy417GFd+B+9xnzxuR7PHuiEg5JyGsRroL5QpkVL6QvgGzSkXp
	PKZVV1mK0Lk53JqW79DhCXA4bdktBU6l6eORbK6Mk8SFvJpqmUkdR06KHs10kW0jxyIxJRzVOUW
	jb7p46YYHqZUPvscVyh1qHygA7AYPkA7+gXHdThjcJpiyq5WMXpbibEgOp9ZMKNtBm9mMTWEwKG
	EQ0K8eKHdPZKFLLuFHmuH5yK/5SgpTuo9x8pauhlPSlwuvKJdxiLDGmSp4P7AaUO4fpilHWhHxl
	2dfFlWVIK
X-Received: by 2002:a05:6402:208c:20b0:6b5:69f4:e7ce with SMTP id 4fb4d7f45d1cf-6b7c0c62bacmr1415990a12.39.1794564822367;
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm4332158f8f.35.2026.11.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:42 -0800 (PST)
Message-ID: <3546dd28b1d63c1478d391a2015fff4c1b976639.camel@amutable.com>
Subject: Re: [PATCH RFC 24/41] efivarfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-24-4c998976c6c7@kernel.org>
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
> Initialize efivarfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. efivarfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/efivarfs/super.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12746ced6dc6..e598d42c5f42 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/efi.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/pagemap.h>
> @@ -554,6 +555,7 @@ static int efivarfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	}
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sfi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &efivarfs_context_ops;
> =C2=A0
> =C2=A0	return 0;

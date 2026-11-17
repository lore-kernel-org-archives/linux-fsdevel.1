Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904514;
	b=mq6BOWve89yWX+2d5zmNMo52NGCUz6ITWFzP4CyASPrcUdPf54GRgxFmoQci5GVYHozG
	 2D+RV6LYHjMVFQRmYLwJSnaKeEkPkmm8faehAYhMxxghwEy5vI5HvWKzjPTLuu6J6zsoF
	 VuJ4EQIjXNpNHSkV6JJxltRwWwcOR+DyA2iqtlvH1wNV+I7FllytGZX6/Et5hg3+7brIN
	 SSECXT/UmckRFz336xTvzL082O+mvAFoVbQLqTvzNhB7rIbhrTauWjcY0QkLbUcIZ+TSA
	 zS/XlTpkckJMEUb8pHpTlajN3wblkYisPQdI3nGYzJzWjde8Hgh4Gy/CqU31hfQOkGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
	b=hkqCQVT+iz+fmWQszDFTmKtR1M14z5iWRleTZRoLoYQasK3WaTM8I/n27YCZbfAGYgBF
	 RVLAS5yNuW+XvCCsLvjdjzB7yuod9hMgzn1vJ/CHrjz93yhzZgxdSkbMGNBwJUNne7NSB
	 D1Hy5CDQ0T7NCh9kQnCauKrp7u918o7iJ5or734/CaWYzH/ZQSfc2SgDZgHnB8WnU+6Hd
	 Otl1rcWayIdkyE31/7opXnmgCUurYY7qOQcHROzjeACcN5H6vHUXuUBRMHny8kq9U16XQ
	 pxXIWcHHb+0iS6OQAFncLZKSK7DCvPY4z7MRsjv2EpP6l56KkuzQdKveGdEs6JaIOBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9C606A898
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE9C606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4919a880834so2252943f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904510; x=1795509310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=asHWLUHh9Osx9c7ISjHVvBK+jrwM+bEKiKQ5ZLUG8jHeL8cbDrdmay7aq+azwtlrvN
         q7YkHw224WJQO7TnM1AyMygFYXrlY29jKpq3C9XROr0oTqsA+UK4p+WS5GMy+xx9DTRb
         nuDA+OEO8+ykjkDq/RDjAwEfWgenycj+snq2KkG6mulygb6NKchr6plM71+t8W0/+aGL
         LigMC+giRqQ92TsunABClmE52NWQSdRqhQeez7lH76lemvGh63Ic8nud3Qte/9KpQmbQ
         YrdviXjfG5hlS64KIE7Iq0kMRVYmtZMNK2hkMRb6Cz1tihRk5N+J71aJKPK+K5E0SOED
         KbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904510; x=1795509310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=U9YIT/+cWmMLuPdhHjnFQUDsv9+8NFIuhye6QWq/aqUNTWUCapRwTf+UKaD6FJR1cv
         x28fqgQ/OEw2GQ3F5NKxKpdMZQ7C9iiE8g8rQQUYNJRCqJ2iYwup1QXRmZX5oYmqGQCo
         aBHYKIL7m6ga7nec7/ZjlDaXYHdqtEBVidg5dUHEBzCDDU+aiKsQCyqi9UMiw4qVpxMR
         uAPLQfNRn3MsuycP/5tWTFUH3bVra9ZJO6tVx1IoZj1pp2QBz5S7VAY7bSPjDI9X36CI
         zDEMUpdiy51bOMcxgOtCMpIXOysOyPXSVBqvPqaV8UcuDLTG85EjKVA37IjJ0bz3uEkl
         TWFA==
X-Forwarded-Encrypted: i=1; AL+hErEdDqib622pmhNFu2uJrzWXQ9TL545wXDpVdDj+cN0u+2sSDR8OUQRlqy61XstFkHEAUgItR4L83VC0OKO0@vger.kernel.org
X-Gm-Message-State: APuU4Z8jbA355ElUDV/SXxeYvjKNdbYUPZJCgnAsjt7ZouNUUhMLd09+
	XpP3X1sgJ8hNrbBFxlxPiSsV+XTM9+A0UeJlcJ49/BMYmLAP1GRuDqh+QLl3rwZ6bfxf
X-Gm-Gg: AZFdTZdrjrgSDu/rcOA0Ac7g2iqwYnlSojgiCrzMEFlG8IjP8xKZWQlUnwl2ZeUPop7
	KFd3lp4CbVdT+iqY354wnQM5i7nIutAbcqnVWaravzUv2xnj1PGzP/ey5ZvgaKkUL0wQPrT0krl
	UEQkHpa2td6M4uIX13E9AD0uCkMRWRbPaksNYKUqRehZ9j4BOc9IzhxApZuFHLcG1adcJp8wuWj
	kcmK0uzGxdZTPRD2FzRfFhzNh1s46xdoIrbubQTljDI0wyiIuHv4VrTZM84nfW8JZxIrunmK+jw
	EkM1rZs6eGePyA7GxyiDHqxtwJKX2okC1EOr5BZGqQ5Lget/lYJhpN/QnxWiZf12f7SlzeRMHJd
	bP/DmbHXQ0hBh2yIv9HfZ3tBWHx8oM92xglkPVOHLeMt/g+NQ35vmuzCDHZBNi4z5FHG0XfwAdH
	yLF5XbodhS+lgODi9x1mpDKjiT7WNjHmYRap2WJ7NjgXeIc/hVVdgJUTIMZNFBOAM4/le9hVdOe
	cFIiPJwKO9q2YSEKzetvfxIIh8ySxgraLg/8iI5eIoLhWEvl2sgv/Tqoo0qXPIvM9imwhjMz7/o
	XYUu5mmQppWjc28NhKwn9YkafhXbpfxF1TaCicnmMfPRc4wXUt3m6WIutfFtldhV0DcUF/aOIDH
	AFm3H5T+gGqSEAeYr2w7po6qe9odDUYKmgd90JwmJEJtN9H138DHzencx
X-Received: by 2002:adf:e193:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-49c728c6e6amr26569239f8f.43.1794904509932;
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm26338505f8f.36.2026.11.17.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Message-ID: <b0ec2cd8f9b7a6a2e4a54c6df2fa897bce068cbd.camel@amutable.com>
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:35:07 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/ocfs2/dlmfs/dlmfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index d3bfcada3e3bf..1789ec96dc130 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/slab.h>
> @@ -563,6 +564,7 @@ static const struct fs_context_operations
> dlmfs_context_ops =3D {
> =C2=A0
> =C2=A0static int dlmfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &dlmfs_context_ops;
> =C2=A0
> =C2=A0	return 0;

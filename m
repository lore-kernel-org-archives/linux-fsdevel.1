Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564841;
	b=IaPZGMdVTQ6CKgpSwYytPq170DQ/hj1TFNxmgXbSTjCsIzKyQh2F8wY9A1WNV66jhdks
	 L9fZDpQAVWZDDABBhDHHO5p1nQpGjL6anyV+ZRxH1xU+tFFMX30PU+aYpHD/8R+yRHfIb
	 ZfF5BBZCENz5WqAD1pCq2qs8SUhAI3VxnvQv/z4VifSeCqStNKONOEkPBhl8Riqh5y6/Z
	 nPFu3Lk3mls9ypdF5FcMR4kCoJgHcxiOJyGYMqeHMOB8HDX97n4gzvyfbl/jM7SwFegzW
	 3foIuI9ooARcRwBtu9xm3c4aV17T+TOwtFqwvsevURfZ7jIr3LxKSm6ZjI5DrWCZrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
	b=cmEs3Eepy96gBQc9mfWMYISr8zO/21R/GMi8NQe1CZkkeh/RSdm2ltoh8u30YBrm7j4o
	 gFI5uAlo2WiJ372J/Aux42ujH1+XhNUrmSsQSVoP97gXZoPsNQK2KDKvgPKinWvgB+5K4
	 T8sWnRsSq2BY01PMiby6a4+4RrPcMITo6QjXkOGeaGWHsiWItr5+b4/oY2FiJmvYeIlE4
	 eB2M4/yOpRcgpYZp3fh9zkSvfHJwklzIslUZb0DTRqB5fzs/D/Vl85Kfd6LGwPswYSDh+
	 NVI023YIOUDDxTjTjUdCq1sYqnGCfU6OQGxPAxYgGa9Mhg+qsz/pMR626F21MPIneig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fgkfOyvU;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C9606A8B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514C9606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fgkfOyvU
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48b001cd92bso590381f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564839; x=1795169639; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=fgkfOyvUu8xf6W8q9zChbNscxyQBBGlOoHgKBKJ1BkQkWvPVGihrF+rRK/++Rh9GyG
         JHspcfYOBNPixo8oPKNP4HMqn4Pm5ECxNu6WadiPSEV1Ef7s5pMOTmdpp1h0qheNYCAL
         reGCPjjBuRkeLgJtvMnJj51efD/XBAnW7OBUZupe3DEOpiY9mIzToOLvbGpl9PZAiITD
         ja/hKOWfLJ2HwVqW5WbU5vpLe4u/8sEd47rKsdelsOgJDSYM8eMKS9Bg+p1Lcupp+2o7
         A8nYundFQzH4qm98PvOkGZvKdsA4h3jxn0f8A/jmsMNUP8nMz4irJ6DT1xabl6IkGIEw
         iw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564839; x=1795169639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=bHuyw1xCKqtDW4QVYQGlieEOvK2vzZoTKAOp6Z65OEL4z5luaN50Aq+SM8/pAL+kH6
         kBxcq2xs+dOoOVr1SgBFAAnJT6w2uRbwS5RhETQXtRoT6iXzcwUEcH5zMjutSAnAa5AO
         gtxrj1B/EtjmUrgnuPnuqvtz/PIM+AaIuetJZdjbpw87p53I85JUHpz+gApx992wXHRT
         pCvJoOf/Mi2tvHTRD7JZw/7ciAA7HAYVtFaQLvJrzAcRJBpJxZlnL2lWi0bZj+RaV20Y
         skWu5e/vMfss2UDfyTzARb9I3dML7gBh93u5WsoQpb0BXZAJv0aao83J/4yo82Eu4WNV
         3Aqw==
X-Forwarded-Encrypted: i=1; AL+hErHoDIhW3Ed02RiPQhU7+p67kCxtuPd+GPJW7N090ms/UT3pF4L6qk/fX6ad7DOJts55QmV+F+RgcsdGLn8l@vger.kernel.org
X-Gm-Message-State: APuU4Z8dEqnBKE1cwEUKT5sLCa3Vqopp9XDExRDdK8WxhS34ZGaIIxCJ
	eN09yNYq33Nt+lYi77T13hsyvJYd5c3Rj1BwiU7gBkzAfVWeJOLOomBD/+Rnz+nuuAL6
X-Gm-Gg: AYBFou2BaxSI9D0D7QJsJs+qh6AE9tlflyGElE347T+nffLa8vGFek2QB8YYL652UND
	e9lUSaiTonkDjZblRHO5ICkZfhXjuXwWCswbMahYkFDaSW9rx/LB2xGONXdJbK+Gw53x26sPhRl
	JXEclUKr7+4stCiwGQ03tzgVUwb+qotalSlAD21vK/8xv4XwOq/PcTPVPRd7sEJnjla3b5N1sgT
	wJCHDeWgddpDMfnK4qM5RSU5Cx1EtX/M0vQMqyBTow2Z+lGlMq9F76+rEXlWQc2VHJXSRSN7wwW
	EnMLqlihDS3+mCnrXSNNodENvkVRr3r6yKiorJODsZts/dcQk56Z1x+8fJ+c1FaTEtaZi0cNA+j
	zjEWd9W9XxLRdG5lSfWUxlJye4SS9NulbuZqwZ4sWrqM/niAD9Ki30aG/Xk05Pul3AiI9iOyHZD
	WX+ZF9EgXPkl/4xCVh+aC1X+fefncWffe94FXx8Ap8cyzh4Fy9LWS3A2NmG0ySQFX5Y45+4SBPB
	IOMZ4TQixTkWx2uGRRLYvag1+vTuLSFqcZ71QYsWvBcP42jPdouDM8WSR0e926AQWPqHDh7Ikxf
	k14kQ6tY/pgYiyj2YBIo2DbgofbcZ2Wfu6M4fywbRl7Z7BFRuxP6xHs7iSTysUI=
X-Received: by 2002:a05:6000:993:b0:48f:bc59:ab9c with SMTP id ffacd0b85a97d-49c6fd932f0mr4358101f8f.12.1794564838578;
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d673ce75fsm190118f8f.55.2026.11.13.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Message-ID: <77855be3fb9f0e1888c6dddc56d73a1683c820f0.camel@amutable.com>
Subject: Re: [PATCH RFC 25/41] pstore: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
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
> Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/pstore/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index cf499ba72702..4658561cf90b 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/ramfs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/pstore.h>
> @@ -491,6 +492,7 @@ static int pstore_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->kmsg_bytes =3D kmsg_bytes;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &pstore_context_ops;
> =C2=A0
> =C2=A0	return 0;

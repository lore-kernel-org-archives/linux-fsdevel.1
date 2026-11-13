Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564728;
	b=k5E3n5ZmIJLDJ2iLTFE9CMZ2Enk6n6eEGGhJ312UyWMtF75r6wvFTNg5YfLXNspVLwar
	 Hmk/JKZT3r/Ia5YBoO7PdaDwmms5PHmgiYQTkugpcOWm4no65AHxdjKzLC6yTqMmxd86U
	 vhfMesqIn93UayqeSmH4ozW4wtJgXwbFq0LdWRgkJIHLKfWHpMc243Pff159MLlyxVwr0
	 goSixHylc/nSQQv0AXyll18kimjmbaFGTrAStLbwawJXeUz3HKRdBys5eiP7Mm05FUozE
	 N0bJ1Une5swWM24Gi8gDB5kBt2yD/DDZe3qfZdBlCmn1y86FlQQXDbD8kNget0Is1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
	b=16cKTF4zgklNC9gR1EGhaTy3U3vJZYh5MgLuzzGwwLPFSAekYPGZxz4cAVeJLovrhrf5
	 QsIieULm4QuaaSiYyI57DQzBKiOINnOTO8eKOjMI78KGm+PyPwtwQoPlrD30brS9JbtzT
	 BPHIjVBT08c32hDnymclXwx/h2Da0FBrPmqnn36yJAOFNqzAmwqFrPQn7hbQ2CTGdcuCx
	 KoTKSlOa1KS/aPu+/Wj/h/IKHdC2vgf13FGwnoeNwx8hy/E6aM2LvlWRI+VYS/QgWeS66
	 tPLOAOPICQVvde4BwBPuPzKoKJPwcFlimSgo66KTL0/aIE4JKDdAsi8C+oAak47lLcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B79606A894
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B79606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JofFrwon
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so10660795e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564726; x=1795169526; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=JofFrwonLml2YmEXhdcViuKQhdgodt9TPfkjQoH5bRE5MuhkX9eapeBcuLoN9BMOMG
         mg62x7tr1NIo2ce3//xfxGBo2Glw1JnMwrRUE5PKg9cgXRmANAsmerUzgfn4I+APSoic
         nLUkrr6h7Ej/6ZnsBOEx8OEPXrCx3CvMaGkTszs9w9WOs3gF62hftbL3MH/tr8iwAkM5
         IEqdn+20vI39qrHT5Lu5B20ux21tBPJwfptIyU9tNUhlU5QyFDk51k8ZhbiJowoQswf0
         13eatahih0uhEB44iQMwucAarD0vNvZBAG3aTkRmepVuKD8cgol5N6Bgv+DPTP+kX4Yt
         YdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564726; x=1795169526;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9TZKYRayQVC7UyXoancZRI4bPIYIHY06/n7s/4tB9k=;
        b=PCFL8RxqCY10ToNbgyab5L4abjFX2FRGX0yQcQMG0/DqLAtiLQFCE/nCKJDVRhCdsM
         AbWs1azu2S23dHPY5qo+HaeLYSCPDy3qly4vf1o2paBI/BsKmEpwGK8DXUvNu2013cuz
         /yrmOaUJZfFDU7UgbGjQy41GcuHR2+gDk8j04CVsZg9gAOkGg+meWNCoT8fuo8gZbQi1
         oeUhxmE9DN981YSPZsupPro4VGkxdIuQHWOCmySTD5S1ugP+CfSDfD8funpCqwRsL5FB
         ZNy/Ormuw93XbwraypODuK3HhBjdEiuh6a6PdbInhCi1yFHS15zWst2Rp5idTey+RgR9
         H0/Q==
X-Forwarded-Encrypted: i=1; AL+hErEF0BEn4ePYiSwhM7M/eGrMr+TcBZGHeTl4Or/CtrRU1TaMM3Tsvd08zzmNBsljSktHx4VgG30HeEPrU9UR@vger.kernel.org
X-Gm-Message-State: APuU4Z/f6B/Tg+UrKdlxmDzU4doTQzsT8zt4Qg21R9TgjIldNgkGck3C
	QWeuJWy4bpe4LM71XjNU5mJhJl7NVmnt6jLFDoK179bEdutDI1+P03BPS1v/UwGqGOu+
X-Gm-Gg: AYBFou1txWF/5X50iEj5FEHG7Toh3u6HeuBBbiMmtsX1A3Sj/Vm31XQW3qCDc6Rjb/5
	xezczK7ZGwVrlnxt402CkpvzTnBZi1FFlq+pOKP1fK7oq5OXrJJpNrbN54zBIEuSujpD7ABrFJp
	0EwsbwL7v6BemArMhQ4PLrs3bGnQcSjw+K7cl5B6t5pV0yQ/MMVGoQYZcKMjj9tkrtesL8sPo6z
	3eZl/1dLf0rpPqQt51bslNbHd95CyyjGBdfsR81pAUQ5JkESb6m8G8LM/R3U0g9w8sJRn3MruZc
	KLJoG0QWMLrEwK4VovOVBWzGSDwO9weeJZwfct6qqrzAHYA6AD55PJcDy0f5lutX2iTrZzwMjOV
	D64stjRkm0Q/HFcgNxQAqTK7ZarfHOzorCZEg+joinXFeQijo4iIH4PCf0+a37iX0DNH1X6Q4JT
	WWq37QkewmE+GAteULB8sIO/8rurIPBvCBzcxlRkq/cBWeJkxOcUccxVhhyeksN8o0ConYZPS4N
	iNlOIOg7g/AWQaJ1ZD401m9XNdm5y8nXQ5vgqAQl/4C6+2rBrpsFSKEQXgHeX5vMXDvQh+DxC/n
	hHWl/RbTSiVIY9U5y+bDpFbQ5wGvefWE1xYjGUyToTPeXZlp/Cq+SAe3rIuO1g9ot9V2yzW+faG
	XfAWaPiTB
X-Received: by 2002:a05:600c:c4a3:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb55a02932mr40317635e9.1.1794564726124;
        Fri, 13 Nov 2026 02:12:06 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2842e6sm142085915e9.4.2026.11.13.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:12:05 -0800 (PST)
Message-ID: <82d691d2db7579d9630bf89f73132e36124bf74e.camel@amutable.com>
Subject: Re: [PATCH RFC 19/41] smack: use fc_init_pseudo() for smackfs
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
Date: Fri, 13 Nov 2026 11:12:03 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
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
> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0security/smack/smackfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index a72bc7fabea9..4a56bbeaeca3 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -25,6 +25,7 @@
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include "smack.h"
> =C2=A0
> =C2=A0#define BEBITS	(sizeof(__be32) * 8)
> @@ -2880,6 +2881,7 @@ static const struct fs_context_operations
> smk_context_ops =3D {
> =C2=A0 */
> =C2=A0static int smk_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &smk_context_ops;
> =C2=A0	return 0;
> =C2=A0}

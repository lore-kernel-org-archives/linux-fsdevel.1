Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904596;
	b=HezOyfz/Bu1X7IRVkMT6wbS7boVHEdd5e2FHD4Nydrp7xMf7HghK6DZLf6aceKW9o9XF
	 TPf8D/e9NbTfIuxigofCU4+NfVL2m0DvYcjxxM6zvlIcmN0E36nNpXJMlpgn7v2w3QLVY
	 5oIH19bc5qjw8mUJ4AX3rt81w+WzAbJ4hIePqvBL/AIrlWcS7JmYkgwrUhVSeU2Lbxrlt
	 vlvkXrm7HRYCjqfW1705t3hd9HesLWoyCKyswYIAb2S5QVCoFfE5PbHJF9et+VIvpbPvG
	 7Sn4+6r+E9tma7NqREk94usf2v96NLG4zvA6PGxgevnPZxRfsYvn1xhpHoW+a9Fp6eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
	b=CKz1oO1kfwoQDFqs0qopDtIn7WKcVOXuo3q9PWoYZISXLh2NHyetABCo5voQ5UipxmL7
	 p1du11uhwIb8JPd8AnaIhcLL19ap1UpS/3OgynAoMs1CP+zVzgeHf4Pwi9UKuFPx2Bxg8
	 HXNJYmY4zyVszwQqPnmYRmw40GzxO1521d14cus1nhoFJbG5w+kiuXtkvEQ2QeqqddPEh
	 Z2LpK21v1SCYriJfo4HoM+zT2vXrpa8+xL9kSKrlTw4h/XaAXmWFv4En1m43tBvoYv+IR
	 O1QqimAxDVPuqn7jtQGLcsjyMkon0Xni5iwSpVGRNZo0+xIoLpyLYd2yYMQ/xkVMd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465B606A89A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C465B606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VB84C1sh
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so17252385e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904592; x=1795509392; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=VB84C1shjSG034pSk2oK3egXlQwWjuu3VjrdbAKPawk/Twv4Yif6yhPlbROFWtMgPQ
         3tz2NQZOgPBk3fq0QRZC/paJXFCSb8aJt/mhh+A0iXMTZvR4a2C4xo37cxqDT+bS5wyK
         cFfqQ64HX4H+WtOYlqmaNWk53bLD4rVzH3Dam/22N7EldMgTIeT60YiznWNjIzN+eEJD
         Zc6kl9xoD3REW2KAU35dfm9/7zuNgWUL6hteTTxoqyJmYKiacM/NYuvwNSKHsMwzezat
         1L4qftGlpMPZouPAaee8sA2dATEpRVvU+RzrgkUS2mvSj/+KFRi5Npjbd19v9tUdsF88
         Zbrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904592; x=1795509392;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/hxpfxH2Ygjpkkpn+gEQ4NFMpeA+YPAHTw9d0qdSc4=;
        b=mTJH4akcu+F1VKhvNQi1PzlHooGJz9exe0WTBHHnipcpPG37TfGC8988Anr+VWBcwH
         3vhnttCBkNFqdvL2EmMogAESCly08wLYEpaUBSX/SCnz83/BT660YyP6ipxs2Ncsx4q6
         L/XZ/XcWIFcvQuTzDWKn+kJSlbueGdgnluCv/D4CNouNOoYJvx5gm+ZQFRMDjY8QgAUb
         jqbpd72SI44Ee7l06y0ZYxS11ICXgGLfzRC6Gt0GNlrkkZbU7tUdx0XjxvbEzfEGyrYw
         Fe53CBEKY0tAeORwRV/cGJEqdvSIUeu1PA6JWswOvPoqUM8Kp/ipU3ErA6drd/pP+GZZ
         Gi4w==
X-Forwarded-Encrypted: i=1; AL+hErGT7QteA+2BY+ARdT8L0DcD5uXSEakHWtE9e9q4N8+n6MJCZLbBl1t8W/PI9NKoFLnKIWqYizdQalG4dptQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+c85qmWvKUn+mCPRnQY2508E3BAuSGDAByQxM/ZX0Xs0pvU1QE
	72ffvSdCB6Ri1wihU9UPUrHJxCHQ38a/h9ze2AQrlTstVnESyjxsdrk9Lr0yaBrf0Jtm
X-Gm-Gg: AYBFou2302lSlGs5h7lqHub4DCygG2Wx8tv19XK2bkvJ1Rdch05yCO9JuQQjVwqOIjC
	Ff4apZcwe8cS56VY9f0ZsDa2uSVLOIEReUUSz/cxhYeT08HFpaGLtAaDrAb+MMg+7zI0lpdZreg
	bhOIeXliU5YPtpLPfaEOqBGiOdYI30O73BD0Kn2ZnnHhYaGF2XoMv62s303IDwfChxRxPxisCye
	GgoBlx4hX3e5+v5XIvfZwZV+swTzn+ObpHAGKmESU//hChJaxSLHh9hRaKQaVo+lGS9urUJlvFB
	klHIXhf7yVmTyERXPDl6wWuAF4Y9A1sWoByR3kN0mzckefhOWoj7zsf05T+EcqZeG29sIjUOOIT
	CFFobaWNgYFIrAQmrznlhim+htL369RAi0gSGYrk5ffmTndk2lUzSHttVREhA81vLJrgrBHf8ZW
	IxVhnrb4b/VqekPSgA0V/YNiQ3z790Isdx7qlrg9hY3QQYPe4q6b6CLXzRbDi+KRrCmAfUg+a31
	lO7EWdFg0Y7m38vkrspYSrUUpCFXAxPqyAsyOdPnCvb6AjighfYaH/uOlMoe2+WYKZ4+S36jZHR
	KIeUjCe+AudKi3Ixk/3QUVlxV/uaYu3RRg2SSAJSRf4WECc3ULDN9dGtQ477y1zMYIMkMT5bufb
	kn7VOO2GLCaOrsUexS51Rx3i5qSwJ7HA/8GiRRNehBOumxusDeLBy6LBI
X-Received: by 2002:a05:600c:1f90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb55ab281bmr266345525e9.21.1794904592167;
        Tue, 17 Nov 2026 00:36:32 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430752sm52548565e9.12.2026.11.17.00.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:36:31 -0800 (PST)
Message-ID: <411502f9a4f940c223b2b88d7e19fafdce63172e.camel@amutable.com>
Subject: Re: [PATCH RFC v3 29/44] s390/hypfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:36:30 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-29-8cbbea1cf34f@kernel.org>
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
> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0arch/s390/hypfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> index 559b011e68800..8662169de477a 100644
> --- a/arch/s390/hypfs/inode.c
> +++ b/arch/s390/hypfs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/vfs.h>
> @@ -301,6 +302,7 @@ static int hypfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	sbi->gid =3D current_gid();
> =C2=A0
> =C2=A0	fc->s_fs_info =3D sbi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &hypfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

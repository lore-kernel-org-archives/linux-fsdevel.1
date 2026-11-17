Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904089;
	b=lKHoEvy1FIhbwlpmzJoiAT1OSlPy8NJ4L3xYYTdPIcRfwRSAdpEk7+MjlgvKPxE6JZ/4
	 2gV11HQlfDsWX05ewdYO+xhhl68Iaaeh5aW0ixMuBlHBhqn1qePMwWTVwNNn+SMq1iutZ
	 WKD4EPkQ29nPjY/hVX5JRbBGuLp55/FOPJT8+OTMuChmkWHUYBEcyx/CXvYOKCFyHJVrt
	 Ac5GaG0sgwl2alEvc15t+yzxrv2E1Q2lE3jasikJPr2qrLw40L/4e8dqMXxqkyEtN2vjJ
	 aKKgPUYlR8bZ2LQ8TP4oFN9rgTqSN+1TwstN4a4+9c7e1s6kAGvEGK/zdJW6OSgdMSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904089;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
	b=J81nDZprH6jzra7kmTfBFMguEgZoe/kB6DiO6KxpiKBHleoxZ2Yktp4uV2wjeskZsyUa
	 7cLNKopsV3mKlo2FjKUKfMmyVCrexnOVoat6ezyx0L/kUbyfxrTKc3BLvvblRAvM3vYew
	 srZjHQPCpUHVGNGQGqPEY7S1bWbGKFD6CME9QGT1lFr2LfwsP3PlzIxXgDbmGk5cWtWrN
	 DJ1RwGlS7TRUh/mB6PXWWYEQ1Yl8L5w0FOmXvpeOvAvhKfnBHTkTmDQVIGfkNk8OYGm6j
	 MnKziYK5RykhGnL0aFVYtiXnV6f93XbEWOnpVQukYnIcGtWUUvCTlZAVLChuti59SoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB82606A898
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FB82606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=G5kPAzk6
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so47025605e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904086; x=1795508886; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=G5kPAzk6YKyHaocuCdT5IFslrUJH5/ldhNVhV6xYWUthrOIppv7Y8kBtZdevqAkpzI
         BDRFsu2jrF+YCozPia7EV1j3KLeZC6Lnc8BgBdPYFaePytvbOESC0m4eRkryqhoEbPxE
         WM5n2Fa2IGRg+WkSIkgfyoTemIrDdEbfzZV+2Eacmamzzj+t+HuCPRqV+GPswkKxuMa/
         2fm9UdrHUV6v7jtlgmqycAcrxGUcSbURHcUFMMj9LS/XjgTFJtp8hDDDARovdS596Fjm
         xwkar34XXNuYsLWY+RNo1AZ45FE/L69efZRvwjPbSAF3CGRgr3AaMHZz6Kf/cz8pCVs/
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904086; x=1795508886;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AET1JHslkSzLNTOs00e5qdhXA33kuZnL+yhN5Q6hFHY=;
        b=Teq5SpVhkC3PRXiwI+sAP7hAsI5U/Kuz2Dti71y0mCEgJ4VUWkV3097nRSnaX6yqmb
         AXq5MG3ymvIu6Hm5A0Li2XVtQdeUbb1DFVAWoFgZ17cWjI6BMYEOB3aSiYpSwk4m23Dg
         UhHdjvb4PEoB8M+qyn66rpjjqmN+3b9i4N3cDosJ6sxt5HojWSEyFqnGHzXMiDF3CX8z
         mH6ZlzEZvdZVPDrvJpX8U0C2fluHNDWhQdg71mShxr/uiLSt3V66yQ1dS3AKZOajGIZA
         aNAXQOO+d9Z4lCCa0pHcWqvVEaka2VtcYRzRlKzfZQJyzvFnh9m6x0LFzddeIrLlxwa8
         KpeA==
X-Forwarded-Encrypted: i=1; AL+hErFWZ5bkm7QlwRAaq1itR7+46fbnMnDhmp94WxquwDglrXQWcMqbDPnaTdyCxTBG902DwnR5g/1/1NxCwShL@vger.kernel.org
X-Gm-Message-State: APuU4Z+XRFRKni77gCilaxR+TAHzCTQFnifT14/F0ZxoO/tYIlhhXssM
	nHycXrLYyCv/YGK6L3XSMfNHsYnrXCiU4W+efOAHe+PVxLcF56tWHCEpOIRkw57dEWJP
X-Gm-Gg: AYBFou2SiaMSBNj/wT9yddHjtDOMGC2+4Vogo35DAcDVpkcdpwait4K3Y9Sl7RwRW0L
	QC6+ZaApedd/wQdjX3oi9ZLDLUiqcX0tOwiLkB5A4AznpI8Rnyziazmscy98glqjLXnDBah2gbd
	bjciQdWOS6m11JH7l3cPaT6Rp3vyPFEuXWryBbiwSQzSZlQrddrZgDVKU2vPa/ZlL4L5drwGHJT
	HXybV8soSBYBjYp5Mhxof2Ul0sFNNALN54PGGwz+I+X5MsjXN33HfEMUbkWycLI76WRz2pHk91x
	cdo3/NF/gSyyPZ0MNzwEyDVSh+zai0HXbmqux3INgNE+cRPl0ccvg1CuRdSLIuM7FxXLZFEVSzB
	08Be5FvhOlOBB/EatDoH10scjUrP7x9Hyq/UKcaIAY/9fpIoV5Nw78PKALC/elM1GVxLQXyZ7TL
	zIiA3YryFFgdqAj612XykDIJu1vqaeAfnPWWabffveXEE5ggSjOArny1BpZLAhM/ZM4bEYwkcQ1
	Ep4xh5yQ/9uCHLHVAbUbq91hEL769GzOB1rVeCzcC+sbI7fmN9hU0DgMq81Dse3El/xtvCMBwgy
	KwebZ0+XRDi37oDVw0yDUccWwEzCxSvNO07uU5hKiYzIi97TTeDIXUsRrtubacJrExzVDE3u3NZ
	5EizfvE29wswTGrgEvIOSOX5n28hePQl6cQbq/8XVDYwoLkVhUL/6+P5H
X-Received: by 2002:a05:600c:512:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb55a5aa47mr209766355e9.19.1794904086313;
        Tue, 17 Nov 2026 00:28:06 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm74782845e9.8.2026.11.17.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:28:05 -0800 (PST)
Message-ID: <fa0ce0f7ecdbe91cc6773bcbe86be137d2129944.camel@amutable.com>
Subject: Re: [PATCH RFC v3 21/44] nfsd: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chuck Lever	 <cel@kernel.org>, Chris Down
 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:28:04 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-21-8cbbea1cf34f@kernel.org>
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/nfsd/nfsctl.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f32311f2d7cf9..ce2666deddbd9 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/ctype.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0
> =C2=A0#include <linux/sunrpc/cache.h>
> =C2=A0#include <linux/sunrpc/svcsock.h>
> @@ -1375,6 +1376,7 @@ static int nfsd_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &nfsd_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

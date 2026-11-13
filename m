Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564808;
	b=IVZmCvQSJxaYUagqE3C9Pj0AkVGPILdplyWwzHPzFJlPP7F4v6tJwDD1W6lxfQcXGyAe
	 ti4GC6rNyatxJMO9FgwM4Cly5KN0UfEOtn6IQD87qrHBTYSsaIgSsOU+eYc55ptA3l8Li
	 6cSvrv8FXpuaylXcdZc7OcKql6UgApyS/oVMFWlv0JxRdAiWxlGN39WFqgPWPhbb6sFFR
	 2opjYgipP2m+jNCRyAKW7T2z3/NcreFDvT7r34bxzCMeXSVaECsciZDXnJ9/qkqtNt6l5
	 rY4pyQmXgVmKMI3LI850bAf8GI7VRTNFWs3jIoHY1G1innyLWaQVC/nG6132Fh+r6xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
	b=V+RILMZUwY7/MdGJEDEm1aCSp7cq1IuMqDR6nW51CpXcVpKfw/dDgaSL+eutmuDj2gXL
	 ZHfsuDAlkNg0uaDCnKuub7Q7P/rHMskx5x637XkYU0X7pUfHRTxidCqChYLa2LhkUvJl4
	 I2cgiUF8Je0xvwqpTa4FAkGFc4qdLGaIIfSW0JbCZH3OKK/X64qFSUrvKJ8CYr0RJqbWV
	 UAZF26+ijzO0EbV3dfIvLV25ijJncQh3h2C7AAcQN4ivVxm1gl3Uwvd3b+RNpA4KWkr0/
	 RcEJFQ5dx1o/bIKyE4SiAekxZMcUUVXiilICszJhd6LttIMglFZHJO3PzYiO9TYumsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5366606A88C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5366606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rqBNEWhe
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10214365e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564806; x=1795169606; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=rqBNEWhefqtER2dpEJNVPTElbe19fVdkNyIzbVbNULqUnWk9JP4TtodfrAxZg35Ufq
         +ciPTMXXDC3Fn73QdDq1nxL10hoZ0LEMTSuk+HTluWLCH3mNQBpp5ecm/W/Lr1PQghIv
         NQThaRjLVubmwKFzY9W4H2pkvpw752j1vTd8XwcKuq70wsUgwzLrChjclsxLFe4j6CXh
         P2+zI4RYwkyiSmtYnxi7mmM5Yw0kfqLENKBervoD5JNkytp6QIULxp+qmuf3k5WOFN+d
         HC6ACfaHkSpUVoBZwd9XYoAangfmrtxV8FymQjjH9iY0qoozDauX1oxEdXhYxV5zTWYW
         c/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564806; x=1795169606;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UX3uQO58FXw3i2m3kzI3o8uINYIcsljrdUAfEKBly4o=;
        b=2A6feog5MC39uYIbqgz7nCDBpFGI0bf+0GD6R7RU0bJDUVV4MPNjm7hGCV8pbAeAp3
         7DRvcs2d+HTVa4DfBddMAn37q/bZpUMe0pTt7Toe6lPopTkeoKVCXrjMME1L2NiVQthv
         GRDQcu/wbmgzyF8RTteHfw3JXRUzG0Pe3WCsy5MMhlfim6q3D9Y39QXl6vWxduuC1b69
         6zc2n9ZahpyHHkkSKhzxje4K5i5TX30AR/BiE2Lya6CeIBEhR6XDV7yF0fy7x3E2qjxx
         DtGE9dMSqqk4irgMLIcGb/zZXxeajshai00whLNajGM8d6o4a0HBNaE7TaLgwXSfvU5j
         MLew==
X-Forwarded-Encrypted: i=1; AL+hErHXAPjXW6ljOCR0xtKNqgxUt7AJVNh4Slqmo4GrmPxbu4ikkwJeEM5MMrod9cFxRcPXNFDJ6RM7j9KyU5vF@vger.kernel.org
X-Gm-Message-State: APuU4Z/gJlwa9HHdXSlf34i2bkrJLKpL0ghkMJba9J8MPvIrNv8x9xr2
	AfpXwpt+5zqbJHLmC38ChzxsNA2jcvv4yfQLmg9ZBZSGcSowU4wQplZE8nNN+hrBT384
X-Gm-Gg: AYBFou0oWdCNcwcs5bBNiriIDfXRKBE++ux0dTzWvzqHO3/4ez0x5HVBFwD/9loZUZW
	yA6w8h/HCgVyRTEx6asWDhB49ot8iNxfjVX9z8vrjOSCzBNv+KkreuRbzbSVq4bmyzBt96lWj0d
	GdSR41BtCmRHdnK/ehA8cm9K2ZIWENp1WprE3zrOg+4ZQW3f4c/mLA4Dnk4XHXguYIZRsZLN04t
	lK8OpWn9lizRIlqC7SPDV3OYBZlALwo6lRHe/VMe5ez9dYnZ0HE1N7+HRUa3ewT+eA9tktn+I2Y
	7UXhrdKhdL6/RGqwuo5FIRSQoRqHVkeFwvC2mY/TAPXg0KuDr8v2DR/hmNuhAjN4yP00TuAOI1r
	72EVuvoJ6sF0oPYzFgRPd0NXptWDL44+cKzw9Rkg7zCpzDnCsdjgANifzTaRppV9v5N7Ld8NDHy
	OjLuwlJ7DvAeffW/YpxpPPxIRhEBpRYv3NbXPH8SAYralw+7m4VUyNLRLqyfXc0Pe3HGCSAAhw3
	rUpR2+dVVyrqspvpu5J3oukA12V3xljm5cNEPvWvaYTiU6mTFFkf/giMsbQ5i3w45z0AyOd7fZk
	lliiEbPAa4G1qJF7QT7yRBnpA0j+8bxQkPTqpONgAdG++IAbKzTpPV2jg8GM6Iw=
X-Received: by 2002:a05:600c:45d4:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4bb559f6f31mr43583035e9.2.1794564806374;
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm4362275f8f.49.2026.11.13.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:26 -0800 (PST)
Message-ID: <23edc29c421f5d4c1103004f79e104e9f94d42c2.camel@amutable.com>
Subject: Re: [PATCH RFC 23/41] fuse: use fc_init_pseudo() for fusectl
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
Date: Fri, 13 Nov 2026 11:13:24 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-23-4c998976c6c7@kernel.org>
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
> Initialize fusectl as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. fusectl never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/fuse/control.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 21ffde596d61..4497362e7df0 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0
> =C2=A0#define FUSE_CTL_SUPER_MAGIC 0x65735543
> @@ -334,6 +335,7 @@ static const struct fs_context_operations
> fuse_ctl_context_ops =3D {
> =C2=A0
> =C2=A0static int fuse_ctl_init_fs_context(struct fs_context *fsc)
> =C2=A0{
> +	fc_init_pseudo(fsc);
> =C2=A0	fsc->ops =3D &fuse_ctl_context_ops;
> =C2=A0	return 0;
> =C2=A0}

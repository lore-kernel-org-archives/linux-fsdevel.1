Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904006;
	b=VVHYuXrPbfXL9508nJyddBNuYHMWopBxztELql6VsXP2qdQimdB0LBJJEuZSbI5kXCGb
	 iKfDP1QeXEcbCo/KAqKEMT5B+RVgYRwl1YIIEf1e08K2b0kc4DtRego3nE7UwxiQP82pS
	 3ErPJzoTBN3NLJBlNUBgaXmt6myvKoGvzEnFs452w9sT5F37e/V755Vrw5iGmNrzneLRQ
	 34C6pbCHfaFOdIULwO00bKy/1gdutIUFbWFKPfzw61aDDr8t4gNxEYeVgZbOhKFQ6tTkq
	 PuLgbdRzzrFLCm9dSJRpNgZCRb3Ia1UcUWdczA5rmxPWMKRg2UJaOqAYQfU5F3Ri0hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
	b=0gpUvQwFKnObF7577peSPuiRI1r58XbUl9gWDbrxwLNEUcN+AImAGeV5cvqe8SxT9qp8
	 RZgj/0QT3l1S73pRBXOB77gAiLyiEasExutKvk0Pwq6CrfV4rjTUrqF3OmyzpgvO3L/S1
	 zPfWOJq9YPbkts17nzEwMZYC/KMCZ7jZz1YWj9kyMgunXlwffCT0v4UUtnUoYJQHmuVeV
	 MjMqVRT5Eh8Jx8L/KYs4PjwzTSETsgs/2JWSRG/BfdIIWBwS8bzPPtCt6q41bVEb2gCwC
	 9WP1OwvAeBoKCntO99+qiXkXPJX79bnBzto114ShpK8Rv/SyZ73xWnlylR//cMlBz+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720F606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2720F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bh3COd7Z
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a358881793so374287f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904004; x=1795508804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=Bh3COd7ZzI6TmZdb32Fg462zWvuh7WQNnrUpXucHXcpV5t+t8gMfKKxOWwhkcHBcNt
         zIJKpUT9Ten8K9xmb0ZHj3p/ljeyNVefWtOpjWCo7Igmb/P1wzmYs63YOxLg7f+WXmDC
         wf3ao9cg3f1DrvZE/oBKoQiWFPBKSPnWk+jCT2CGoQgxeoDuJREjXd8oRMM0GizRyDLq
         q7c8W4Fdq61I08pJrjWNPm+S1jXNjmZ2MpEutx4SYZ/JoE6iRzvUZ/uRuGO7TyWDBzw1
         OlncqX8aSwrA8zDhY0Cn+N6eWM3qFfFk2ULf9A0Yk8lhKFDJjJXQbcxKbI+h6RZ2p0E1
         0Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904004; x=1795508804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=0EXDT9d3bBY5kvhaX0uxBTL5L1FTI5L2EWkK/DMj8sdhzv9WcgMCSb9IBmNHKKgYt3
         +nKqhXKtMs7HXvjsSH4hsY4Pkh49BsVopOGRkiho1pYXY5LIj6W3SwqOafhFpaMZfGRw
         VJinjIE/6x15Ny4gyICQlU+JYRHsvjqPe8GPBB/me0Z4tkfwcVvsd7iQ//t7HUFKfB+A
         v3R0rRJ7K0R+eoHMtOoeeOlOyVXwE24UVojmwH3V+u0FQh06skZcBQuRvOmu0FlCAgPo
         DoWrb8XXMubHJwDWOpoYsFsRnF6H3UlmSdJp4t6LISshpAKzd3f4+VKhGDTRY22W+bQd
         eBWg==
X-Forwarded-Encrypted: i=1; AL+hErHiXeLRkHikQSvvDYl1pkb5T+3yqNdG7k9N0R1prXjzpie9hmsG/PYJZ16czV/daMOjMxRetdPYlyzw6zKV@vger.kernel.org
X-Gm-Message-State: APuU4Z8b1QC2JtTL/PWFG+4muA9O3axBmHdOfik42VfDWjQYQ0pEdsvO
	zVBk4HyFP9ycFVwXE8SyI//CBJJ0hiqFDTJHA/Qxt/b0Iaa5OIJ9XKYP+i5pp+FFZ21b
X-Gm-Gg: AZFdTZexazBsJYlQqP74J+kifd5BvnG/zAnVmm9u0iJLSP9QvsGAF4a1dDqcpwECbGf
	YNrPIiv13+WNRC2KgvxgWw6XLWXVNYbbkD+EMUj8BKBOO99FL0TqvcD1vPOv9UGCBCP6Z9QqUYx
	8m1qu8jUgt/BG8i7LKddWRERnFJWxwgOynjTjwaJj+lxb5sjFdE4blfl1DLj5qPde0x3EWeWSwG
	yfN9g5gXr3P/dnYiuTUOKyfz1+IbICW+NwOf8CPjHMoK/vTqH+ZEA409vFNnPUXEsPbYT9//H/V
	Emh+87letGsAwYgEA7cmkobrcpusoE6Arkkf/757fPPWUHJ+f39YAT+QY6xASXBK+mmYHjeiyYR
	wHFQzUABpN2yBlKYVMKSQ5SbV8gvnqMlhyE57wItNbA9gCZXoU7cen2xpqq+nb3jIZqHdHmCu7S
	a7sOmlK6/0qCHPrdFhQA0rk6zJfmg3luRRRL7yf6KC9eAI6kq2/XnN8C1TZAMnG4LAx7ifSxLC0
	EEP1waG86IM9By162qBpd9+Ez5g6tjlWe5sR9KcCVPUOzDGPfaeuBuxJWqri/IpvxuDuNznjnfS
	GtizE0P/NO7cMLG2wpqrNFC5CLw6dnbBSvd2EPK9RJk8+aY7IPPP8Azb16+fN5pAYK1TRVE+rEN
	wv3GQvlhd6vpxd+cNDfApKfaupbOZoQoMNXPst3g0Vy3g7AGIUvsbjJpg
X-Received: by 2002:a05:6000:2009:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4a52e6a947bmr243585f8f.29.1794904004601;
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm977858f8f.8.2026.11.17.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Message-ID: <c43d70badf41f62f8e149ac024bab3df979fa756.camel@amutable.com>
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:26:42 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
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
> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/failfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/failfs.c b/fs/failfs.c
> index 437cdc981c2de..f03334f361c0e 100644
> --- a/fs/failfs.c
> +++ b/fs/failfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> @@ -132,7 +133,7 @@ static int failfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fc->ops		=3D &failfs_context_ops;
> =C2=A0	fc->global	=3D true;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

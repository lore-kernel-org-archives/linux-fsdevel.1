Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564173;
	b=UpI0zY0QdWNzL21gYgUDAVYVse0OASNHkaIM68uLBveZjSmpzQp7fwyM0s2HU+VHi/mS
	 qmog/FU7sEx+VLraWvmHe2c+96ck2meRylWihy+UkRHh+xepCEva5V5f2IChI74HvEDHq
	 TF9ymMu7U6TBGXcFTlh8Y7cLkYrdLk9K1GtGosWqQw41i33In4zbpVnLo5ijxHj2WsOLZ
	 vG5mYJKHGlDJuZqXh+Y7XdPm4XyT3kAjmEZXsw/0DfmynEEf4YNgjqAmFxMPdNeeEQD+J
	 WquFwl4Bja+X8M+AMKLSxEitZePTW5sAmCsHTS9pwEWvGznAKmyJGJIIFwLSn9owrhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
	b=sFiqzEgRqkqjbAFMO8x4yDXH57i2pg8PdvcK+CWzLGoSgpA68PJwlFJdFG+uzvsmUTQO
	 /d8LfMPnl0r1s1BBEA5EtrU12QD7eyLSDTLH4B/D+ljhvg6059397RfjIxmKBX+O1lZvw
	 az/z5vDt7mta6N1Elo/xKrS1Qhu/cjoPEtZVjjdXPKIxi2/+zr1BHbkMUGB0GS00CNLyw
	 PrTJVkVwmhqdYuYnpQLIekTHZjlekz0GaH9E31cim62Xzvm4PcnX8FvFcuBhCazZHoYQH
	 Gn0bY+FP/7239jbX4diO1f60SXyJqXw4q3vdDBQUShHs3RAYdRScdhrvIv9/AZhxuog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BrRghWve;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC252606A332
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC252606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BrRghWve
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so1163227a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564171; x=1795168971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=BrRghWveZPMQ2lrGbo6B+XUgpff5EufUxldGFiTipoIaiFawRH8FVJvDBChKSCm+0U
         qE7NrwVrHQo2b1oiTPINBjADcjfu8j5+2hiB9wPnUB0Sj/3WgVbhatfBxMm3U8N4KnOM
         ecLP+89NGaRsX9nOgSryY2U8lUIJARrslqQpZFBfoMRf7b7aCNcM2ESlmVVEcyz67Zq1
         nmg/xl76oWVlPrwozco+e18C71yw30j2TPM9TFHhbc2tHwAu5TUUkKbNr7mrc8DWNqok
         L5mLyN847Ry543yO7VRmUF69tZ0RGoya4bqZfEDQ44XXZ70j+SgMCotFLrfSWds1gzqN
         VQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564171; x=1795168971;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=18cWwm7dFbbTa2jY/ms3qUUBIwxWV0BhTJZYGrxWfN91t7TSbkST2DEgaNXy8QNh/5
         uiIEBfDbOfGGB+0aecorrBulogSs79cXqGVB6LBKUT1eyPnaM/fa4STK+kXQmBK30JyB
         0kogc1z8bVyzYkdML0jmUNRx2JcbSiij9o28tLdmwTTxLlha66Hk7o5o5lBxLqW/xJYR
         WyEW3Qe0xmPI9+tvR78TwJoEiSWuC6XbXRxfUr0ZBDeGO7MU4w5Aijlw+zRG7aeV6zic
         rP8yu6dZb7vRGXsUT00uQUf6DHF2I8TAsLieP1EtwYTGsOD7JVlrEyiTw9lZQUUN6WaH
         ApGg==
X-Forwarded-Encrypted: i=1; AL+hErE/ZOkuA17R7Q07zi+RLQojDElaHzaBYWoIRJZ2+nY2wSNJfahDCMW89UCxs65sZJQcfLQAE0QX59amircB@vger.kernel.org
X-Gm-Message-State: APuU4Z+VkpMttpOU7K002zgAzB+OOJ/FprooBviI05QmW2XiJsXWizum
	rsy04zap78YE9Z5WQAO//n4va/nziC7eTWXH3iB36r1wTMXynQdRJer9/8PRlfvIX/k5slgqvWS
	aZnsDWzImJPQ=
X-Gm-Gg: AYBFou22IdJuOaEpKd9+zvulLYR8a/vNYhMkw9VJFf8OGukL6BXz8ZCHamF/4p+Hlx+
	Lg1x3XeI2c9V1UxqjQmimxr1x0HDwcygU0tII1DsLTNb4CSL4phyin/eZVQTIm4h8vbtld3oKrT
	WHYG0GMhEiDX2f41HE6+YxsF+WqTaLhZJt6CYln22w9eR4ChkTyapaasw/vD+vxnBP0J5uQtoCm
	uhOwwG6Cd7lN/sJNAsUJx42zqA3MdBj7JXAL17gvXW9o2Bau5/6OzVsM4JZ5sygt2XdZzeedLsM
	Q5nKe3ymnHB1zIQF67YB228jVD8D3qh/GshaF9TANJ3xuhu7IfKf+ha6E+EG83+P8nEs8mQMKEm
	SK4SAt6AJKs6ojhTYpjT/dWdNEqrSv1DoAxxvE0GfOkLDhZukPFITpY0r4kj0od8CEO+yATmXlo
	rqlS0uK++u8ZZvEd9S7pYyquUKcdr3o7gBa5JIvMwtA2tsLjLAd/TYLCuJm9N05ebOZgGP634YB
	o2ivwodwoi6kJgQ52qqMEBo4ess0vVr+8IN1rQ4Rl+lySdb9iVJ/YQAbRrZLLcUCIzafah/rDBL
	ydahyjLr/rCaQXSMoAVdtaii7tfGFUojeZXKz1qQb1IamSOi/hPR+hC1jncqz1k=
X-Received: by 2002:aa7:c842:0:b0:6b7:82cf:f69f with SMTP id 4fb4d7f45d1cf-6b7c0ceaefemr1298014a12.41.1794564171137;
        Fri, 13 Nov 2026 02:02:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c262338csm739270a12.33.2026.11.13.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:50 -0800 (PST)
Message-ID: <06b194053de4f4b65895248d1f2ba29d42a21b17.camel@amutable.com>
Subject: Re: [PATCH RFC 06/41] proc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:49 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
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
> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> =C2=A0fs/proc/root.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a..ca0e75081934 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/user_namespace.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pid_namespace.h>
> =C2=A0#include <linux/fs_parser.h>
> @@ -265,8 +266,6 @@ static int proc_fill_super(struct super_block *s,
> struct fs_context *fc)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	/* User space would break if executables or devices appear
> on proc */
> -	s->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> =C2=A0	s->s_blocksize =3D 1024;
> =C2=A0	s->s_blocksize_bits =3D 10;
> @@ -350,6 +349,7 @@ static int proc_init_fs_context(struct fs_context
> *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &proc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

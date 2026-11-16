Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859450;
	b=eCTrA8DN43t2MBTB+TiqatLEdDLGtT1pjkd6uwgpcORAIcSTW6ai8hK/mHs+F4o4Vt+k
	 nQ+sEQ4iu/15xfzQc2doFWCbze1h0FNeMBUapnH/j7Z2VlrsYd2Dx4o8zjLrY0DAjnWRZ
	 fbtFRvpR7XO6V2z2JIdNwzrxlNx1jkGdqKniFUYkJ0OvUHUyVH852um3c1AJ/sE0RGZC3
	 cUdxsGhWMKpF3LxWR37oGvcd61ppOxxpJM6ALZ44pobo0NmMqR7jLH5GoB9M1n4yFogte
	 hwwgM1Y+4MUeG7LWTwUkFpaONT99tgWXLTmRAuY3XXFphtHlQgh4iGaRAuQfBfCB3iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
	b=c6UDhOfBnocf/ahSt2scvnku0pckpy6K/jHRwep7+ztZJ9kfIFB6YEXiHlaaqipJVVd+
	 eyBuHYkGgWkYncggyH2xgtSiDuNFkTjZ8BPMwaOhvCVzf+1GySvyYQXIMeQsUXpFuvbK4
	 8yhNBPcqqMAPGiAMp7r4SRixtpVAuhPolZ9PS0sCzI2tiQK94rrGcOF3EuSLMbq/CeHHN
	 RZ2BvCxtE+rGnQ/fIBqUaK6IwIAlXxzqSydsgqIV9mCQnX/RlUiCpA7mErR/V7NBFkSIf
	 uWgfTS6tWpFOyIVdKkYsXYuAvKCZod7T+jN1yCeawm4MkI5amszInRtP56/C7mtcRCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E42606A330
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32E42606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49a92144733so1559078f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=s6dyQfLa8uFv291obU3VmhlANGkKcZ20pbncJEy8PyogrLa8qQt0VjzowKC+dmeeIj
         YZBKZnMQLbOh7DKta1rMibnL0DZcaNp3wuSgskiMIzyG9+SNE4kItyy96zc4ZoU2P/Ce
         STSpBnqbD+tDoBG6HuT1a08zAIol4ld98qHykhkHZ6HuLgJu9zrY0KP350hmLlyIokei
         q/IpUjCnyNnL8MfyJIuSBiKb9a1pbJZwP/3xJM/+MVygG/XIraN7MpHRow7FWRy2s335
         xsoV0/KK2hhdgn0BxxgyuJ7E3IaI9Tv8SK8gF9WiZtqalB8YSJtIKKNi9voyJdgq2VYI
         uPNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=qdyr67nSZ1QdBrxiqi7+eoRpseLxzIz2qc3OzEF4hkw=;
        b=DAImTDutj7BBy0uBTC1awBhxjrTUX/wVgvcZuwI44ORYpiYIpmEoHXJkwiqttI1CKc
         tLvQZkg7qwtuDSzQfHmuFH7r9jT8Hno22dLcKx1Db3QJDdCFONF7N+uthvzzxZ8ESYCM
         qYW5IJ0wC4Py+KQ1dmWg94P7iBBTdJQZ8IN/j1tHzaUVngn+nh90mQSgCA+eow0cmtm7
         dprspTk1GqAUgrdJn5RVsqSIMNxu9gp6Roq4qYhFPMEmPlvNFwr4xqjRxTMi/YETgdi4
         pnVlTalhbwkfvrVIrK2hO8jlyRHQmCcaGy8IAhiriohCkK/FqwZY4lGOfJMf/y1ZIrcr
         Wi7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=hnqDx80H1BHGMZ+jCw863LQE2wm4hG6wTw//ziQNWkZpZIjdyNNCtFJNcbykSvuJWZ
         RrqgQGru9l+9Rlw9NCoAO7RXSeH6CHzRwb+h6TsbT77V+vTLtC7o5AslWzWJ8+7yhciq
         sbJxN7Yoz6y6VYO91QUyEDVlXVHt5e/uzOZriYhKEljZIduQH6pNfhdOY5sHlJFueOxf
         bN/uTLfuNBjnHaTZ+WukZQS/Wa30tWyiKsfqEPmOKtkcPCgN1gGIeLsa9pfco/3ZvP3P
         koo3Bb9/+esUnHdHS2hTd5qtXE/k/xctadMJUuU/zchcL0VDKvTRNofZgdIQ6mLOou9W
         X5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=XwSZBRqHQ4qSBEEmVKrrkTS/gERVVvKxM3deEHDINi+Pqr3aQ4/6c2UNj2ILHQuGQX
         /98z4R/2dd0wGzV4ytCxKbi2ztiHf8CIzQllgKeaSQTuGaDhIdHhVoFzYtSHirW8f43m
         +CnI5TGxt4GbBAhxkl6zBjLLC4leLOlwkpcpBDXyv6EcaouVos5vIKYwe/jI5PDxIFSL
         dgFmBegXVm2VSxNuDKQBjcCLNiL3emNRWyGLhlqRn5kQQFZCt4191m4fIWvqRQ5opWFv
         WfxIM0XPOaV1VHq6Ez+vIMYyaJHxdSaZ/HdKtTt5bvrKor1TIRFEH/YG8Ps5KbCN0Gzc
         QJvg==
X-Gm-Message-State: APuU4Z9Z7WH36U/q2TCR3AmAXo+MoBtdxH6kRANW0h/lNHzG8ForPnJO
	XJ1sUJbVU0OmfzXCz+4ioTSPDRmOEcYh4bVd2Cd9xBXvCVWzYjXX81cHlBLbRpzKglgoicb9jSz
	tcONhBtv29f1LwWeAOletwdlhx0xmkLI=
X-Gm-Gg: AZFdTZcshhND2MXEcNXr5ASL+Kbr0AS7miLa0Zbt+AWaWwtCob8sqFAwu5MAjifMWTo
	2vkmeHH/PBPcVG9cRHMCuc7j2Y15Pblujhuzh4WX0foHhK+2a4vtaEPrYMYSLwSpYdoS53IVtGB
	xXn+/0292y5z1EkK+3+7iPzaKB84rF6TV5EIqJkPeXZPM+SYL3H2eZwyaQMzBq4VeM3n9nPVfZR
	tpjwqEfcr5woiObbBIjOSPKrFY3GYV5hDjkBRY40mVt6uwiXKMxFqUU6JEFwT+cn8WOX4aN+qUf
	orCk6zvjfhFgCjHSOmMh+2+qqF8HE0SrH/hVkN90enFHAb/PFOtGCftb9yatAI2akvl3J1iQId2
	E/Ao3z3f9B3mv277MWe27ihUexUpuhHtlndjq7WBhhxq+wbE0rNPJD6cS0WsF55S06jIJ520x3v
	HOnR0l98ZKh+Bm4Sdc0jU=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>

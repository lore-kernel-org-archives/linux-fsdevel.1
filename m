Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904032;
	b=KFttmeOk85nLEqsGDtPO0KnBloNyWtEGDhg89qOKS4a8BrdQiFl3F5sM2A0FYz/fuJa+
	 zXk0Vt0WeoG+ZZATPkuy3h2JsShGErO0cE1Xb1LTbP1HV/L2vmzxaDYZ4JcO1LlpciYEq
	 S9ev7CJTWyxK/Sbk3bCBZ5sC6SRa4chDDwWHzfZVIf60ZcD+u+J+R19CaysjnJx5FIuQo
	 Nxy+Bgk+3lpvfsrgX3eE460VrnnZRTjwHFmuuGvK3hBYjXCge1UGiTqN9muq/Y9Hv6PeI
	 sj/N1izr1bgNcrkuiq1T59zvhfs5FQsQZZg6zXCHHD4uqM+Y/bylj8qkWT2A/N/Jrig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
	b=QDZSCHn67XEAhjNs/9fwNSOaWqXdhdXmUfrzMkZZ5eD+vvS4o10LqsoZOrFjrgKrylct
	 N8DS6SS/uEo+VIY18KXb19ZTiZo97Dx7pC8QlruhjJryG/KjMYbdstJ3zfE7/Swwp+sYL
	 FZgijAAn4RoAz9/U60cHP6JK7FIL8sUGx97fMisUjn5RFwUQe27+EHYeD3B48XectHNOk
	 H/7U2DzTG97r6If7gqgHqE4do9GXnzPAejHjGMJ/2S7rStrOre3xy4oBKrwfb0qlJrAHz
	 mhC59c6lZaZrfa7vWeSO1RbwDdBkb8ZFF9wNZ2VoVhSaqWa2BEtcIAYmqUmgEI52Jqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA239606A330
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 08:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA239606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m3Y+iV2p
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b467581b98so38964035e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 00:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904030; x=1795508830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=m3Y+iV2pelmutPYORVxza4CHQMpjq7iS5lmecWgDjvax6Coso4uWa+KMaCm+CB3bWY
         yM9xDjlaUDqClL2wfFs+3EgMKFX4Q8fuLgup7VSVEO3iDYFOyh4nyeN0Shri07+KD82b
         UFGbuWvBELdRnXkiKa1GIWjPRb4Wz8WRQUErt4eMboeCaxWHABbQwTZk6BuPw2NopAXW
         5935wwOL0Ggt8LD7VeJmtmL6iC6DgtiD4S4DRbEtkaj1swNFS1XEbe90cWaNyokAE8Lz
         Ulc1c4G0eNVUIpLzTdbViN3HgCOMoyHpu6hnCIZ+utcpbQY02w1kBKtCyN8iaUfGq6tI
         6sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904030; x=1795508830;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7Ds5Sp5DChQJ6GHa3pEkVZuOErJkij7LbLCUPT9+Pc=;
        b=BfQC4zXQWVPBbal1qGxRuhA3+jCx9IvlApmABz3NSDBpKK4wgPbpzJLQiYkpagBP1D
         AJCL1KfE7WKkArVcc9qJ6PhasY+vZsTbgG8oc7sxPslpRTGwyq4tNrNrQnAilThBBOnG
         jgCki1+1FRWJ7TnJ8ZiIV1SAQz/BQ8WZER/mtVaE7uhe59jLj1nrUbu6S0AxNl+vqUbS
         bwgBoetkewy2vz29KxkgjeMrcPe8D/St/Vxyz8opIpwY3P/bO/sUzahfj+m8pjmHUQk2
         LzgkovmlCNXAen7hk9mjI3yprSnZ1NMES58GiIh0U9Yx1dgjblWhbiV+aX1l2tuXtq76
         FgOg==
X-Forwarded-Encrypted: i=1; AL+hErFZdCoIIdhXSHAPB01Ts/ssh2RMe4kW6stFt9KHvttfPqIPjzdq4O3Ar3pNJFSAawsFMb7OtELSPruYfCNT@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZK0BEv+6T9xHRcizNTvptzPYVBTnyYPvS5oCXT39Ea7SbQ6Us
	701OHIY3rI+ibeDALO0pB0p7ExSMKqaCHj37aITtNLGVfNn0pXP8Sh9vKGVrJ85B+ZG8
X-Gm-Gg: AYBFou3yyeTFrYea9FDh3QLKMSm4aTCH1juvbttfoS+/TrX+qCq4ipx0ERW0f9GFCbQ
	96nLNe7UrbFaZeDblSSVU3AxeDL7M6HYSLgE/FmbOy0GDA6eEyWN90VrjkNwBNE1N2yrdpPq2vG
	1p0GbIcITenwjmoynkmAvkJPmdhavhvtWp+UuS8Piy95GriVJXozE+shvJUA1mZ9wWpAgCxW/vI
	q5hQhsMzJfCy5GVyopUksFLdVet2NzFyf/eM0wdQDygjpdkSYK3uDHWHVLV4xeFfgqeiOxDO6gu
	IK2sSSzXe8ftxJ/1CFh2q/WCvPFEuzgRrqrEcygsvv0UgqBuCgIZ5gHpoh+SeVtq2AaBHrVeEmd
	+sP8xZ2pHpZjqTVhAGSc9PiGg4le0I47+N9UiXMy0Mv3aKGQvnaihWS6mm8wA6l1brCP6JKeHLc
	ceHNm8O2/gXveW3y3IomVaQXRpBjliuTP4BYYnVODv2FBHEDMG+ZtDpnfqusn+2pxraFedfuenC
	4QTghjCL2EHZ+jV8ElkjSdKrggMAJjl6cqBZ9e0GWfx+8b60JaV8V7qS5XhqL4E8OHA6eSbBYJA
	JyQl0inJFSRP0VrIR2IQ1ubvoVh7SyZlgsPtUUkiBjQyN+CtepAuWaOe1q+k2YZ9q3p2Q3lYZIV
	6QLcw5dc69R8UuDz6wx/qY1vOzCExpB+SBMmxZK8ehv4QIhAmS6541pQN
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb6c71c232mr134135095e9.6.1794904030378;
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7838c912sm45730155e9.4.2026.11.17.00.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:27:10 -0800 (PST)
Message-ID: <0ec7b8c90cc456b24e5b19c1db673d497ae43735.camel@amutable.com>
Subject: Re: [PATCH RFC v3 12/44] rust_binderfs: use fc_init_pseudo()
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
Date: Tue, 17 Nov 2026 09:27:08 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-12-8cbbea1cf34f@kernel.org>
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
> Initialize binderfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC
> by hand. This adds SB_I_PSEUDO. binderfs_fill_super() keeps clearing
> SB_I_NODEV for the binder device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/android/binder/rust_binderfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/android/binder/rust_binderfs.c
> b/drivers/android/binder/rust_binderfs.c
> index 5f020226720db..04468c5b5c116 100644
> --- a/drivers/android/binder/rust_binderfs.c
> +++ b/drivers/android/binder/rust_binderfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/compiler_types.h>
> =C2=A0#include <linux/errno.h>
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/gfp.h>
> =C2=A0#include <linux/idr.h>
> @@ -667,7 +668,6 @@ static int binderfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	 * necessary and safe.
> =C2=A0	 */
> =C2=A0	sb->s_iflags &=3D ~SB_I_NODEV;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> =C2=A0	sb->s_magic =3D RUST_BINDERFS_SUPER_MAGIC;
> =C2=A0	sb->s_op =3D &binderfs_super_ops;
> =C2=A0	sb->s_time_gran =3D 1;
> @@ -759,6 +759,7 @@ static int binderfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->stats_mode =3D binderfs_stats_mode_unset;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &binderfs_fs_context_ops;
> =C2=A0
> =C2=A0	return 0;

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564363;
	b=sQxWP+Cfp418MvNrwGZYk+9q8ouv3z0PWg8oNqLfj0j043ngUwGpVy3SpAghlBX5X+oY
	 Tf8nM+R1+kUWIaLQ1MEaA1ca4I9WUbMc7VVk0NPiIkyVfzpTQUMyaqn3zeVhOUpKD68iC
	 w9AR3wh7ZjZ6Oe0P/hyfcm8BkWQQMYjmPgqgPAYwevp5MDs9DVZU/G/yUJU+BWMtiEC1H
	 atspD+Pa5giwJu+lZneRGZm35w22+xrF+8wJ6ZkR8pD/WYHvmwQ8s43CZx/WKYmPLUbHS
	 73z0EFa5ZYj8s6jiUKQTAdOSMVSRwDZYNuAbMskSBMtc+RwrGwslgp99osHAJiu1IMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
	b=I3buoQdDfSjm5sDjJVLV9nJQ7gaQXX8+fmf+RTfIT3M4mRK6fXDTlCFbBtbVdpg3tD6f
	 Uq1zgW0KgIo5SBxuHwo5abpv8xTwFWuNp6mYg0HPHanrFz9ZintVTlbNekWYQobGAE94U
	 zpvy4b5bUhloPosEAv+rH+YMY5mOMBUj5Cv1A7lw/IVhWDGn1fyCi3gn9sFtbV/rBFCgB
	 E4Sf0F0NF14+eg/QB1q2Q6Sj3RPAk0T1gexbW3rG9BfZHtUuINmP6nWd4tV5+qnr2bETl
	 yJ6aCeFruY9saJX88N3F/HtNeSYnUINv3lPFwiewiVfLZA+r0ojU7yhhkZFXphQ+YUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F3160A262B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1F3160A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cjEYfKb2
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4d427836e9so121960166b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564361; x=1795169161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=cjEYfKb2ti/xguKoQF5XePY0eNOezud7K33Duf47S0g3JkHBuObkd06WZKSsE2j4TE
         DEwnxkXlTao4933EWT51qAqcKFQZzBDYUWq7IdS+RrJUrXD2u7QTXDm9Wr29l+nlsY2h
         ba2aoEFnt/fnBZ4TqG8AlHBTx7MlaAOM8MSBIpLqFecTqJgM42mukp171NeFhmx0Zx4N
         EfXY8c4e2NVT5eQpV/Fv1f87MHIzBgzN889RZpIYFKMs83t0n9Q8bpafRw7OfeQ9pMp+
         KOGhNvmnj7I3xZktgYLxquasfZAW0tMnNpo/9hpnK424qA58Vs+J+ftPxNsRzOLYAEav
         G1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564361; x=1795169161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjkCmA8zoLhZK8u7U4HhR7QcElVzore/o+jClE5BdRs=;
        b=QQQe8ScN0JG9RudcP3MW6XOFD545wsEqLbaDNCD/X6W1MbD3HtkG2ZPdFfB+ld+ca3
         y/jyGMqdtjBsOA9+6x9X70VMnOAD9OWjUBSVgX1oi9HSQZIvF6f/5CAjQmjhe8wwMQF8
         e8aotWjsPRvn2qYSzAsMItiuNNmiMfRKzs4koKrd3RE0y1U1a1HDWFCuN3/CeTgr+8u7
         PFEEjdn9CCqqgr4GA4doMiyiLYfkrpFNjYkzUzhAG6I+twdEh73Ktf+YuV9cSwWYbrai
         OZ1ZHpugcSwh0/RonE8Fb2TEF8VS6lwle7CkhMWOl/jpkmf8su+70DqTdTD/jHLQOfye
         ogxA==
X-Forwarded-Encrypted: i=1; AL+hErGpAQrLvcpJg4xBN0jHY30irADEolk7bPg/t6q1lZkUSnnEeL7DntEO0FxlV1CBBPX6567Jl6yQY7LOdnaQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+UGMMHa03s2Q47GnPnjsujHfb3mEHN3vCgpXWgI7fokcRVAmOm
	rgKwDAKveVgqfxQmlYAeq6xhVXhFP+dhWG7YXs0IIAz0kinAhEX0MATJbcEOK+hlrEwc
X-Gm-Gg: AYBFou3oMsx1BAtNrqrV4oYphvLwbRfHij0haTjRpOBUk94TUOlWvJOGs0lCNKCO0qY
	f8h//M2JOkyPTuHSV+c6w2xgGMZ6NcroMvGYGSObnCYQVKN+wtXwOFd/HDQu9OdmJtTZw/lv2Ou
	kd3gqmWAjNs3/2QvgF6dxMETLnDYyYu48zhah3qPmfqAUr2qAGlgjN/CAKY+8DXw6vHYe2QdmC9
	n0f+gnUtb+o5g4wXRH5HP2raooFbwiqTDtx81VuLmzW8n5/ZWzDplcbmZ6BhB75ETvJanzX8d1E
	/iG2yQWLIkQ6dqHJNZJ8IGRhz9ssgxAtSM6MrXoQ0fxaB6ordI0U4+mym3u6MrBt82zP+zIvPFj
	hFz356YKPPOT1T/0E38mGC8c8p09FZzSANqvHIov/LIqGarhyBZgY05Mvjmd5ULQpM/jgGcScXI
	ohY9unRyjsBCE8LV7CuFfXAoZ0SPw7mKxbah9wbsxYYr8EPWnQwQ/DslrMCEyKiOvSH73NPYVOG
	e+VjS4hxrSM02anoum87pjA+foC8mYLNNS8GRRFTBoRLeiBZr86zjH8rlwQBkuEWcg6pGEOhsGS
	E508IAoy5FKdbA2ySW+aWU3J1QnK9rN8QxYyQILjr6fcVeG81RRSLgp8NwA+f8M=
X-Received: by 2002:a17:906:ef07:b0:c4d:5820:325a with SMTP id a640c23a62f3a-c50963dc627mr169588066b.39.1794564361325;
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b8651bsm73693366b.78.2026.11.13.02.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:01 -0800 (PST)
Message-ID: <e8b71a2778d7d7797d433e7bac1a37ee64aaa30c.camel@amutable.com>
Subject: Re: [PATCH RFC 15/41] tracefs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:59 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-15-4c998976c6c7@kernel.org>
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
> Initialize tracefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. tracefs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The only tracefs files
> that can be mapped are the ring buffers and __rb_map_vma() refuses
> VM_EXEC already.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/tracefs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 5020365ca704..e04febd868eb 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -12,6 +12,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kobject.h>
> =C2=A0#include <linux/namei.h>
> @@ -510,6 +511,7 @@ static int tracefs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D TRACEFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &tracefs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

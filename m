Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564785;
	b=heBPiqWHkMONBPg3N94UFRHSK4FlZyWnqmigua7pRTP6CtwTJVdmXt3sN/eYQ95oFMso
	 Q7+HdCojIkwhhAS7w/WdbRz9NYRMxoqslnz/8GFeE4BcB3+9R+iHkhcXrtkDHHbSZr0nY
	 lRrtEqc73nX9po6qBLftqYyoHY1MFWjYG7y3fJtz3LU1B8F+ip1u6LlDbo4aOU4hShnFb
	 +EgRkSPu0LEFSpm+AT2dGbHNv5bw74sf52BFp+4mbDlDa5ZHLWk4tPMHotsCVgT0XOgeV
	 W5+MjKC/WGDrvpdu1FayOb+M2IFJyfDF+5k29A7ci3iFn9nZIMZi4orSKbfX0csDaOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
	b=r+48hpJxezJYSGpQQAcOqYjrCiBmKv4qAxswbuCKh0O1FfqiMvEfldL0fahhgllfagzT
	 tKrT+kwhfPjAMbr7E4l6J3eiQZ9wgnTRrhdK4Sm2GlpvELfs/gxT2Wpu3exirLEsNyZyp
	 Ks1dU5/pHd1hUzp+Idg4iAARsMT6flP/wPDg0EGvT9tlOIbvSKgZCx1VN0coGAgXW7yo2
	 UH24Ghb2Ttcsp2hZ7lCTYJs4DjO2iZuh8Dj+xqlmBSWCL+O4m/JlCuhAttoF7y5QfELiv
	 h0yytYKbswgoUgXBQwzLRCuAkROHnPUcLVSZZGJMxeRbwlsubTQEm5hBVVVTYfAvqCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A8606A887
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 10:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F7A8606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=qhgXZLcH
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so10467135e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 02:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564783; x=1795169583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=qhgXZLcHEG/xp1ftPxi4Y+VtkR5xPsdZusiH6E7v1UVOpu+pQQwW0vkLZszWZiEzcA
         +BIaLUI7scE4yUL73wk7QDgrWayWPrLwdz+Upaai9wvZdfIC4mpAyM7/MboFd4cm+sgl
         6S6dsMSsgGsAMWrOW2SdAqPT3x/sY2fNDxpywpmU57N6cPKU4MQNdvXTLk3fPNzTNPjQ
         TN2vMd0rw8z+5ZJqFwtlFaNorLJKFpgZtePYZzAG9uux/UTV4iwPxrV7Aluh/WlU8Te+
         mKwCC2bzY5T7ZateqcC/h9wnCcfLq6dmSfmWCE2kpyRSPYXephvqiHzXHW2gW5l+Jqy/
         ZrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564783; x=1795169583;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=YnnrrrMtfiGrBcBrPeMkOCCCtcJ11/9EUIT38Jry5KpgSxHSgLkjGcV6ioscoXIcbw
         3QOfA41VIp/Hft7p55TFoQ+Qj3nid34mkLpgD8FmAI7cVtDMSQXLY9LdYq3bMINBZeHy
         QEGYnde9es2X7HYa67JGqiiYLGGtq5/24CHL9cSkJG9FYLuT7PPBDcloVU/EXSuohC8u
         RPlb7xt+xLpa0XULiSTPQzphpJuk6MHZvrEPH/074EZ6J/MoaZ97pXYXjAwEZqyS+plh
         ifS2tNvVd0/onCFsMB64VCtj9nkOFxzAlQfp/Wzy58y5+ElwcQLM+N5VuLoIsH71Ewbd
         hMMA==
X-Forwarded-Encrypted: i=1; AL+hErEVOmR96NxWmrdPQtbw6rKmniuC/XwJfEx7yRyN7oCSMRP/U4NfhdkPi4C5qGda97QAZYx0fsBDROuOsj3H@vger.kernel.org
X-Gm-Message-State: APuU4Z+dgNdWc3HuZzh+62st3MHhV4jUpfugWBsCX4UWzCXBrny2JT3d
	gylfZVKqrrdAMTprn8/qgZSkqFzSCkLfkGh8AuORVJzY0JULycuWjBgMmdy9C0b9Cbtz
X-Gm-Gg: AYBFou1hs1D15gMvaIidctwcsMaN4ekCfCkeNXrXwpA/5J7nSl94vLq9W0j+2n5vMTg
	C9X97Ipx+E4NRUsWPQqz2J7lUXQ75QJ5ntke7TnKI18wE7O8SRWYoHb7wHMpkmRZdYe1fCAq11Q
	8TCb4ptkdMZAr0KAnpz6J3hcjLVDtREVMgVOwJUxNGGh6FJufqRVp5Ek4pdP7c4XQofly7zb2g/
	GUslH1d74ELMTKf2OoaxKiEJzKPR/tAs0LhhPa8M0QPmWRDRg4vAkqVH3J/+93aLPodrOuZ9gtD
	bC+h8PRSloGKgEnKUKq6E/EYKe0OCFK2n4OQ0JHzqNjDABouD6YjycRJpOzU36krFnNd8vEwws+
	SEbdHQlzOAKZaGSeSpkwSUQuD8pFKbwA3WXOA2kZJ9VcgTg240VmIrelLA9KAoF5PYykizCv8Q5
	HisD+il1YIB3BmxINAtBGmCUu2OpwC4d9No7YpUj133XkzS2uDKZAW/CFzeBGc7bvfnl/AS3OQy
	WetNq7Zt7Vo2FQxtK6/4YBSsLir0mPfCulKWdpVEft5l4SW39zykPcqN9SwxyLBlmMX2FevTEt9
	ZwqmVZwsfOMnEpBXxaVg/MI+FNFqOmD2AJvpC+ug/YbtP5CC05MEVxTXswdcUL07
X-Received: by 2002:a05:600c:4f90:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb55a47602mr36814615e9.10.1794564782834;
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5d2872edsm4056955e9.12.2026.11.13.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Message-ID: <94dfa5ec75f4479663dd79f3ce05c1dc6c080185.camel@amutable.com>
Subject: Re: [PATCH RFC 22/41] sunrpc: use fc_init_pseudo() for rpc_pipefs
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
Date: Fri, 13 Nov 2026 11:13:00 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
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
> Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0net/sunrpc/rpc_pipe.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 9d349cfbc483..37277a6d2415 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/kernel.h>
> @@ -1181,6 +1182,7 @@ static int rpc_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &rpc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

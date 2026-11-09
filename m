Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263410;
	b=PpnUoNJOOJtV3DALRFNb8NoJBnapRI05Dg9U9i3IO706y89o3+yrt4D+VDGIfwL6uDJE
	 dIoV1xczjWFNAjKJGDHpGzQF7AUIEWG/0ndEV64UCQYO8q8IpXT8kU45l7CozTYV/7ufh
	 HnIvJiig6E01z+Q5iNtoSOdwfruKHE4XV0DIp25DxxSGfvQp1kRh1YycLGQgp3LJpmhWH
	 1MBS1O6dbIAtaA3iZN1oSzh6UR5HEN8NAmYnihE6qz090BEs/o7iU6lWBUJiaeAs8y1za
	 yQa8bEpIWUnzq2+6dJ3Lyuq2zyw6POTbAGbJSgo4LO3ESRkfAvPR3rK5i+9mp8iGCQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	b=sPkx9O3X4gKLSk7Vei8CsZpIezsDK/ew7PvAocXtwsS1oB6ZjUSVbG3A7hmzZHtLviAB
	 OIOa8QmWxSA2g2uan2tD9+B03lPcSd+1LKWjNyMhSsQyh7nCBkN5RbN3pcp4yl1zppgry
	 s6ORymAP0SRfx7KQ+XeUpj4bBATESNlTPvRZr7vxKaGsn7jw6uOhZRQ6vPgZEb66O3bxF
	 pOhbfDXoHtOfp0zGk+E/mq1n6zpQ0hWDh28Dc646DEiFd3MTfGUgNRDyZe3F9d2P1srFz
	 qNDsE3XsFInGHdQaFibx1gkQqrkiJ5lpb9tlPU7boBITbpfyuHa2ff0GuXGl+pPZJUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E6606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 437E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535f598d126so39531cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=U2BX2EUCYTwGoxXaOLvXj2evIfhCU7CPpi+CM+MwQct+qLL9h7xoxFgFGtYvAMbSO9
         3/EAHX/hulttYZd9Udqhk9c1uYEgI0DNiLIY8e22DaiolWa2ydbjnmLIEY3udpJQ635H
         GSzQ+L3TWY/IKBVGcxZT91BzWnRPAp2oOaP23eHObTiWXGyChvFztowE6mailijpxZph
         gRcEtwFWb/1sokerFpdGR+36moywGWTpegLBtakjOlDRE7yr+8AdVcRNbuvO+B9/tjrU
         Acbs3dZ5e88VKhgZSa7aDtejOYy/onyuI6XkjEkUMxu0vvxQXc7aRdGkwzV9x89oiO+8
         NHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=r3dVkNojxykZP8GYgwG2D/7Rfi0V5UKtVDoxcGFSPP8=;
        b=hCfvlmWpBU1SdINwQK0GX/f+vxW9HXR8f0wzz7s2zQwEUersUu8nWfJ5KH2BibrYMV
         ePLPrJYBa80EGTRrjWOHW/PuEctghBsq5RvOsTQErrWDndkaKzzJKa+nTP5rkMbQ7fQT
         Wytbu1/goV8NpipGnUv4xyyiKX6BE+qefoc5ZCUwkOvbKG2xPrypICvyNIjk0U34H9LW
         tsbC6O/BrYTwkGu3WeKHWSXQc+VBaaOvSokjpz4dGH0N2L+TerVejUMg4L9XdLlcVl25
         nCzbmNakw85vHzaT78rPd+1/JYEeAL57aA3DDo6jo/SiOhFq1gV3E6X9P71isGCsTwDP
         ARLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=bc6ecKnXzqp5zahKN5US+W/GLFNu9bOCxLTorv75CdL/TyOgB/Qh6QFUi86M3M/XI3
         3gbxOXuAYS2+xcjqU4SLj5C27dCKM/SCCgBGdSbxDV00eICb4MzgEjo9vjECQ1QTCTmr
         MgCtojiqIWlVyB6AunwAs2qSQJP0tUdJsdT71C1y4WilJg+rQa++O5B+9FpAikzFpyGD
         TU94u5aUZCMHCz2bEPFushfsTW1bpin21NCA0WBKSF7omxyVw4eI3lnqeaGfI4JhzN5X
         ZQZwi7mBvwRBGIVH1EKWZ2xsmVHzuYxoBrVKANockiyw6pDDJKKlw7J5nTOQpM4hDjUm
         KR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=fvueiK4D5WQgDu4CGCaZ9FsiHt6XMZJigvrWgYKJx+ujF4i8VuVAEzJrCdwJaWMf9p
         LwErIA8HA8+CtNWEFMr5t6uy+WEuKdTHJlB2TteP4FNjoJ7N/GNI8IgykXZ9chN+75Vc
         80C7g7ll5qF+par27ZSZ2BilWtQSURiHaWql5Xt73loc5IatBCdWYMtvGJVNZY8ZvfhN
         TZHNEm9hHkAC9/LgbsJisP9N5Ago/eAt3QmqJCoSGUQS8tXz9gVsnUqJSnGwou6oW3Yi
         QFwx0QwnA5+jv55wsmaKGgV3zdSfZ8srHS8yDlb1vleBi0fMpTMmz3Qph3ZI5aDBjUjG
         JBQg==
X-Forwarded-Encrypted: i=1; AL+hErF8oOw8p5ykOFMT7Gp3sSPcBL7NjhmWbVcm9v3XkyfsCupo+5aEJLvxhZZxZbGNkTC5Ty5siTK+O5ODm3qo@vger.kernel.org
X-Gm-Message-State: APuU4Z991AzdiGNKklFrN1bWI6He9/y2/88/yr0Ue90TxaWfw/UwAo2a
	4QF/tUdny953s2XXwlAV8Gql9x9ko3wf6yUIAv6TfXddC72GZ0wnLjrGyJIXfB/qyZe2h424075
	JJx984V0Kh2ssOssmC0RAPz2Di2YZM3zxhrDhYI0D
X-Gm-Gg: AYBFou24IFjIuBQsMIkd2C/AerZt/XFdtDGDRusRVrXijG66RYatKL5Vui307YH8u9v
	T1/NAYZUd4xRYj1+IwVrPLpsn7YTiAMrGYCnRIAvmN/MfdN+MB1+Tdazon6cJghV7LO5l0Bju0r
	1DIj/ua0nHFzDxG8I0/BUCjPuaSXMJc4TNiRd+V4ODAf1bXDpkZXs5SchDIeUVrRJlztrYRQdmm
	LEPDyX8ixBmqUat9s6i7oDn8Ksh3Ys8Y/XDDGRgnFzAVoHC4Ti70tGoFJr4qHY/9Pw1+Y1Hku+C
	ly8DEEvx6+LyGzVDo1METETVDIJTdlZTe0nuISi3T9Hb66D2RPeCoSOimJ/kLT8RSTsedNXC6AQ
	44eQ1N1m7dzoDz4iPHajc1ezx2squZxVLAesUxbvzXacU5IUc2D35d71LT0OVl2fV3mo=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen

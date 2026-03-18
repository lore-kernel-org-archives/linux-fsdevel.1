Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB5279DC9
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868758; cv=pass; b=WK2urrx6wvD25WyeV3HNWLdQl1KYpjKeJMxh4WI2kFjwlQZY/dQX/Qix0SWHpgef/2S1Z6HrN1ClDrNrna6FPHmxv0yyeEjreAPjxWpBFQLRTrRbh0dtj9tGcjXS562e8IzviZSexR3ycCD7UHqPj6mk9DHMlo5nJFfsT27tcyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868758; c=relaxed/simple;
	bh=oV2y9XZO/ccri5xuigobFBSORPCL3lTaq0tcz5b6pCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVJ/UZHqC++iaFhp5Af+NU9rgxKDoY9gXgchSG6/6Ibyj6PVdgvAPXUa/SCMfugID3n1blWbJw6W8wi5VNconH38hf9+hBRay2OR6pFboMSo+urczFNbWClN0JbMdjlUg84V+npvu5rvJUBhrU+bHoiV+03GR17pbVTss03mNRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNw7kKEe; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNw7kKEe"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b44c0bcdbso260825f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 14:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773868756; cv=none;
        d=google.com; s=arc-20240605;
        b=OMhgnlfoRTwFEC/WJiMQv056d3SKmpohbOneNiFsrgVlsZ7Kb31ycY8ionHnIhIUVS
         3tZ7rzkKjVw45t+Xuc7G9L1P9qovpENR5cmpmDMH1WaQlZ2F/EWJis22wcW/9YciHJse
         nwPspGGLS6l9A/gVcyyEM8fQfcZb8VjrqpnLt5Aws5peXYM0qOPz0K8QrMSzDixNjRzg
         8qom7/4inDFfxa2qJ2r35EVx0I51FpLSaPNcVqNNlCdFIuBJ0LzZrIv0ZkX9AhyEAX38
         N1eS6YugI+qwH1Fn6Yyvlsp9WZf4FRy/pG9djsdELRAJlHjXKQyfu7HOCWkVFp+p/3uD
         Ul+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Spy+fp3CMv4m+0aeuw6k09ecZ4nTBR0d7y9euJp8Oms=;
        fh=ZNdFTf4ReJ0s5kNJVdSl4OLW5HaP46SvGD85BYACYLo=;
        b=dEaZDSp+ICCokpRqFoVM0VX2nEl7obus5OiBwG0gWhFXwVx0ZYRhKoiiU5ZHX8Vs5M
         kHGmlttCHFbqh2COhUB1SbWj+C8shir6ZMMkP6ub19+BDaQE3V3Y1YhDpfAfT4DO7MB1
         di5qHSpkXcVpdH4PbkCWIc0zX5xVvDkpuhF+EPlj0jRglTb1xEm/bJiUw/13ar2cEf9g
         3ljJCrr/X9mubA8VrBHx9dR/gRxo8FWvh+4rhwUmxABsn19+w+iJoDrlNq8mvss3Pqks
         TKCUm5OcFPB8eQjCoHG+ZhbmE3k3KfzSSN3/KThKWcNtwnDoC8a92pEn08xN6UvtTLxr
         v2Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773868756; x=1774473556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spy+fp3CMv4m+0aeuw6k09ecZ4nTBR0d7y9euJp8Oms=;
        b=fNw7kKEeSpKgKOPb2oBnDA7eFXaKkJVp+lPeSX1IRUQ2Wt0gkXhHZpRt5cwKTE2UZw
         YtHVOxpV6H1/ZmVikfw9zJ9t7X1HsFBj+C3NUxyeAOVoQTBH8ysUB5NIGypqOouMcnDg
         O5B8FeSCI0Jn418iZ0jn5S6HtHltOdJu4WnqQB3xRnl43TDVJMUBDU6fBqjrsclO4o1W
         ZPXVuFPWaPQIAcG4uxQrv1bTdAjNgIThI6AT+2GwNgT7z1JsLzvMtdMEd414H+B96gCk
         DeEDLOCFqkE96D+tDyHFaMBy7cUei+J4JncAdnkKPvBPxC7Mp+BC2gxf1VM+BCyLLxL2
         HQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868756; x=1774473556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Spy+fp3CMv4m+0aeuw6k09ecZ4nTBR0d7y9euJp8Oms=;
        b=QouLrj6FLVWCA5smObig+C/CFJfDjH2litWIX0tG3KWq+K8cV3JC5vIUyZrVc3AYX+
         MK+Am9wMMu6wgEHGL1sP78R6d5bUkTC5nfeFzyhGHvgAMmbUYn1Q3wQdu+/5aLcLTglY
         WzaWoEkX99y5jaM0COpC4naMndCLvmL6pRdm5LWkaOLN6k8u1+u2iPrpa6rIsjgq4LtJ
         tZz/6Q810a52umdEE31HaZcAFpewp8biozwhe/VlRlRHbwcNUkK+9Lvg0qJj+Knss3fZ
         De0NG0z9f3XeJt212wBK1ZboT2xHeMZL2MpJhgQ6D8NE46jxkTpBBvN3WWALDmmYhROh
         0yCg==
X-Forwarded-Encrypted: i=1; AJvYcCVGL4NkxvIKg9UfpaiJXgTC/DpDR6HQUQHSnDUi6hp4wp4X97suVS0WRysW3UBx78Xc8B4kNyY8NPD8LVuj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzps0sGlPDk/PKoUzRYELQV6/a51/7XpQy/zErXrXyFy83N0SGN
	yI4HDqOKg/KaUPQAOki+eexJ/mXS94fO41Q+fr6EHxMV7cr25evMQ5hEbewElaRnwxiNlhpw3yt
	hpXBownsnhUcmFRD/Ypt4NJaFMHsH8RY=
X-Gm-Gg: ATEYQzyfyRW1V/emC3rsQoItVC+jPIoS1mzdTHPaPvP7L9kIPkKIO7lqpVUrR4fnBkj
	mLTJ9M77ZgCTVLduOIpSTMBdYG4cZTaMEFRF55HTMbcH3msRDVMRTlBXOOg0ivkNcvl+97fb8f8
	jgnItiP1xUfW8KYXZyZmSn4FettFIUliWLqRXjnN8ouW62seaUutw/0fTKvnqLIi1SkTyRQUig1
	Mm7GEKdhhCSqaVKdfsZbuzga+JqvL5GQ8uet5NB+ahCVGkueEZPlroveC9e6I6SZjqUkafu3gBg
	+cvwy3Eajy6zzO4D
X-Received: by 2002:a05:6000:310c:b0:43b:498f:dcec with SMTP id
 ffacd0b85a97d-43b527a08c7mr8330444f8f.3.1773868755689; Wed, 18 Mar 2026
 14:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box> <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
 <abqvmS4adTXVxFIW@fedora.fritz.box>
In-Reply-To: <abqvmS4adTXVxFIW@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Mar 2026 14:19:04 -0700
X-Gm-Features: AaiRm53eqSrKQx857OkI78fNOrUpHR-rrxbKea0ZDAx-PFH0D9Rg2bd41iB2F04
Message-ID: <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] fuse: when copying a folio delay the mark dirty
 until the end
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 7:03=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> Hi Joanne,
>
> I wonder, would something like this help for large folios?

Hi Horst,

I don't think it's likely that the pages backing the userspace buffer
are large folios, so I think this may actually add extra overhead with
the extra folio_test_dirty() check.

From what I've seen, the main cost that dwarfs everything else for
writes/reads is the actual IO, the context switches, and the memcpys.
I think compared to these things, the set_page_dirty_lock() cost is
negligible and pretty much undetectable.

Thanks,
Joanne

>
> @@ -856,8 +856,11 @@ void fuse_copy_finish(struct fuse_copy_state *cs)
>                 cs->currbuf =3D NULL;
>         } else if (cs->pg) {
>                 if (cs->write) {
> +                       struct folio *folio =3D page_folio(cs->pg);
> +
>                         flush_dcache_page(cs->pg);
> -                       set_page_dirty_lock(cs->pg);
> +                       if (!folio_test_dirty(folio))
> +                               set_page_dirty_lock(cs->pg);
>                 }
>                 put_page(cs->pg);
>         }
>
> Do you have seen any problems with spin locks being way too costly while
> doing writes?
>
> That was actually why I started looking into this.
>
> Thanks,
> Horst

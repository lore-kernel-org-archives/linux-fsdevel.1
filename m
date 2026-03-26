Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FF3976BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555762; cv=pass; b=CSdisLWfLgiVl1tmuT/RoS4tr13u3oiCLFExQ/x5rhi9hU0pfKYGojb5S9nxLXJEQeV5gTHtWnFiB+GoB7zb5NcRJrxzKF+tA4BVX3uYWDFS+6OoboQpTOSNgiiY9f19bFA2iM818WCFQMeimpXlYvLRWoK5PRr0FLeyx1BRuhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555762; c=relaxed/simple;
	bh=gzhu+CqUtrVezttb8Z2iXnjh5eZo7Vdxey490E+JjDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxG+JQmTDA3HWx4s6zKZku2f1p4rftqK81fGm1uz05eh76obr33eVlIRIygmHXR5l0C3zRbNCWcS6G+hRl6or+Dex7a2as6pG0YWy7wZV4zPlny8MkDROKxmEn25+1FiKYIiW/orYxY4R/XcdR8LiIxll37CtPVMbuHta2Ikimo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTki4Cq9; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTki4Cq9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b9d3ebed5so108952f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 13:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774555757; cv=none;
        d=google.com; s=arc-20240605;
        b=iSU0AiuzMshcKGtlv1cRqgJZ6dHSA7UOdjDsO/yT3Jz2BBIHrk9vq6iGQ5LnJLnGQC
         wl+dWKFtPlUXvUGzVvXK35wuxoeKcc7mJ0frGM26rsopq94cKbKYRz81R/vCbnOx3+xV
         mE5DZgeJ0cG/54vPeZ6k8zGaOdIxdixabBMydLTRh5sPKRLTIMLb/6GgEa2Rg2CJvg0S
         Sky2A1CD5xTyO07cbMlx2NtRd00vmonlpRKqggatqLoSM0E3ozGiBliCbEMfVG0Dx2wv
         bRu4wF5+Ts6dqgir4U5UySu/8AqUpngThlGO/r1FcE8w2oN2824hOGiwlutoM4HuBsaq
         hFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pSO5Vci2cBEWyd9BSx5G0lqNsVvZH3gUM8GItXsYDhw=;
        fh=rBYXqLRg+B8BnId6WlTVcC6eaJhDTq5k3Eg1Iz28rNE=;
        b=FX+sRHrnE8eoDghS56FLWW/+n3KXsWV1q+GAe73YM0WC2ORU2MJKlWWSCOL/KfwX7X
         WLzbUOA0rpWqfODhW0dWcJvXhqSVVjQY0/IXEleWuO/wrMeLZc+aohHU+5uoEXs6xQD+
         tLRgwdMCEeFEq+tAOCToKxbQSyu9fWZKXoxdbnbRi+wAjdibidVKeu4QPuBPEYGcM5LF
         +maPydhOd7Ncu+lj0TlQODnvMx38lTNmsBDyZG5cYk9olJhwGYk7q4rrrPYgmgadVAmm
         RUBrcvzsKnGJFtwG3Bt2x2djxUqCOsTsu+0N8/AkrUaqHSCC49m+4caS2CfJs8Oh9ZAT
         kPnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774555757; x=1775160557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSO5Vci2cBEWyd9BSx5G0lqNsVvZH3gUM8GItXsYDhw=;
        b=gTki4Cq93fauyh6mGoJTBnIrc3Fwoob+MFYqbJD7T2KI3QENjpHupJCyD+kO0+82s7
         S3F9HqEIdrWndEvi3czMbUOiAYtiwkxn3wTqmADALufyjJau618KIKR/zZFT9UlmoThs
         3oe+StZIAI5jhRMBy4BTyjWmuoChaMgFpxEbc80p1PDmW+ZZn4QmgbjepF+BjJpnUYgI
         404aqdydWerrpXLrm2+BE6leJ8inhc6tBKctsoSJl3eKMcUBxfcsBymm1TQoUc4uoRYb
         bNov3n+AhSutGl7z7hoJ6CiA347koCBwWoKaARM+l5u1vNiwLcHgXp4tb8xEdMULn/w2
         ogcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555757; x=1775160557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pSO5Vci2cBEWyd9BSx5G0lqNsVvZH3gUM8GItXsYDhw=;
        b=iXR1k7t9MdROigKVMclJm41UUQyVWXDqj0B6ufid9LUps9OPxyNUTX1wzCnGHqAj2B
         DmcJeBngKtwjDnOhOnDuCDR2O/tz2aQtC0hU/IxinuLhuY7zzzqYFRE0N75QHyC+wcyU
         25jXPhYhIw6/9gDhjLjHoeGFSIkU9f2qYOVKq2fxvqeAr3fDbKDUVwMq35glIIKVoDf3
         holNftRrJ/plHUAPUdKfpUNAzxtkvOZMIQ+4eNPAeBj478aaolwpiaFatXHXNGpuZjeN
         EcfdQc9ftjIaandd4jJFbc4LlgwKr+N16PD0mU7vPeZ8uRPU2rmZdiDhgRstygiRAczD
         fBPg==
X-Forwarded-Encrypted: i=1; AJvYcCU76Xsu01lQwZPj/RF63KKvUfEi8Juy8xoGlnAgyvZMpQxImsYptpaM+zJJKmePuV8K+ELvGDwo0BROjg0x@vger.kernel.org
X-Gm-Message-State: AOJu0YzTc+g0XfOvFha3wCAyXlK20R58VVrLF6ZFBYdWFU59KVJaSUb/
	V2KP8D1w6M+XaFWUIMkqTbVJOVZdMTm0a3urYKy3EFJ+R4ZWoRh1hNXe/VbVT/rmgtSnfjpBBTw
	LPfMVmhEG66+np1MY5AMl6dZxKbxZr6Y=
X-Gm-Gg: ATEYQzzMLAYqgaQgxcqYi0NsD/j0Uz4bnHE8sxTW8CVsW/wJEkXa1CrW3ncQWb/XyTN
	Jqf2MHYTzEX6SiwNwQeTutL6BVOw+tpLBC5Vci9Ga388rw5lYh2G0ntcIsAxvxclvaKyXA69oxJ
	RXdCvjZq8u+6tpuJUHX56inGnr9PEYJktL+eoC357pkD4NHgvHC0QUa0w/viwgXZgL0pV1EqOZe
	gxOiJ81wqkarBU3mQhMjji6BAQudElJo/6MFOFWlEpsbLwU2zjD43A8f5xAXdN5KEBC0YEvYKuC
	gYGvAbqHC1uVmcSl
X-Received: by 2002:a05:6000:420e:b0:43b:4720:10f2 with SMTP id
 ffacd0b85a97d-43b88a8ea25mr13987946f8f.43.1774555756849; Thu, 26 Mar 2026
 13:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
 <20260306003224.3620942-3-joannelkoong@gmail.com> <CAG48ez1QJZMO0+6FHBU4NHb_jp3appDWaw-KBzvJ0vzHWmXMQQ@mail.gmail.com>
In-Reply-To: <CAG48ez1QJZMO0+6FHBU4NHb_jp3appDWaw-KBzvJ0vzHWmXMQQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 13:09:04 -0700
X-Gm-Features: AQROBzDrqW0kWt11sHOKcDhoAUH681FTTWU_vKdUyT9FiPuio18gxRZyIl70GPk
Message-ID: <CAJnrk1Yv5GN4J8-VnWYCRhdkwwtvJJRFy4o=Yn7CGM86-h=WJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] io_uring/kbuf: support kernel-managed buffer rings
 in buffer selection
To: Jann Horn <jannh@google.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	bernd@bsbernd.com, csander@purestorage.com, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 12:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
>
> On Fri, Mar 6, 2026 at 1:32=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> > Allow kernel-managed buffers to be selected. This requires modifying th=
e
> > io_br_sel struct to separate the fields for address and val, since a
> > kernel address cannot be distinguished from a negative val when error
> > checking.
> [...]
> > @@ -200,9 +205,12 @@ static struct io_br_sel io_ring_buffer_select(stru=
ct io_kiocb *req, size_t *len,
> >         req->flags |=3D REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
> >         req->buf_index =3D READ_ONCE(buf->bid);
> >         sel.buf_list =3D bl;
> > -       sel.addr =3D u64_to_user_ptr(READ_ONCE(buf->addr));
> > +       if (bl->flags & IOBL_KERNEL_MANAGED)
> > +               sel.kaddr =3D (void *)(uintptr_t)READ_ONCE(buf->addr);
> > +       else
> > +               sel.addr =3D u64_to_user_ptr(READ_ONCE(buf->addr));
>
> Nit: For IOBL_KERNEL_MANAGED buffers, "struct io_uring_buf" is stored
> in a normal kernel allocation that isn't concurrently accessed from
> anywhere else, right? So no READ_ONCE() is needed in the
> IOBL_KERNEL_MANAGED case?

Yes you're right, I had copied it over from the userptr case but it's
unnecessary here. I'll submit a follow-up to take this out or maybe
Jens can remove it locally.

Thanks,
Joanne

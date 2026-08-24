Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A441D13D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575999; cv=pass; b=lyA1Slxw59pwc8k7HhEkCpGdpX1qf3eBVMle13z4JdkOYtkdib51e/EiEmrl4ME8rA7BerKUhjpkPX9KzezhVaZxLYktC0DbyXUWm4AEwMSxRZvSIE8rl1XXClSG581Q7E68886Swm4Okk8tdQVuyblll4C6v/mOlq0mjOLN2rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575999; c=relaxed/simple;
	bh=LZFjpb9lXURhzbS/CoAdgyKyJvfoaiCSYSWBisfzp0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp+evSVbxMTNFt/7RrXYEx80KDe7zwjVAHIWd0cBxhVBsrEq3RssEYl6X+6uosYeISI+x3zszmLbEMokgDTjGKytsUbtOJt/2X9Q4cJRUfuYAKnSLUnVVt7cux2CQXubrdN+7ah4dkN3O3+J3sESXCHSCtG9+PHmAUV3sj3xgos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WdELMEMT; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WdELMEMT"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-526f963372aso24195691cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 05:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787575997; cv=none;
        d=google.com; s=arc-20260327;
        b=grTw27ovYOTh1WY40kD/aiDFOD49ZvjDmCkgnklo0m5MNNZrrmvR6dwpTwnYjWFt5M
         2EdyjzZhiUDUatBw8bQ+UAPis9W0mr4xxFmJYZsM5WDCccABPtkPTM6fuZcIGnJCoFmM
         IMGF2fNYMQcdERUVKKmwK2QPRknTAuw+Ff6vArlsujr8feWHi7SKrAUvC4F19erkovP+
         ucm2wm2Kszb0Ap1GVUWQCLkRXCBOI82JP3+tQh3vcI/MmqGMYaJ69BsPNXJccgPSNU/6
         Umnj5tR8czqUw6nzI4u2YZVNSyh0ynaQeUP2Th+ZLrYeMZTbQkoleFjxqsg9IMW8Yojp
         GujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0IX1RRllwYXbu1MmF/rjjTVoWXY5K0/uFpmcxvfdldE=;
        fh=kUJf/Kt2XIcc5qKvN9nhHkkUBB1O6XlxLRfkYTWFqQM=;
        b=L3+/po9SsKykK4hDGHbfc9PxFnjXyCoLq9zBgiYnju1wdPWG4RsM58BHtmkeRa49ZY
         6I5cguQyOuPcd2yd0zC3jRHIO5H3bDswyqbslBubCU2OOpZoqHty/6bmh5pm61SR7r4H
         l7YMuumGCDqPtgk4Qd7E3zfh4DfIeebH3HEJNSCFvIITMpb1u72/UScBX3n1MQQUWlwN
         ideYEqwVrlfmRLBym9KhFAuA5iRIU6GtcXXB3INOeJhle4P9yZ0pPpEXzWjJfWHvb5o/
         k0y3HxTtu6DuUWy8OplI5JROGAIUOctS+RdvE169jNwzxWGBVm+MDlruo/+Lh8b2ENhA
         zApQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787575997; x=1788180797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0IX1RRllwYXbu1MmF/rjjTVoWXY5K0/uFpmcxvfdldE=;
        b=WdELMEMTM+Foq6M51D7qBB4RWbI/QF9aYjMqceLDKUpFJxdRzZPTCLe38NXymwTN8C
         QQWbrQGErWPWZj+vP7KVrHarIn7foHFmUtwEGyccxaTL1vqvcrJm6/xBA0S6w+o71RWh
         61QKTv4KpAATflwGrx8H2tLlt0w0fzm3ru4IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575997; x=1788180797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IX1RRllwYXbu1MmF/rjjTVoWXY5K0/uFpmcxvfdldE=;
        b=NEWu5iC1/pIDLSbAs2HJo7E4IgHMMBXn7U9W5tJPUPEiuPW/H4yMOB+Mmf3Ngrq9qA
         90Ycbi4MwnzyTtltOxJtQL0DoZO+qnYzj6EXuhRGMR7ne7MMHW5jWmsJjBxHXaNWdpxv
         CsQCdk2n99jsoHe4X3p26eogkOqHFcmO3KnYJsccB3ZNUF6ba1iGEnDm4rR8eKJHSFE/
         JB/kS4jfyojBFWgZXHyOT4NvfLcy2qccuxgvEByYNjpKktuOcPiP0lbWYTvMpwZRCv59
         GpnJop0xv7BinfoeGRUN8hzWzUxOGWsJhE+qaVynWU6bZYft4mLChKZfK4lZS1pGuXVa
         z/8g==
X-Forwarded-Encrypted: i=1; AHgh+Rpae/DYaUJaWlL5wwL1790iYiYm32iwuZ32ANLnoHBnYssf05779k3JdClHPnewg7ozmdXsahMLJ4ntn4AU@vger.kernel.org
X-Gm-Message-State: AFuF++khQHqbHo8hTIe2Q9AT8UAJ5Xu4eHJ9MccYP6tccwUyETTWgMLA
	YNKvWlEzDT/LCrnrRgigOxFHDQ5EkOX/RFtstYyYKgrNwzklFpVX2a+6O6qDMnd9usnGtuCgSlX
	BdR+aEBHAXhLtIa19+1MzGvjLzdBLXh2buPC5F2Tepw==
X-Gm-Gg: AR+sD10dnbTY4gJ/s6rFe+5pZ4/gXuic/4N7GZi+5TXBmRwuHSMdzsB2iuKcyOzQXSR
	BWUit5n3gkc+yPqIwI4KbnJ6/JSlAH2jD2Mp4sRUwpR01GWkOVAce2z6MEe+wLflhCQZ2QS1MyR
	k4OLtPvo2FrbpMj/h3t4xs5S9ILFjjZEG7CJqoh9eD0mLZPpMHw+7WS7OW1/XLXeR/nzbI+HDPS
	WARsCxGppUmCRp9dj5pTbaJpJ1wfjUElDM/khgklp4rpgutIfpefkQOdRlPcYh6VpuTFI2hPvBT
	5GpnrYR4a1TLIODf2n2Bi0gx0N6aTAdxj1IpatZrPIsIW0DO4DVMlUdooXvR7TgBFxFsk4xe80p
	dZcwowKdfqFc8Jm/htkikLioTvw==
X-Received: by 2002:a05:622a:514e:b0:516:d781:589a with SMTP id
 d75a77b69052e-52e09c6fe74mr192671201cf.22.1787575996851; Mon, 24 Aug 2026
 05:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026082150-autograph-perky-e3cb@gregkh> <20260823224256.2724025-1-fahad@codepure.com>
 <CAOQ4uxjhfpNVvoVrTayj46H2CViTOc3oxzM6xdb8+E7ikE2CSA@mail.gmail.com>
 <CAJfpegt1WinKmP5nOGv8Yx9VLf4Mk1ojg7e3xR5iUz=7yDAh0Q@mail.gmail.com>
 <CAOQ4uxj+GRa8CaCONwPQzLCjx=R8MRr6PTYYC+QW7VrK0PEhMQ@mail.gmail.com>
 <CAJfpegsVoUyqy0dYkTvBGRZvgdv_nmzmCw_uF+LP-Vq3EhEkSg@mail.gmail.com> <CAOQ4uxhX_neohTAjZDOT0oSWC-JNiqNWqnfE5YSa7Ln05QPQ-A@mail.gmail.com>
In-Reply-To: <CAOQ4uxhX_neohTAjZDOT0oSWC-JNiqNWqnfE5YSa7Ln05QPQ-A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 14:53:05 +0200
X-Gm-Features: AcwNN1WHBei9qmI1SLzVZk7vatFLte10goznOMhdg7Wfikdfth6HYnN4vftGbC0
Message-ID: <CAJfpegut15YWZyS5zJ9-WmG0+fVPgRJp+c0aoGQv-0KM8iYj=Q@mail.gmail.com>
Subject: Re: ovl_copy_xattr() can write uninitialised heap into the upper
 file's xattr
To: Amir Goldstein <amir73il@gmail.com>
Cc: Fahad Alharbi <fahad@codepure.com>, security@kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Aug 2026 at 14:46, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Aug 24, 2026 at 11:49=E2=80=AFAM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >
> > On Mon, 24 Aug 2026 at 11:30, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > > It's not really a retry loop, it is an opportunistic buffer auto grow
> > > loop, see
> > > e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
> >
> > Ah, okay.
> >
> > The logic is too complicated, though.
> >
> > I'd still go with a separate helper  that gets passed (..., void
> > **bufp, size_t *bufsizep). Single caller of ovl_getxattr_value() can
> > also be converted to that.
>
> OK. something like this?

Perfect, thanks.

Miklos

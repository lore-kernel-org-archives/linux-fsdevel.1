Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6233EC
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 00:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037201; cv=pass; b=TnHkZ5sccA+cE/AUqkPaRY/kk2A5VykDBjVgEg+X3YBw5DfggniV/vXqCyzqshuwzKjgsnyEzZHjqu5BS41VCcZT+B75IFuXUQpGwv6+wN/z/JnVwUM5m8ltWEhz7606pOhNEcsAt8+S4xXgI+Sji3D+sve5Y5fFB0StSCm3kX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037201; c=relaxed/simple;
	bh=gslqVT1C4ZAxfFgX/Lm3Op7ina+YCPCXFvipiwlHJKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1PjYq33hSpq6lwf7i7huipQa5tNiFMiOEn7dsRgkhJgOtfFLEBcybtrwIjh8QHTk2YaInZMgkmvVtmCaE5atQl2B2tk6mjEhnJoSJ4Iu7Ajv6DJpJ0D/qqBd43u5Db6JccrOOt+aqXMjF2pzWFGF7L3RtDIoY4/L7oBRDGP6gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVgJB4Vt; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVgJB4Vt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b691cb44so16947035e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 17:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783037199; cv=none;
        d=google.com; s=arc-20260327;
        b=YBvbZF/3l5fqdC7ysc1+E0ATZjTQWNSp2gV7hd0mKJ1yPq/Nyi8kekkdOmJDqq+rgw
         rHsqGMRdvDP4j3mgmR5aU+viLnLu3lUBZUqhbBKvsBu57fgeIJF9U5/6/Fr6ljO8TvM/
         AcikDDH9QwtnvrhZ/BpZw+edMLw3ELxEb2YPrT/53/pZqBYVmzWS3E3eWXXVQ0kn4Qjb
         dHRFiWHCNjI4KlQ1Mr98a8FlenD99ahTY01b11j9j45uyMEYKvRen/5LGkJ2Ca/eYKd3
         FVGGIogOE4r5YH9nqY2vJhVYRIMUbY+3CvTrhO97mihlqjyjY1sO0+u6ms8XP+NJEree
         6a4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S5DS9XhdwYciT3vOVgdq4aobfOtX1mJihQgroHMwxY4=;
        fh=uO0aDP/NCn5Lh6LkvlYF1vk4254O2jUCjZLQ7HE3Fd4=;
        b=WrRgjTWbdOw4q0GQEmIGbCfuO3ofO5As6SDDSOUyHYN/QWEKXWzfEbTRlT20grVPs+
         3IDt0/IHmFFchF4MOkU2qwTZvBdtOjYMwNtUkgJeGv+z85jVNfq14vt4bhyhFCr55OE0
         NeByWIJJco9hxOKZK45XiUNGPlxr86PCJ1/JbkaZVvObPAS7oO3jXmiWostlZ5H2lT1l
         AuRArTBjzIgOWAaYQMwa0kLo5U3p0QiYYKuzPKDxkU2MtP+O2Fx+KerkPjQ2nXAhXCsn
         WbInRF6UVtKxVsMZ3V8lXyAcYCTcd36KMCc5fVnR1R8y7CXICKhEITpx1fvKULZRLnMU
         WG3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783037199; x=1783641999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5DS9XhdwYciT3vOVgdq4aobfOtX1mJihQgroHMwxY4=;
        b=AVgJB4Vtx27BcO1cdm5VPuhyft+sx1vbQjIKHjikjMs3dnbZCKjrLRwVIM0F82Vgsh
         Zlk4TqaBr8IH1nrscltvcgU84AkaKC9lglxNZt3ZW0hHoIGEM2ds3TLsTjrMU1vziRDB
         obwI4W3FpS3n76EF05KUJ4CRPXKvah3HjfKvZRYjJCXa2cMHm5VxSe27eir66OprVPMI
         V1MxZ6ew2nFkEQQk9TUMIz2ElA20dBwYPcFdDYGUc5ioml+o5YzMIoa33Wn+ZiCkUeIN
         Hq5I2o6sQ8Nuacr5iYhX9Ff7ZTUhsbObNEVb7AmMqIWQWLwU2vqGM17ukNUCra8xHT/y
         GXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037199; x=1783641999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5DS9XhdwYciT3vOVgdq4aobfOtX1mJihQgroHMwxY4=;
        b=lSTqi0MRrBYrZ6srjaPqKeF2MQXwWhFFeVvPELcwfRnjXD56lFwQ/IICw0ahAJzOkE
         eMZeDIciu9obmoYBGgn0cjdIbTy+B0xkNswpYiCBfv6paelGbRFHQde2vsC1QMPX7oTs
         82A2ZhUumv47UgOdmfCXivr3we5Uop97p5dRhsMMrRa10SVe83nIO+Akuqpea1lAxGVy
         MZuePD99LpcKozh9+r+iAg+fKjCPaZ6ifQQ3/gGkom4P45mD/yFZIdWU932IeLBVkSK5
         ph+m66liJKL+Cun6Opj7o49yjiJNB9PuCHg4u5H2zLl1hm6kC7t0QUmll4tGm18jZ6tf
         cCCg==
X-Forwarded-Encrypted: i=1; AFNElJ+DCnuTlWtALG+xyhKE8Wd4GL2DivpeAoz/Cftkxg4LBshDeADAIeGGWiR4UciUGXOH6kh//320MQh6LPgC@vger.kernel.org
X-Gm-Message-State: AOJu0YxVTY2NMy6vthljKpGyaJFPDcags/ezuk90tYrvdaviffjaXNRk
	diXg+W1BFZg/YY+DbfZIjc8XFs1rUNjwk9ZgxDQG/vZACnpzZfTUmyQqdFWrlluERncdf51rKW3
	MA2CASpjFIwzVRDQsiPT622C3DWlkyN4=
X-Gm-Gg: AfdE7ckY3kzFTwH7NHO12XfO/pIZprdqw/L27kmIQ0rEgGoRoFGTJ74PRtK0xIbAW4P
	7NpLbQxlsg5Wq8cGqP4wzv+Xj/767vqXjjSmMgrdCFKpDNRorxtH6jEIori9W4wKyhJau8BN26d
	NDKw2BFJz1RUDkGQgo7phabL1UQJh2MH9C7Dcqk/dGcczrZVCvlcKNi3cDm1od17AcTVbAHjARd
	Mz10BB4Jog2rdiXYy+K3R4wB+oGfvdgwq0XgX5PK0+ei+vKT6SfE/FioKa51t5DNpOG12PAc5jV
	jV3Z1UZihWyqtODyV54j17Rlo+iZVQ+EGXSVycaMqm8J84qEAUC0
X-Received: by 2002:a05:600c:5808:b0:493:aa0a:45b0 with SMTP id
 5b1f17b1804b1-493c2b855famr82697505e9.23.1783037198482; Thu, 02 Jul 2026
 17:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-11-joannelkoong@gmail.com> <akRlehPHzy-F_105@kbusch-mbp>
In-Reply-To: <akRlehPHzy-F_105@kbusch-mbp>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 17:06:26 -0700
X-Gm-Features: AVVi8Cdk_C73wAd0LEg65xZ99iaBn5MPuJR0EWtJiHzmTYc6q8IOOPpqNnJDiic
Message-ID: <CAJnrk1b2T1GiWzvBKaBg-97sEZ_9SA6EVEUO=9CknK1vS3oJ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] block: convert iomap ops to ->iomap_next()
To: Keith Busch <kbusch@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:55=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Tue, Jun 30, 2026 at 05:09:25PM -0700, Joanne Koong wrote:
> >  static const struct iomap_ops blkdev_iomap_ops =3D {
> > -     .iomap_begin            =3D blkdev_iomap_begin,
> > +     .iomap_next             =3D blkdev_iomap_next,
> >  };
>
> I think it's generally safe to use the same mailing list for the entire
> series. There's no context here on what "iomap_next" is because I'm
> subscribed only to linux-block. I found the rest here:
>
>   https://lore.kernel.org/linux-fsdevel/20260701000949.1666714-1-joannelk=
oong@gmail.com/

Ahh I see, thanks for the heads up Keith. I'll do that from now on.

Thanks,
Joanne

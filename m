Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CC366800
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961266; cv=pass; b=FHmyTcQtIqOZgCzEBuOz5zwCLcMCgr5CEQlyLZeT8nKcRnkIjav/mHePEXaTV68I5/7T2yk/kfuheyeOj1WJr88ml+/vI5A7ZJ/iwN4VEoKSzvjBkv/+hGHqZvBtkJ0rueGvv5AIrHzmiD9Kr8XOXP5fA2pmE0vI1tnoPaUFxI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961266; c=relaxed/simple;
	bh=ZoSklbGcCkdQVQ7cKRrY2OEl2h0RV+ReTOxDyHsdoxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1RAuVQ1lEL/w09H0N/jxEN8SpQNHEG2x0PJSJiwsykrt2TknFOt9ZnMaMSOSJjVPe9BhetUeb+I11JEQTOAfr14+Yno6YYurDYLvRuQuHCsdI/xIYB7mxNaxHFvYW/IB9Gzq7s1kbcwGnGk/Y5aps1Bw9anQji8tPfL6tD7rWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com; spf=pass smtp.mailfrom=openresty.com; dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b=kHL9FjDx; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openresty.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b="kHL9FjDx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad4d639db3so35320455ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 09:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776961265; cv=none;
        d=google.com; s=arc-20240605;
        b=ciBxu5cuRV4bV4EANW3n77FSyaAXzxqbkiK6GIC3U6f3DLvE1vUNv59lznrDqEIzP5
         sBWx2Q0dUELc5i56PFAYDZzS61KoijfTW3tGTTzf9vUMeIdEpNY7CSfwU24i2pwVjUqw
         ndgl3Gs2kwVafcuQFgGGtAcCbTvBT5nF749RvDnEfk+oqSJLtCGl3i1/8XFvy26YnYvG
         NQy7IUBcMPd9ZpzrxGTZd7jf5DnA37/8NwJR9Wc5ek/cLabm0uMRLMRkInS957uUcR3x
         +1N4YORij5BiB6hPbOK3+U3wVNUxSfZ9BPc0HaDMaxkhPZbgwWSccaPx8L0/nAGAj7oY
         lWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZoSklbGcCkdQVQ7cKRrY2OEl2h0RV+ReTOxDyHsdoxg=;
        fh=zjjH8gsJrBgZmZWIehDmRr5jpFnuWIGS4gI1JkKtnv4=;
        b=Bt/wgJSr7FR6eEZVNiKut020siordds2il7MOjhlGwUwlE8+Il9aKKcLsp1AZKRyYW
         tW9XX5r/O9rpqKhY1g0oZC+H+YhfLGMznba0ou88MSuFzHXwummKyY0yVKJbygvc/Kzv
         EWxY0g3sI0XuT3Eocff3UFXxW5jZ43EuHJGTbAS3beylHn34GruVDX4gObRx7oMw4xQF
         wt+CeWdfcfFG9P9zr7o5Z4yCjcoyXsaz/erImm/Si3T5efBKyYK+3NeCYeuStJs+gBzZ
         oGYvNtq9ucJh0wuL6xgj4XJegE2hlNsv5E8Vhbm3vvSeKo90HO8eyVSVAIwMMLnG+qAX
         +qcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openresty.com; s=google; t=1776961265; x=1777566065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoSklbGcCkdQVQ7cKRrY2OEl2h0RV+ReTOxDyHsdoxg=;
        b=kHL9FjDxdOmwo2TuAhfEN+aL8G0frLPMdQT/gR1+ot3vRR0D+gvfMpbOY75NxFbcQj
         WFrMWlba8UxF9iHzYsuu+aUc68D5fGlgXY22IqGfd7JFnng9Jdba1mIvg7xjBiFa37P3
         vo48IM/4nj93g9l32XwsCgViCXIfTRqxIa8hJ7Jbsam55DdLM6cEVG1IXOC+A5G6nC0v
         Kiyn2nSJwaP9VzqkE9WnJmDFBQ7FGolLgtp1+QPH7WrdBSqKpWqPRllTFMCQ6DtVvGcx
         xtZVVTFwcw9w/cQCeOTHNPD6RacoVLU38JZtmRGm+pAHosL4DCRdHT9CukQpPKlGTT5D
         ZSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776961265; x=1777566065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZoSklbGcCkdQVQ7cKRrY2OEl2h0RV+ReTOxDyHsdoxg=;
        b=f3IYiLPPBvIsF7X/VTypYjFE37QrqwzhROExaBrP46JptWRUvON2fBn+OmRjiTYqNG
         tspd49klcWUvqgtiJKb0FLyJx0axdp8HcDlBHLTY7DCTRddyQlt30/h+sPkcBOTsKJUO
         hjCiVGcFX/DVlFtvkfAULgx5Z1sVmM/mBmQRKMdt+JTfqS0TCxdbXxP11LSq3QlKfbFt
         qsuYhYV5qwJweybMRp6f/ay0d/jEa929a3zOmhedynYl/UpK2ZCwCVNd070ZBwWguUBb
         07sZag4Y3aV4vNxXoBobE9VJSTzx+nh792x9KH78JVXHszK5J6QaQytXzf7a/dghnjJy
         7Hew==
X-Forwarded-Encrypted: i=1; AFNElJ8PayXJg0XOmXUkKZeJ7+HJYUa3SReh/Lh6QWWXD18C9jrfe5HeZbTVTrDHHZyOx7O1LcwblVDv6qrGh2f7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3b1RI+xtS2lIDfaEc4jTPs4oB1Z2jDudot3vj0BpZVATS9O9e
	pb+RZmKfWKRqsbtY74mOJJsnrOJZgldZnikzyIWdhdf3u3dhJzc2U7Omyb4FuePvDqueAFP9Svr
	f4pdSKr/fx/S25nPj+IU/oxPFMPK+MmztXbFnDHOHhQ==
X-Gm-Gg: AeBDiet3Lr/GgdRH4Ees2j9nGY/OAi3QJN5Dcmw2Jbgl0zUGK7YfFU3YgEA70Oq3nqg
	I2ligwVhbO7lpO/SGrq6tY7qnXDKtl9WIuTdjYZ96lXHU/tPokgz2Dimo8OHPVeuWO15n03HDE8
	HV+NYCliiNB+/GrxImfk2EP+U5jA0pmjURNtCrh3Z+hZhw5OGr/dVia/yml9M1IZcs299p47+pG
	6WJIr7k9fuoWLag7brUtwr7sWoZV2gey/GYnZZKQ6t3E++Mg3Amh8wGSEdFtbnLSL3hD6Q89GC5
	uZq/n6ZQAZi+tEAhAiOSvBsBeknWchTt+J0x3+JFnK4sKzea273H
X-Received: by 2002:a17:902:74c2:b0:2b0:6d33:e7c0 with SMTP id
 d9443c01a7336-2b5f9ecaea6mr223243735ad.1.1776961264697; Thu, 23 Apr 2026
 09:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422152505.818254-1-ammarfaizi2@openresty.com> <aek0-rq8zX-ta6aW@dread>
In-Reply-To: <aek0-rq8zX-ta6aW@dread>
From: Ammar Faizi <ammarfaizi2@openresty.com>
Date: Thu, 23 Apr 2026 23:20:53 +0700
X-Gm-Features: AQROBzAi2UsI-20jfUWrIvnJZC15-HYlrcUx6dTprYVhDUiwBCsh8jbvltFHGwU
Message-ID: <CA+KFgX5vp4L-NrHKDBCy+FaVEO-p-D1ReSKDv_1_hk+5cEnFhQ@mail.gmail.com>
Subject: Re: XFS Deadlock on Linux 6.12.82
To: Dave Chinner <dgc@kernel.org>
Cc: Linux XFS Mailing List <linux-xfs@vger.kernel.org>, 
	Linux FSdevel Mailing List <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yichun Zhang <yichun@openresty.com>, 
	Junlong Li <lijunlong@openresty.com>, 
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>, gwml@gnuweeb.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 3:52=E2=80=AFAM Dave Chinner wrote:
> Well known false positive.
>
> Lockdep knows nothing about inode reference counts and how they
> interact with memory reclaim. i.e. A referenced locked inode doing
> memory allocation cannot be found by memory reclaim processing
> unreferenced inodes, so reclaim cannot deadlock on inode locks held
> by referenced inodes when doing memory allocation.

I see, understandable. Thanks for the clarification!

--=20
Ammar Faizi

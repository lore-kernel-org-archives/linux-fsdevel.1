Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793385232;
	b=2oCnpcEKM1IRSQnZFUWZf7difU80SS39gify4/M/e3JnItdVrdVVqUAowvVMpZlQjSe7
	 bYlPLTWTauS25SWUY65n9reOWEhGR2LxE1DY0hEcfDlhnDMMKGoIMw4KjhHd4maYfeTXu
	 OnfFNQ0k6BkyRd0doYcdEYlXvC6pFG9SLYQSOk9Z9a4Xa1etyld3h+8uGJT8KMG99j3Wd
	 +p/SRlUBGGPMve9stLd2NRIKjEXMT/Zpnnh7tAshlRJ66v0KQrOoDLWyEch1a+qWySHx9
	 f936bPfjWiIv1CuSoWzDuczC0LoGOPxQrtwSqjYhZQxBFgYv4CrfkjVq/AFSXVYQO6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tcTbJO+0+S2knz+SdPsLwHK3PTtsS4Ru8HZcBW+ib7o=;
	b=09Tf+4BZV08JxGdI4bOdeLer+pPzZi6fA+hfTx6POmc29BJm6VGzVKqRJsMbXWS7LT2L
	 V/dnA3BbNAiNMQV5xP8qyf4mYI6C/QTC0Jdjm6nsdcIo0Mop3pI1AdLvOMe5sMSvxGNIf
	 9nF2YC12B+8slbe8p2SsuG6f7b3g0FVA5bzh1uvX6DFwuT2zawUp+yYA6R7joudbwdhsc
	 Rtlv/N48bRBaLBeT/o892ELmhLCJmVW+Usxm8zGQbQglVJ2S62psiqILr6qh2GfeJYm1U
	 yv40osb8wEikAX6luGa8sXO35UXF0z+tM6HXZRvjg6+6CQmRHY0Y+DHVPiYZqcDvDIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiuMvH5j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494F606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 18:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6494F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YiuMvH5j
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c247f6687dcso184792866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 11:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793385231; cv=none;
        d=google.com; s=arc-20260327;
        b=Dr6vOW0IfmariiRbYuCw6lEWBQzuuLVcI6fWrDkaUEY1+mkBeTbgzhhJ+7ZeirgILZ
         FVI0Ve0msXQY5ESj/mrrnn+gUSiT0fWFo9djTQpY5W9MM0TI1YWjaovd7xZS0tvaOqCw
         EnFvPDvSax2NS5K6yAqG/izUUH8cJ+HACJnG12cALncavvR9rhMhPPggLhvvjAG7nNUV
         E+x0GVlNj5USgaWiBm3IphWzbXzzYaqF60B2tHBTAUdKZQFntrng6t8oX5EOcvaO40Y0
         bZJHG4MbW+sSnd9Z1IF3UrTxYkLOCSDcf3AKuqF3kNwqwKhjmEoBKSv2gr9iVNShyPIO
         w1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tcTbJO+0+S2knz+SdPsLwHK3PTtsS4Ru8HZcBW+ib7o=;
        fh=8ppnxiTkDP9WdFL+j+XoxTEPVJtWeoOJglbFVLiVkrE=;
        b=ErJl6cerbnKnWLp1RqjbG/f/dgtZLGtqTs1v660Bwgatz9TnJYFoWkr/dgtQyRyH1I
         MNodnITMIg4OF5ILBpOojcXsVf5AUfsaRoaeV7yfAgn2NTckqHek3AZ0WPaDJP5+FXbG
         HEiCvQH+U8vfM7xfveUdby5Etn2ynsJLjTfPLMNnrWjt68xOuW8qYskfb9fplRJIJ9qX
         wlOjtpYjWyCoHEYDKJUEgr2SPnpOrur02d2LhgpY9n91ZCcuQ8AaLYApn3UpwE9sC9es
         uuPUjMPBKLJUUiH6xy3OItJLskMRSXlUaraCIG7CxdqIqwUE6dYK724wTEpJNzEV4T/K
         WQUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793385231; x=1793990031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tcTbJO+0+S2knz+SdPsLwHK3PTtsS4Ru8HZcBW+ib7o=;
        b=YiuMvH5j0xC7G2dCtE+dqBWbjlFnD9G+5HJGKQuFt68uQ7ICAq2rQdX2qodCZ9Wt6Q
         BjEdWejjMR1maKvxtfSAuX4GfUPvY+5DlXMdOW8aLsTZAgLZdrW1VYYYQY6df0LHdaJe
         tAb4ZgczqkxiDv1DGWcNtvTCUPwKUaOc3Xe06vvfMvr+VV4CK5wTNpIwKn7ghtMvh3wC
         Bd/LhVcXoGNnx1nDr2qvAYMCwT7zBgbBvW8J3mo6hUaNxUdb44Ry0aNe4ksnkRD2OeZ0
         v44iVgk5HXDmtx/BHf+qCJTbqmo3mwsKzx1BnDROSJmQ57B0q9EGVQVGAQE4X6KADjji
         eZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793385231; x=1793990031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tcTbJO+0+S2knz+SdPsLwHK3PTtsS4Ru8HZcBW+ib7o=;
        b=K0MfKqFrttIdkr4slZdlSoaNJJ0ITabxC3rhgdBxda3d3gXTJlJAcLSvHQO0EnBjaU
         2/NYj+Feq+P9Tk9Ps4jshD8bRb6qt9N87onSbDeVfSowZrUGZA74cDu+c44aXJ2YAxMq
         BdZq7ot6rFggpz1yTleWE4or3b6mOQuvT70wTaWYBNkGBQTDWg7XuF+iYWNVBLVPhI3Y
         1XkDTaXWbZZ0PjRS11giiyY7u6AXkQ8z3ZwAYXpBhIR4wZdyg4kPfdZmdpy/0InKx9zZ
         EhvPzXTceOOnblagtGYmOOeMW0D3mt6oOQdf0LA28rr13MyFSOV2XGhDMJRUgSfoaRHX
         MOOg==
X-Forwarded-Encrypted: i=1; AKwUvBxYO7AmV20/U5mUOFyq6UvQ7rfFLoSiU2ie4UWVg0IYVMX7n/Fx5VLKRA3V3kBZZk2ruQmk4df7MmpMWSmA@vger.kernel.org
X-Gm-Message-State: AFq9FYIfQhrKogbif+kvYvqAHytfNRAI9aENac6WN236LtmIsYSbCSWl
	nDyQT9hzXdR9to1tp89wmeDw+sgYj5evLnnhVWZ7McBa+cZRseLm2hNc9fo2sKSPHRuHxvqGuuR
	ka6vl5dSAG8z3AikGgLY9Ex3eeXWqrZ47y2k5
X-Gm-Gg: AYBFou08dJ44gdoF8p+Eo/66Q/sN5lkXttW+gKYuoEfBtXajROTQ9O+1uaUp+MJPggE
	d1UjUyYqPA1jUVv2SNWKdfzNBt1ZnRgx1j1li2pE1aPbBjabIAUx/BBK2b6Z7yTNYz4HCFIv0et
	emdFOXPaHdPlm55QQGSXBDmucR3COrQ5IPTjafp7OTNh54yvkiLTZSTkp3v3ODlB+DBYrctVd/5
	oBGXvP2pzM/Bg0ATGPuTEaSFF2hyfOzY2tZ0NArFVWm+tC7R7xjqX0ju0dziRryv3ZlqgU8Kx/3
	viCYT5JNn4t4xLkaTRywxD3ANE2h+bvLLKviFYrE5esGc0rgSYGKBmbb45yy4zsSjbQkd8b1dsZ
	Hu5lEkTo4WQ2dtrNp5uR0CdSMKswicP/fqnCDK0/rp2gYSVaw+KB7ggkS1NanhYmj/Ls=
X-Received: by 2002:a17:907:3f95:b0:c26:1648:a06b with SMTP id
 a640c23a62f3a-c4ca7a96a37mr288415166b.38.1793385230667; Fri, 30 Oct 2026
 11:33:50 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015085326.340074-1-liqiang01@kylinos.cn> <20261030-almosen-kaleidoskop-alpinsport-aa25b8e28d7b@brauner>
In-Reply-To: <20261030-almosen-kaleidoskop-alpinsport-aa25b8e28d7b@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 30 Oct 2026 19:33:37 +0100
X-Gm-Features: AclHuK-rLe_DQTrVjURbbB-BmxTRRZ60mDxXPOCkV58QW-hcxW62qhsY0ehUl4E
Message-ID: <CAGudoHG+ofOUv43u8MD3NX+cDE7Dq67iqnaRH18S_XcrWbrgaw@mail.gmail.com>
Subject: Re: [PATCH] pipe: bound new-page copies by remaining iterator bytes
To: Christian Brauner <brauner@kernel.org>
Cc: Li Qiang <liqiang01@kylinos.cn>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Oct 15, 2026 at 04:53:26PM +0800, Li Qiang wrote:
> > anon_pipe_write() requests PAGE_SIZE bytes even when fewer bytes
> > remain in the source iterator. This causes copy_page_from_iter()
> > to perform an unnecessary extra iteration after copying all data.
>
> This is an optimization not a fix. copy_page_from_iter() already clamps
> to the iterator count, so nothing is copied twice. What you save is one
> kmap round trip.

I know a guy who promised he would write the patch to avoid the
multiple SMAP trips for read and write side (it's not me).

It is unclear if the thing will materialize, let alone for the next merge c=
ycle.

I think the patch proposed here is ok enough to go in regardless, even
if it becomes obsolete in few weeks.

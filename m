Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793740770;
	b=hT5XAUvHkd/IhZSzwVbYTzLRdlKJnkJ3Ruw6HjS3pJiA5LOWH2WIw9jVY1BBOmXAjdUS
	 evWqXSbQsEwfMge980FWdPVReVHagGoVgSfK2/b6HQLZWFuBBUyvfPFZRyK/KPcz25Siv
	 Hsy3CgoOS9610PZ6dF6nyr5j0DE/rjbsjPyv8Q7MG1zKe1MG+Dfz1+AbzqeoVGHcARYkO
	 +khL86sjwExUND6MEyeAWty6mLYdmlxtgcwtjSM/bnmfMQ8jdIxlEU6sPtWt9hfmOHM19
	 c5W9UsDGa6u9lL+v/4VVVzrLafILY9n0/SCQEsQkUkQ7AENqnXLZjEL5GDHPv83rWeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E5djs837Oc0mgny3OGd4HuTw/22BWE5GoWMv7ehHmb0=;
	b=n5oQXx0Da+TQq592i0DSQswLckwdt71SSD0RsW+TMExdPT/Q02zFdRGfCdXdx1UlBCa6
	 JkO8Vra1V7MA18aAzcSpK9npcpXuT+0h8zAxjQPs7QPSuRmvoWAJL/OF7H7KX3CjPOQbI
	 R7DAkXXyt9EDqafqtNgPquYWT0PGjqLCXcjH++CLSoiwVlMyGly5c/qGr7KE7Wrmim+Zw
	 YzQ5/I097CP7QLzjQ9sMmz/SIy5C/9bqKUMTn985tjNRym3BiqmBBKfdXLs2paFSnZGf/
	 wl9R2SFN4K+jePUZKB9LZrXnt9LPaaRc1oOoYw9jjAmOE4H+i9a3lZM7Z5mojdla1jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BYxaItvH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89861606A326
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 21:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89861606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BYxaItvH
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso1846574a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 13:19:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793740769; cv=none;
        d=google.com; s=arc-20260327;
        b=Yw9ZKEp1elNNExaOL4XqnH8IZTiEaIFB+U9w0Ce7ueko5uae2pJ+0zkcycxcn60DuT
         06675jtb0XsTKQ6EEqLtmeFP/3bbH71ou/Z/kZha+vmQr75dmTwcdWh4AyB7fk+BzAf/
         9KGIzhso8Sa83uXXOIo7NJgvXWaap8s1mEQIA4j7agocaNqoEVidYnZskzT8aUXY+xKh
         TEZOrrPtnOzOv4OpcKLMxEfF5idv+Z6fR1+4ynhjv9o1+7xdEiE1Jpjyfm46BKgQwzw/
         N/vZnvgSRztLqb5eWbpLE/mmScnre/T8yI3yeI8VsLuiWTou1k3FIdtZXqO5OElhnSJH
         PTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E5djs837Oc0mgny3OGd4HuTw/22BWE5GoWMv7ehHmb0=;
        fh=L0GFMuMV3EFhmjeXOfOtNjyZQx4VuLJc60HRKU/uiK8=;
        b=ibiBGzp+LnoU4f6XwvqLDDWlILc3fzKiO9CR9wsNFsvPF799bfrNs39R6/n2X1Fa3v
         fXFChPyHJaMqWNWwsTDVVnFMwOnw8EGQ0T+btESKPXksgshdEScAkLDxQY0i3l7uhe5G
         YYP25xlPUewY9XNbfooI3DYSp+agC0zzdOAIqWaA1w/wYLGAOFEocRJUx3pdApSH+muP
         tFSDXlBXfas3pfh9NF/NalBKyC2SgflwIWLR6lfEGnE8dYmJyPgRoqDheWRH57OLPtN5
         qrTVYtYuVpzju4Wgsy0u5cPlI00aJdesxmw75jR7mT+rMBDnnOPTTAnq1lFYJrSmY3VG
         KfGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793740769; x=1794345569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E5djs837Oc0mgny3OGd4HuTw/22BWE5GoWMv7ehHmb0=;
        b=BYxaItvHI1gZItrW86V+E4vAwKZEiV3Jru97UJtiI4qR5NfUaldAMAoMNUpyl9x173
         F/5KhA9CmA0FEys3/Ton+U3I9Nhhm1REyRvR/CPLUyBs3EmMHj3Fu9M5MrMu2KNW76kU
         s0d1grVHKHvqBrCwKSaR9976nLpJRnfNLNeMroF8QIRmdIux/v3iZja/lgLcQtI6w9VD
         GQvyTBDtM6P8vqOjLXEpj1EuZV4PSdBe6i+Wulb4OkRdwH/oAcDEKEcJ/pxOwPf6yIJO
         /awfigc03vNy39OxYWjcazcLCEruRJjEhV/rV2B4JCUIexFY+PZDtp+TxUwOdmX0s5o7
         WCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793740769; x=1794345569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5djs837Oc0mgny3OGd4HuTw/22BWE5GoWMv7ehHmb0=;
        b=Dukhts93qj0Q2KD1Jz+Lzaa0R/a+P9YsgMYYpMAhkohfgUqn7D/PvW3pmYimL+kUrs
         PXSGvY53awjvKNnjhgEqR00rGtw0LUWm+2pDo/7+fkk/SCusXwPqFUelhRdvVFdgmkgB
         PDZHBLX+y8rtp8h/6CTx+gvD5ojTXm7OvUEuzH2uk/EFZ7PG9567tCNfH1k28Y5x3V/L
         UBhfM8sOqDdrfuQhKR3wajlN5DrcvxLCy4YFQOwukHEe5xMHIP5Q/5l7jITtm/eovBP9
         MZESDj53cA4A9xDC3LAEpbQCbk+H6k9QER2bm7yDi3x1Z1Jfmnt5fs9awEthyMOLrIC5
         rI8A==
X-Forwarded-Encrypted: i=1; AKwUvBykEBeSdLM9YESSHBSEqGGbtO1AuAGaRKoaRqYTxeDQE5rGeW7o3roY/yL9tXOqBYT0F2FgN/3CT9cq9Cse@vger.kernel.org
X-Gm-Message-State: APuU4Z/YIXSDykHugc4eMYxsFZA/pGaAJZommhU8hWBx2JFvfE/c2zd1
	K7ht/cQte0uG9epbmw227m8K42zVnp2SyiQbXwoeHsfaTMrlBH7vvpUxrG2xeTKpNSyV4IcFQuz
	QiUl1gme2C60fOLCELzwxkXW19be+czk=
X-Gm-Gg: AYBFou1YW/AOPSeTOMRQVmeEy5Lxca3QGthfo8FmxPgJwpvT47bpqJltwhN/T8R4zUT
	oIBA0e+XOvfLdTSkwt18FG17kJDDhr7QnziQ8HXEaDFiW5+7lSWjTZHt9REo4gPxa1Oso0+tzAs
	HfzOeWxOJn6d1xwLaWJ/hBxua8XrTzEudNqxTT6wboySXMjCdc/8q87GX5NcOxzQPSHgYaplcgJ
	xVCDYmSae81g7+PYNfrA2ves1Mdhd1R/ofLIJlnfc5MZ/cSMwHkDWNwTE13C/OHBUsvoLgzXl3t
	doLLFrXt+wY4RCgP3Ixf+xR19LRVLfZC6uJH154IpMpilr/+SLrPPVvgGjdhhEDMyidy0WIYDVt
	r5RZ+GuS0QC4cJstydaThQ5v0wSGee3eJHIHLOk0aDvw0SU6sYVckWyvvWdiH7Y/0Bae9oA==
X-Received: by 2002:a05:6402:a6c1:20b0:6b4:1eed:b9f2 with SMTP id
 4fb4d7f45d1cf-6b4d5255a99mr6904980a12.10.1793740768783; Tue, 03 Nov 2026
 13:19:28 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031095716.3030288-1-amir73il@gmail.com> <CAHk-=wiPhTLn1p0ZHx-7SMdk4_zazqDK1k7MMEn9scRfqeDgtw@mail.gmail.com>
 <CAOQ4uxjNrdxZdZZipsqnUNq+TswCKqp+30iKRKCqh2WOQ-zKGA@mail.gmail.com>
 <CAHk-=wiimdwWu0EVQdxGVjbVWdzNKGg0f6vZ1aR-GXxDvQa-Eg@mail.gmail.com> <CAHk-=wjz+Tg3iq_6uBqxm+egP_aRhodcz2Qu3pQaR8SQcvPt0A@mail.gmail.com>
In-Reply-To: <CAHk-=wjz+Tg3iq_6uBqxm+egP_aRhodcz2Qu3pQaR8SQcvPt0A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Nov 2026 22:19:16 +0100
X-Gm-Features: AclHuK9tonoGwvOBReDPDncd9ly3rSzJs7SEyhXaRkacdqBh5Cb5BYpyjNlp-9w
Message-ID: <CAOQ4uxjL9a6c=8u=eqrtkU=K1Es5ZdekAb-v16xNeD0-87Sr4g@mail.gmail.com>
Subject: Re: Return failure from take_dentry_name_snapshot() (Was: [GIT PULL]
 overlayfs fixes for 7.3)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 1 Nov 2026 at 09:16, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I'd like to see an ack from Al / Christian, but
> > I think I'll also rewrite that function to use guards.
>
> I didn't get any acks, but I obviously did do the guard rewrite (and
> then some: I got a bit OCD about it).
>
> I've committed the end result.

Thanks for cleaning it up.
Amir.

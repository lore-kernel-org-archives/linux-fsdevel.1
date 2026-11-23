Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795475980;
	b=GgWa3htw0jtR27E6huuv1vQmCS7USdL3O8mvfc5A2dS+gVA8MHmh0oyZN2aOZAHLE5nF
	 O95MBCZBK9sCzZjSaQC6RyD8eU2MuBW2Rwe06DjTnaKYISIjH2aB5vkNfosaUwO11dMF7
	 z6PizerCciiE2ylc63cewMmfQIS/RrGhuvp5UxDyqNYofzL1jBJVr7qauXjdiMZbGRj66
	 +zWp0J7But1/XXQ+p2jrPj+nBJFJnXMfUSr0iJp3Jt7frcgfyMgMEyiIHXTXzPkYcwczY
	 8zxjDyHJcfXtjOQNx5LstSXg7cM7SIuz+vS3CLMXBtPpju4ChoEG+77CvTR9TxHEWsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795475980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
	b=ciaLCFghO6CCeo25dCfyvT84LRmY719eKv4vKKqzlh19ng10mEpixEsrpVoAX1lHg4q4
	 6LnqPjPgJS5M/72hGIriaCS5nAFgfe0UdrafM3eYfgeNfGWVvlynO9H97EhgmQVXKg+Uc
	 /qhbkIqXcQICkv85oT9raG/RPFsqywKpMj8MI/1684l2aVstIKYOh6Q6NDZpmkMfSo/Iy
	 RNk2+sAiiNbRP9M4K6CU2q+R1fyZwaAVzJWM5h1hNZtbORGHxcRsr10vwvKzNe3xmgUsq
	 XLULoQZrsoLVzHI+5nDCTgT62NXMW27Jl43f9KCcUM82dMGF8xg6LS7X5n8dXsyLuAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="RH0V0w/Y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A37606A335
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 23:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A37606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=RH0V0w/Y
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9ae391a05so25928045ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 15:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795475979; cv=none;
        d=google.com; s=arc-20260327;
        b=bNRx4yvUig80S8756yJkUcCJU0JNn9XspTufTUAU+LmiwNL8RF/HXb1BjK0reqAgJ7
         BlO6sPMHRv/RFDoAKFzqUhLElCy0jIfscmj1kBwZehCD0A7NvwcmB/U+LZc/jm2jYi4y
         1VVouHkZhDH2vP0RplDRP/AhbIVVOUCoHHTVFEkGF6KnIENuTHmrR7JhnWRrxRgimAKQ
         3auS6c+hXlKQhBZtExVXKUwhEdwshchr14aNzCKkbSzSyyNAB3YFNMNJTBTW25i4GyND
         3dpi1Tz1oGH/hmgDK8UjMpd/tW/+UbYq4BLIKZzdZyYrg05eE96EMqEW/S160519jvZo
         2xqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        fh=SVRf1FX0pn3orfkSWevt00CjaMb3GuNecOe071Cjlss=;
        b=ABsDFhSXoJOKOYGIsmPBV0zI3AQS5AeRhhhCqYF6wim7qlTqcb/eBwdaIxSzbzcVhf
         NnQ3eJIOBN65lBc/vzjLk0d6Eg9FkOXKGmfxNga29wzxU0zHpgzkTXkGnaLvjuV6YngC
         cMwtc3BOxCPxj12/ui3bd4GETuv5gbZhHFu1BAvFnthjwEonXBxLYBA0P1+4BGK7gPsq
         PGg+0I/DgqYzIHsMBKNxPMvJ/nHVnr17U7DrG5RLfY/WAhE0FHfr73i1Sw6z4/83tEaw
         JpspH0ja+jOUUpqJaO/MS8DnHoSXq0DXjO8nHr7Td6kCPgvW6+Rfp5fy0azSs+u9wP2u
         RM0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795475979; x=1796080779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        b=RH0V0w/Yr/Z4AMRG2tN8F5gjksBm5yKNRTXUsuF/1NCZKbxj6Px+gUwAwti0vvEIpt
         ze3b0AYAjegli3ajVz8reHPYaQTczy5D/5H8TnUyeIVMRhXGJnsSb2RnhkLCYbicZhtS
         ZETTU1BDFAWMBEqZg2gXH/dKYu5ciTgugb+pbPvjad24YoECg7uC1XTQp+k2Mtqfn/u4
         yQUYcoahFdNOsiB3bh3TXDCfyjppcwNpsbv48RHxu13sF+IUnNZLd7/GZ4I98ylOdH7Q
         mlftfwPpLhqmf1SaXDEf4Z+0c98TbjBQ/xj4UXn4EhbvPUieaPwitbh/1GX9QXJhge1z
         U98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795475979; x=1796080779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PoobtMyoDnc+gxXLqB2HvjfkYgUQiC23/ftHCG2Qu/k=;
        b=zrXFelnaJbaJMUT23bgnxWJrSLY488X3COWeyFObYL8/ve+x1QHItgJN85Q5MQb6EI
         1RlP+NiGkcvP2+1zm2/6G4nFlyz1uVWokxie/n0TLIxnJJPJmphBp77cQxtQ10EBeMue
         ylsUPDf4rIiQXZLWeEfBMA3oRG7oo/b/+QeySaaXIR9ks4bssWqEJpp34s2gPTr4AnhW
         TIHavt6Hxj3p5GtQlnaa2+WDCyu6EpKsWvbA1O670R3pC1M4jKCoU8MCTq6+G4U4wXBZ
         cc7YiciPiXT5adBkZq37qxVaW2EjpHIR7OkIohnGn3LoIlc6rSz9236fwIW6dyGOUGGi
         2ePw==
X-Gm-Message-State: APuU4Z8mvksZ+L5IsF7JGDMtCjLlrOlKTSMebKKRpCnlJQpsYsFqYTVO
	D/OsLZZ8/7QKg58k25clWP8DSINQsX1mGhO6V9yhXswnVXb3gv7tTHLaJnhlLv+EOOnwFVIPwts
	7tRwzgnCcfDAkiobW6IA4TlBDmls/8iieIH6n3FIq
X-Gm-Gg: AZFdTZd0eAX8fIHrFU/s9eXVHRLYKPUZEjAHWpCDkTJq2iDYkR42fW+XNcclE+j3wIH
	1NVwj6/38z05Envg18SwCHPyKLnhuNVsHmRmOs2wMVqW6TZG1lkhwxhVio0VOjXEe8RAB3XNndp
	yZT8NvFp8GslewNWVLVcfgjQFSARNKA0zF6Ko5LuZtsh9I7F8TsK6hMOzYl4KytmB9UMOy9siHc
	BxALRqzdY9HD+WPFOETWF03Ta3mZWPTEq4+e1dbLHm3ZCmatT22syUi3046/Bewn6KAQioVFTz1
	JtSqi9WMZ0d2hld07bBZvPYe+zXBo0vf7kwQyU/hEPmJ/ri16Va6muRkMikZtN9QSKnIas6MypP
	G5wRrr5I5hJTZIzlgNwcWUQPUfp65p5WXzadf6GXkNiROAkU0yxvoCWF/nK4+gLP3LA/bOb36+M
	e7P5d4Zv8AHXORZg==
X-Received: by 2002:a17:902:e5c5:b0:2e9:528c:b9ea with SMTP id
 d9443c01a7336-2f03f18ed69mr94092915ad.11.1795475978663; Mon, 23 Nov 2026
 15:19:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
 <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Nov 2026 18:19:27 -0500
X-Gm-Features: Aa3M54p84nMzXEsFfUh5-yY_9m2RQyZXUhbb-xh5PHe7PIY590iycN_cOXWciDA
Message-ID: <CAHC9VhTXzxXECV6fwt0BaJC8jF9EBzmzoon4f7fWaJotv1PyRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] lsm: fix the security_namespace_init() kernel-doc
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:41=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The kernel-doc claims that the owning user namespace is available via
> ns->ops->owner(ns). But security_namespace_init() is called from
> __ns_common_init() before the namespace has been set up. Apart from
> network namespaces the owning user namespace isn't set at that point so
> ->owner() returns NULL. And for init_net with CONFIG_NET_NS=3Dn ns->ops
> itself is NULL.
>
> What a namespace_init hook can rely on is the namespace type and, now
> that it is allocated before the hook is called, the namespace id. So
> document that instead.
>
> No functional changes.
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Cc: <stable@kernel.org> # mainline only
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  security/security.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

The way this patchset is structured this probably should be folded
into patch 4/7 as it doesn't make sense by itself.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

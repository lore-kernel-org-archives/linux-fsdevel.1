Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503878;
	b=0b07Xp1MKYZC1o8vBFqR/Sh+uVMGTTQJYQZ1zsiPlphxUfoi32aADNW5OAvl9hUx1H/1
	 5X5khov08FWqjszbf86ZL+9m+DRKdzP0uojK52GEKoACWxG894Y4aCPTDtzWcT7uWpc5z
	 BkRUpTvqAlThKFO4N4vHP8Jo+VDVby/uR9rvzuAcMmvOULCtwGW6umb8XBQiOuxLoBCKr
	 8kgnW4XFTMqrjEw0ZsiJcWQ+AOsd1IaFgGmVD3Hg9GSLmG2DtPwCOY8r2/inbhynLDs3X
	 esYnCgi0L9HTC910n9owjs448d+iESWw6lnOZn4P3LknxLziN8O2SqhmX/i8pUwVmPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
	b=KvYqZcCMaTRj2iKk5i1m0//+lmo1nF2dza5pNvkTGWn6hfjns1NHXbbtBu+LjHePuPIG
	 uA46dFuT1skQIZa3HfCkjn/KPNSS/PBgjlsq+BIwYaDmLqQ8e09JuVPyUFyMSasUl1MoC
	 XBFVrAGtLihUe1402sSgGsFDGQsC4mo93FTA3R6dQna4lb76kSV8w6G/E75PTTmCEshQG
	 m3mcdKOlsRIxx1dy/nXZAgt2ckUVYyHTzI7ktHHYL9YSgnf0nNMFF7VUqO3/c+QS02Jju
	 a51d/Ihhn50Pj+n+EKwbPDMuewJJSAnUPek1IaEcP1+tvLGsu6QjxIKsqU13e2JNyWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QvyOqH3t;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44A606A893
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B44A606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=QvyOqH3t
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso102300a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794503875; x=1795108675; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
        b=QvyOqH3t0M3pFkt0ZvSXlN98+sXT9MWsrJ08zN1h1QA7GG32mUGDb1lmlr0U0DGVz0
         NTwR5vXLBSDhTH5JYvC8n/wz7ZKMEyIPJvs9C6nndQUhO4eOi+Slzo5Artxqa48ub7p/
         oXrzaC7qL8PJ++C+ios3/vygPbjmGpMxrIeF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503875; x=1795108675;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=F6YTYLTty4ZhMoj9B/ri1dVEfYoUCO5Spihz/O49FOQ=;
        b=22onc8x2bm3mZTcBGcBFi0tNMDCOChNrLBkzzJ500Z0cl6ZXRL0ed0p4GvuZx8iKHW
         tVd8wgxe4ibCC8qWDavFaEDoqDBTnwPpW3irh0ekuF0lY2+rbbk9QZ0SFSidxC6V6jss
         JQYfHcrJEYabIPyDxHEJAoLX5Voe3eDpFfqbx/6Jq1qtH7vdvkc3HFpND4JRLYwuBc/o
         HHQAAsfFp14UtSBoV1IZtX/HsPKqLFAXN5CqiYpfZB+326Q/6p2+fcJOE/kVFQ6/W2xA
         Wf1V8u/ydnmywRGARcctyRqzvmsKc1c1i0a6KMABeJ1OOIgu14rESr0F3uWPhL3/cW8j
         8XZw==
X-Forwarded-Encrypted: i=1; AL+hErG2XRwET9SW9lQ9hMohjzA6lD6G4/2Ifo/ScmDuWvt9p8gPDFRl5Ffx5VH7r6G0n7kV5BAZq1OvyTMNUp5R@vger.kernel.org
X-Gm-Message-State: APuU4Z/x713o82P43iVArHeFaOwWEPA/TSGawtFWvJNhTxtaRAYVzTZN
	nznsxzMpLue6toiyBspZHjYqlFkfm0LYGOzeUfpaSHTT/aOXM8g/aohctiKT5JrfWWpnfY02JXF
	+yF1cHbWfRQ==
X-Gm-Gg: AYBFou0WylmDzFHaJF63vusdzNpqVSD+3WdqCTlNvQs78zIYhPZFawj76lblTeekcVN
	Mk5kN07WFhyhqnlc2APHdkQB6dMUeCzZpJe9/+HbxQ6xirWl8m3a4jof7rL1HHc2htF+Qqp0Wlm
	wK19NXxiTVgFHCown1MYkUprbLYChpTvZBrs7mjR3jKI1Hxr7A8dEEPpPs6/yKFa8qTubIW1Wve
	aG8EVeg4eKDaVgsZYMZookXdNF5qYjfQJ0MOdbqLS7n3/FbRhfjZQ93Kt+bMgxk+2BsuhCnh3zw
	qOsfBHeDxBhW8sMMdLHvugJ2npaKqZE0b32P3+0Ewf9a21IVaVPnqxYi9Guu1+WdX90Rrhqr3Xo
	S/D+pZY7NPy6EPDaA0qDBTrhouW2JuAO8rnZSBNypFl/nTbkvfwbKsfziskbdGF3hvEJuQEVYuA
	+6BQgMHZILIVpCdwukxM2ZwR0KeMref0Fg1+zN9IbXRgzZl7PnFZzEfBlanQ+wSz7kIKJb8GUXk
	W+lITU6plWqM2USKbDWWxoE6wRibT+EtwKljlYlYf6EvcyMIm6EL75hXSVHqp2Xrqj4XgQqIOyI
	03ztPGxHRnQWXWWPEYIc5aQtQ+BHMD1y9ujPBj1WC7GXZ/y4TDMGbJczwMJRDnifNaYEhsLWS9o
	lk9s=
X-Received: by 2002:a17:907:1c9c:b0:c40:d920:746f with SMTP id a640c23a62f3a-c5066dd1398mr632132266b.46.1794503875338;
        Thu, 12 Nov 2026 09:17:55 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b60befsm189766b.58.2026.11.12.09.17.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:17:55 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso41399a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:17:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGfLG4RrW5a0c2fxTwvvpY0FkhXbWjoUKq0qT+uaCOP1ZW2JG9PXqDQAIvKBz/RykMCB/PA6LkSEEZKUJxW@vger.kernel.org
X-Received: by 2002:a17:907:dab:b0:c35:babe:ab44 with SMTP id
 a640c23a62f3a-c50665538e0mr626078766b.0.1794503550222; Thu, 12 Nov 2026
 09:12:30 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110145241.536019-1-kas@kernel.org> <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org> <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner> <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner> <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
 <e94bdf7c-eae6-4f64-bf93-0aeedca1a22e@app.fastmail.com> <32ad880e-5946-4703-9c6f-43ff59da39af@kernel.org>
 <3eb60948-8fc9-4682-87c2-c113e54e7d4e@app.fastmail.com> <4d6a3d68-3fc7-446e-9f59-f61d7475e22e@kernel.org>
 <bf186643-780c-40e0-bde6-f2af90404a18@app.fastmail.com> <b90d4bcb-b865-4a41-8496-78d751c03dfb@app.fastmail.com>
In-Reply-To: <b90d4bcb-b865-4a41-8496-78d751c03dfb@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:12:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTG_hWYC=a2+uu_+SeN4E1ra0n=ytGqyk83Yr7tDuEJA@mail.gmail.com>
X-Gm-Features: AclHuK8_5teM8idFuSWqym8O4N3OQPYF_Y6jfMJ_yh9uCx25qjwD1XBnjE0OwRA
Message-ID: <CAHk-=whTG_hWYC=a2+uu_+SeN4E1ra0n=ytGqyk83Yr7tDuEJA@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amit Shah <amit@kernel.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Bernd Schubert <bschubert@ddn.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Nishanth Menon <nm@ti.com>, Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 03:35, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Posted with a somewhat shorter Cc list at
> https://lore.kernel.org/linux-arm-kernel/20261112112528.1116405-1-arnd@kernel.org/T/#t

Lovely.

I'd love to expand on this kind of early removal: anybody want to get
brownie points by just removing the remaining users of the legacy
'kmap()' interface entirely?

I don't think we actually have that many of them. Almost all users
have already been converted to 'kmap_local_page()' and friends.

If we got rid of the legacy kmap() case, I think that would get rid of
the whole "pkmap_page_table[]" mess and the PKMAP_BASE / PKMAP_END /
PKMAP_ADDR games and only use the FIXMAP area.

                   Linus

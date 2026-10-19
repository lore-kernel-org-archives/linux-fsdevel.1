Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439673;
	b=aSF/meobnyqCKJSM+Fxj+MQBY9emPLAONdChJb/IYoNrpvHzckWK+MjsG3/EkBVN7Iv3
	 GT+WsOIStsI0PPDom4rOGkK79OC4fVJm2sWM8tNmZp5k6hLIxWL3z/Few3ze8QFtK3ZTW
	 h7Wh8T9WbidihoOg7SG08lfLAqgu86AlKnIzbSdmdJsLJ61NCfcOo2TSKQfmuQ2mdKCXx
	 T0mAneqLmoDn8yVckTdcgYDr/g+4NgLvsFcAS8SueWMLbyKjVcnukEGF6KlAQGHpb1t/M
	 E5bUouBeSikzSxR8XlkKUeorEGU324X0OE5Kaps2qHbRk9kgWJYO7c3zT1zPtwdXpfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439673;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=r4Dziqd1OmNhjy33+aycNRkzYAof3VSJ+fHhVZGkSd8=;
	b=yz0Alx5SZVf/JthG2fDuNxCtrtZqoiQTYQN/BDTizuGWZmrxm/OM8o7bjaP9U0Fk8wX+
	 rcwuWyWk1sZrVx4V6eDSUb5D5q5MLmzqa6hm6s2AYZ3w609zmf8IrMF5HlPCelqMWeCFC
	 Z8h4lyM2zQBRYFmA948mck8mVAV2J6+2shND3X9EeKby2hJ6FExm9o3Bb0nfGyRKYFiDt
	 B33Q/P6KYmzcSNBhL9ceAXvf3/PaMTBRerCW0J25XY4M0lm0Ab92mGy8CyTkzOuOB1sQC
	 MY5dBZ9+2C4Y69xf1nIyUZQv7dqvukiL5JIv6dFgw6C+e76KNIre+MKacU2AW6Inqqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=meNaQKPb;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36644606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 19:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36644606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=meNaQKPb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r4Dziqd1OmNhjy33+aycNRkzYAof3VSJ+fHhVZGkSd8=; t=1792439671; x=1793303671; 
	b=meNaQKPbcHHgKOYlUyYUdcyRP7GPKvYwxz6b7XHrLUp6kXIZVd0KCLb4NQYWqev/hItZqAKNHYP
	kBHf2blUz6VnkxCGjnydK0y43cZ2LOT4yqYTKomo+wLWGgwrryVMyH0J6SLlwhbiHqinITZFuedUL
	MxIr/Y9fA8K2TAYb0qr8M2FrESWIdiNp7LGcFbbwv9FXlq1kZ/pAo/3m8SuLHbmMEYaihIEI0evql
	JP8tROrmhteU+tlNfCL5k//SAAcbFSF54Gc06f3Ntzl0lL8u+bmMxu3ystIySkEGdMUn70ul84uuj
	LXCb/+iHtU47y3oOhitDLGbGLwS6LFki1iEQ==;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xItRH-00C9Eh-4N
	for linux-fsdevel@vger.kernel.org;
	Mon, 19 Oct 2026 15:54:31 -0400
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso429070866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 12:54:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzE8/N4ixshIKUtS8cWsvqf47eiEcGpIIiwZKYjp2gdeanueyjjYx15jGhliWBMD+2WAvpl5flWkM61Qccr@vger.kernel.org
X-Gm-Message-State: AFq9FYKFfF33kfRiObuSjrxt/orlgtV+66FGRLmEttgW8RbNsUjzsr09
	SV9aC2Rv05fNMnbOrt+3Kifv3YJj8ycp3GGEGDUpv01zETGRsd1z9RVLHaGky2KTy7Mxi8rKaBU
	dgKHieMvYMJ32SS8eZ25yMLjLooeZaEc=
X-Received: by 2002:a17:907:86aa:b0:c26:1691:b364 with SMTP id
 a640c23a62f3a-c419f314d81mr620262366b.29.1792439670207; Mon, 19 Oct 2026
 12:54:30 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016222721.791785-1-nickolai@csail.mit.edu> <atZw_gtMIIKXgc1q@bfoster>
In-Reply-To: <atZw_gtMIIKXgc1q@bfoster>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Mon, 19 Oct 2026 15:54:14 -0400
X-Gmail-Original-Message-ID: <CADGQE7H91ZwPgUzPHoAJmF3WjzRKxeQkQcV8+BLdGn7+kkEduA@mail.gmail.com>
X-Gm-Features: AclHuK89MSswr69kBbcBKYnmvmSPp-W3tduRDj-mdyB6dBht9FWZCtTRTbNC_Go
Message-ID: <CADGQE7H91ZwPgUzPHoAJmF3WjzRKxeQkQcV8+BLdGn7+kkEduA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/truncate: fix the zeroing end of pagecache_isize_extended()
To: Brian Foster <bfoster@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 3:35=E2=80=AFPM Brian Foster <bfoster@redhat.com> w=
rote:
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -878,8 +878,7 @@ void pagecache_isize_extended(struct inode *inode, =
loff_t from, loff_t to)
> >               unsigned int offset, end;
> >
> >               offset =3D from - folio_pos(folio);
> > -             end =3D min_t(unsigned int, to - folio_pos(folio),
> > -                         folio_size(folio));
> > +             end =3D min_t(loff_t, to - folio_pos(folio), folio_size(f=
olio));
>
> Good catch...
>
> folio_size() returns size_t and folio_zero_segment() expects size_t for
> the offset params. Perhaps we should that instead of loff_t?

size_t is (unsigned int) on 32-bit machines, like i386, which has the
same issue (reproducer from the patch).

Nickolai.

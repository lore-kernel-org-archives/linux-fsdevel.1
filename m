Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792812632;
	b=MZJ4jWEhyUemjfIWNbdo1/1zoOSAmO+jIAn7foNZPFtsncVTdtwC3Cl0ejU9vqSK/UmR
	 0O8BGmN7loHvKNz5pSQ+mnqVZ+PRgVmfPhiBw62YLDTBMksJJrO1bzdCqwBJJr7RlzI8t
	 vJ/dOIOIGOTZQ8qTVNQOLZX3YDpi33rqQucz+7/AdcNQJZ3w6+Fc952rg0oaIsFmgRABW
	 SWn6QBpNbkoOyExg5kOwdlDm9RrI7Ap9leG87rVlRI16hZOTbeJaUpsgbKfB2RStYm81e
	 MeTMi6V5/GaUmVaSRgOd1aR588ZubAHIisl2JW1U6ECTatdeNkV6495AKRWvh0jnevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792812632;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DxREnxXFL74zEXnlXFVXWPlkVOMBFqhGQRo3iyJ0jLE=;
	b=xruNQKGy5Egc/n2uzQJQ9DuMpYwPOAxAAvf7xxGTUGhAxQKNVqrK5i36CATHkfluDd9v
	 mn8FhO+1XBHVM50KWhmjpR6UzlPoaTQtv5bFBO0pqgQhm5hvC7khYeUz68bIVE5U0avJL
	 IPNF45qzgc0txhXK1tLKmEuDgf+kKh4i2mvxlJPHUV02jTcLDX93rg8qprJD0qS2w2jO1
	 k0MoHmuSK5mRP3ecwRWBdOKDLCFoQJe6KSYVOiuU18UfkdZzJajLNhQmY2qcFnlMszjNm
	 kyIF03Ow5xcsifBUa/QHFmt654d+TpbZ/k8qUhD131I3eajXD8cuZUusKspjTq4g06g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=XlupHKHL;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8016D606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 03:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8016D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=XlupHKHL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DxREnxXFL74zEXnlXFVXWPlkVOMBFqhGQRo3iyJ0jLE=; t=1792812631; x=1793676631; 
	b=XlupHKHLpRFmdluWHfjziaHaQxpnzyIc15B0KGp+IoxQJED0J9Erd/yDzNGAseaEJ0Wx8wo0OSg
	aNRoZl8uJx2PbB7LvwxFu/uHmfJWiUqKW1GrJaBcXbc5s9OzwOONJL51e71f75Sgw/gq88eo1qU3k
	+MiB7VDXOgoA74MXJ0EkGeKZW6amuAR9M2LkN8/QdY2y1XkA1ApHnpYf7PD9KNLjQsvcbQJvPvwCU
	x5T//BAry6XuMSJtevZaCST60tpwg8Z29ZAdcVj/4Q2NVRiv9gZj1h8nvilpyEuiBm40RPJd1Ej0j
	+px0EfzXuA4PHi1AVAU/RxYa9zX/0qCUCdug==;
Received: from mail-dl1-f49.google.com ([74.125.82.49])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xKSSk-00EHej-Dy
	for linux-fsdevel@vger.kernel.org;
	Fri, 23 Oct 2026 23:30:30 -0400
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15943c9c005so1931580c88.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 20:30:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBywJbTu0r+QSluoFgmdqfDv7l//fN0OG1h7KpVwMuztgOVXe7OCaETUMSYh1nr5RkRRTKzinGZ0f6XFw+im@vger.kernel.org
X-Gm-Message-State: AFq9FYLokbbZcHy8+FAf25jTwiYr/vuihPxJMpNYnVdUlhO7LH01lv12
	w++W2gnI4fptQXWOFaxyVhCDGBOzkZ8r42N3e+Jn0qdeF5xo8yH8vf7Kdg3BMOLH0ONDhiACZYI
	3MSxfQx8siXQdkGAHU9PBGznt2IuZ7Nk=
X-Received: by 2002:a05:701b:2915:b0:196:e254:db24 with SMTP id
 a92af1059eb24-199375eb26amr1030037c88.21.1792812629421; Fri, 23 Oct 2026
 20:30:29 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016222721.791785-1-nickolai@csail.mit.edu>
 <atZw_gtMIIKXgc1q@bfoster> <CADGQE7H91ZwPgUzPHoAJmF3WjzRKxeQkQcV8+BLdGn7+kkEduA@mail.gmail.com>
 <atdHhW7JU8j5pozl@bfoster>
In-Reply-To: <atdHhW7JU8j5pozl@bfoster>
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
Date: Fri, 23 Oct 2026 23:30:17 -0400
X-Gmail-Original-Message-ID: <CADGQE7Gaw9t14nOr_FYcT4d5y+VEjX+oSgkQoNWiNtomCfkVRQ@mail.gmail.com>
X-Gm-Features: AclHuK8U-00Ea83CZV1_hG7vFrciQgbpxapAyoOn_d2XFtjDVI9f8nU_G2FcSqA
Message-ID: <CADGQE7Gaw9t14nOr_FYcT4d5y+VEjX+oSgkQoNWiNtomCfkVRQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm/truncate: fix the zeroing end of pagecache_isize_extended()
To: Brian Foster <bfoster@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 6:51=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
> On Mon, Oct 19, 2026 at 03:54:14PM -0400, Nickolai Zeldovich wrote:
> > On Mon, Oct 19, 2026 at 3:35=E2=80=AFPM Brian Foster <bfoster@redhat.co=
m> wrote:
> > > > --- a/mm/truncate.c
> > > > +++ b/mm/truncate.c
> > > > @@ -878,8 +878,7 @@ void pagecache_isize_extended(struct inode *ino=
de, loff_t from, loff_t to)
> > > >               unsigned int offset, end;
> > > >
> > > >               offset =3D from - folio_pos(folio);
> > > > -             end =3D min_t(unsigned int, to - folio_pos(folio),
> > > > -                         folio_size(folio));
> > > > +             end =3D min_t(loff_t, to - folio_pos(folio), folio_si=
ze(folio));
> > >
> > > Good catch...
> > >
> > > folio_size() returns size_t and folio_zero_segment() expects size_t f=
or
> > > the offset params. Perhaps we should that instead of loff_t?
> >
> > size_t is (unsigned int) on 32-bit machines, like i386, which has the
> > same issue (reproducer from the patch).
> >
>
> Ah, Ok. So loff_t makes sense for the min_t(). I do still wonder if it
> makes sense to switch offset and end to size_t while we're here though.

I believe they're always pretty small (bounded by folio_size, which is
bounded by 2^MAX_PAGECACHE_ORDER), so size_t isn't going to make a
difference here.

Nickolai.

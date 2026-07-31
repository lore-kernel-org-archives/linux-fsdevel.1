Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59039183A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507289; cv=pass; b=aEK+rbFNN3PfdSzDmx8xqZXnAmqVw03K/9qmALh4cx8E6plyBnA4hHIz1Z/KBlV5uhJxKSIKN+B+BNCxGtAcBcFvDOmDREZ9DCE0CPhDXo7FW8lAYhSPKxxlnD3U17PvL4NAZip2k9KfOPOpikKapfrgznFiyYk6T+6NPw4uptg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507289; c=relaxed/simple;
	bh=2wpm8pNBdWbOzBfFxf8+9X+JkdbjJLNLCWw//BIeIJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojWFAjTrjkJ6m8ZeVHiI91CF+chHYEe/KI0GVU7lrIqZj8lN/w4teHO3ce8I5Wi64onK7asbMK1+xegWIkvUVYrVVua4NU0IYNvXODVjBwszZ5P8x65kih7q5fH7KsefwiHm0JKEUDsxnnx2uA5fRRhcd3JCrfqNho17XIfbcsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AHZNpvLB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1dggKTE; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHZNpvLB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1dggKTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785507287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wpm8pNBdWbOzBfFxf8+9X+JkdbjJLNLCWw//BIeIJ8=;
	b=AHZNpvLBGj5Q624mHsdowLwJBwt5EincsejeDCA/GQk47b2JeAbsq5ashtgaezaQ1hB3NL
	0b8n/NP9QEa5fne7uBqpetMlgZfaJCr3zvPStVrdPNm19SLouTCxSXkqpsN5FXL8SFoTy/
	xhhcu0pScpaFSAdKZLby2y1Fpg2A+cA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-ckIDpjTrNJO9LRihccIrlw-1; Fri, 31 Jul 2026 10:14:45 -0400
X-MC-Unique: ckIDpjTrNJO9LRihccIrlw-1
X-Mimecast-MFC-AGG-ID: ckIDpjTrNJO9LRihccIrlw_1785507285
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e6ae12b42so15093227b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 07:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785507285; cv=none;
        d=google.com; s=arc-20260327;
        b=h+SgGEfggRkqBFN/cqGfcGoTLG7du2fX8BCHzKBgRaO9LJzpuiIvPr1Z/+/rsyvfaM
         w8Wu8aCwE5ARy6dH9PLQ+92Mlbtp7ib/a9G+bsYv4crVOKDNvb2/NteD/zhnVib6VD4u
         ZnQs/pRL2n55e58TD8Zsy/3bArFtaS7JFMECiFjrRmAOBAL7MdauXWzt72dMBJ81q+jz
         hfC9vVODZMf04OIB7K18owSC047MksvFyNlIZvAhxCndO+vjU84Faq9EBJMyEH/IzRcG
         a74mxFDSGib61CwLtJgEo0WSSCnArQTod1tGHCGGIwZO8wfW79xfRptMr1J4MYeThbaB
         aycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2wpm8pNBdWbOzBfFxf8+9X+JkdbjJLNLCWw//BIeIJ8=;
        fh=qmVRIfrmvQ6SIu9UEVeupog/8+RVLaSSOuvQAhae8gk=;
        b=FdQlIE6SeJUVH7/aRJUWm7HBBXaVhD53LVnirz5A3Ane39aI/EmEyJSRiSB+NjSuM4
         YnbJaZTxeAuwfQPQqc1BxOGE3oju2MNnHraxXPdnLD1Mrhl7LOrN47lvtBXlt2Ehejhe
         QJGOF0EWBdypqj/aW1uXcClQZRjuq4IxnPUx/vMeCsScPfT32zXbNs3WvpM9wn1fq66O
         6/BAinmp0kp/gqMeIU+xxiGxgBslXQj6NOesG106jSxeUEOZnf5b/AFH4NF8Fi4ZLnfS
         shRPtPeYqEqacXDE17BxTzGJoCZ8npkFRe1Hak4oRiq21pI5NOqrCeYbvUEKmmJ3sk4F
         aZtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785507285; x=1786112085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2wpm8pNBdWbOzBfFxf8+9X+JkdbjJLNLCWw//BIeIJ8=;
        b=h1dggKTEwYMPX9nxufgK3cGHRLpw5ZKzS/xUjW1OBDE7Ft373s0OMGP7i90C0WeBr/
         vxi/DmSn+RGoq+O8sL21XAmzi9KRnowbWUN7Cvz/6gfepA6NpoRiuSw48S44JMBR1nfa
         nWC7mmKBtxGrYM0rD4VxZN3jfi6PfOji1BEFZoGtlLxOpRZZbUDdZ0XIkMA+9tlKakh2
         E92HhMCBVIunDPKeWkbmT4BPYaYOhv0B0+elWgNTljzEn+NFDHwG/XIrczizjW2j2yGC
         I7UgVBHGYJSgQT1yzvZmr0liqOtj5YN05FGHWUDquZ842ZKSZ0SzOaRNT7xyp/rrotTY
         MFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507285; x=1786112085;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wpm8pNBdWbOzBfFxf8+9X+JkdbjJLNLCWw//BIeIJ8=;
        b=Hlq86A/ZOW+za4QYSWBXgvFz5E4qtJdEImnvCC/rK7rWlHb4agoosxQ7rbQMwdyNot
         KVpZoDyEnPh3KqvZeg/En7+WfK0M2CL5k9reo1PCbT8b0B+KP1YR2mz+yw/8kipj9gsz
         x4u4VykOMlpSAM2pKoMP3HGbv/kUv3wWP3kIJgtmCtvHiKTJ4SDZzbzKSujT14j+prU9
         eryUOg7uMlEaeflKFtGmuQKt7E9+ljR9WRv9holFzN+CHCf1rrRV4QcPBO8ELinniDvk
         QfnLCGARINsh17+GClDKslAGen2kaAJAIiCNY9JMh9YRcBotiWopgPDVRc2cvK+0X7yJ
         doag==
X-Forwarded-Encrypted: i=1; AHgh+RpYugqgzF7B6cOCGGsaGQb/pg51WZn/mgms7UU8P+m+/+oXjxpy0yL4yETl0l6M+8fzfmnGK1QlKzGhCsr9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32/y9bBkoiokt9umyxCvdvjWiEzIwGoDC2LUxfbLWTtOf3hIM
	dvnoJYW+AvRQXYDrrNKzWZSqI/PPOfMNO8aTw6Z89ZrqIPDfHnyKVpReKaOSbLutax567l+Cz21
	G/YvFI5PipPwdYukxdS8p2GKO3NW8291Jbd28Xir7hgLoXAvW3UvxhmEYjMK8T6Kmo+HeTScTd4
	fKYxNMbS0icS0CGTlGYBtQVTmxU+SiNW5expT7Oth/ufuD3F+/T1Yh
X-Gm-Gg: AR+sD10/Cv1JcgWXm9V+ntjVG2mYS/lRAYX9a/bmjclYtq1EU8bqexXRSkhY2dHEsjm
	4l6JqkijaReRgnMRnuee/jh3eS+Fl+5vF5YIEOMI0t9rJf4n/Stqqg3MQnvg+sDhTT0lIgSu01T
	ODlU4rLLv1VI/u38QI1UpXaQJ37P/AEpfACIBERgnmvSi2gR45HrZ9Np1uNYNmTk5jYkIrC04yr
	BvMnd1lYnk5+sSsTczOqWe+jUK2ect9XKpIpdlPg+sH
X-Received: by 2002:a05:690c:6982:b0:81e:a471:e893 with SMTP id 00721157ae682-81fcbad5eb5mr20457997b3.24.1785507284969;
        Fri, 31 Jul 2026 07:14:44 -0700 (PDT)
X-Received: by 2002:a05:690c:6982:b0:81e:a471:e893 with SMTP id
 00721157ae682-81fcbad5eb5mr20457687b3.24.1785507284532; Fri, 31 Jul 2026
 07:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722151023.1308069-1-agruenba@redhat.com> <20260730-armband-reklamieren-heuchelei-6f67abb088de@brauner>
 <CAHc6FU4719z5crxP-ahSXs2qLachSL9GOiv4kXRZRifNxm-U_A@mail.gmail.com> <20260731-rustikal-revidieren-parolen-02b3e749e9cb@brauner>
In-Reply-To: <20260731-rustikal-revidieren-parolen-02b3e749e9cb@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 31 Jul 2026 16:14:33 +0200
X-Gm-Features: AUfX_myqDMWH1dty6METaEXpYWBGoLjv9iwKN_tVhRaDYxWp_s4po3esAogYYOU
Message-ID: <CAHc6FU7JQsrqf064yzG8_nDovSFwNCd+-cfmJE=_9pQLLYLdXw@mail.gmail.com>
Subject: Re: [PATCH v2] xattrat: accept empty O_PATH file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:26=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On 2026-07-30 22:34 +0200, Andreas Gruenbacher wrote:
> > On Thu, Jul 30, 2026 at 8:49=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On 2026-07-22 17:10 +0200, Andreas Gruenbacher wrote:
> > > > Christian,
> > > >
> > > > here's an updated patch for making the *xattrat() system calls acce=
pt
> > > > O_PATH file descriptors.
> > > >
> > > > Compared to the previous version (see the discussion at [*]), this
> > > > version adds a fd_maybe_raw cleanup class that uses either fdget() =
or
> > > > fdget_raw() depending on which kinds of file descriptors are accept=
able.
> > > > That's still a but ugly, but all the alternatives I could come up w=
ith
> > > > are much worse.
> > > >
> > > > [*] https://lore.kernel.org/linux-fsdevel/20260701191649.175871-1-a=
gruenba@redhat.com/
> > >
> > > Thank you. How do you feel about?
> >
> > I don't think it's an improvement; see below.
>
> Do you see other users outside of fs/xattr.c that would use this new fd
> class. If not it might be useful to just have a local version of this in
> fs/xattr.c?

I hope nothing else will use fd_maybe_raw, but hiding it in fs/xattr.c
still doesn't seem like a good idea. Do you insist on having it moved?

Thanks,
Andreas


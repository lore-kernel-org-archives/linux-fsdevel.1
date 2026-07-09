Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A291E4252AD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598552; cv=pass; b=Z2oZ2lMcotC8InEs/VfwzlXPx/enXG3jTF6Yyn7QGOtx+nl2jbAAXD0GerFLVrCWcsN0Eeh8+UzmduSJQxssO/5tBxwOTjRIM/1BMnU2+H/Ux8G0r+qdeF46K0wyMfEdB/km0ZD3yG/92dTMHJQXR3nH0LrUR4ZhdSh2PJuLdws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598552; c=relaxed/simple;
	bh=ri5Y8I53n/fbTrDmRJaZc+MoEb7JWs8yFkilYJlYPmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXEkfvu0LZyYamrVdezD9FSY4SJdvWvdhgmGTwjRpPA9q3ch0gf1QtxbV9/nwceABkm7dmxqgDrKECkP02V++hz3XABQqEq3a8l2tm04knLxod6js7fnngLeseht541SVKB6ZrAMllnF+qNnJIvrVyOIIHxgr2bnK2Xqsswgbw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SIUfte1C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScuAtsjS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIUfte1C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScuAtsjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783598545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klhrskk2BFrUSOAnaJscRnKKJOGyjkDmCm2PlrUHhiQ=;
	b=SIUfte1Cpq1VuToLsncvQ/QL+Lx1vIQtblpZZL0Bs/2JU1bwC3iQNXNqSinLz83In829BQ
	vszwCIXC+eOHXUKegcEttUk9Ffgyr6vv5aQLaypIj+rLTLOSAnBIf99r78b9o9n6colqkU
	7JctHWjcpQ+z3DznbI+qWRfhn7MUE+I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-LdIyfdN-Pn6P80NI1HtT3A-1; Thu, 09 Jul 2026 08:02:21 -0400
X-MC-Unique: LdIyfdN-Pn6P80NI1HtT3A-1
X-Mimecast-MFC-AGG-ID: LdIyfdN-Pn6P80NI1HtT3A_1783598540
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-698b9b2edc8so808782a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 05:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783598540; cv=none;
        d=google.com; s=arc-20260327;
        b=M+sSF5wGr1XzwuSOhJuyDJr+0BlpXN+n2iJ8vuAUKNaBWR7cykAqLZehFi6yj8SOD7
         B/bfa/Y19Z6kZjoGC/e6sNzQTxslOH9nVme9dA0Rp8UFyB8YiameOyIUSexVNjrDtRKi
         /WsUTmPFmThDNqQ1MN4kwtnFiIgridjE5OobiJJSgcCmOn7PjBaTZYBoXWVTEpzv32NM
         36R3r8NeX0y39L5BUTJNrUcDGhMq/TgQfzCjmZqIu36WHLIY9KTvYHTUlsfqRR+Ez6Mc
         4ifBq7PyROt2q26A+5KbzyIBU8qgJMQOMFKpjUYRR9ZWI0R1QASeLWPDZyngYEsqgfpc
         ME3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=klhrskk2BFrUSOAnaJscRnKKJOGyjkDmCm2PlrUHhiQ=;
        fh=NX6a1B5Les+Voe8kVujxP7WR0Isq32pQy54DbPkn58c=;
        b=SrzrfOFL3tydMFeEe7zB8UyxRWWccFxVz8B2Zb30dgsPZqmF8/YsXHvuqcW16iWFqN
         tKpLP5ZjiEESdonRDW+Vf9drrknIXKAeU/esgANkcMsc/lUcVFBY4TFRBXQtHNxFJTaS
         oFnzAD9Sc/I89VbLytbHwZSYVxzcwQfOF9dvXf0zPkkuNl9ntbq9iF+dCfnE57yiJBov
         RFKbYeGvLfOkWBZw0Qs6fFiJeA0SWVb8YAKIcdldldhgCfuzHILwqR4HbTphrW6Md1Os
         l3kcxSpbQA8BKf1k9YXYpnNUPkBzm1JQgXjsF9qcWp5H+GavIyo1L/edtY2t3i+m6Yet
         25+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783598540; x=1784203340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=klhrskk2BFrUSOAnaJscRnKKJOGyjkDmCm2PlrUHhiQ=;
        b=ScuAtsjSHG/NYNfXFMF63nsVUyEQEPx6X9Uw+aqQexnf3SuWHAkWhmScmFdVKL2iQ9
         /lMvzZj4OW7Ej9JLcwekcKVOxaeFHDSbHtWLZ7vd2nKWN0JhL9SFp4ynILiqIOLCk1kN
         Owf8iFByzy4pY2pRS4SAjruSWKCuM7RilWLuAunMltWHGocMnxK9jazIl/TM/hj8V8oA
         oRP+EPnv1RdkPo3l/51xH4n8e4wt/PfFEitRg69aoeqpIw78V+hhtNGfXFfMnNNbG4S/
         iXD0tTILhyJHghpzL83yDX/cU0pMJ5ltmhJgO5Ai8M1n3AWqgPUi0mjMLuCYisfjU49a
         HIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783598540; x=1784203340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=klhrskk2BFrUSOAnaJscRnKKJOGyjkDmCm2PlrUHhiQ=;
        b=QZcSAwx+hwk6IVrN3aYwLqqXOJFl7cVPv1PQdHycjCEHmmnm+0cHrzGJixYB+i+pOI
         j51CYn3yt8teEBqdlj8JnqDblGtubG6Ri3jZuV/H4ejdd6jls9BMVRS7yiZ2jYYyMrKS
         UlgcvIVPGsNQ8eOJwRMO03+HB2a+mhE6TmGW10tX4Lfv4XObM0BQGq+4yaNJpx93BeRX
         rYnuPgZYozBvYr1YwgEzuUiXJ18z2wJ3BBRfMy7CqLAG6bgLwKLgS77/fcWAc3Zm35n1
         lzD9aCAY0snVF0muvqnd+IEGWiXSAwnV0xoyUF3m/9I3Zy01kfx0c2MAkVyL27mR4wHV
         tBRg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7tv3j6zOezV73O6BIGb2H6CeNwLWVrM4N1z5ILm5ydquGAAFEQz2bP+YCbQT5nDUxccudWmmfvOLmyBJG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0p5JfvqXKWZQSivK2PCPbbj/ivkmYrcOuhCHXxWkZQWtJlXMT
	Z8l3j35UudrPgXKAs4j38JPKIXjGlecwvIRHC4PZWsagyeXaSXw1P8inN6ZsDf2Wq8zDayDizVx
	Nxbgt+gwEOXnrn2/ZWWliPRXfAG/EOwjQxJMGMeWaKhdnBG3MLmzHDFS2qpRQZtob5jLB9MiR6l
	I4h9BP6szADhiBeVY7Wk7bKwTZIwLszW5GXbjly/tb5g==
X-Gm-Gg: AfdE7cm3fmMnpevfEcpV/CPGipT5SMxnXfN8ULVGqDzbZlEntFjZAZxWAcRs9F0wc02
	N7GZ2tmfqJHDaT9DBbQieB/z6oWFq9uoRLLifccwZtQsQxBYyN6NvQzPNjiF/b5sjPOPTYvrldi
	v8bKf9ZiJcCmZH6bp2buxgBOGYlW61mPNzjxTZoo4Di0SpOLAFE863wG8fMqKslbyGJ+55+ja/Y
	qGUwBCkPkkuKU1SNxz1QRaP3mTUPD3rKty3PgnF6SXXLCpSnToBjbc=
X-Received: by 2002:a05:6402:3788:b0:698:3ce6:767f with SMTP id 4fb4d7f45d1cf-69ab445dd6amr2838651a12.12.1783598540433;
        Thu, 09 Jul 2026 05:02:20 -0700 (PDT)
X-Received: by 2002:a05:6402:3788:b0:698:3ce6:767f with SMTP id
 4fb4d7f45d1cf-69ab445dd6amr2838610a12.12.1783598539939; Thu, 09 Jul 2026
 05:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709062622.2939412-1-ravising@redhat.com> <ak9UqRfSB_O7vDVM@dread>
In-Reply-To: <ak9UqRfSB_O7vDVM@dread>
From: Ravi Singh <ravising@redhat.com>
Date: Thu, 9 Jul 2026 17:32:08 +0530
X-Gm-Features: AUfX_mwZEQk8JKKKAMSNrn7Grs4IbBwv1IY32hLR0L-jP3Rk0HjGQhM_5z2e7J4
Message-ID: <CAF-d4OuEMZWeKn1DLA8gCCycb68TMVacUmLDeH2yZivVbbg7Kw@mail.gmail.com>
Subject: Re: [PATCH] xfs: punch COW fork delalloc on COW writeback failure
To: Dave Chinner <dgc@kernel.org>
Cc: linux-xfs@vger.kernel.org, dchinner@redhat.com, bfoster@redhat.com, 
	hch@lst.de, djwong@kernel.org, cem@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:28=E2=80=AFPM Dave Chinner <dgc@kernel.org> wrote:
>
> On Thu, Jul 09, 2026 at 06:26:22AM +0000, Ravi Singh wrote:
> > When a COW writeback I/O fails, xfs_end_ioend_write() cancels the COW
> > fork extents and punches out any overlapping delalloc blocks.  Currentl=
y
> > the delalloc punch targets XFS_DATA_FORK, but on the error path
> > xfs_reflink_end_cow() is never called, so the COW fork extents have not
> > been moved to the data fork yet.  Any overlapping delalloc that needs t=
o
> > be cleaned up is therefore still in the COW fork.
> >
> > Punching the data fork is incorrect because it can remove delalloc
> > reservations that belong to a concurrent buffered write.  In particular=
,
> > the convert_delay path in xfs_buffered_write_iomap_begin() drops the
> > ILOCK before calling xfs_bmapi_convert_delalloc(), and a concurrent COW
> > writeback failure punching data fork delalloc during this window causes
> > xfs_bmapi_convert_one_delalloc() to find the extent missing and trigger
> > a WARN_ON_ONCE(whichfork !=3D XFS_COW_FORK).
> >
> > This is the same class of wrong-fork issue fixed by commit f6f91d290c8b
> > ("xfs: punch delalloc extents from the COW fork for COW writes") for th=
e
> > xfs_buffered_write_iomap_end() path.
>
> I know I suggested that punching the wrong fork -might- be the cause
> of the bug you were trying to reproduce after noticing that commit
> reference in your analysis, but I don't think my hypothesis was
> correct.
>
> I've had reason to look at xfs_reflink_cancel_cow_range() very
> closely today, and I think you should, too. i.e. work out what the
> COW fork should contain after it finishes running on the range the
> IO spanned.
>
> Then....
>
> > Fix xfs_end_ioend_write() to punch delalloc from XFS_COW_FORK instead
> > of XFS_DATA_FORK for IOMAP_IOEND_SHARED ioends.
>
> ... it should become clear that COW fork doesn't actually contain
> any delalloc extents over the given range after the cancel operation
> returns.
>
> So even if punching the data fork is wrong or triggering some other
> data fork extent manipulation race, replacing it with a cow fork
> punch is not a fix for whatever the underlying issue might be.
>

Thanks Dave. You're right I should have looked at
xfs_reflink_cancel_cow_range() more carefully before posting.
cancel_cow_blocks() removes both delalloc and real extents from
the COW fork when cancel_real is true, so there's nothing left in
the COW fork to punch after it returns.

I'll go back and look at this more closely.

> Cheers,
>
> Dave.
> --
> Dave Chinner
> dgc@kernel.org
>


Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A5386C3C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629378; cv=pass; b=Mku6zI4oIyVlXdzfrPbX8V9ZUOdOpclVLRnQfijv5k6INHRyNWJMkSlajeLIN+BJ6ARKU9rSi7oz5f+wDIbRHds2iwd15uh2B2cvPUK9QS66QYUouc+zb+jZwOQI8YoxDGnkOfl8ofW46tmiTmlJO04pD0eVpNbOH3Uj60TCTR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629378; c=relaxed/simple;
	bh=ihacAeS0i6fk5VQDmiyxQBBI5wafi+7J75DYIclWFuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqTu6cl/w5QUxmf4n4hkiEcpk9G0JVgbdnd++Ifso5WlCKo7ETqrkYTdUqM2PGGctcWKE+ok+1H9Oh3seNTMhLY8+ydGVKVv5KxtcwUTHpG8zKgLFBds+QSMdGGLLzw31wY1M4Tgxf2fi/tGTj12MpElrlXYsslWQJJDzJ1QiOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bNUNREl2; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNUNREl2"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-132cccd3d77so53c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 16:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778629376; cv=none;
        d=google.com; s=arc-20240605;
        b=fFkMxCGD4Ak6uAAQed+Jwpp2xjI3cPFVhy/dly1UN9t67F37Nk5ON9oiyuVWBC9xmY
         qsWV4IiefdRAatCv8WylwZcWPNsSxCuEDHZ1NHKVf8X2/LYDpJJi7ywPuN7DUJipToSJ
         oSWdLI95vncyWaheYvOvm8p3pc6QUzyc9+CzwRbWQ4Ja0WJfmbGLp9IN/4anfo8Y6gzT
         rtIX8t3wtqPWozH+vNz1QgTdLGzRCzzSwoZCzDLwahdougkeAXEHVHuu7xK2/zwDBwRc
         fgzx7oekiuFJBeQAWn0IH1e71o/ZHgDoe1CvaDwLhVnRenrOhgQdIsPTwVEhRgvVg19b
         nFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h0VhtExHawMft8issPpgsUtVwnBbQo6CTp5v0nrHBV4=;
        fh=JXsIMXUgUeQvPsYdj0sza1ECbpWkUMEJ+W3m6mi2+bw=;
        b=WcBwthBdBrg0bMjBqIsjjmhHuKnoSNTJ8iGyvvzVdn9KwJKhuzsMPUUAGQJBwbAuRN
         y6tWiEWFAJTMxL5deg0kv1uQmEN7iChxRa+tUC6Qf9NTDOpGP2VwvUzI0ksi1lResikA
         jxBiqYe6L1qoH2sZ0c9De1Cxa5W8R1BUgWE8ccY8YcJWCMwgkKN8P1BbOOT2qMIl8bte
         vsp7NLfxJRfeqXmJ/wKjvt+VDsSLi3ExdkkZxoU4Lo1cJmCB/YZZ5nmK3S96eR8z/dvP
         fXcNFYfyPdJnrlJZp9YSwv/4FuZ3DBfBGPnM0JScARFDiEfI9II1BRIcfBFXOGp7aTi3
         xqNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778629376; x=1779234176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0VhtExHawMft8issPpgsUtVwnBbQo6CTp5v0nrHBV4=;
        b=bNUNREl2RzQUp1N37MFkN7XmQnnZ2PSKk/rcgvBjBTYorEAaJe7VZx0CJFLobMohMO
         BzWVrP/MjTmKLukWjR8ywynlqC6hjg91vOA+2YSjgKYrPTN0c9fFBYclll2+qBy6cPXy
         wyfZ7+vzxhpJFy0NK5dUEIHdmSqsYskTOFJiZf3/lgAyECEMsp2n3BmwcYGUq2GIBnmO
         QX3LODufnXBQSeT32iWXqUghqEZ4WINN+5SuSx+zar/N2o2LikJRcuG5y3ppnGnkA3hf
         GjEkMrVZoh21mTVyr3GxpNcA/rvGsk4jcz15MtjjsEFrlGoH7c7hw5KC6how1ffMfn9S
         ZT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778629376; x=1779234176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0VhtExHawMft8issPpgsUtVwnBbQo6CTp5v0nrHBV4=;
        b=bqmDIUbEJv/bs0e9bisURoNiTa4kQnIb4hxIo3sjcCNwK9yNqtZ1ohRm7pUltGC4Lt
         T9BLDP/ajvLyp1cRd+UmWJBfQoCbYALQpYxVAnwuVwESVtXzLOZpmKYu+DL5Zb9Xlnxx
         Co8mgLEmc/ipJUzTowMnDAH4C24oiM/E2NWsgH4eNgEP/9U/1OtjXRVm8HXFK2TA/U73
         66cNB43Ksv9LaphCsNUHG1+9Gl97TsSvDEl3LdUThCrcq2m5FCDxIPAFJDqxzzh5OUeb
         8AokcM6uty87Es13z+Y05Wju9ri1Yg9xgyOASDCTr1OkOutWJ2vK5Btja1BXGHXZpJ3q
         CJDw==
X-Forwarded-Encrypted: i=1; AFNElJ/DLX6KAgxVMYVuwGSMb28vEGylAZU9oO+IlWSLhdCr+uo4CeoyCS0bWrA6Uej/5/ZTHo5zCgqmcZP7rKZ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcJ4d8QTK7U/3S1SzYGZr8JXK0BIhu4xthQilG2yiOPFZt6QB
	2r805OfbWMpN0fa0enWy8DFspNLA+QoWW11fMXBT+4kapa7URbnK8avDp1FWCc1LdTwoVTK1jf/
	4uGD4TY1YPns8v0JW1D9nAwCWf6zPA6YvF4ZhaBZy
X-Gm-Gg: Acq92OFPL5W2zh9go9M9oto1/6zz95QygfLZw3rDeDnQ0SLLTHeR4VIHkMiERGFCXbH
	9+dBZBTf+lFSplOjAwMOL3vFr2CtbSZ8QhLKpczLLCMxpBDr9ShwLAgQsewQzlWZqC2ItZgBrzw
	XsEVEyofseQRfpDGijMsYgKmHahegcN5QY8N3L6FfxiDFeCmkXE02j4eQWfJy6fdMk+G4vuk5WU
	w1ePdpG/lNkOmdpABn35xH1+cQDbtGsjWhBzh3uj9pnTf1U0jX6rQQrMGkXhLeRdwjvD9WjdVml
	gWR9VOmkIGvvOVeDWaZaJNizNulaRDoDUA/8jzwBqb/ytvvhPaqu
X-Received: by 2002:a05:7022:518:b0:12c:6da8:860a with SMTP id
 a92af1059eb24-13401ba55a2mr137632c88.4.1778629375192; Tue, 12 May 2026
 16:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508181237.670645-1-fmayle@google.com> <20260508165345.b40a73da1dbb45a95c55c0c1@linux-foundation.org>
In-Reply-To: <20260508165345.b40a73da1dbb45a95c55c0c1@linux-foundation.org>
From: Frederick Mayle <fmayle@google.com>
Date: Tue, 12 May 2026 16:42:43 -0700
X-Gm-Features: AVHnY4LWamnVNGFRDJjhOv7_S40CzCBIVjve0YhhnkS5TzJunUzhut_qzqGWO8I
Message-ID: <CAHCxdc60iR5-vDwOp+1FfYsXPX-BbiZxEkwu+QoV0tcAHXWG=w@mail.gmail.com>
Subject: Re: [PATCH] mm/readahead: no PG_readahead on EOF
To: Andrew Morton <akpm@linux-foundation.org>
Cc: android-mm@google.com, kernel-team@android.com, 
	Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:53=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri,  8 May 2026 11:12:31 -0700 Frederick Mayle <fmayle@google.com> wr=
ote:
>
> > When readahead pulls in all the remaining pages for a file, setting the
> > readahead bit is counter productive. The async readahead it would
> > trigger would almost certainly be a no-op. Additionally, for mmap'd fil=
e
> > IO, the readahead bit limits the fault around [0],
>
> There is no "[0]".

Sorry, that should be "[1]".

>
> > causing an extra
> > minor fault when the page is accessed.
> >
> > This was discovered when looking at /sys/kernel/tracing/events/readahea=
d
> > traces for a simple program. With the patch applied, fewer
> > page_cache_ra_unbounded calls are observed.
> >
> > [1] do_fault_around calls filemap_map_pages, which finds eligible pages
> >     by calling next_uptodate_folio [2]. next_uptodate_folio skips pages
> >     with PG_readahead set [3].
> >
> > Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3921-L3=
939 [2]
> > Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3721-L3=
722 [3]
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Frederick Mayle <fmayle@google.com>
>
> AI review found a little race:
>         https://sashiko.dev/#/patchset/20260508181237.670645-1-fmayle@goo=
gle.com

Tricky. My understanding is that previous code technically has the same iss=
ue
sashiko is pointing out. An expression like `min(limit, index + ra->size - =
1)`
only mentions the field once but the compiler or hardware can still decide =
to
perform multiple loads from the field's address, resulting in incoherent
results.

I see from past discussions that the lack of locking is intentional for
file_ra_state fields and also there has been pushback against requiring
READ_ONCE and WRITE_ONCE for accesses, for example in the following recent
thread:

    https://lore.kernel.org/r/2xzc3lp6ehtjwbzip4i5muh4g6oep4l72zh3j6sablfgh=
bvbau@kh7famgorzrh/

There is another one of these just below (copied here) that can result in a=
n
underflow if ra->size gets smaller after the condition is checked. Looks to=
 be
benign right now because do_page_cache_ra puts a limit on the param.

        if (ra->size > index - start)
                do_page_cache_ra(ractl, ra->size - (index - start),
                                 ra->async_size);

I think a fully correct solution requires READ_ONCE, but, in the meantime, =
I
can make it less wrong by reading ra->size into a variable and reusing that
variable through the function (+ re-reading before the fallback branch).

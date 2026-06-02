Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22E437F739
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437987; cv=none; b=tfhidEg60p4dg4dABFuSatX3CWmaYOIQWkyfzsnQs2EL0L1yaMqGCrTlpzt9V+UJlx9LLmuAwt+pDn8xOxTY5ggIAyo+2673urJ/ZlbSP4czWig87fQZO220XpudG9+MHATTOlUXf4XbYDg5846/Lwk8RXpPqzl6Q28KB+6Vars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437987; c=relaxed/simple;
	bh=ggdn1Kxplzazv5OLdinIKnlry9LYLtLaNuo30kwvE0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsiPFDnLGkVrDmDuN5kiuaXkH/xQaoX5HKrzv8kWOUPOb4qZy/28u/Nvw6D2TMqsYli7egdTdgaEY9x0IP6jfziZyfqQDxEoKvU+r33aL0a3BY4MrvPSC+nXs1Jey23w56k74QgNqmhJ2/9VxlFjvu5beuB88EKA82uJ6tibcq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=exkedOBm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="exkedOBm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec405a6ea5so484582866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 15:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780437984; x=1781042784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw8RVcymrwPdvtyZ+lyACgxH7IqaYDBeV32TfvS6Ats=;
        b=exkedOBm76b/sdANVWwoAG9tPTr0l00oLfLFW+8VZ3TsZcQSjy0wfBwoJEU9CeW+vi
         D7oCoIAqxDRpLp0svvCsbuJWcwGrFTCsnP2g2tbVhsdzB1Yfw2rOPH712UScAJxI1pYK
         p0OJV5iUx9/nEKWWtNM0aw/4YmRq4c6zoI3rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437984; x=1781042784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw8RVcymrwPdvtyZ+lyACgxH7IqaYDBeV32TfvS6Ats=;
        b=DnAOlPPciCGAodTY83z28/D3Z/qfwJHdQeS2zihyA1bPSoBHVeN8AzS1abp1eDotb5
         FAS1iXv/L9N0LRUjhXkBHk2z1fdp3feoUcfrLvvtY+vHRa4EPJDMhO6DmyLnqe+tovuz
         Yc/8HrzT31XRKDIFWLX1AXh7U7iXOUhc5lAbdnUZkMJEffbtwuUsS592xlbnla6V/ZES
         t/nqKO+Awieh68iesJ37HkF/S+scsQMMtIXlc0EAKox40yh6+XYTcOVKY+rle2uK04h9
         0sy83JMbHcxyZW4j835GTO/QozvbmBvqO9v0eXxkzJlrj1MEtDvahraJpi8MxMlWSJ97
         CaLg==
X-Forwarded-Encrypted: i=1; AFNElJ8c97HH3ddwzozduzYGjvTS38FlPVX4p3F4UGJ/YdqWSs0eetFUeMgcR7CnxzrWtmdRhW5XhV8ZNCIn7XDd@vger.kernel.org
X-Gm-Message-State: AOJu0YySAmT8I+NA8djquPc0PBGiU1UOx3xkPsokKFTV5LZcgiHPUZiz
	e3VMpHjWcmGtzD7/KPJHIsxAM0H6qYOtj7uH2PGLwHHeafXNV0hMJUrn5Ag1Jr3xEiXPih4N7qm
	P6M8kubU=
X-Gm-Gg: Acq92OHvJn6SpIS56jbukWKPCOF01oVuGcFvxGuullTVpjis1tTRQlDM5y4QTmYPYDb
	MovNdbhXdOpaEBdeScflI9bMWHLWZcnGhR6LssnClvoXcavAnemmFkC8pERL4/FKG20HXug7/29
	AjC1A6yIihw9mdArGhlgAzTZnCbxskgD6O8PEIjnJQhlq3gnoHdxPDI8OFQcJi9CbYtFXlbzYeQ
	9WIfkDCOaAB2VbI5T4Uh88rgvFAlBy6MiwMIP/rBQXyFsKq+9NuAy91nELStMJ3kL/xPIk9MEYl
	p76dk3yZAYyCAEeyff9TmkOpOtuUl7Bkt93s2iO+e8IIh8+8Fmsq7YDPY0kyc2Ybmfs3ACHyUFE
	W7ZZvqDyEU6/PZvG47RGCgdyZTL+WKKoOjQkZhRBHvyCU/bHLLCHDkCP4rpS3vzbcbQfIBEsXOV
	J4N3GagSHDExQUk9lS1BVZZgsaljc2rbzRdRnbXeGXVaA96jS/fZjo/9JQ+Bho5Nz5f+QbJBOzz
	sOIs8OGPM0=
X-Received: by 2002:a17:907:d8b:b0:bf0:550:d9f with SMTP id a640c23a62f3a-bf0ae9f9d78mr14861566b.31.1780437983940;
        Tue, 02 Jun 2026 15:06:23 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0558f3885sm41165266b.54.2026.06.02.15.06.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 15:06:23 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bed2195323cso420460366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 15:06:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9L3eqiF8h/RiQLQMy5CxBmTnI88SsuW/mLla3W3cXyJ9Bt/GbVaHSKV9e3S5O7YuP6F1iPyRTud99aAMqV@vger.kernel.org
X-Received: by 2002:a17:907:3f19:b0:bed:62c1:f7 with SMTP id
 a640c23a62f3a-bf0ad9ebf64mr15174966b.20.1780437983314; Tue, 02 Jun 2026
 15:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahv16ogY8Zx3Rtox@pedro-suse.lan> <20260602211242.13870-1-safinaskar@gmail.com>
 <ah9LaPQayJ6tBE53@pedro-suse.lan>
In-Reply-To: <ah9LaPQayJ6tBE53@pedro-suse.lan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jun 2026 15:06:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
X-Gm-Features: AVHnY4La_ZzADdnhLw7VXJvUOP1cc6TzuLIwNWiX_o8vXHDUu8ML9nZoEC5oxec
Message-ID: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Pedro Falcato <pfalcato@suse.de>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 14:37, Pedro Falcato <pfalcato@suse.de> wrote:
>
> Well, that's most definitely part of my patch. Also, you cannot outright
> remove splice() functionality

That isn't what Askar's patch ever did.

You apparently didn't even read it.

Honestly, I think you are the one out of line here.

Askar did something I suggested years ago, and didn't remove any functionality.

It just changes vmsplice to be a copying model (one of the directions
already was). It doesn't change regular splice at all.

And yes, it has the potential to be a visible behavior difference - if
some insane user uses vmsplice and then modifies the buffer
*afterwards*, then that would be semantically different between a
zero-copy and a normal copy.

But that would be insane behavior, and was never really reliable
anyway even with zero-copy (ie subsequent writes to user space buffers
would potentially do COW breaking based purely on timing and memory
pressure etc, so anybody who relied on it being visible wasn't goign
to get it realiably anyway)

Perhaps more importantly, it has the potential to change performance -
zero-copy *can* be a performance win, although typically it really
doesn't tend to be (looking up the page mapping is often slower than
copying).

I would expect it to be very clear in trivial benchmarks that aren't
actually real loads. And probably not visible anywhere else.

But your responses have been making it clear that you didn't seem to
actually look at the patch or the history of it.

Trying to make it look like Askar is the problem is only making you look worse.

Anyway, the vmsplice() thing is queued up in Christian's tree, and I
guess we'll see if anybody even notices anything.

              Linus

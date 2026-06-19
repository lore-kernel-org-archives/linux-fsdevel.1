Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204642D9ECB
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897637; cv=pass; b=p3xkNn32XwUwqXqoUIFDNbY8UnAMKO3VBKLGFev+xNrc9J2WPVgq40Ukx19XIyOkE/Vd2Z2xK0sggykrdB+KFfthm46srZyzD95C3y6AhV5DKDUHhhCmPTBqYZhCbxK0NIAUglKc/cdxUQ/ysiGMS0F0LZhR716BoPa67xPPnJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897637; c=relaxed/simple;
	bh=+f8NJEu4qsRplBiOZq4PNX+X13+IyWrjmLblIVa6icc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0K0tkYYsYBqIRFKj0Lgn69bNMo9y6z7PHITpPIHMXW/lmlAS+FLeIJRT11PrSQiymNuTjght3OxaFxXHaonc9yARE39kR1wKYbL9iQ7Jo/iw4TyMYxkpSO9H98P7HZkbRyqARrCyo5zaZx9qLzoLwLEJ0q36MxILfczvzgvlpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pEgQNTcG; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pEgQNTcG"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51765531803so372221cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 12:33:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781897635; cv=none;
        d=google.com; s=arc-20260327;
        b=ld7aK6aU5IcRC0rtYS9AaVKQisTCuxqzVSPnfVWzgZRKeAuCEHg0e/Ha12Waqn6n5p
         kmRonHTwEbaa/BCm4vPVBOiGb7717I3bOz3c5IWgw+5C7YcD7hecd3oYy7cfp+mn6Nvj
         hTUS4luMNHqsOjXmLwPY6kx2fsy1kldgTBC766Ui3JsOyC7vEvrelKdC/2EfwlypcX2s
         G2GhSM+99bEGnTeboAh6xU+BqNyLhelE/Y0LzHxRRKe01SVNaq9rIuIhgqt+RfOcZ5rX
         vsu2eo3yxNx6Fl1OY4Nk3JMQGXq6vGXB4oqHR3YZc6G5Kl0LkNnMXXf5GOlp+Yl3FmmG
         nylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UixWekKQ1E/9s6EcbfIpsM1Q9ZWGO+u8pFvuLswEpPA=;
        fh=UiR90QxgA4CMy3wifKqnAtmqMtFsjFNBHS4EdxfMLPo=;
        b=HPFrwF3XkMM1OhTz5OZXE5M7hM86IXeMx+FJ9h2omKkLK9uDpLwVmnQHQXVHZOd1Q+
         bdQ6GU582B6pYakTAT6L5AqFOF7SEVvk3GrGb/h2Ct6+Y3S63TZ0cMYjhI0wdu11bW7r
         7k32eA2TEcPJVenUkxKh3CN2+v+Kx6U1tscVV873wydoCL96CNzmZZn1eTy7/geewBAp
         VlgbjsiMlm2A2mgdYnh5mGBejQuy1/+HhjbXCWmT6CTn/NQir+eQqIDWJ1x5thk0fQx7
         xtm0vYGDlobdAdShR1BYl0YKTWU/x7iffkkZ0e1M7rXES6oqaNTcC2dubz/q9BOOlPrL
         ln5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781897635; x=1782502435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UixWekKQ1E/9s6EcbfIpsM1Q9ZWGO+u8pFvuLswEpPA=;
        b=pEgQNTcGtNelMos4zMWsN4wjhoHHXQam4z5ESN7icVVkUFhO8nlanI5wBnfp4x55SC
         V8rLbHf5WqInmv2DZDK1IVUPOWQQg3PXQnSEutlqBfDnwSN70hpTBW2sAvYTdwpfwsD8
         NzLylmKrD8MwCOR4CpjDrriX+0q/wt0s6clEJ7VKDv7rMOpwUNpb5zopB5ZA7JZI5TR/
         qwhOU/9g+L94wMw/kQJ5aD3WvN88NCuepID5mHRLRzrEh2iJ4Pm4KM/JUxZRRj3lGL9D
         nmmpMJJ/AkwgVkjaa126FzuZH9DyzUyUKHYvWfsrT11KpGuiGzN1YkOFm8dpoYBgzxh0
         qlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781897635; x=1782502435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UixWekKQ1E/9s6EcbfIpsM1Q9ZWGO+u8pFvuLswEpPA=;
        b=aD6liSRiY99XeXLlSKPIncl/nFCrE4DCvEdHoeCV8kQjeIQ7Cc8h0KD08/bGLAmjbD
         4PbFGQnNF1v1aJQg3O4EJR5tTGl5y3GO08YExyLuYT1DVqHLZfNJKK7mes+M7sM1NBFR
         f6U1GxVOUAh1IfkIY3tiybjcdIARdQGs9id/LO3PvxpyzD3hcUmOzOpDKHvgGHvspyeY
         BWB3kemNu6Efob6yOC3scE3FCeVoYTN8qsWZdoSNhfXAweNhLPjQz4Fq4SqLgguuon8Y
         Lu5heZPF5Enexa6ql8HN9g67j82LalCHdhMDfcAbp+Sl1E2T4PV5U4cfKZTGCDw+4/Hi
         EwSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+aezedaKqmKBsOLvjLM0nzIhr61G9K+/hHRK6DiBfHMVT6TUj7okdsiqMiKaq576TPULeWnpTb3fBaMVb@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXuzb4ply8bOQQkorHWApkvukB2RE0SOfuqAX18qZ1hYWJM+t
	n/EmsyrIuWgXxNcSYEzIhtCfwEhcuKeZl1F1WuZUW3rJvqm5sT8qzY80ubtVZTkNu9QCSffu38f
	6+FPjmTt2i9dS5Xe5vL91jSLDNbUwC839S3Fzuu8j
X-Gm-Gg: AfdE7cnn1MyZGcvqFKilOD5x8Sea7ed+mGqX2jv/mxhWznzcwFU4i1fm0VJWZsXXF+O
	9aI82PRKsE/UU+pVpBxWF6cXbgIGv0eBnPLpg+1vBc+Ocq9aM6WGXj0sosVd9LXM6yL+g5+8hRa
	/tmsjf1VcsnRUhbTI6rc50E0WOvR50UzkVsoryJPuWCI7WiKE8Dnu+mlgRacSfME1MbcJpAhfob
	z9MzTq4KVIe2sTzYM7POJECV8GhFtLpz3L+4DMsbjiFsdXix7kCZ+xKx6aTWyDu20Io81o=
X-Received: by 2002:a05:622a:4183:b0:517:5ec3:b59c with SMTP id
 d75a77b69052e-519e489116cmr11379961cf.2.1781897634481; Fri, 19 Jun 2026
 12:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619112852.104213-1-ljs@kernel.org> <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org> <ajV0TbwEyaKMzoa6@lucifer>
 <ajV49Fyogfa6aIjy@pedro-suse> <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org> <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
 <ajWXEn7gECvgG7F5@pedro-suse.lan>
In-Reply-To: <ajWXEn7gECvgG7F5@pedro-suse.lan>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 19 Jun 2026 12:33:43 -0700
X-Gm-Features: AVVi8CcQdg_GeSS44UmY6f04HdsYstBTwAOA63kTc6IMW2JgtuBGnEWqPtwabq0
Message-ID: <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead to
 VMA boundaries"
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Frederick Mayle <fmayle@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:26=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> w=
rote:
>
> On Fri, Jun 19, 2026 at 10:52:07AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Jun 19, 2026 at 10:46=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Fri, Jun 19, 2026 at 10:43:06AM -0700, Suren Baghdasaryan wrote:
> > > > > Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I gue=
ss the
> > > > > pattern may come up time and time again for people doing chunked =
mmap
> > > > > reads. I think we need to take a closer look at this change.
> > > >
> > > > Frame-by-frame mmapping for a streaming workoad is quite questionab=
le
> > > > IMHO and I don't think we should be optimizing or encouraging such
> > > > usage, but I understand the reasoning for the revert.
> > >
> > > If userspace is properly tuned, it doesn't need automatic readahead
> > > at all; it can disable it and issue manual readaheads.  The point of
> > > automatic readahead is to cope with userspace which is doing stupid
> > > things like calling read() for a single byte at a time.
> > >
> > > Could it have better defaults?  Maybe!  It's worth a try.  But those
> > > attempts need to have a very low bar for reversion when it turns out
> > > they affect other workloads.
> >
> > That what I meant in the last part of my reply :)
> >
> > But in general, I think that benchmark measuring "how many frames per
> > second a CPU can encode" should be revised so it doesn't depend on
> > file prefetching mechanisms. Otherwise it's measuring something else.
>
> To be clear, that's not (necessarily) a benchmark, the code we were
> looking at is their encoder app.

Ack.

>
> (it's also generally not possible to prefetch the whole thing into RAM
> because, well, raw video files are quite large)

For such streaminig workload I think read() would be more appropriate,
and the change limiting read-ahead by VMA size would not affect it.

>
> --
> Pedro

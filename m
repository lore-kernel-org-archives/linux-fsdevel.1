Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE233F597
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781891542; cv=pass; b=i+7Yw+ICaFCRzDkZC0iKtsBomamwCEuxl06g3jn+tOBH6pIyuSfWxLyqNLThfKG6Lfd2U8zQp6D1LNEI1oMQXWep9vidn52ASrDLKPPkyNmYTHdclLkZbwzeXk89FA/mQPtrI+ggI2VLiG3ELmkKj8s8ay0e8SYImX7iPxCxBYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781891542; c=relaxed/simple;
	bh=Iy0wFRj7GENslhuf/wLo5cwoBNPo/I6qfhDrCHBETe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSkUKGAhw6oEbGudDqRfe/lo7Fet+FsnFY9SjCF5tOPtLb/+YvfGfi0EJ3/bP3ILANwNJYLobROZ0Y/sOWNlpGtqmeyfk9H+1luUMNa1ffM6hIhEhRf+DOykvqilCdBu2qnXecvzIhMExQj5/PKirjwmzFVi5xO3VvDQPpKwkPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usx5pF3O; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usx5pF3O"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-519ed52bcc6so239031cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 10:52:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781891540; cv=none;
        d=google.com; s=arc-20260327;
        b=iR35/TVdqiOjjgRx1yef/ePC5yrcNH+DZrT/YzJhGtvW1q9jXEobbjzKs88qdHxp86
         admYApBkHo+uv6DjsqGTiPWQjyEfxL699N1P4CfdEYImjoBQ3x2/2xaNXAclbjWPZmnr
         h8VpqExQ4NoshMxE7fcKO3h3hNXTga2YOJh/S1nyRInC0/NQfYhsPIwToLAQySIkk8LA
         gRlrCbBFIPZ4uwOlYVQBd3P2rkVmXEvDs/d35oLoVdvhAfzuJSAlQUMRDNjdXF1y2Lqh
         xSnUSPiO6IuyR/5E/7rNLmMNLs/y2N3ZdQUd8xPEnU6tH3I065ISh20QD2fDl2YkPT2B
         0kMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FBweOLOoLT8l8WaW95dDGRcZkdKMtkyDzvzVE/JdPhA=;
        fh=tXGHgxNPzFcZPIhtVS6KAe+uA2bnw7TLc+NgHRv2BLw=;
        b=A6TeoY51aGl47WGEPd27OSc1BilTaBcnblDikpaUCgn/9bh87nkEWx027UJ8xv4ALA
         Fy/NJhuftI6N7huzM4NkL10zV379xYz4WvUFtsxkaaRCmKd/QVmfaEpxS6/PTSCy8JrN
         oyqJl+6UnnVgiVWyv//c3Nh23kgDe1U6uJHc4YKDwhzmeniIMejud5iRO0WqIXd7f2To
         IFdfQjUq4EHwmsrlEkGR2cZRplMcSZ8iNbwJQrYzfeGs/lwG5wCeusj5aaWqxV+irJm3
         iPFilE5Cg1MwEEuOCsUOhd822t7t3GLCjRm4CyFZSa7Wt7pMzATGLF+c13+KgdF2lqSY
         nAKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781891540; x=1782496340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FBweOLOoLT8l8WaW95dDGRcZkdKMtkyDzvzVE/JdPhA=;
        b=usx5pF3O6RgDB8vfcQOb3BSpExQee3rq2CTfpVtXlIyqNESRlEByugRHdxW7azoIKb
         2135Z5iXThv6ZC7cVbIbtggMX/lN5Vijtu/2VKtsiU9301+x9eEqfZlWl/fJlXcuf+rI
         khsx3ezLXNmn9XTCi2BLOYRg+hsbNp9bY6V0MvVSnM2wzjI0wE+5w//TTqPq1XHZV23S
         1gH6CBMIzB4+GcsyKPeS8frVdANDCtx6iMBIwUx7FkCwa8oxcluFyLxH9mrYakWsR0tm
         UFtnY81LJncygkr0DUa64DOX+DvuPhxBW1lYb7s225/p1elFSf4SyrHbtYyYb6v31vCw
         U9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781891540; x=1782496340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FBweOLOoLT8l8WaW95dDGRcZkdKMtkyDzvzVE/JdPhA=;
        b=Iqi8vpO0kFT+ju83yHzAyvZ9CYGekttr6SCkFIyTuKUirGw8nrwgYmA2adgBh90tYl
         B3JPHSTbSKqOQM9NFmyN+bl2ZH5maaipTShkkNIPQrpEqxSW2Y3ihaZMp6OBd01m5p0E
         +gWQxop0uR/mJKuzVKdSozh/vXQ5o7KOxGnlJnIvS8FTe6bluuQyRQI2zujBx/lXxxVj
         RlyjhXLnT4HtcMge16Y3Sw7Shstmjz9KXpr9Hda6WJU8bw9c0Ci4EBUFcF5ipRkRpDeO
         2t2q88zQ5xc/2w7iiJIGH3fb2e4xq+V46suIdzlasoX2XIAgGUTvguwoTZ2OWOdCE7vF
         dr7w==
X-Forwarded-Encrypted: i=1; AFNElJ8UXZWyJSjlgFeC5OgpuTd2SfHno8S8Hq5H7pSJ3g6InjS1P/TiH3T7XGIY0liXkULFa+mo1vKlABGGTve3@vger.kernel.org
X-Gm-Message-State: AOJu0YxS0CfQc126nPKeuAxBZkeswy6N8P8bKH2LE51Q7uljT/Cfmxel
	KtWfDwJ3IHA4NMeHE7jF8ppRukHJTuEhjCUNXJaT5gfIx0pAgB/N09UDbS4Nzn8paf3LIzZWdGV
	g7K/FDSASWBXBYsfdLpFtskxqEGRVS1QSSSx0valr
X-Gm-Gg: AfdE7ck84Zc1+gNxGeF4Zf/h+LwQMqCbj+wXfm06dqMR0RuvKM4NvPOehdrDAgz8H3N
	blaVJ+gz5BmFIlXiaV95fJbEj6F4ETmLBgaACeSxPyXD2Tz/+EbeDGgejIw3/hOI0EeJnSJ17PK
	W84C8QAru7kFc/ELKpI0D3NPEabJhc+jXc57f7XbtLAAShB4vhmVGqC5JrlQZcth92grWlEkKwt
	YvGPOyTgMmbl7kio2NGlmZz2S9L1lXlAor1qXt4fu1inU2c9kUk8t/DfJbqPe2mD+K3+f4=
X-Received: by 2002:a05:622a:146:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-519e892438fmr8708101cf.5.1781891539149; Fri, 19 Jun 2026
 10:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619112852.104213-1-ljs@kernel.org> <20260619093711.d0d37c9920b3a16394c356a6@linux-foundation.org>
 <ajVz1nhMn2JwucMY@casper.infradead.org> <ajV0TbwEyaKMzoa6@lucifer>
 <ajV49Fyogfa6aIjy@pedro-suse> <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org>
In-Reply-To: <ajWAYBXHJniJAO4u@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 19 Jun 2026 10:52:07 -0700
X-Gm-Features: AVVi8CfZj4z6nJKviyUfEHJ8xHkdW818jy0j9_ZxSUxk4x_AfiipzYtYvyZt1sA
Message-ID: <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead to
 VMA boundaries"
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Frederick Mayle <fmayle@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 10:46=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Fri, Jun 19, 2026 at 10:43:06AM -0700, Suren Baghdasaryan wrote:
> > > Yeah, the mmap usage on SVT-AV1 is a little suspicious, but I guess t=
he
> > > pattern may come up time and time again for people doing chunked mmap
> > > reads. I think we need to take a closer look at this change.
> >
> > Frame-by-frame mmapping for a streaming workoad is quite questionable
> > IMHO and I don't think we should be optimizing or encouraging such
> > usage, but I understand the reasoning for the revert.
>
> If userspace is properly tuned, it doesn't need automatic readahead
> at all; it can disable it and issue manual readaheads.  The point of
> automatic readahead is to cope with userspace which is doing stupid
> things like calling read() for a single byte at a time.
>
> Could it have better defaults?  Maybe!  It's worth a try.  But those
> attempts need to have a very low bar for reversion when it turns out
> they affect other workloads.

That what I meant in the last part of my reply :)

But in general, I think that benchmark measuring "how many frames per
second a CPU can encode" should be revised so it doesn't depend on
file prefetching mechanisms. Otherwise it's measuring something else.

Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48529827E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454528; cv=pass; b=AdM1c2RwKJ+71+b+OYnUBrmmicKGFEwpitGwmnhYWkrq03q89q57zRahjUn8d7qY7LLb6ENtWSXocPlC6LsR3ukopgDX3QUvrGkxBrvhz2L+D3/JudHEGETm8eSeEKtuGZiBFK+VwfqJOSUeZpk4Gc0DllZB8BJgA4Vssp3ODks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454528; c=relaxed/simple;
	bh=EPXnTicHxjO3r0CVVtRWh3D1dZqlAPTDXfoysvtgqqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADeBKMSKQhSr5tKQnGON2/wopi0C1Z58NwSdcB8leckY1IYke5RUpJ0Qur2xBDUiuIgfVNLq2gxRzhdKB2spaddxcxmYG5+rfK9U4+EtqIJYcmm79SgAm+cwa01FouQrWAWqU5QF3afEBcsZ4gDgwvzvJ6+9u/oquvVvZCQOzDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpHnN9kU; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpHnN9kU"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43eada6d900so964424f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 12:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776454526; cv=none;
        d=google.com; s=arc-20240605;
        b=UZyaGtMcOUtXyvSWMaz9q+o7LsUsxEU5+T7nRz8CCEG36mpxQ1GC6UIwZgf4/x/Uxi
         m4fl8y0UCrchDyMlIBRhDLFuIlg0lDokD8Gna1fRCjlR22KrAqPKA3YzWhUJXy+hFnWp
         YHX1ivFEX8Z6ZnmvlCda//BrqokARBMV4V6UYGLUJy0iyA37x1kjnZBWsUffjk+VTypG
         pUMhlVKr4ierDcSI1d9LTyqCndcZImYU4JFWq10NTXIjkbAJeLXAuISbRxUrNUtpQkby
         AAPgC/SFxzH353l35/ttdV6MGE+iuliISYiGqpIdxuPR1VMlwANIoU/DaNM8kr8ttzRw
         uPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKQtLrK767PS4V8iaYQzHGGgM/KC0ExoAgrnjJyr8Lk=;
        fh=ruJY2My2e0aFJXr0tc9o0nwFQuSCLc0o7bnV0qewwTs=;
        b=Xk3yTSwfkgx6rV2Migs4EcXOWJmy4lRbfHzc+5xODLdnpxgZcL/UWB6VXfE9CfvLJs
         FU5p2VmVWhciAhwOGB1c3WehZ3w+cXh23Ehgut/1T8Ve5BkZdr0qZ0Fs3WJT5sdqr6pX
         PwLKPa7OmKknMH7G51X13lqKAisuKVjEl2stGYcNJJudbgJkHbRbzS+Y+s1dCno2z1HA
         vN/GzyZWKTCGemohRSnjwzAdalDgrz8ScNsYBpDA8pAvEagyjw7VrkVIE+joHLKgxE4n
         81gH9o5YCZ53qSssHHJ+cDTBd+v4ljSb9tLbe6hTygfDbB0CXtHEFJR/rSCnzBtIngw6
         56EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776454526; x=1777059326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKQtLrK767PS4V8iaYQzHGGgM/KC0ExoAgrnjJyr8Lk=;
        b=XpHnN9kURoEwAEunp9ZErv1Z+SK0yb9+22cR/DvdaesZ4JDCety6WKRZ0pQf3dWuyv
         iZMclneWAHY7r3mWc9UIYNooN741K/90eBvoFutga5DzKYg/sNkXvBAOIExJa4vfzYJT
         reA2inwr4DTtjPvM3gaIYFzSG/6S7hyZ2Dga/KBny3CfCghsPoJAgtPHmZzUTkLuOrI0
         rxzMBoWVCER20lkM6dUCRg3FtaRFR71cjDmYUo57Z14BPyEYNrLTZhlTe63OV8n74eao
         nTWwGni+mBhxFhkdkfea8sDR4NwOfZUjAGA+9bW3Sw5QHp9KQBr2An9EpKUNAscIBQdk
         +dXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776454526; x=1777059326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKQtLrK767PS4V8iaYQzHGGgM/KC0ExoAgrnjJyr8Lk=;
        b=pHPljFrcS9aC/ayPW/cxZXi7e5mTTGEGGOfOCu6jNxX//w9uju7dWQP9t2dksFpnZq
         78JWmBZZ5u1NXrwczOOHZ4e6qMFw3W4pK08LMRezCjKLzcT+b+xJD/TOrMzVoRVzsOlJ
         sY2OBgeYDFu3nPmrcIw33beXv9Gti4jizH49+A0by6X4bfuMcEZLixJwwBSGT7L9gIHY
         3IfMWwNKXyyNPmaE2EVe00sUX1F9I1UVVukEMIM0XRtHikh+FUpfsKygKMHEjPigHdB9
         +s0rkMRtXMddktea45pHKU4v1m7WxIwLMM5LP/WTWjekVUDkI/jpJYyqtqXqD5vzx0MY
         QrXw==
X-Forwarded-Encrypted: i=1; AFNElJ+Yq+9xGl7dI+lt3J2gQT1VZfjS0Sm5VYscvR+hexsk2ilCjlX1JNC18PGNX73C4K+xkYSKkDwgO9gIu9p3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1FJBfkK91gYOIZ5FyG/3YWkElvDim8g/m0YkcvgoCAyblFU5
	QAyc68vHvaYRgzKXJMsAMCwC58phurQ0dBA5bu3qK0ak3O72KwTqAMsZOHBf60OxuQzIPn2P0tW
	IYvQOIiMqaqKtYG3zDQ1Ut12AzHZxMxw=
X-Gm-Gg: AeBDievVDFdNCQPrVpEqSjMbD4ZfpxR8H0HgCgIluvp0bwUfIAFYBNaVDZ9vJdKYZiD
	M86MqJl9y+uqBXUn02/ucTiYD5SmB5XxEKl4yJ3zyr4/kOEgDPAmpFs5QId5K2zrGn9I5+jOTLn
	eOrKhLfqD5o/gLR+gnS3KVJ1Wrl1/qqO863mb8kWH7+iaQj9eWP8t28+x7EL+IO4lhEjGavjB2S
	L1bHqZBd5LODx/s39pC50hnPKizgVGr0FSGZ/RuY0ypxlEllAw0yerMPQgM7uDiSidumhQMNaYE
	KN1myQH+VqAOOdJM
X-Received: by 2002:a05:6000:4283:b0:43d:73ff:fd59 with SMTP id
 ffacd0b85a97d-43fe3db9bc9mr6846919f8f.10.1776454525489; Fri, 17 Apr 2026
 12:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331123702.35052-1-john@jagalactic.com> <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
 <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
 <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com> <aeHpjpNN4TliZOyp@infradead.org>
In-Reply-To: <aeHpjpNN4TliZOyp@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Apr 2026 12:35:13 -0700
X-Gm-Features: AQROBzCmeJrVtq6kS88NntBxYwuWq2p8m5V_NUCivAWMbSPdKuP6DBJLkBWNmVk
Message-ID: <CAJnrk1a7idWN4UNpW0P-X4xeBKOkhnR+Mvfo3QW38OfShiwpKw@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 1:04=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> This is the first mail without annoying and pointless full quotes,
> so chiming in here.  Sorry if I missed something important in all the
> noise.
>
> On Tue, Apr 14, 2026 at 03:19:36PM +0200, Miklos Szeredi wrote:
> > On Fri, 10 Apr 2026 at 21:44, Joanne Koong <joannelkoong@gmail.com> wro=
te:
> >
> > > Overall, my intention with bringing this up is just to make sure we'r=
e
> > > at least aware of this alternative before anything is merged and
> > > permanent. If Miklos and you think we should land this series, then
> > > I'm on board with that.
> >
> > TBH, I'd prefer not to add the famfs specific mapping interface if not
> > absolutely necessary.
>
> Yes,  fuse needing support for a specific file systems sounds like a
> design mistake.
>
> >This was the main sticking point originally,
> > but there seemed to be no better alternative.
> >
> > However with the bpf approach this would be gone, which is great.
>
> So what is this bpf magic actually trying to solve?

It is trying to avoid having famfs-specific implementation details
hardcoded permanently into fuse's uapi and kernel code. I really like
your suggestion of adding generic stride/offset multi-device support
to fs/iomap. That is a much better solution than bpf.

Thanks,
Joanne

>

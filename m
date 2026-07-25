Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B01F2E736B
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 04:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784952106; cv=pass; b=E0FSGI2UT5b8RCN4cs+JtNwUnklN1Hy+KODYor+CvD6GTBn8KrEmxWZGHo5kQ0whu83rOtEuGg4oegRTv14F9sg2EIg9ITQimK5YR0sl2vACtVKRuBztmq21rmPeahtz/6KZLl6XR4S2/1eSoJjXlUXvHvr+6vzTRkQbIu55KcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784952106; c=relaxed/simple;
	bh=fNC8wElaBgCywizq8gsw7GvnGpxJrTKPY2EQunJ50fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUqQn+/mNlh+TObpWCPAfXD4ClXFuX0Joh34HFLae7PvH6keG4kR8nD+Qsc/FS5pTmHnubqBSSJ9XdvBVS1/SDyJQAU6caaUOnI1mMJUQrSsbCZhjSXpGk0tJMwJQaRgnXEEFj01mbIjTxLCxln0kMybJSwkCpy1TdMHO/uQyY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CNAZJoN0; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CNAZJoN0"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-526f963372aso9481471cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784952103; cv=none;
        d=google.com; s=arc-20260327;
        b=E0WsEJvzFfBQHWY5Zv+B4yFqYp7sgIZLd7zA88fMwWeIp8b76x2eFHoiXOYC0/btzi
         lY4KFxl33Dl0WqkLe8pPILABcRXwtAcVX5WD4NHsK4HNVjIa5gkZ1dboMl8zhzIrgQ3A
         h0MgtJAugTHO+23QOwvoiKaSuDTS3+sYYMlENUMtGW4opaxwBRZ/VjygaiB06hr44prW
         NPDnuNwLNwm+/OKZz/JC80hB5j3NNmw8EIZHKTPVu2WsoRCsQ+IoQONvU9CVa5ca4ab8
         Uum++9ndyFmzY/A7Xq3pjem89WtgQgjkvvG/V5NcIzgw2HN8a80x8tfEA+fEUixi85la
         EgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CzPMjf6pORP572iHiiQv3possHTxsjbSzVUS0tfn1HU=;
        fh=Ol+ucJlo/e4Or9R36pSLoGm48oniQAvBiYVk8I93Usg=;
        b=OFiibXNkyI55o2tmgSKlgMUSxK3WbvRXzvFRAnNpTFUKerqYXnpJDZT6Lw81vLVMI5
         obXHWc5KEeOClZltq51TVIlCiAT52mNSx+bNFvsPtlOAKpH0Gxn61ED8tl8nlqXbYU7L
         +9x4y+RUZKYLiCZ/I6pacc5qfXgzaiK65OV35jomUdSlxHF39fzIIWR0UkGm8ZKmIiUe
         2yWbzcbcLxDeGQHjzf+3G7MVeF773IdSmK+22gM/Zue5T1eefL8J4oJcrn4e561R0CYI
         KISmqujThvE4jhIwVbkVEpbQdfkCJRAAldu18opst8Cldj59Hjz7pcLVHVvaU95G7cB1
         cQNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784952103; x=1785556903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzPMjf6pORP572iHiiQv3possHTxsjbSzVUS0tfn1HU=;
        b=CNAZJoN0GTGYkkNaC+LQwZa9ZPYftYSqqF9YnFNyEv/DFmrM+msE4JBCrJb/oKRqVL
         hih2RSoXP1ImRcm7kDGVqmiKReSP64UzzbzY7d6sGRf3Iz+pK7OkARtstKIc9iL9J3Ko
         Jfb6ddY0nBEAbcuBHouUYHej58F60A0BJgcIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784952103; x=1785556903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CzPMjf6pORP572iHiiQv3possHTxsjbSzVUS0tfn1HU=;
        b=jvfmAIxnFRGEEhDDXazsK2s7B1aITqCp9mK0coNHp0N1y7uCmYV22cUpLqqDIxKBvB
         U6zdk7G0cHzpmDrdCLd09BsyHzDuUm/Kltchp366sMGs+O3JkCSTLWeAD1IAf6/mGdZ5
         yYJ/4XV6sYk8YmIZbhrV2ARhwknBrflscRRrkAkjK1NNWpi0Frjfb3uwxtloMYekV/1Q
         U/nKS6jK03RZCcLpSnkf3y7N3Bbt8CjCP4ee8NA4I2RnX0HehZ0fsokUhZbnwZy3zWO6
         ix3tcgCQA/GsrymS5oKfwCD0gnjWCnCP+hPmozl8zz6s86X8ikqoUvLDCXvbxaNtl7RT
         PsMw==
X-Forwarded-Encrypted: i=1; AHgh+RqfRj2Es053dHyqJBEQVrVrhh8L7QxFiTjYsqPX2W+LKF3Rb4k4MIkzqmHK7XHCoJYJqDg2j3ebQnvE756h@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+1dPh9i5QG0FrjhW0NcQR5/2RMfISWwI0twTmBHuEDoT6iaU
	G1B2D/qTdGVkx/xJzTIvF8pkQvAW8Q2WPqjDkEessQShRR80V7A+mHHYrZK7qtnfKKgWJi103g0
	S1SQWjvM75M4X5e/bmqmEVIrhm41se33Qmz1NM4jMXw==
X-Gm-Gg: AR+sD12ZAl9+iyp3tHbCvtyDkNuy1aQ2wKNBIROsD3rAiuN3BMXxSyIUVUv7C1VD0AO
	mYEroW6hirD+Jcl5KMmai6ilLA975Zl63TJIDK74C026elqFRuzbgM3kBD8B86aRkwC7sP4KmTc
	sSYQ0qY04Pf2y3jHwv5mFi8iZJKFSFhq1zDynkNG1QQ/HGl90agYQEOcTCVEzZ3ghPnHgfiJeRl
	iry2Xyzpyehr/ojZRp19fnwREbRsBsf01C6hjm9f4UZGRBWPODhZUxfwpS8SSXH8Z10Ye398yNt
	ViO6TNq1o+qMNq5t
X-Received: by 2002:ac8:5c90:0:b0:51c:7b12:6001 with SMTP id
 d75a77b69052e-529a8714e88mr10045521cf.77.1784952103086; Fri, 24 Jul 2026
 21:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
 <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
 <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
 <CAJnrk1Yat+SEr=SmZXwUt9y2WcC0VEC4KUpPrkrRSjMEmx42WQ@mail.gmail.com>
 <CAJfpegtnja6tkOnNPD2WZxu14Dd+UM9AvynsVB_E268iSXLbkQ@mail.gmail.com> <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com>
In-Reply-To: <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 25 Jul 2026 06:01:30 +0200
X-Gm-Features: AUfX_mxAcvr2jX4Ns3aulDhtsSqUabRQhwz0VnV0bbRi_FBtOFn1nR0cN_FIRKA
Message-ID: <CAJfpeguEptz4sEXq=pBWPFop--1kTDu5p2yZnCyzXcrZ28Nekw@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, John Groves <john@jagalactic.com>, 
	John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

(Replying shortly as we are starting now on a two week journey.  Won't
read email during this time).

On Fri, 24 Jul 2026 at 22:23, Joanne Koong <joannelkoong@gmail.com> wrote:

> imo these changes seem doable for making the 7.3 merge window. I'm not
> sure how much bandwidth John has though. Maybe one idea that could
> work if John is completely slammed for time right now is having the
> changes requested above be a separate followup series someone else can
> do and then this current series (after the sashiko fixes) and that
> series can get landed together in the same merge window.

I'm all for it.


>
> >
> > Maybe the striping setup can also be done with a notification.  The
>
> I had interpreted the FUSE_DEV_IOC_STRIPE_OPEN patch as implying that
> the mapping gets forwarded to the kernel through the backing id in the
> open() reply, which I think is how Amir had also interpreted it. I
> didn't like that the striping mappings got sent through an ioctl while
> the simple mappings didn't, but I think maybe the patch was not trying
> to suggest that and I had interpreted it too literally. I like the
> striping setup through an ioctl - I think it makes sense given that it
> is connection-level instead of inode-level.

Yeah, the striping setup is on a different level (like we have with
regular filesystems).  So I think it's not that bad that the setup is
different.

Thanks,
Miklos

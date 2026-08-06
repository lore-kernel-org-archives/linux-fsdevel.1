Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE153F54D1
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004965; cv=none; b=k4q0PaPoFxsHtcZS/sc/jqzVTozRKLRbq8WcEKAWfuTstf/NpRNajVAipkYEsZKv1regPbleboBVIV5OLIMC+7TWqqF/XYRi9gJQW/xwRJEmdsTyzw7Hqrjsdh6AsrfKPMRoUTg3JdWZQPokA+kyuTmfMSfTJu46pLIlRP9GUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004965; c=relaxed/simple;
	bh=uPTGsqwqW72fV9uO1Q1bBszUUqt+DIw0cPITC9fmsxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5czLBASqPFcxI23MoXZHlOgMxr2r/DvXccEO38Uu8xXRdLRLrTnEgxIn/pILJquMVlCMAoHEHbL6z/se11yviW/mHdD1Up3E0LfH1LIqXMVJpqZNIn/adJZ02/vTTsuxV29T26oCaV2sRCx5WlylOQpnnxWaQdAPWL0OJ1zXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c149c5722so5788241cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 01:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004963; x=1786609763;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8L67UEittnM3U78kuIxDIhdFKAHMIN1W6YC5oHWi9ks=;
        b=OIgoIR1zZFj9Asu42hGE6SIHRR5L4r/ZRBNcp99bGiGEmeXT4RTg9Z3HIK5t7ozps+
         s8LpHmuH8hI/mvtrN++xLbdQ3oM3xynuyt1KhuNrBOueb+BIS2quhtur9eDjZc9c00gm
         tgbfqrvFcu7E0nvV2FmNRN5UMkkvsKwctFDzXcDaDL+7pT8MTCE0AXELL78oV2X/KI68
         tnESSWlLnSdaHV0vfAQw16xf1sn6T8Rfjdkm1i/UmM26fcJLJopyEBkcG5tMzkgx3McN
         mYMb2XvP22OYVYDam8qbOj3WRM4V3nNvnHyalETPjPp5arXKfa8lO/hg5vrGV62vTMHG
         qmCA==
X-Forwarded-Encrypted: i=1; AHgh+RpO40L1W+dhO1ETZOxHpQKpoVbT6XaYTzNdXExhlu7CGjs2FWXcfuYUuZz0PB4vS4R2Ldy1IJPiHGmWMtVG@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrDd6MbMgcMxFlyv80yoCL2bhEM6mS3fXsEk1BQs6IXzRDwV6
	1BiyOA86tG41Kl/Ko5+iVG2eH/uSNhEggiyT5Of/8cSI0G2n+8dGuabjM8gAgnvZ6S4QoX7B
X-Gm-Gg: AR+sD10n0x4I6eSX7M+X8PvZWi+fVuo1G94MhoYbspCbVSsBMNqbELeMRFLFaUaD3ms
	hmD6my1Tv9nMozPiCjetWtMFD8S+mIgA0uKghJz9VaciljZpndHDK+wNKNgCIeMYPy8ZEimsj8b
	Au/swqc1+hP5tPWJ2QRKvrpW8RbPXw7JCZR5mFhYj0IGq3IfkFR0P4tXA3VzsTcCYj71R+DPsn1
	hhPpMORMrMMW1qF7k8BfqQXMhL3fatjzZM8Mz2z/SORAwWyEhcsfCyW8LZ9hnq/I5H/YLE9Wl7d
	nteGkhRgcOmx4hIjjWEY8uQ8LGVHdXl7eibDejnlKdW/DowFOwKaykVzgNje06MbLeFSJiWiXbZ
	XMLvkiGHazDTOGnJU27BhaJlyk9HsyODCwnOo4DO83195i1Tr6Lhb+YM0aTfCf9MCyGrZltDI/x
	O2x7l8SkCoumCyTe2+awOIF9RVaJtZruqvQWiKMuCJvEziCXazH4BLvWf+c1of8E3NXidsTLTeB
	psIT6ma1S61oR+p4LCb
X-Received: by 2002:a05:622a:4d86:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-52cfb00255dmr55128191cf.13.1786004963159;
        Thu, 06 Aug 2026 01:29:23 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908800ae043sm47108236d6.40.2026.08.06.01.29.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 01:29:22 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51c0a81d286so4276981cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 01:29:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpt9d23CHoDggG/Zttvy/qWxNXHX2MX/gVc2srEF4YoOJNnAbKas8zUGlXH1BrM+0oWxJnriqffFscuse+G@vger.kernel.org
X-Received: by 2002:a05:622a:4d86:b0:51c:b91a:33f9 with SMTP id
 d75a77b69052e-52cfb00255dmr55127701cf.13.1786004962328; Thu, 06 Aug 2026
 01:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720201057.1862857-1-kbusch@meta.com> <20260720201057.1862857-6-kbusch@meta.com>
 <anMscoGkR5BYjSGy@shinmob> <anQ-28nxOqBmQjxu@shinmob>
In-Reply-To: <anQ-28nxOqBmQjxu@shinmob>
From: 0wnerD1ed <l7z@0b1t.tech>
Date: Thu, 6 Aug 2026 16:29:10 +0800
X-Gmail-Original-Message-ID: <CAKTh27_RnTA_Q8qAbQ60gBo9Op_OQm7J8KyamQ_tbuTRb4XF2w@mail.gmail.com>
X-Gm-Features: AUfX_mw5QWwwkKt-kO8BytpUZdN-dhibuCeCRe8GGvMpBbYSL4fmaxKXk8xK3Mc
Message-ID: <CAKTh27_RnTA_Q8qAbQ60gBo9Op_OQm7J8KyamQ_tbuTRb4XF2w@mail.gmail.com>
Subject: Re: [PATCH RESEND 5/5] block: validate user space vectors during extraction
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, dm-devel@lists.linux.dev, hch@lst.de, 
	axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org, 
	viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org, 
	Hannes Reinecke <hare@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Aug 06, 2026 / 16:04, Shin'ichiro Kawasaki wrote:
> I took a closer look. I modified the test case to respect the dma alignment [*],
> and now the test case passes. This approach looks working. Will post the change
> as a formal patch for review.

Sorry for the slow reply, I have been busy lately.

Thanks for chasing this down. The test is mine and its assumption is
wrong, not the kernel, src/bio-full-trim puts the destination at
p + page_size - 1, and null_blk advertises dma_alignment = 1 since
commit 3451cf34f51b ("null_blk: allow byte aligned memory offsets"),
so iov_iter_extract_bvecs() now rejects that odd address before
anything is extracted and bio_iov_iter_align_down() is never reached.
That restores the behaviour we had until 5ff3f74e145a ("block:
simplify direct io validity check"), so the test is what has to
respect dma_alignment. Your approach is the right one.

One problem in the trial patch, the guard has to be against the
logical block size, not the page size. What the test needs is a
fragment that bio_iov_iter_align_down() removes completely, i.e. one
smaller than the block size, and the read has to reach the PROT_NONE
page. With dma_alignment = 511 and a 512 byte block size (the block
layer default for drivers that do not set dma_alignment),
dma_aligned_offset becomes 512, which is below page_size and passes
the check, but the read then lies entirely within the first page,
succeeds, and the helper reports

      pread returned 512 (errno 0)

instead of taking the "unexpected dma_alignment" exit. block/045 only
uses null_blk so this cannot bite today, but the check does not do
what it intends. block_size comes from BLKSSZGET, so it also has to
move below that ioctl:

      if (dma_aligned_offset >= block_size)
              errx(EXIT_FAILURE,
                   "unexpected dma_alignment %u for block size %u",
                   dma_alignment, block_size);

While there, err() should be errx(), errno is not meaningful at that
point.

I am short on time at the moment, so please go ahead with the formal
posting. I will send a Tested-by once I get a chance to run it.

Regards,

0wnerD1ed
l7z@0b1t.tech

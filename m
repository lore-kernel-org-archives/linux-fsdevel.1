Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10763368A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117926; cv=none; b=lTyJYzG8pC/jsVO2INkQqSW5YBbneaFhi1vxuG5CTBzIt2nppWIwLIfuKq/A/RBU0IZ1p4TccLYv2voP3s97r2AX7rBLtf4NyqnDzpUEBAkUeOwzwiQnaqPqVmoa7+IRKBl1X5jHE2NW7yOVSwDOXSdw3o2cprtK0NCIoR12a0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117926; c=relaxed/simple;
	bh=f3DORJrJpkP6ZRkP19t1XIOYLbgIcUWXGly+WSIdbaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT127mR70ip5iHf22vA4JjDWQZ6T5M9i58Qh+eFcy46prqabgd2dkTY9hz+biug6w5uemqJak5akiLD0Wjq1p+9yuUWPwwWW5xI7ClHwDdq/Qn6i73ovXJ7q8HXjrTVybbuxBNoYGrKf9JgdvKe6oTX46fGGEpgDe+rvwK3VUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=Lb+yK4lq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="Lb+yK4lq"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53394bffe0fso7305311cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 19:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792117924; x=1792722724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=myFazyiklnuqy8xHfQCBKX5TKL0fchWKCY5jJRzEhZ4=;
        b=Lb+yK4lqkt2BfUfCOe7Bt8yvghRl9MUpErEBMAEYfXa1prT4eNcmwhHcy/WnNaPDQO
         31DJne0gjcuj66Lit4Nol8wJDO8rnFNowtS4Spgwo40BY1lZKdo1R5Ls/kDGu16/fKU2
         k24jLb6tQvVlbnbhmLrCYBWKLBcbRmFg1966I2EAhK8fKsdjGEfhQ/Qb+Juxj0wxSZB9
         kO7ipFOUMgtn9A1pw/ad9moHelbQU0e1smRYinSMp3Tvyeny3pmltDV2KB3aVdwwb4oi
         wm5zyQZ1YlX7FFT2bkQ1Gab+gFwDh3Z+lnvYS82ITjprwO+MflkNaueAtIJv1xJu7a4y
         pMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117924; x=1792722724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=myFazyiklnuqy8xHfQCBKX5TKL0fchWKCY5jJRzEhZ4=;
        b=nHrNvacReZSEH2M8OlfxqLzxlwWG3hcr6kRp7HllzH0E1Md4jEGlCvAWjwMLEOXIWB
         TipDa9EusF/woMWhhMW1937Ihfi49uyMDHApMxhbzdgHebyBpLuqL82bQpSNUGCCnH4s
         t3Y/9FdfSpMTwLYnS2E/TP8JVqVt36jvv2CTWIA6GTrpK5RpmXLVaWaRqtuDmVNWM3Q2
         wkBf5aKytGFSdEGR+UX1WZWO2jvy27JYWuJ9wCVhtuhn+xnJVcQPymZSsQIyR5EBUxUZ
         AWeHpHBEgQmAr4DPiIvoly7qtty5l0Vzns+GsIG+rbapVTzVl45wCovFOA1T2AMnPMbp
         QWqw==
X-Forwarded-Encrypted: i=1; AKwUvBxQnPdRuDJyCOXCsn0dlIHqpCP5GlGbyRArGLuqbL1UkBoON/+q/fJ5Wzmgj5NDZciHt48ASqQKop2AFboW@vger.kernel.org
X-Gm-Message-State: AFq9FYK4Se3tvLU0zWTsFpM9oDWURcEGEQygx8QdJkD96S5iRj3ccnFn
	/k3/7fCRt5KmDIf1QfmagsrYT5uwDhiihtnxEkL5dGJL10ncgH3Orp7GDgS/ShsHJw==
X-Gm-Gg: AYBFou0J9f0oATIEngQLmnKZtEArVOhPpv2cz1TSPpnGmMpM7yx8VRu21DXzcRrsIKv
	uLqZAFukhZWAEgTDzf0bdvH7Wd04sPPMO9PO8IBPggSFZA2qND37QKEe3irraEhqlkdAPJmsQ/l
	r+gbw/SLbyhCyZjAGd9DB0syhysGBQO8Qyb8ZgvmneuGDZ7+blZOmgGSBreEMhFN7ZlPngZKtCm
	tAe2tfvjyU0UJSsmjbsTrHJurmVVYdEDSPI6hQYUJQZGt2NSi8YizwCMRMtk2bX6CFqx6eTNA3R
	FYJ82YAoFmLv9IC0HwJJlWiutabuMQ2Yf0/F/DahzKVxncrOI2EG4szYKmYu4xwWv7zMHGezFKw
	2Jp7OCkP73YvUTbcIkRxwISJUousH3NjMLNMH5Rjxd3nN1VJ5dbCjh3QeT3AdgxHNugjTQ+Min1
	wEmXWPXjzE0dDJ+tmH7+XtaiyMGn00k8bR3/QzOE7wOZ36hPjKtuzm0qgxfv0CgHM0r1pYL+r33
	Fwl4LZU1RoM1/PuhtOx
X-Received: by 2002:a05:622a:1dcb:b0:535:fdd7:b490 with SMTP id d75a77b69052e-53626d2623dmr35175501cf.0.1792117923761;
        Thu, 15 Oct 2026 19:32:03 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bce8918bdsm6778646d6.48.2026.10.15.19.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:32:01 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Thu, 15 Oct 2026 22:31:25 -0400
Message-ID: <20261016023125.2271361-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <45b692cfda51e3b10caa27ae51609edc34efb0d0.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu> <45b692cfda51e3b10caa27ae51609edc34efb0d0.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Thu, Oct 15, 2026 at 12:58:14PM -0700, Viacheslav Dubeyko wrote:
> (1) The goal of hfs_correct_next_unused_CNID() was to fix the volume
> corruption issue. Have you run hfs.fsck tool to check that volume is
> valid (not corrupted) after your fix?

Thanks for pointing this out. I have now run the additional checks on
v7.3-rc6 with this patch, using fsck.hfs 540.1-Linux:

- All 14 normal-volume images from the original tests passed
  fsck.hfs -fn after unmount. This includes the reproducer, CNID holes,
  missing optional file threads, concurrent operations, and reordered
  leaf node numbers. The checker did not modify the images.

> (2) Have you run xfstests (especially, generic/736) with your fix?
> Because, the patch had goal to fix the generic/736 failure:

- On a freshly formatted 64 MiB HFS volume, I ran:

    ./check -i 10 generic/736

  All 10 iterations passed, including the filesystem checks after each
  iteration, with FSCK_OPTIONS="-fn". A separate fsck.hfs -fn after
  the run also passed. There was no "invalid MDB drNxtCNID" error.
  The unpatched v7.3-rc6 kernel also passed these 10 iterations.

- I repeated the minimal reproducer on a separate fresh volume. The
  first creation of c failed with EEXIST without the patch and succeeded
  with it. The surviving file's CNID and contents were unchanged, and
  the patched volume passed fsck.hfs -fn after unmount.

For completeness, I initially ran generic/736 on a 256 MiB HFS volume.
The test body completed, but the final fsck reported:

    Invalid map node linkage
    (4, 2048)

I reproduced the same failure on unpatched v7.3-rc6 with the same volume
size and tools. The catalog had 6129 nodes, while its header map and
single map node covered only 5984 nodes. I then used fresh 64 MiB volumes
for the runs above; their filesystem checks passed without repair.

No KASAN report or kernel BUG/WARNING was observed during these runs.

Thanks,
Hengyu

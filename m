Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670825;
	b=FF4QtAFgN/HfIekHVDCsUoIYgKMsyFS92+bhI2VJ39sUCMruiHRH0M5Crjxd5n6yE4yI
	 7s4eVYKGpdbe5qswL7fx5TsPKLr3N21XD+/kFWh2qYdRmeinPtNl4JIcW8KKHmAA+Vj5M
	 5tt8mUIX3MkMbQx2Wy4tDoW9FlcH0KBw1qsjrBLgQS/vSLpgMOxdcErtZXsNwp9bSuSFq
	 tZ84gPAZ04soY7l/wHL0Z1V1ta+XtGxsWGsTq6vxd+1kfjLyxSydmvSwB9I5/53REMvD8
	 pyCs8MVoMvq14KKDK+paDSgRpvpIfimGUZz4Nl79W4wM0NHtz3h6PjActKv7/aeDuUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670825;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f4Pj7b5+BCbfAUSTsrmqLzkuYkoyWrTz+YeW1iMb6p8=;
	b=bB+aKk5ejwQKX8Tl03kIcuVr/9TWd1Xjta3haqnHHNSCpSyUJ2+BfsBPxphLBZmlsfvV
	 QMja6kb3K8MtpA19yCbb+4HDspTiFmSLBcrkRmZFPoyHtFvvrRdIFrh6GhP6M3z05mH34
	 jBtP7lOvbFmuFl5A8HnGJrb2ieHg0ft1EDokvi1DncTcDuJ9NUqASUa4Ua/3Sq/pNvVME
	 7Cj8Id7hPrEKsXh/8tompXl36dvSt/UihcfuJ7uckLEQYLf5tjfUeYkOpLOx0MtFLXtkR
	 4NrUHVctNn3biA3nNBNAPIU60+hLguPiXfFhkVVgK4XZY32+2KLsOAbyVn+7dnLtGfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=DCho+HQ0;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14814606A319
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 12:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14814606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=DCho+HQ0
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ac8a2ac52bso8656777b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792670824; x=1793275624; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4Pj7b5+BCbfAUSTsrmqLzkuYkoyWrTz+YeW1iMb6p8=;
        b=DCho+HQ0HUQRh5vJ4m/7U8EaK1YUKYd0HqPcqV483E8mA8fjn+MUsZLKDRZAc54V2o
         dq4aMXrXJqsfG0nTL8vatAr/OVoProMCvuAiOrYBGwToottVPhQ+JkGsA+pqysFAdqVU
         WD2Tg54uWt6n1l51HQsRTxWtYDzUjdmgf1pSV6V2Eb9EHa1Wpo5jt9bSpqBEJY+DJsoR
         owpIrpLxe1pfrNEaXNsZax7LCA+iPdJgPosYvSJ4YRVBHCCtDkm0Q7gbTwMCl5nAa3bL
         Vppa5iAczQkqskWc/lpfDtHIuLdFFBMUcFsbFnPA/EttqYE0WiOBydE3whHqwbUFRdiH
         BS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670824; x=1793275624;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4Pj7b5+BCbfAUSTsrmqLzkuYkoyWrTz+YeW1iMb6p8=;
        b=wmyq6/h5CBgNBcF9qERthowsuOW2FnWDOzSpFwJfTVKg5goDeqQHKPq0QGnXR8CPqA
         UrCGDkGTgjxcsKO6PmPeAQvm7+so051tXfwNShbQbVTYwt/CKzaLB5CQB6RxtMrNv7rU
         9asTzoLeJciyUBNXHV+yXNpaG6v1iQSwRE99axfRNumBsQQGAIcAbgUb2FKfkGIT0Zd2
         +uax8uZHP3t8hN3sb1EvtoV63lfOVDRAjIpguqKUXIlDeHMp45jI8qDo440yWDZPlvt3
         Le1hK9wLmcRfLzORadYrg53qiT+AVZRcmAlXK0CwWh4zQADgKvFZq41L2LOzKQl5/IqZ
         LNJQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+uRmgf5sbMQVQogwPsGBiNZSvW2o3cqe9i3t3X+1i3RhM6UEyZUGC05YmGkBWmupECb1AOH7smVW30pWm@vger.kernel.org
X-Gm-Message-State: AFq9FYJFsI8/8lMcvmGc8wgBj7bP20S3uR00tAJaOa6DYbO2a5nbSIPI
	JM1FmDSvuc0iVssqgPu1zZQ9gXx0dleLKa6/7ARCnzFsQMU9DIZrGXUkNok/2yuTLg==
X-Gm-Gg: AYBFou2UsHzBERj/JEWd9V9bw8mPD5tL1MP/hcPPzriXVueEZ4w2w3TYyUu0jUeHiMF
	YmtE7U8xTmxz7puzHE/MZ8lRaQgrlMDv/T2Mtz8tIcJRYDpFwqN2/dGkVELrd0X/vdNFxhDPQ3s
	94XMuySJXgCrn8MdE7p0Aq5EvP0ItqT7zr8MwY0+YAgFmj1Bw87iGvEbq3Bv4RAyxp2KbbiFmkS
	sbepWkOJGnEEe4hat9i6LcBMtzGr8kUdfnjV/4EdNEGfnMeVL3ripvYzzRttcL9jCa7Ce0a3JjO
	GXM1VcuzHIBbczGohuhhyeF121zngMXmRPd5BuxHjXKOoffCy3ilRdq1KhuCA5Bzm7rBnRUqJ8i
	hx7Ri7zFI0dxa9ks7GIx8DmUAWQCM8IdIYJr/Xh1XMnvWig+P9Pg+LvpFdcVicN875XdJjv1/tQ
	h5CGOep12zfPzwFZXMk5EjToCcIjvcVHjBDR8eVTs3JwOHdiYuLxYCp3+p4zqQ2Bh4ED58E7QJL
	JZ0H1UYj7UheIxx65fq/4TIIznPfFTM6FIVLP6GMfY73HKSaHFp7UOFnhqRvpvihJTxU6FhjUZe
	MqeN
X-Received: by 2002:a05:690c:39a:b0:8b0:a171:65f7 with SMTP id 00721157ae682-8b145716d60mr15017307b3.19.1792670823891;
        Thu, 22 Oct 2026 05:07:03 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300ae236sm25232857b3.20.2026.10.22.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:07:03 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
Date: Thu, 22 Oct 2026 08:06:57 -0400
Message-ID: <20261022120658.1328124-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu> <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com> <20261021153141.311425-1-hengyul@cs.unc.edu> <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Wed, Oct 21, 2026 at 03:26:10PM -0700, Viacheslav Dubeyko wrote:
> I think I see your point. So, I think that fix is much simpler. We need
> to add the thread records processing here [1]:
[...]
> The current logic simply misses the HFS_CDR_THD and HFS_CDR_FTH cases
> processing.

Thanks. I tried this in KVM on a804c5742bff. It fixes the example from
my last mail only in part, for two reasons.

First, a thread record's own CNID is in its key. rec.thread.ParID is
the CNID of the parent. In the example, a's thread is (17, "") with
ParID 2, so taking rec.thread.ParID sets next_id to 16, and the next
create fails with -EEXIST on z. Taking the CNID from the key gives 18,
which is right.

Second, even with the key, the scan still stops at the first record it
finds, and the last record need not hold the largest CNID:

    operation    allocated CNID
    create a          16
    mkdir y           17
    create b          18
    mv a y/
    rm b

The last records are now (17, "") for y's thread and (17, "a") for a's
file record, with CNID 16. The scan stops at (17, "a") and sets next_id
to 17, which y still uses, so the next create fails with -EEXIST.

File threads are also optional (HFS_FIL_THD; hfs_cat_move() already
handles files without one). If a (CNID 17) in the example has no
thread, the next create gets CNID 17 as well, without an error, because
hfs_cat_create() only checks for an existing thread.

Result of creating the next file in each case:

                        unpatched   thread ParID   thread key   patch
    example (z, a, b)   -EEXIST     -EEXIST        18           18
    mv a into y         -EEXIST     -EEXIST        -EEXIST      18
    a without thread    17 (dup)    -EEXIST        17 (dup)     18

So the scan needs the largest CNID over all records, not the first one
it finds. This is what the patch does; the cnid - 1 lookup only avoids
the full scan in the common case.

If this looks right to you, I will send v2 without the != change.

Thanks,
Hengyu

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769335;
	b=v9KEKaNyzZ+ivFk8MZe8upncY3NDT+jhwFrXfmBRo3oqLmf/38Bl4OtZrTZti40rBAvv
	 MfWpAw33jvefAcShLN7s+0CoyZVvqCWMdZRP5VSjcsa6qqJzUS8jzVmAc1I3gRW2+Wdp5
	 kdaphBT5di/W0X7oCfcbtnmVp+LMWYVexVNBVKthszekPswSv4Wfui5fB0Afdk0fex0He
	 Pd/SvG/+iF/lzTsagA75I8IjNl3oyotvzZ03tgzw8kQqCb0X3mLBq0kdXVexrpqB5n7C4
	 fRObLstwkHGxSPK3ImlXccrXSHdRPFr2kdWurt4G/6CfGiMdjAq7Q/Lzjf/38amSAlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
	b=fFIFvo9GaVOg8RKSPgbFnHciMbZSfuVtu+y20bl044ry4aX15YAzBXgEChs6hrhjviUA
	 uY6hDmsl9ZGiKWsaPKzvbYKWIwwJNBEn9luBXiIkQvbVgBHfu4hFK0jUMZV3663JP5eoI
	 N/eZZz+MbzuSwdiDnF3McLysst06bMLZhbi95ifeCQtFpCuJdkpsUV8lUwgoiyMHzp1T3
	 ybPrp8PA/mwmN0GRA15xpqhdpoLLhyVoXlDxY0TqJXTVvE9yRtLPinK129J9H5diow51w
	 oAeM8oytY6sf8Dw5G9X+rDwNlpxh9CouEm4UiyzO2CKzHNRcBFe+9b/SSXnTDjg45Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rv1OPzlL;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16B606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE16B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rv1OPzlL
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc751eddf25so4972218a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795769334; x=1796374134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
        b=rv1OPzlLkeMojQwNzlK+naiity0+ZhuvitsfuYoiZykqG7hyKze1YUcsQxa5pVh7pB
         ClC8NqEi2LoX9Gu5KsdHslyQwBffNItV2Phv1HQuYFabj0PurZIHGu8upGbDJQQ3gafV
         6/FGJ83mkeV+P7Te5KQuDrIt2OupsaKqUeuqEibGamitTgM4lnwh34YE5mrTNvAriFpn
         4yfPfS/jmW++py4tRKwH/wMfr7FMbNCfo8nkn4VF9BTYeTH56WUpJ/3F2mXsZ14xUY1L
         k8jyhUVgICEsnwAaJhL3pKJlPsGSQvwC+W4u3dZiXGqzcpnPpVGtCVio4chZikqXbDbH
         e/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795769334; x=1796374134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V20sSYH+TxrCV4unQJ7dg7ZdaFxiFFR+LbaIUnR8j9c=;
        b=Uc/pSOogq36GvGf/GOjcA8z5+ei4ifdU8dsDBoHI1cAxQRMJcZcLVW8ba7QzLXGT0I
         6ssxM+xcIbGcFtW8fIp/2i07h4nQh1bcUPKZbYnc1ZuMs1wKY4CyV3bUefR2fUjhRVW9
         qEbJOcrE9usurmInU42HH4JUPM0kbF/5PcAz1G5jqBkWyOkqScVm15Iul5q0ZDkn1Fu1
         4LLGnr+xQ+WWfBbEoLfARSyuu0/HQmNoyq+LFohJV5VjpEFKYDq0mLDVWYf65gOgjELP
         VBsTG2RXpcjfkZ7D4mCTRKb6fIr8tiASms5giic4vwfotmc4P3Cmo5gCMInfEfQmafnt
         8r1Q==
X-Forwarded-Encrypted: i=1; AL+hErHFPXcxRA8Q46M81a88pyQp1Mi8/RUj54AFk1DpzzlGYn6tocvieu6fr7PGp3pn5sapEQyCgYSeCPu77kZc@vger.kernel.org
X-Gm-Message-State: APuU4Z8uAh1XwCiCsHGjoGFhB2oyQax/J/DTqHQbVQkKI8EspWw/OMkg
	WOGLvXeWTyyYzvEwSJdRVXo2yQJGRJ/MLk1KY0tx6LIsoDPkixGF5iog
X-Gm-Gg: AZFdTZfMNIU4xjvFIX70yXh+7L7blfX9s0GQdYNZb1Booe0UcAX2HtZrnG0JfFvwJue
	4hf9A0/RqMoiZ6S8JKU90QvjD2MR7uiL9u5zsc5r4SMwUnAmUxXuh6u3aM4bQT6S7rkN7ApmHlu
	+zAQo9h1Zr/n/pObnaIDVkK92BkrUF/U6QHsS8wVy/ftdwExp3Qe/zxVG1XnA49Jgti4M5x0nEM
	wAxx8Et2fJ1zTgaS5Cuq15QQCxAi5Du0SB8bVGAcgOjrA71XFmKo+IEfMWMinzWocdAoRSjo5hL
	9Ye3TgHdKh5kx1Sdc1XDO5ELf11qYB51gXw9uXAcdHpQNGueg1QDoF3Fy9AVb7zkjWqZ1bb0Icm
	s/Qa2FL5YfvV89yqADkbMpVtgQKA2PJ4X3lTmgVXgxfHKaKf2Tvdyn9ezwRj6Ql8oCol9tXmQh1
	Q22NTAVmXCpRoh7kz2TD9hiAF7yIm4BE+I9s/B9aQtqUyXLcRH37zl4vWXqusd+LM+fiu0BBfzp
	nC8+taWlp3mcIyCBsRNpkGsaYdFB+R3mAQyZmWA2Yf0f1SKJQH28fjlTQ58pg4QbBCqEQdfg93T
	axwEcoDHO61n2BjZx4KCnbuI5r+SlVhreTlc93jo5lZSbkRgOaDf96H0TWU9ZZQuY9yJYVkU+gE
	Mm+y4KmKLQ1I=
X-Received: by 2002:a17:90b:390e:b0:3b4:fcba:8f7d with SMTP id 98e67ed59e1d1-3b4fcba9627mr7869895a91.29.1795769334244;
        Fri, 27 Nov 2026 00:48:54 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm12289058a12.30.2026.11.27.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:48:53 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	jack@suse.cz,
	axboe@kernel.dk,
	tz2294@columbia.edu,
	baohua@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v6 0/2] f2fs: enable buffered RWF_DONTCACHE
Date: Fri, 27 Nov 2026 16:48:43 +0800
Message-ID: <cover.1795746008.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com> <cover.1788795700.git.qiwenjie@xiaomi.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables buffered RWF_DONTCACHE on F2FS for one-pass streaming
I/O, where retaining the transferred data can displace more useful cache.

Patch 1 marks dropbehind write bios with BIO_COMPLETE_IN_TASK. Normal and
dropbehind folios may share otherwise mergeable IPU and OPU bios; the flag
is set when a dropbehind folio joins a bio. The block layer handles
deferral from unsafe completion contexts.

Patch 2 passes FGP_DONTCACHE to the buffered write folio lookup and
advertises FOP_DONTCACHE, enabling buffered reads and writes. Internal
write_begin callers that pass a NULL kiocb remain supported.

Tests used x86-64 QEMU/KVM with two vCPUs, 2 GiB RAM, and an NVMe-backed
F2FS image. Each attempt transferred a 1-GiB file sequentially in a fresh
guest, with memory.max=255852544 (244 MiB) and memory.swap.max=0. Normal
and dontcache each ran ten counterbalanced rounds. Values below are
arithmetic means of the ten runs per mode. Write throughput excludes the
final fdatasync().

Throughput was:

 Operation  I/O       Normal MiB/s  Dontcache MiB/s  Change
 Read       1 MiB         4137.96          5869.38  +41.84%
 Write      8 KiB          686.09          1752.24 +155.39%
 Write      1 MiB          714.91          2161.02 +202.28%

Average memory.current was:

 Operation  I/O       Normal MiB  Dontcache MiB  Change
 Read       1 MiB         197.26          13.70 -93.06%
 Write      8 KiB         214.22          13.15 -93.86%
 Write      1 MiB         215.20          19.52 -90.93%

Mean reclaim counters per run were:

 Operation  I/O       pgscan normal/DC   pgsteal normal/DC
 Read       1 MiB          200999.7/0          200888.4/0
 Write      8 KiB          201136.8/0          201120.8/0
 Write      1 MiB          200899.3/0          200883.3/0

Scan counts pages examined by reclaim; steal counts pages reclaimed.
memory.current includes all memory charged to the workload, not only
file-cache pages.

Dontcache left zero target pages resident after reads and one 4-KiB page
after write synchronization.

Changes since v5:

- Rebase onto the F2FS dev branch, adapting the bio tagging to the
  sub-folio merge paths and excluding metadata-cache I/O.
- Drop the Android 6.12 backport results, as its dropbehind implementation
  differs substantially from that in the current dev branch.
- Add memory-limited read results and update the write results,
  reporting arithmetic means of ten runs per mode.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 10 ++++++++++
 fs/f2fs/file.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: b61a029304bb5531312ebc133b2a895d14dc3fee
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994564;
	b=sxqZBmm0a+06ilHPXKyS13Yxy+x/gNFjCq224PjiinvjIs8KAApHsR1Bqu9FaqyCHlBp
	 uQqPm7L1jFaMAM+niTdwXD6zeFOGhoDsPeYbJwu0KM/97KuokPDTLoiHerXHPgQG+Uaxl
	 nOye1Y2URD6vSdKDamSUTkTsrPhH0z1FvUpM/m65Ev8k9zHHwcsTSbCezN3WeqTJNRFJL
	 boIgWkWmwe1xitGtcLThZRfemGTF+yvRscTluEFB2/ZaD99zwzq/ne/iF+hHJUJvQ/b54
	 fyR7wcBJkZKWDNYb33bRcLKbPIVj9SDjdgT4CfPEbhEMwMharM12sgUqb6ZdjEdTF7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=duUV49H96MPxft6pLFc1UF8z64munBlO0c9zGA7dLPU=;
	b=JEh2+HFsh8LUQu+wAkHS80I1hX9StO3weBrM8FC8/6EiafcGS9rkM32FVX8e/t6NFYOS
	 HaYfSTBGzTXh5yBYUeT55K1OzueF95Lv7CLuLD3qIURpHKBAu9MaeibsJIghQofLLGnuY
	 /qVojyOfSnQk/6bA3/8HF/NOdBSWvfo1524E5ceEyc8yOFnbGUQcJQkqQTrHxi9EVZvPY
	 Cc7mImS04Q6X5GHemVHAz8mfJZBFBDRYCM1vuzjwwO81t8U9/CV5b+8ZnYqnxIvpJ/hsQ
	 eqFD/lQZZof1av7CNMime4zKX9AG5ko3xBHFxhSGY44uyVnBq4Z8JcyH74GABYxNS+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGOQR19o;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C51606A8A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 09:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C51606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mGOQR19o
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so453268a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 01:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794994564; x=1795599364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duUV49H96MPxft6pLFc1UF8z64munBlO0c9zGA7dLPU=;
        b=mGOQR19ot4NvHLd3vZv0p8aKvwi0KLW/z0VSlaX8lnmOlrHdBFD47svrCSzVjodLNN
         v9HvALjM7udwt4WlswzzkZEGKwD0zowPNR3LxZLt6bM29nQLMkBr+YXwS+YNks/nQrkU
         6CY9dcEKoXEmTS/lR99f43Zfz1qDPF/JhEPlnkhaR9hNLCwt1EBRBnrvrhlirkFn1dWA
         YXFxwx553vpm3UfEMLBkNMY//YG2Co4UNObZLKFeHy5SrmHqmWMWlpoqHH1AMzFGY2kv
         RKQfZHUgzn3q/LqsLHFhENdMsaGTgsXs4tFpYIj21HsVfCnWo5B3dfcOEsuXMvSGxXo8
         cZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994564; x=1795599364;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=duUV49H96MPxft6pLFc1UF8z64munBlO0c9zGA7dLPU=;
        b=URM1KCJh3ll9dTiqmR//tC00SDdgb6eqkG8ugiKW5CEmKjHW3eQoC9ASnHvSLYSPWk
         wjZo9/QjW4+K2kydmyx1Xm4qm+jalzXjKEWxfPZ2eVhJdU7QvkHiXR4LqNQy/INptzxQ
         IrvSLLvSW48iw6Hgkno5drrD0EX3rS87sh+h63Ct2W90/0ZvLr7B5Z0+sdGC0qicHTrV
         inuRiNBqM+K2t6lg5Nn1cKAXbgnXoZVUKiL4CzmLMcu0nAMxtCQTzZ/ks+q1siaA9EZa
         5/9l3Xz8prM2ceZvufr+taqgCDlwDkfwZ4irLquytlp8KMuFBjvWbblhcxaVSlnaltic
         z92g==
X-Forwarded-Encrypted: i=1; AL+hErFIyHHme4kb5X3wHyvbo5IeaglVibbIY8/kVy5lmzYQH6zK5syJKHqfXqDxKvY65oYeDRJTnwlQNshYUxxa@vger.kernel.org
X-Gm-Message-State: APuU4Z9EgmYDxP+BGQB3Rvx7o4QgZLeSyDlESuRAJzBMSc8jnSDr6xF3
	Gj2+AxaRs3NT0Ik10HXSyRPQwi3B4U39EeB9hVq1bEbgfDg+gr4sori6
X-Gm-Gg: AZFdTZfIrFCAQGYHfQxVk3KJcpJSS6KewrwfbfWbEvl3EIA96aC8hItN6WuaQESK6NS
	cbuTSDAOLU7khRHX0sXY0smyQsK6W3YrFUplyxSvuj2AvXcW915CEGUhJIF+rHYB1js8eY1W5hu
	lcnOPQIniqAlV5lzEUFRD1L4o7OQ/NyKau2o7B4ujh52IN29OHv1eOKtCAe8t2qIwkzgcmrJCGx
	qp/XPsq9vPjqo/73PjfIQJd8dE9fv5ABkS4BVg2hU3V9EGB7ujjawEn0LiWgv1kOpsp87ufkHEd
	1WjHBxOmQ3nJuCRaIMspdTtyLN89FMvwWjgboMcS5YvN/49KJIR07YjBuNlY5ZvevY6ag0/k/nU
	0U8vPQ4A7GQBwn6Xox1xjQ1HGazxFqD2ynzeuhwFKvURYMLhUlY6pXjau7lC1jqHCfQmVUNLPEa
	UrXtHp+VzBe863YPtl2H4932pFF9M+5tqqhUHX/8//SczjFM1LhYn+QcvGYZFZOgTKf0c0Jeg8m
	2C2uUK0YcIHd5u8gEdbwJkJkS/w5eJqhWMAownMSwgCpQ0SH+mBpcnAuVgvArGxnOX4+qPqAa5B
	MC0gzomGKlWcxWSDiB6AGpBaY/75qyfxtPHys8PY/vGGb1O9Npv9gTAPkKOlkJEiF07sYP2MTsZ
	HZDlx6yK79JGO3/3/tO8glhUnMoxr7YSf
X-Received: by 2002:a17:90b:5343:b0:3ac:9176:e82b with SMTP id 98e67ed59e1d1-3b3d07c9cb1mr1972912a91.54.1794994563902;
        Wed, 18 Nov 2026 01:36:03 -0800 (PST)
Received: from reply-prefix.eml ([117.28.251.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d143b9a6sm3505843a91.2.2026.11.18.01.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:36:03 -0800 (PST)
From: Chengfeng Lin <lin2530632123@gmail.com>
To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
    Andreas Dilger <adilger.kernel@dilger.ca>,
    Matthew Wilcox <willy@infradead.org>,
    Jan Kara <jack@suse.cz>,
    linux-ext4@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ext4: avoid tail walks for cached large-folio writes
In-Reply-To: <20260609035202.90669-1-zhujia.zj@bytedance.com>
References: <20260609035202.90669-1-zhujia.zj@bytedance.com>
Date: Wed, 18 Nov 2026 17:12:32 +0800
Message-ID: <20261118091232.ext4-write-t1k-prefix.3a08a@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Jia and all,

In libMicro write_t1k, one worker overwrites a prepared ext4 file in
1 KiB buffered writes. In our v6.15.11 / v7.3 / v6.15.11 comparison,
with nine runs per endpoint, libMicro's reported time per write rose
from about 0.233 to 0.502 us (about 115%). As discussed in this series,
large folios amplify the existing buffer_head walks. The measurements
below concern the remaining prefix cost after d09811183db2 and
f10b9cc1eb20, both included in the tested v7.3 kernel.

Before each run, I created a fresh 10 MiB file on ext4 with ten buffered
1 MiB writes of zeros. Each batch seeks back to offset zero and performs
10,000 sequential overwrites; each invocation runs for 30 seconds.
The machine is an i7-12700KF, with THP=madvise. The worker was allowed on
all 20 logical CPUs, without another benchmark running.

I compared v7.3, the same kernel with ext4's maximum folio order capped
at its minimum order, and v7.3 again. Each endpoint has nine clean runs:

                                v7.3 A   min-order   v7.3 B
  Buffered write, us/1 KiB call  0.500237  0.245877    0.496312
  Observed folio size            1 MiB     4 KiB       1 MiB
  Buffers visited per walk       128.5      1          128.5
  Of those, before write range   127.5      0          127.5

The timing row averages libMicro's nine per-run medians at each
endpoint. It covers the 1 KiB buffered overwrite loop, excluding file
preparation. Maximum run-to-run CV was 0.59%; baseline drift was -0.78%.

For the traversal counts, I instrumented one separate run of the same
workload at each endpoint. I counted buffer visits in the begin and
commit walks separately for the first 1,024 writes from offset zero.
At 1 KiB per write, that covers one full 1 MiB folio on the unmodified
kernel.

The min-order control reduced the reported time per 1 KiB buffered write
by about 50.5%, or 0.25 us/call. This supports a remaining prefix-related
cost, although changing folio size also changes allocation/cache
granularity; the control is diagnostic, not a proposal to disable large
folios generally.

These counts quantify the prefix traversal that remains after the tail
fixes and may be useful for future work on this path.

The libMicro source is gormanm/libMicro at
976d502afaa2d9b919564d7fa8a08fec286dfc89. The command was:

  ./write -E -C 0 -D 30000 -B 10000 -L -S -W \
      -N write_t1k -s 1k -f /path/on/ext4/data

Thanks.

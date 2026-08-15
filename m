Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587E3C3BEE
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786785514; cv=none; b=StLazqIO076T+hboHTTfuMf2HI8jBB0+VpLnSuFiPVtkAhsrdDs7CEdB2UspHjA+Srte5kWPxae6x0UfL+mEs0oMyHyBMm/E6mBqMRzPp44x4RD5mteg6ewoXMYxmK+/67sUyw0JfTtpHdbZ/rBXddMgigSueI93ImQg+MpksPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786785514; c=relaxed/simple;
	bh=5Tk26TZlY4MOjCWHoxMOQGtJ853fDrZtjs1HhWW1xrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9uT6h1WC5rLqEOckGCsjYV2xy3BgS7kfYvDIGq8lOY0EFqXdxCVANBXWzRufnI8S3FeZucDY5kDDhKJspZn8SxKdGMtNbnFx5buZtIOH49YbWoxbaOc4eZBTTe4or8LsXGqctnfIsEEEzijfUgO98bHFQrGgDcXQUZqSNIqMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeOxmG1Y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeOxmG1Y"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84faf87d19dso1871746b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786785511; x=1787390311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXZKFyuDLY2DRqrs+BqA4wglyce4j9tGUwHMwcrD9yQ=;
        b=eeOxmG1Yv5n2ziL/1dL99m3xVHhDpZZp1Nxf4AkmTCP9/1DufHLD31EQK93p7FkwOm
         6oi2RPOKGK/2RXZjBMk9TsfqXbxSBOugu8VMflKirsAJw13U9vLBSZnSznzc/HcLefJX
         G1TXx06IzC51h1p6J/dZ6HC+lynor7u0bOkoH/G39C23G40X3n8S5Y1mKCp5ypgXbxh/
         GPU9pEm2KlA8YdCvrBXFTTCwjdVzkz4Qexe2SIC3VNrY4RDEeIq02oys9KlKtqYos4iL
         6TH9wcr/fb1uE/lvMVuHCWaYdNOX5uak+wJG4EDvHACEtEuRKumZGUEAHk3iUYeQCa/+
         pUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786785511; x=1787390311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXZKFyuDLY2DRqrs+BqA4wglyce4j9tGUwHMwcrD9yQ=;
        b=jPVgSOlbWdzsPDXqdjVrDTRGg9KIY3LOhrltS5ArHc8AcXm2ncbw/gmSeD7FOETGbE
         mOLEj2C74JIuGIZai+7gs/LS1yNU1qdmk1/dZD3BhvqGEr4SKqZX76oc4RL0LnrqP3u8
         Ry/w8VeWSZoW6G00ZDaH5bChwNUxT35mNHsOUE9CJbCurlWdy29MMOcbBw2bCfKQAp8O
         rslng/CqITPjWXPqBZrvFJokZlFDGnJWnc7Wk4zts38Ps3lrfr7v4+/EHVfYD1nkP2Qh
         Oj8gqBaI5G36NjgVUXdUawknnej3iB7h28QGqAU8zPDTsds55G/AzyTt7kHqXni4q2DU
         gkMA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9wBwaQHLqJ7L4QgPxXjpRIh7qYQnzYdLpPeVY+AGyY/XBixJy4BtIoRiUKgbv+/Hh8qTKnsQgM6muZrlp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zwtIBbPba2iBECWdkHXT3ejd6af1ghqs64o81bnaLAk6ceXC
	utPUqSqxKOWxfMm0DmAaiJN4SLuJQR64KtZdnvfRrVpIWXfeQEshM9lP
X-Gm-Gg: AR+sD12T4Jh6nAudr/5hlm0N3PrqfY+kpS3lP8ddc1Jtojau1ey4MI7JPqS0XUw0T5w
	lcEOsagJ42I/JrrTj/nV7GSwd3YEQ+8zZRK8/4IJgC7XKjJm+FN0Wb3GUft9J6CXVMDhXW3Yixt
	9987iot0lsLqBaPRUccdd7iKxj7ukdq4WlT1uaiqE7Cl7BrnEEs1r49YDXxpI81rrvj8gK28Yzx
	c70i/8qmYfXLoETYxtjh5+VffQW0K+00AwTSHjxY9FHq9bHZKDGUIVu7nQAeu4UH40v62xD74SN
	gfgqHvIdOdmlsclft+6b5UGGAj5NTGwALVoN6mbqyfvi147qVfkXG2SaisMOMdJEF5M9eD0+0KU
	tOSR+uh11w4yIPKYYjH1UjXiqT/OsIQLKHWycJhpkw5mlqb/ateIb8JPoKVIPIrj8gw+LLzHssj
	oWqVtvZSUIsvfYJK++3uAZ8yeK7/KZSVIxI5dBb/gTeVHLTHhtbcDZMNsjwxgR3Bm5bK2jKCJU5
	A8wKyhsLzjX+u6xi7B0Zgmzrug8
X-Received: by 2002:a05:6a00:3d88:b0:851:8084:133a with SMTP id d2e1a72fcca58-8518084471emr6698912b3a.29.1786785510477;
        Sat, 15 Aug 2026 02:18:30 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223f1bsm1274934b3a.38.2026.08.15.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 02:18:28 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	yinchuang1@xiaomi.com,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [RFC] bpf: account ring buffer backing pages separately from Lost RAM
Date: Sat, 15 Aug 2026 17:18:19 +0800
Message-Id: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to discuss accounting BPF ring buffer backing pages in
system-wide memory reports.

BPF ring buffers allocate their data and metadata as order-0 pages directly
from the buddy allocator, and then map those pages with vmap().

Because vmap() maps caller-owned pages, these backing pages are not counted
by VmallocUsed. They are also not slab pages. As a result, most BPF ring
buffer memory is not represented by an existing named /proc/meminfo category
and appears as Lost RAM in Android memory reports.

We measured this on an Android 6.18 kernel.

Test case:

  32 BPF ring buffer maps
  16 MiB data area per map
  512 MiB total data area

Observed changes:

  Lost RAM:       approximately +529 MiB
  VmallocUsed:      approximately +2 MiB
  Slab:        approximately unchanged

After destroying all maps, the values returned close to baseline.

The question is whether the kernel should expose the unique physical backing
pages of live BPF ring buffers through a dedicated global counter and a
/proc/meminfo entry, for example:

  BpfRingbuf: <value in kB>

The proposed counter would include:

  * ring buffer data pages;
  * metadata pages;
  * consumer and producer position pages.

It would exclude:

  * the second virtual mapping of data pages;
  * the pages[] pointer array;
  * map metadata allocations;
  * vmap page tables.

The goal is to account for the currently unclassified direct backing pages.
Slab- and vmalloc-backed auxiliary allocations are already represented by
existing memory categories and should not be counted again.

A possible implementation is an NR_BPF_RINGBUF vmstat counter maintained by
the ring buffer allocation and free paths, with the aggregate exposed through
/proc/meminfo.

Questions:

1. Is a dedicated BPF ring buffer counter appropriate?
2. Should this be represented as an NR_* vmstat counter?
3. Is /proc/meminfo an acceptable interface for this information?
4. Is counting only unique physical backing pages the correct accounting unit?

Thanks,

Xiang Gao

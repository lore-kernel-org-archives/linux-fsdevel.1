Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969164;
	b=itZ69I6OtAHNIbcG6+pZBLcwhRSARkGqKKQ/fWrnzgZ6TDEdi/wug2G2u3IrtWXEdhcM
	 FAZkYVedEREtGl77Fl/rY2s6uFdGrq8mTGOj3rrduFUGHx72bNZJnpWdgNHJSztR/ByO3
	 N04O2LHv2Fp4jhiJ6w7VqyGyIGq5D36uyh7lXLoE73tVmYR1frysg3i6Y0lE8YsWndVbC
	 796eJk1oon4EPpQTaDtwoiBFQ0ijzdxGCvHwkDCpldssCLASJJahnvX1AUlbEuTPopCGn
	 8ambOR6s9OyUqX8y4NJZ6oiqUJ8aKpdw5MuHUz/RaTpqXt6Jim0zMW5Q0I8tTOdU8jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5lZ1X9OvYujo7R37IHLIlb8OsfThW1dgQ21ejL+gEBc=;
	b=vzc5BVVYffeerC9xbtdzcyf7GbgApQWL287EWmbgjwnlf7vVoBSXS6R6oIwNBbqfmZd5
	 H8uwRSdRIP/aIAAsNhd3jvt9ODmBHccIHWJOLuGrLT0pvlnqiVQIIC0sMycTS/ru/5YDC
	 sFEFFNgvIuz6OKdoKDWbjqvXJVFvIrK7iyAsPiY336CfPhMzqc9o8eskK+P/n+0LGIYn0
	 10jSW+uZbyxcMs/0392A2dGLsCfZQr91WTXCwzTngPK6ZWlcjE8ZgGuBUZUugPIpxasph
	 JRok7tpeDYzs34CYe/JMRfuBMnDhZ3eIN7m+AdW/1KGNi/fCBbr+pP+XCaFiWTOUNSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0EVpDk5;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783E606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 12:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6783E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0EVpDk5
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so863230eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 04:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969163; x=1794573963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5lZ1X9OvYujo7R37IHLIlb8OsfThW1dgQ21ejL+gEBc=;
        b=J0EVpDk534xXmZlhJmIUi9XA9qotEUu15atz2gyPmWLJFyPapECP0OJsL4AlqB4XSh
         Egm65cYGOfDobgBFJDvbnaaO4SUHJnXExolEW7fETfOsH55o5ppeZdVj1w2sL71z0z1z
         B9wC/nQrI/H3wrO5cQCWME/2t5WfXdci09sl4ZxenZ5AFP8JOepG+0/8k1XRAmUF44B5
         N9DwqTaPnjZ2oo3jJ3pfR355upUI5EezGI3/VIxiM5oxomCB1kYh8ACJBDA5iTWEivr2
         VGJdENqiBmCehsdmtOiYMNefTTFLpQWkY0jNw6ILdqPJwbh1oRUci63l3W0gspSv5S4J
         p3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969163; x=1794573963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5lZ1X9OvYujo7R37IHLIlb8OsfThW1dgQ21ejL+gEBc=;
        b=0lgIQbcA4sN0ykyYC2mtLOGGcMHGTdjdL7j0xqm5ZPYVnEY4JUe5qszCdJdZ4jI9jJ
         Zns7+Js7fISJpmgCJkwtj0S4omSZMdgxsEBt+Jrh7kxOVtSC6WXQ1iTErsqsryHufA4T
         PHILEt72O5reAd7gwbCYr4Fl4fOZaZe1fnZG786MTQnKcihqF45U97FCjf/5ejLM3xeg
         aMunZOe9hLaGbyWtlXFFeiRildS1S7BPQGLX18ZK4uOih0F3H6B82wzRf/JgJlwL+lsn
         rG5m/rH7skz4ZldCq1Musv1jCOct0mRtJzLMPt6hX4Cc8dY2gRHM858t25ZAaniNWdip
         6v5Q==
X-Forwarded-Encrypted: i=1; AL+hErF9z2joDBDtT4capvyCM32uv0FYI3RvPbouehlx4z7ZyWWno2WDo37d8/Hvyzoh21j5lIb2250KyOTRHL2k@vger.kernel.org
X-Gm-Message-State: APuU4Z/YAIwZbnP+FAKhVlYTOFm8LRkIvhamyWZ+vkQX4Q2QougAu7li
	a/1McxLun+Rgju06LrtzI87lIq+vOuom1O+Pk8na/xuhuOpeFDAyjvN2
X-Gm-Gg: AYBFou0DGHg1z4SbwekMugKm/qNQcSwjAF5PV7pIG/POcSb9RrcuQJjbkvsthHGKJbY
	83bJgJytGMRL7C70W8VQ+tSBMVfc9KNLRvn8mxml8JW7vYJ8qQdjDbNk83r8R5CeDwwCjA+A4k1
	6+sBonb33vrkQbAb3CqKWrUW1cjCPdlIrZ1p0Qo0D79rds3l3XGvMHQC6Q1dICLYd6GWu5WtCoF
	ssWKfK3u6Djm95W6Keqfva+fCHFaUrkv2v3XAEjwkESTFhZDgGj4/rzVoGphjMtfIRosX77zp/r
	6uxyIgQslQxV3HXL6ffYr4a/d0MpN8xpJCgLozS/HxOdbj6pXpNLMv049vthWRjH6PDFVITRk49
	0nJHQfUnGT2Mvn9JEJZE+0dLJ/hvKFa57IhWIaCvvLwIWU62n4KYoNY4WwFlV5o2BUJiutc0jlb
	tw+mFhD5mkZMJ71YJQoUXILLqp6LYOTNnfRddAaWYqtlJWm0DxMl9CHjwaJRCTeZ+RvJ2TAoOQH
	LEsPhhLdr1x85sSYxbv2F4LVMFSvAVpGsIk7Qm32GTxwD9clhwA50gWyfKgJlyGkU55hIqBKLT0
	Wy3YrKbNB7DAdW4eVv9g+7bXj3CcFy0KK2vTaPqZfoTSMi9or82xH35UTJposPD+6Q==
X-Received: by 2002:a05:7301:1601:b0:36e:dd5:fb08 with SMTP id 5a478bee46e88-36f773f7c7fmr3004408eec.40.1793969163232;
        Fri, 06 Nov 2026 04:46:03 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm6802331eec.1.2026.11.06.04.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:46:02 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>
Subject: [PATCH v2 0/3] ntfs: three fixes for crafted images, found by fuzzing
Date: Fri,  6 Nov 2026 18:15:50 +0530
Message-ID: <20261106124553.2617026-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
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

I fuzz the new fs/ntfs driver with mutated images: an image from mkntfs
populated with ntfs-3g, a few bytes changed, then mount, walk the tree
and write, under KASAN. These three problems are still present in
ntfs-next (e62b384ca). Each patch has its trace and reproduction steps.

1. ntfs: do not read an index block outside $INDEX_ALLOCATION
   A directory without a usable $INDEX_ALLOCATION hangs on its first
   lookup. The task waits for an mft record lock that it already holds.
2. ntfs: open the index allocation before reading or writing an index block
   NULL pointer dereference in ntfs_ib_write() on link().
3. ntfs: do not convert a named $DATA stream when making room in a record
   WARN_ON() in ntfs_attr_make_non_resident(); no damaged volume needed.

All three need an image to be mounted, so a crafted image, not a remote
attacker.

Changes in v2, after an automated review of v1 that I checked by hand:
- 2/3: ntfs_ia_open() also succeeds for a directory without
  $INDEX_ALLOCATION and returns an empty resident inode. Reject an index
  inode that is not non-resident, as 1/3 already does.
- 3/3: v1 opened the named stream and converted it. That would lock the
  stream's folio under the mft record lock, the reverse of the read
  path (ntfs_read_iomap_begin_resident()). v2 skips named streams in
  that loop instead.
- 1/3: unchanged.

v1: https://lore.kernel.org/all/20261106091420.2461683-1-wahidzk0091@gmail.com/


Wahid Khan (3):
  ntfs: do not read an index block outside $INDEX_ALLOCATION
  ntfs: open the index allocation before reading or writing an index
    block
  ntfs: do not convert a named $DATA stream when making room in a record

 fs/ntfs/attrib.c |  6 ++++++
 fs/ntfs/dir.c    | 14 ++++++++++++++
 fs/ntfs/index.c  | 22 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)

-- 
2.53.0


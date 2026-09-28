Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015323644DE
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579264; cv=pass; b=PMKtNu9j27oFn8A4isKbGk6uFBw5gdXpcBEtC8Aki6PL1LH06t4OefG5rjaOIBq+wdqkpnam/1mDlrduZVdRhR4VuJH6klqPmmYUhLEHW5t28oCtqTS/pz5LIahcUqsuvHY1F7//7iuigzKCV1zItcq6ggCVaODtv8IfxjTMtYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579264; c=relaxed/simple;
	bh=lkqhvR63AeSANfuhqGFgzdDGmzAD7hceqVurmTwRt/U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Rbh1wTrbwlXL2mD5NFYcWn7cUK4cR+CAgDWOP47IvfV9u4Aaq1TvUHg3RDNOT/Y4b5v/rT7Dmd5ruwJCfzM1DKccxCxOjR+sNspQ2Njx4Zxy0bHgHIcNRq/DNUtSa3/V5+T+zrD3vaeq8qmiQrLCXSyHwSF3lDNLu8L3kwMA0U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aT/0ll/I; arc=pass smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT/0ll/I"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-5332bdd8296so27887021cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 00:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790579262; cv=none;
        d=google.com; s=arc-20260327;
        b=BgX4yPN8fZ/dCBYMSDozLowLFQSs4cipTlnId5t1nBq0tEHUwVbIQhOjXsAdv6X7bO
         pJUnyop6z5p9s55n+wEELjvTOCGEVv+MtLOjQ69mCR2UUipElrnsqz8SYlF4MsFa6GOa
         /VKXPPM5xHgcUTBXVBMooxcnh9ck2I2GRNUxGj6vOt/0RVnFFsTfYmAk7+13A91a0eBj
         GNce43LadestV9dbeiZEM4n88K3UhLDgvXpIZkcXzzLFU8jhfhQt6aXeOYaBamzO4mHg
         UeiJVGIWxzSnWn5F2BsuupY5Q7wuPsi0JRZrQO0xnx7wOKDf6PIr72X0w6VIiJcuqQgP
         iV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=I+r4UsyqICfyWYrYGf3Z5Y+xllxggueQsNYbHXj5tk8=;
        fh=vLbkg4fLvTEQqhJk+PrLrfBdso3R2OEKAAZ6Ojs3pMI=;
        b=WbMi3gv+ZzGvTipl04B2SHX/QmhP3e8LekFWIzKT6kLPqFtwm/2HVJUNBYmAurGPSI
         8Z+DSjbrnqBB6opZ6oNSqbhUkTYNfpBF5831F04FlcS77JagNzB6pEfAJ7sS9MnTsfS3
         wq96IHNwRpXYA1ADVm0SQxbeOBKB72WkxloCmX94U8sbNbtfaatrBAB6gD/hd2A7/PP0
         cOya8ZmS/8B80I+oWDk5XHnCAPG9Q1k1ETV/IQiCYUhnYG/lW5YY0vdtjGA0ICGYslap
         AOVTGyl0N5prI2g9BV80l8p7wnVBo/a8bH3DT+DWEtNt+uJAe3yuQNKWv1ggmyf5G085
         8MEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790579262; x=1791184062; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+r4UsyqICfyWYrYGf3Z5Y+xllxggueQsNYbHXj5tk8=;
        b=aT/0ll/IJVlrDfPKX//4AfqpLYrrj5/SZyMlwWIT18pooKa9cHmNjs5tKFSR22Ntrj
         qTfPsyzmBAQDi+1E/romBFj3nWab8X8IDJz7Pafb47yLLlYvPNrNk0rFb372qxbMniTS
         WTEJ4TCHdqeh4vmjDUgb4kYsv2B55DZO5z+XSG2RlWeAltWcv/nEzNLsNg3lTFgMQrj5
         SD4EyO1CdUDTw+CfIAiECg2EhYLxRqmsgI/voOzG/63lq++5vWRyNOxmIAubwFf5s8sy
         8ty3y7cldqwqFWaQsyFSaNsnfMvXpaoWqZcdqGe3wreuYqiV5yJuMr3LtEnP7NrivKNP
         /HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790579262; x=1791184062;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I+r4UsyqICfyWYrYGf3Z5Y+xllxggueQsNYbHXj5tk8=;
        b=tQ5KiWQESi5FxiJU6dfRitKPJ4uMbkl9WfxI5gzFDfoub7CCoc97NhPUgdLiupS3Mm
         XJvbOafPLNCXlrBt1VNoq1iVVKfh1okkLeqes9dqFPw7rB3UF8TvotSJrokW4E0buN88
         Aqwzq33qnp1JDCKEwOPcT++2JCZTdiDn5RfZtiGcjdD2xMfuvaUDC1EDPXLwRmTLCVcs
         B/hv/pqeHsGlHCIBwh4Fw9c7I9w6HcDTqjxNmk2F6dDdLlzk6RF7s+ieV9yn7mlA9CrO
         qPdy2FdPuO4vWSztJGjMi4urlQdtU4eAEdqg6O7mTdMvts9302xLGyioEFpj776DDiuZ
         AIhQ==
X-Gm-Message-State: AFuF++kcjGqj/eMTq6AM4sNeUR9VQ/RcCecQm/AFpybUbkPnmzC0elmA
	rOBzp+tQ6ykmOkGKW3ZJ0UuFs9o1h5AUossplEF+o8wxekjw+TSI/HTNmy5iDDER4CDjb2PgBKo
	LnFwqo/aOsaNJ1QOF3cuZDoWhcLcGEGy3aerQ
X-Gm-Gg: AYBFou0x9Sv2JxrMiL/j7JXkH3hi6EXZwJgA5aCDvQekg1tPA8b/RqWTB7MGf6HTIwy
	Yb5TCO8itsjsKMzG9A7cahOIK1zm8+o0Xlgd7xRIbai3E2K34g5iD0YkpgOowGelneU1Sz7/gew
	4EEYav764Jyq8TxhFjAQVE2QTjArp4nh5wuSZkXt5EnJmE7SmQway7PM9esM6wFTtIfbzdlLFdM
	ghp7KorgUBn39japnQKduH6Mr73+qAgp3XS0ZYUI7ZVfjr6fcnEp+YZvL7x0WVIYnnDZSLVDC5U
	sP0Xnr0oAhC+vZZ14IrDnJ7O52J1pWUHHBHcPqXotwujsa0xjoemh0KbHwy8g8p5YGnUC5Z0QVf
	74yq54DZkVVaJ9LORNNoN+dgshKwoIxHa83qM
X-Received: by 2002:ac8:5984:0:b0:533:3f82:3b80 with SMTP id
 d75a77b69052e-5333f82434dmr56559711cf.39.1790579261761; Mon, 28 Sep 2026
 00:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>
Date: Mon, 28 Sep 2026 15:07:30 +0800
X-Gm-Features: AclHuK-URrHmhApGmTC_eE0sCs90t8I1v1YfjciG5WiKRhbdAvEXlzFVRK9XjuU
Message-ID: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
Subject: [RFC] madvise: best-effort deferred writeback for shared file mappings
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to request feedback on a mapping-scoped, best-effort hint
to defer background writeback while an application is still constructing
data in a writable MAP_SHARED mapping of a regular disk-backed file.
This is a feature request, not a patch submission or a benchmark report.

Motivation
----------

Consider an application building a large data structure, for example
10 GiB, through multiple passes that repeatedly modify the same pages.
After construction, it persists the file and publishes it for other
processes to mmap and read.

Building directly in MAP_SHARED keeps the data in the file's page cache,
which also serves the consumers. However, background writeback can write
intermediate contents that subsequent construction passes dirty again.
The application knows when construction ends, but cannot express that
knowledge as a mapping-local writeback scheduling hint.

Building in private memory and then doing buffered writes adds a bulk
copy into the file's page cache. Direct I/O does not itself populate that
cache for subsequent file-mapped consumers. A memfd can share the build
buffer, but requires a separate object for persistence and changes the
consumer interface. Global dirty/writeback tuning is broader than this
particular mapping and construction phase.

Proposed interface and behavior
-------------------------------

Tentatively, a pair of madvise operations could express this:

    madvise(addr, len, MADV_DEFER_WRITEBACK);
    /* Construct and repeatedly update the shared file mapping. */
    madvise(addr, len, MADV_ALLOW_WRITEBACK);
    /* Use existing synchronization calls if durability is required. */

The names are placeholders for discussion, not existing constants.

The requested behavior is deliberately advisory:

* Prefer to defer ordinary background writeback for the corresponding
  file pages while the hint is active, including pages faulted in later
  within the advised range.
* The kernel may override or ignore the hint for memory pressure, dirty
  limits, fairness, filesystem constraints, or forward progress. It must
  not reserve or pin memory, exempt pages from dirty accounting, or
  promise that intermediate data will never reach storage.
* Explicit synchronization, including msync(MS_SYNC), fsync, fdatasync,
  syncfs, and sync, retains its existing semantics and must not wait for
  the application to revoke the hint. In-flight I/O need not be canceled.
* Shared-memory visibility, data contents, and existing durability
  guarantees remain unchanged. This is not an atomic publication,
  transaction, or crash-consistency mechanism.
* Revoking the hint restores normal scheduling; it does not itself
  require an immediate writeback or imply durability.

Automatic lifetime cleanup is an important part of the request:

* munmap removes this mapping's hint for the unmapped portion.
* Mapping teardown on process exit, including abnormal termination,
  automatically removes its hints. No application cleanup handler is
  required, and no persistent per-file setting should remain behind.
* Independently advised mappings may refer to the same file pages.
  Removing one mapping must not remove another mapping's own hint.
  Once no applicable hints remain, the pages have normal policy.

An initial scope could be ordinary page-cache-backed regular files with
writable MAP_SHARED mappings. Unsupported mappings could be rejected.
Details such as fork inheritance, VMA splits/merges, mremap, and interaction
with unadvised aliases would need explicit definitions; the lifetime rule
should apply consistently to every mapping that actually owns a hint.

Implementation and evaluation questions
---------------------------------------

Although the proposed API is mapping-scoped, writeback acts on file-cache
folios shared by mappings. An implementation would need an inexpensive
way to connect those scopes and retire the hint without leaving stale
writeback state. This request does not assume that adding a VMA flag
alone is sufficient, or mandate a particular accounting mechanism.

Useful evaluation would compare repeated-update construction with and
without the hint, followed by explicit synchronization and a consumer
mmap/read pass. Metrics should include device bytes written, total time
through final synchronization, dirty throttling, peak memory, and consumer
read I/O. Memory-pressure cases, competing writers, partial unmap, and
process termination should also be covered. There are no measured results
attached to this request; the expected benefit is a hypothesis to test.

Is there an existing per-mapping or per-range mechanism that already
provides this behavior? If not, would a best-effort madvise extension be
an appropriate interface, or would an fd/range advisory API fit the
writeback subsystem better while retaining automatic lifetime cleanup?

Pointers to prior discussions and feedback on whether this is worth
prototyping would be appreciated.

This proposal was developed with AI assistance from an application-use
case discussion; no implementation or performance results are claimed.

Regards,
Peng Lei

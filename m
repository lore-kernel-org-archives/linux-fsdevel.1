Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F085497B85
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164893; cv=none; b=TUjzu4Y8Rl8ycTx/kiimO3n+aEif68vcp6kCnbfCCwN3rMEoLU2pi9ntJM0m7gIRNzgqE+Nb5eLLFIYFfmHMcx9rN4kAP1fvP8i45S8xMgcCPQe2Bj1ZKW+amkX7T5da2OFsumAYtnuJAOBLD5Hj+FNxZt8aoww/ti+qr5KnAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164893; c=relaxed/simple;
	bh=46JLE2djcEBHu/e418tq2dWGc92hKIPjTY95HQc1KFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSZcB1pb7ikMLgZkzBMzBOIRnMR/ulMbre4wBtUJIqzPQlUQxesDzEtohBQCfzk8174D0yliOt+HzDONYixAF7KYGHCv/9/xmoDVDVMevJPjIDbeFW4mVeMJYn4woDxSkuBnFwUb/XTxmYelKKJJSS7EKL+GiZeixGqVi2EFVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM20skbp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM20skbp"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1515575a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164887; x=1789769687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l+6FszybKpenSJZy2BI3hcOtPumB191OQOasiZknYb8=;
        b=GM20skbpoc+0uLE5DAJCmZBQHxS9vqugMxUb5S//OL20BD7r+NVdeEoTb942vpmsfK
         ru0wIMmidHRYp2oRMnvMBIoJMtajZo2SG4zE+FvQwh8/CjIkOWUD9a6Ws4u6IRzd66SM
         JBvS+XqXA5cQHjEJvL4oHGW5H4Y1b5J6s0RzEFH9L1fhV84FFOcKGTQMfwYAm4tSzgbO
         Bj8t+PLrhh97briZQOlMKi2zjISpIAP5jIcYfQa6h7OQaECEc3XZDFF6sIgO3wnoaWiD
         dyEIBGhyesLfvaOkaL0JmOTRvcdeBsScFlZtixKd1P1uvvKUrBM664MGnDOqK3jw2CW0
         9hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164887; x=1789769687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l+6FszybKpenSJZy2BI3hcOtPumB191OQOasiZknYb8=;
        b=rWI0+/Mt6vwWuU7+3sw25B1Sp9qpznO0/Yc1acgwPPuO+EGYsRCsY6VhGlsWHQE5L9
         E7mrflbXvKFPR24H22k8IKXCGsdz90hih7fxgGTuxBBoEWQcAlg+4zFu2kH0N5SIyQoG
         GO2pmAFCDIqWUvCKxeJvW52KLyLXNtMhDX/RKwPuYUnyqjDUsA2eji6Hs8HGau2xEU29
         aptP2JonhiYMo2wq/FkzGcVSryfbmag1UQEk/kP3e0RdHVLoyMnZCxztqbcnBgcgkhMW
         zwe9M9/Tk3fzQ3EhEiBRn5OIm9SSFpq918keFiHUcaUY4lzRzS2uNUasQIEV5z5douIg
         zYJQ==
X-Forwarded-Encrypted: i=1; AKwUvByk7E7cYNKc6nesL4uZ3VuYRmWYjS9kx9bsp/1AcrwuIKYJlfv77KdC02pqOFfjciMtlFktWz5AUf1vqae5@vger.kernel.org
X-Gm-Message-State: AFuF++lr8gl3JKV1O4hQLHHKA1QNdQkspGJFzgc0691iRwzF1C8OiESU
	vA/9fTrLYqoKOh8mskDYBxJ4PWhZRw9zbvXPAckTYNVe0zL4bPn3BQeB
X-Gm-Gg: AYBFou2HMCS09t5LpOU1G/nEsmUoH+/U0aLBzxvJQp3xCe4lYa2PwUqU7gC9+NlJoDu
	jO2miEj2TBFEy3lR3qXA5js0f9ZmTp61sQE1upbOVy5KXO2IEqFBbvJ0IIhaciOfXgW3arxa0Ig
	HWlgAhC/uKIyIXX4O4ZtlzJ8CLfUIstLlF4iDad13H97Bz+9WcUW3BoiIvSbnTGjOF2OvFHqxdR
	qCVK9K75upgKIB8BuzT+5LvVHBvUzotWWI5+9k/jD1/MLXNfTzj8Zv9Gla0coBaWi2JkRf4HRuz
	Xswg0V9e03EzdqHTxPDzpc6lpDK1AyWNOoyvQ4X4wHwsNC+h9i4QLn7h1wvKxtUTtt++TwNwm09
	9GLmroKVZbEH6aaPoRw5FFRui1U+udCQNV+nIsugHSZ9SkRQYPlnggIw6/a16zRrcowLyXDry5a
	TnZYrI140qaSbyLAPk0XlZYz+LzJVRQ5KfznPcJQ+bq2QwicP9D2X8JeGyazTY39AlEebi1qF0h
	3ulVso=
X-Received: by 2002:a17:90a:fc48:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39d9c3527b5mr9789091a91.24.1789164887357;
        Fri, 11 Sep 2026 15:14:47 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4efc398sm10174839eec.19.2026.09.11.15.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:14:46 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <liam@infradead.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	Chris Li <sparse@chrisli.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org
Subject: [PATCH 0/3] Catch automatic storage in IDA and Maple Tree definitions
Date: Fri, 11 Sep 2026 18:14:40 -0400
Message-ID: <20260911221444.1523311-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A 0day report [1] from the region allocation benchmark exposed a lockdep
initialization bug: a stack-local Maple Tree used MTREE_INIT(), whose
embedded lock has a static initializer. On the first allocation, lockdep
rejected the lock address as a non-static class key and disabled locking
validation. The IDA benchmark had the same issue, masked because it ran
after Maple Tree had already disabled lockdep.

The fix [2] switches the test to using mt_init_flags() and ida_init().
This series adds a compile-time check to the related DEFINE_IDA() and
DEFINE_MTREE() declaration macros to catch the same class of mistake
earlier.

Patch 1 introduces ASSERT_STATIC_STORAGE(). It declares an unused static
pointer initialized with the object's address, requiring that address to
be a valid static initializer. Patches 2 and 3 apply the helper to IDA and
Maple Tree definitions, respectively.

The helper is mirrored in the tools compiler header. The existing automatic
local IDAs and Maple Trees in the userspace radix-tree tests are converted
to runtime initialization. The interval-tree span test keeps its existing
mt_init_flags() call and uses a plain Maple Tree declaration.

For example, an automatic local definition:

  void example(void)
  {
          DEFINE_IDA(ida);
          ida_destroy(&ida);
  }

now produces:

  error: initializer element is not constant
  note: in expansion of macro 'ASSERT_STATIC_STORAGE'
  note: in expansion of macro 'DEFINE_IDA'

File-scope definitions and static local definitions remain valid.
Automatic local objects should use ida_init(), mt_init(), or
mt_init_flags().

The check is limited to declaration macros. Direct uses of IDA_INIT(),
MTREE_INIT(), and MTREE_INIT_EXT() remain unchanged. The helper cannot be
inserted directly into those initializer expressions because it expands
to a declaration.

Validated by GCC and Clang checks accepting static storage and rejecting
automatic storage The userspace IDR/IDA and Maple Tree test are passed
as well.

[1] https://download.01.org/0day-ci/archive/20260910/202609101106.771b567e-lkp@intel.com/
[2] https://lore.kernel.org/all/20260911155244.1406122-1-ynorov@nvidia.com/

Yury Norov (3):
  compiler.h: add ASSERT_STATIC_STORAGE()
  idr: assert static storage for DEFINE_IDA()
  maple_tree: assert static storage for DEFINE_MTREE()

 include/linux/compiler.h            |  5 +++++
 include/linux/idr.h                 |  5 ++++-
 include/linux/maple_tree.h          |  4 +++-
 lib/interval_tree_test.c            |  2 +-
 tools/include/linux/compiler.h      |  5 +++++
 tools/testing/radix-tree/idr-test.c | 20 +++++++++++++++-----
 tools/testing/radix-tree/maple.c    | 12 +++++++++---
 7 files changed, 42 insertions(+), 11 deletions(-)

-- 
2.53.0


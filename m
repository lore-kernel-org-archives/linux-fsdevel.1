Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F633B6ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464007; cv=none; b=lYGcIWeGCwCfU+Z91VfXBAESZhfVceQZ6by7HIOJxNf8j+rhLmh/JweMSxgDyAmu3G0G3oWy+XLqGfOEGURSxgb8epgKkOxb9WGnKL4Jri6mhFFzI46h+iCDABBXZHeRAyhEVApmcRZ0kGa4zUmYHqIS2n7p2x7K/HQW1bNbkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464007; c=relaxed/simple;
	bh=48cu2et7c44Coh+w2eflFsLos3dZ0LkEmLZqJYXOmBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I6ADWVpydwzlrycLLix2CeulsAa+qcX73J8LAGsGPy7byDMjU+8JoWoXO15pD98tTk46Pluf+qZwsu24L4+TvbwSxrq0jv9VuQdG/IXNRbI1dhYp2artf79ZrifzcLksaK2kwJtVieHtbDbEfjN5wlUdqZ9SbvuI3hXw0g3dyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=glrrir0Q; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="glrrir0Q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774463992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=guUTuRkVZX4cpq0JsrYHGXP/ufz/bCOXkYefZ5151l8=;
	b=glrrir0QgwQxzJllY+8VTjjzWAN4zl5XMicvWA2En0SCRKGNk+7e2Ln1EdevIoaUenq986
	u+xE3AtUp5egR5AD8zNj+RzRIsqdMvBa7E5DzmwnMGmX1oSj2I1ZMtQ7EEkbIpbr0qF5X4
	yEIgfrpTik057bvOvYG9Md4FtyGe5zA=
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v5 0/2] sysctl: add CTLTBL_ENTRY_XXX() macros for ctl_table initialization
Date: Thu, 26 Mar 2026 02:39:14 +0800
Message-Id: <cover.1774463505.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

Historically, changes to how struct ctl_table entries are initialized
(e.g. removing the child field, const-qualifying ctl_table) required
touching hundreds of files across all subsystems.  Such series require
the attention of many maintainers, sometimes need to be pulled into
mainline in a special way, and create lots of unnecessary churn.  With
CTLTBL_ENTRY_XXX(), future structural changes to struct ctl_table need
only update the macro definitions.

Conversion of existing call sites will proceed incrementally from
kernel/sysctl.c outward, rather than as a treewide sweep.

This series:
 1. Introduces the CTLTBL_ENTRY_XXX() macros in include/linux/sysctl.h,
    using _Generic() for automatic proc_handler selection, auto
    address-of, auto maxlen via sizeof(), and compile-time validation.
    Supported types: int, unsigned int, long, unsigned long, bool, u8.
 2. Converts kernel/sysctl-test.c as a demonstration, adding a
    parameterized KUnit test covering all macro variants (V, VM, VMR,
    VN, VNM, VNMH) across int, u8, bool, and char[] types.

Based on discussion and suggestions from:
[1] https://sysctl-dev-rtd.readthedocs.io/en/latest/notes/ctltable_entry_macro.html
[2] https://lore.kernel.org/all/psot4oeauxi3yyj2w4ajm3tfgtcsvao4rhv5sgd5s6ymmjgojk@p3vrj3qluban/

---
Changes in v5:
  - Extend __CTL_AUTO_HANDLER to support bool and u8
  - Replace individual test functions with a single parameterized KUnit
    test (KUNIT_CASE_PARAM) covering all variants and types
  - Use struct ctl_table as the expected-value container in the param
    struct, eliminating custom expected_* fields

Changes in v4:
  - Fix Wpointer-type-mismatch warnings detected by lkp:
    https://lore.kernel.org/oe-kbuild-all/202603050724.SZxrEyyu-lkp@intel.com/

Changes in v3:
  - Replace the unique macro with "capital letter approach"
  - Reduce the name further
  https://lore.kernel.org/all/rn4rsazh7kxf5byq65vw2phyqgzvwm3scczu3l5h2r4aqit2r6@znlpb24z2zuo/

Changes in v2:
  - Add lvalue check, handler type check, etc.
  https://lore.kernel.org/all/xptwb3uwbzposd4xf7khj52ifv4tchcjdgllhv7aabi6d7wgef@2msurl564v53/


Wen Yang (2):
  sysctl: introduce CTLTBL_ENTRY_XXX() helper macros
  sysctl: convert kernel/sysctl-test.c to use CTLTBL_ENTRY_XXX()

 include/linux/sysctl.h | 307 +++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl-test.c   | 237 ++++++++++++++++++-------------
 kernel/sysctl.c        |   2 +
 3 files changed, 447 insertions(+), 99 deletions(-)

-- 
2.25.1


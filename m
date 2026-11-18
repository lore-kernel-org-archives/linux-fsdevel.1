Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794961579;
	b=4HP6JnZXFO2b7iTVR1l0W7t/1GT/SV+7VqoSY7/mK2qeIntAAQ92YEIUrYQiuDksK0pP
	 ypveG1sOFBHN4wpRhFcB1GW4RTe+g561uSNBC6YyrlQ0SP6Z58NSgNxelaTG80/ne1nyo
	 fueAufWFSEGk2g1aN4s7bQLEU8cZLZwoSf6vplgaiG1HTs2h/xY1wNN9nehBxe5vF8O7U
	 dtrgJkSvWK1htwvZ5NrZ+AEh1btFo5tpH6AwMbROaXiRczb8o8jbPPQnKOa/KU8k/HF+x
	 O+TNrbgnTmQyV+bcQD+Cy0SHDNglANK8gqw9PNKHvilIkOnkopM2Ikt0UB30s5abl9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961579;
	h=Received:DKIM-Signature:Received:From:Date:Subject:To:Cc:Message-Id:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=POG4N7NZx0xTfkdaPV48K+5iER2B3mTTIQQu0p3MJIs=;
	b=psj11cDj0cRHuyQdBvhaSs7dRWqlLJtgcUKVjpOdgfkfmVadYf8w7lsIS10u6uL/pdra
	 U8+5MLDER+7XrAKMI9fIbGns34ZplLLFWm/wNoil9fUWp6LBZCWTXLf0Lu1h/vDh089nJ
	 gTGXNPzl9HyH+J1HzZifbE7XIGLrxHNWWmExRC2xWQaGv73I9fDxNXUlCn6Iy6mhL4NHb
	 YTRliNLNEZ8lNIqQo51QG5Ajc3UQZ4MuMhRRHgm5sONX3HM1PPQeP86IUtnc6GYBNs17N
	 GKm7T61vxKwn7d4jDlx6dLYVu04h9YyUatTUe9Ava056tb2uN63Orqk/w8bRXmMXg6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqjxlCxp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD2606A33B;
	Wed, 18 Nov 2026 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqjxlCxp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794961579;
	b=kXFO0wwDX4IlPs+9/E/DY5GoYBWboLbsvClxEmq8QgJu0s3ppCIFe1LCMZda0ujpiJgo
	 p1Gkm5cSw+wjUBO+l901WB7s0y+bnIZhE6PL7VSQcSyfePrE9K7+9hRsAYdSx38je73qY
	 OphZlddEJQfgqBLnCEK6DdHqEPiEKmRrD3KkAfp/2Gki8Jd8PcPGWMNNkvODSYTPU9GsJ
	 TocrvahpwMh1aDCYWinQqUCNAL36ZLV35Nms9oTBIjvw/dKeviNQmknuz+R3+PuSNETiQ
	 gevZBRMVaYf9crXQl81uzQck2A90WuJKvO+FmXWKrgc+T6OR6IjwNfdH8y+YEHVCG+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794961579;
	h=DKIM-Signature:Received:From:Date:Subject:To:Cc:Message-Id:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=POG4N7NZx0xTfkdaPV48K+5iER2B3mTTIQQu0p3MJIs=;
	b=Ys0k8b1CYTk5xnb4/dybBmAXNeHO/H/Enb5TMYaDY8pUk4Wlc2wVjJNTPIXDFVEVA8wQ
	 Htoxg7NgCoL09TpBcG8jbnqsFos7zmBa7rfHn/zkoX9I3DbolcrTogcLgAv1h983g7OS9
	 OxnNABYMUZmOIx1HTOHz9uYi7x+odgPATKSRVpPUBRM78QO6bhGBvl+sXMv130a5Z35f7
	 1Uag9ymNOvEi7ZLfU/iByLB3i/ybH0U1M0fZ8VOy5Nk+6/igPs/Ny6mPBZq0acyrzUnXK
	 o3WtFAWmnQ7ZO3odnwEyW6GiIWlucCDr0EfE7Bx2zA53BDcDtsXgLfUpynVf/JtkbQA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 374DC1F000C4;
	Wed, 18 Nov 2026 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961579;
	bh=POG4N7NZx0xTfkdaPV48K+5iER2B3mTTIQQu0p3MJIs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=oqjxlCxpyooAK82M6CuoOH2yyI0rdiX8aY+BHgvES9ob6462P6mDmeQCZ72gA0UNI
	 L0veyU3zrrQnihHPEvJBCJNqDhRTogBg4l1/fRAODI2GYWtkmbcEUQabwkNyueUjT0
	 9gIyb4Es/wK3U7uGfijm/7Lw3X9KCPNe4GSVRR8lo2so1OD9arkZdqNn8D3spW20ae
	 5NNCobvQ9+gF2vBmFZElFQqM7+V0T21FDQMtrfThbnewZfEM0bV8dPx3ekB/DRF97S
	 PaNjKrr+f1bgHimSwD+Sl+R4PMSX2fIRytcYUDtmiTPHaRAJd2W5ypiHCwW62tuk6H
	 DB7C445Of2MlQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B70014AB76;
	Wed, 18 Nov 2026 00:26:17 +0000 (UTC)
From: Matthew Salsamendi via B4 Relay <devnull+matthewsalsamendi.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 16:26:17 -0800
Subject: [PATCH v2 0/2] fs/proc: fix PAGEMAP_SCAN walk_end after a buffer
 refill
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Chris Down <chris@chrisdown.name>, Vlastimil Babka <vbabka@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, matthewsalsamendi@gmail.com, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 linux-fsdevel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 linux-kselftest@vger.kernel.org
Message-Id: <20261118-pagemap-walk-end-v2-0-94cd92d838b3@gmail.com>
X-Mailer: b4 0.16.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794961577; l=815;
 i=matthewsalsamendi@gmail.com; s=b4-kernel-20261117;
 h=from:subject:message-id;
 bh=oowHUtsthVeLQJxBrgRcG222FtO1F1EoKnj3be3MVlU=;
 b=vOdiQvji9DzMpw5/AWv0JtWMBH9LLUYwG0GKe+mhCGAYOG5BguFAO8nhkwu3xBM9Ewb4x3hvD
 qvAWl7sQ2c9A1VbcbIQHPqoqxRFnVe+7OeJICM2ig8hE1sLI2iczHR2
X-Developer-Key: i=matthewsalsamendi@gmail.com; a=ed25519;
 pk=K4Lg4pTU46IL2CPz2Nb/u30nsnWJ38MlR2/Co4n0tto=
X-Endpoint-Received: by B4 Relay for
 matthewsalsamendi@gmail.com/b4-kernel-20261117 with auth_id=1555
X-Original-From: Matthew Salsamendi <matthewsalsamendi@gmail.com>
Reply-To: matthewsalsamendi@gmail.com

Hey all,

Thanks for the feedback. I agree with the proposed change to the patch.
Apologies for the delayed reply.

You'll find the updated patch and the requested selftest below.

On x86-64, the refill test fails on the unpatched kernel and the
HugeTLB retry test fails on v1. All 121 tests pass on v2.

Matt

v1: https://lore.kernel.org/linux-mm/CAMPWk9NE_epOdOCbs1PGh8OQP4wjTObvjU-1Wopmu7SSNAMXhw@mail.gmail.com/

Matthew Salsamendi (2):
  fs/proc/task_mmu: reset walk_end before each pagemap walk
  selftests/mm: cover PAGEMAP_SCAN refill and HugeTLB retry

 fs/proc/task_mmu.c                         |  1 +
 tools/testing/selftests/mm/pagemap_ioctl.c | 61 +++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CF3E51F4;
	Thu, 13 Aug 2026 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623530; cv=none; b=SBXPs+ES7rIRyArqWCV0zse1/BglheQPFi/kQR0yuSJTd9VgEW63i10285q6nsTpbzs1RsitEcnD9RdpkaFgpWbQUvzwWmP/n/z7N/ibv3r51T6l7Wuiyt0iRplN08LMCmk4qmbirZ77HntkWfhlEQRSvRu0CJ09tI9na3kTM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623530; c=relaxed/simple;
	bh=D5sh1ZrCd0hPEkiCqVMezIB3PdvCVR/dhJ2i/eaqwyo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KnRoBQxFmtJ/vG/r8VR5cQRTMCKfD33TI8w4DIZTtKPr9uOA4CwUMQhCJG7l851lGNHbpcjS/YGhwEUh9D9d5Nde1+v72fuM1yQPI3CvP8CYV5opA+DaqDHBoxKDtnFZI5Wg6v9UlnyX5OHsraGmTg6T06/InIoBlkkNsfBIgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEs2I4+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEs2I4+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71520C19425;
	Thu, 13 Aug 2026 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786623530;
	bh=D5sh1ZrCd0hPEkiCqVMezIB3PdvCVR/dhJ2i/eaqwyo=;
	h=From:Subject:Date:To:Cc:From;
	b=JEs2I4+ZY+cmQWtgDn89XMY+xVrM856WY5S0OIeEr36hTRWGQAF8A5A97fop4cojt
	 rfewltmxIRkwVCeB2W7G8IF3mVFGYlVDsXLA7XLjXPbZaOP6qiA1MxKO+Sq8oi0gtM
	 TQJT9fDyS8nSz+16WGJEeQhYUx8mueuLBNckBz0RozanioqjsKVq1hP+RwX+jFWzmW
	 AUP8F61mNUfzxh+TVGWLQL26lhvfXYYKrJZyYVOQYXyMeNHwOB+SqRPpNFuMJafDQQ
	 fSK/wD1stJy83oIKgxpSylM0z3YD81pYSHtkyN5ymBXIY3Rj0/SgWTtKkuXXi4ZFju
	 /lv2wkvnajSXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD8FC5CFEB;
	Thu, 13 Aug 2026 12:18:50 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/4] sysctl: Disallow partial updates of miss-formatted
 sysctl vectors
Date: Thu, 13 Aug 2026 14:18:36 +0200
Message-Id: <20260813-lklm-partial_ctlvec-v1-0-df9e51c13704@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABy2fWoC/x3MTQqAIBBA4avIrBOsqKSrRIQ/Uw1ZiUYE4d2Tl
 t/ivRciBsIIPXsh4E2RziOjLBiYVR0LcrLZUImqFbKsudvczr0KFyk3mcvdaLi2Urad7oRtDOT
 SB5zp+a/DmNIH/EmjWmUAAAA=
X-Change-ID: 20260813-lklm-partial_ctlvec-bd8867b70d5c
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-mm@kvack.org
Cc: Jianlin Shi <shijianlin11@foxmail.com>, akpm@linux-foundation.org, 
 vbabka@kernel.org, hannes@cmpxchg.org, surenb@google.com, mhocko@suse.com, 
 jackmanb@google.com, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=D5sh1ZrCd0hPEkiCqVMezIB3PdvCVR/dhJ2i/eaqwyo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGp9tiYkyITKihVvtdZSvziyOBWU4rrAKyjLo
 7jVUN8XrP5xcokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqfbYmAAoJELqXzVK3
 lkFPEKQL/3p1GXmI3YjeYKDHQGH/Ku2m6Y8f5aS/ro+V1BnPyrtE1xVVz7A05MULY+5AzoACOvQ
 YKkqXp2+tbVETWOVv+DcyYbx0SjSasHEYz5lpVdJgG7dh0sPgt3hDTXU7z96LHdyPyzR+XJ9dZv
 rAS6Fe4UruLvBC/tPgZDsMesTcBYFYyJYzz5LrhIJ3F1dNvSGzkWFGq5UEelLvzZqY0sCQ5M5fj
 zv8jbjskCi8TqpkYj9TeVvtI1BiR7e72H5Goo/V51fTYKX7rNIg8Nbo6e4M0Qf0vIV1MMWUG8fy
 XTDp7QeroSVp5Pommp9R8tFCrae+ZwUqqQ75Elf/x2YH0cv6lcqJd9yvVDCKXGjywuOQuBD4xM4
 n1YfoQuT5dhRxpFznN5mwB/uwyZeOt7FvJEg7rCULKBWk46AUL1yw2JG6fkbrKlrCdcrCBqecov
 zMwhEJ5DMzEhF9ANzTyHuU51ahqEenLL1QY84uoHxrQrsqNN5+T+mS9/UCRBHQsCX1WRbjFvkO+
 OM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

What?
=====

Stage table->data when writing INT & ULONG ctl_tables. Commit staged
data to kernel variable only when all the conversions have succeeded.
This is applicable only to variables that represent a vector; paths
pertaining to scalers are left unchanged. Notice that partial updates
can still happen if less than the size of the vector are passed and
correctly formatted.

This is the behavior we are protecting against:

  # echo "4 4 1 7" > /proc/sys/kernel/printk
  # echo "1 x" > /proc/sys/kernel/printk
  -bash: echo: write error: Invalid argument
  # cat /proc/sys/kernel/printk
  1 4 1 7    <- the write failed, the first element changed anyway

Why?
====
Allowing a partial change to a vector after returning from an erroneous
proc_handler is just plain wrong. This should be handled within sysctl
to avoid users having to do it for themselves [1]. 

Behavioral Changes
==================
1. A failed write will not update the vector
2. Vector writes can now fail with -ENOMEM

Testing
=======
This went through regular sysctl kunit and self test. Also is posted to
0-day.

I always find it difficult to know who wants to receive this. Please let
me know if you want to be removed from the Cc/To.

Best

[1] https://lore.kernel.org/all/tencent_A860C873956A52E26AD8D309A308A241BA08@qq.com/

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (4):
      sysctl: Split data conversion and file position handling
      sysctl: Reject uint arrays before calling the general proc_vec
      sysctl: Disallow partial updates for erroneous sysctl vectors
      sysctl: Add 0013 to test partially updated vectors

 kernel/sysctl.c                          | 228 ++++++++++++++++++++-----------
 tools/testing/selftests/sysctl/sysctl.sh |  57 ++++++++
 2 files changed, 205 insertions(+), 80 deletions(-)
---
base-commit: 4c12287001da60f3c022bb25932aa7a5590fc0b1
change-id: 20260813-lklm-partial_ctlvec-bd8867b70d5c

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



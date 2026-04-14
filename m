Received: from smtpout.sipearl.com (smtpout.sipearl.com [178.170.11.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CEA3ECBE2;
	Tue, 14 Apr 2026 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.170.11.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776182091; cv=none; b=RE+rb1ysNk7RptNzgokMDPrEs2QmvqiQ66FvSwMMJEbwk4c+YHY9EvD6P2w241No6RE9zXvGDYjRNmKtJCvPYZqNNBcMF+b3SR00U2ysEzUeBxv9PTUKZTPlU7bfTYzBjByOAiTUgGeLnbKOmeAaBOm2gVOrLySKLxbX43skIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776182091; c=relaxed/simple;
	bh=hBpEZsMGJbbcwkIsdPscSBfh1J1HrVfRbu1Orufbujg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzhl7bfKwNk9yVf9lfTN9ChFUr4QQohYMhu/yjPaJH1ILUP8ZU50Ylj7V7Yc+fKUf8SaQr1ownmbwRhYI/k87A6PyKtdyzxRW1YMzBGEghBBIV2IUqI+VxViTEWeRr9ht+7qcEASQFj+njoCkLJKj/xBeRgXVbg/t6j+1/bvL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com; spf=pass smtp.mailfrom=sipearl.com; dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b=HKOBHOjN; arc=none smtp.client-ip=178.170.11.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipearl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipearl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipearl.com header.i=@sipearl.com header.b="HKOBHOjN"
Received: from smtpout.sipearl.com ([172.31.29.1])
	by smtpin.sipearl.com  with ESMTPS id 63EFdPLt001588-63EFdPLv001588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Apr 2026 17:39:26 +0200
Received: from dc2pvlnosz002.pub.int.sipearl.com (172.31.65.18) by
 dc2pvwexcz001.sipearl.corp (172.31.29.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Tue, 14 Apr 2026 17:39:16 +0200
From: Herve Vico <herve.vico@sipearl.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: Herve Vico <herve.vico@sipearl.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH] docs: proc.rst: update description of VmallocUsed and VmallocChunk
Date: Tue, 14 Apr 2026 17:38:44 +0200
Message-ID: <20260414153845.3480832-1-herve.vico@sipearl.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dc2pvwexcz002.sipearl.corp (172.31.29.2) To
 dc2pvwexcz001.sipearl.corp (172.31.29.1)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFo8JVpcWFhZW1xcSFpaSAANGh4NRh4BCwcoGwEYDQkaBEYLBwVIWUhZXEgLBxoKDRwoBB8GRgYNHEhYSFpIWVlIWV9aRltZRlpRRllIUEhYSFhIW0hYSFhIWEhZXEgLBxoKDRwoBB8GRgYNHEhYSFpdSAQBBh0QRQwHCygeDw0aRgMNGgYNBEYHGg9IWEhaXUgbAwAJBigEAQYdEA4HHQYMCRwBBwZGBxoPSFg=
X-FEAS-Client-IP: 172.31.29.1
X-FE-Policy-ID: 2:2:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=sipearl.com; s=sipearl2024; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=9HwEGJjZ2iPAPucAAohyFG4xYSQ6h/xnr+F/xbaR3Qg=;
 b=HKOBHOjNAqY4p2EUY0DZqJUR9QYh3bLyajZUE4tHR7sIBMrqzaZcBuTMTuNM+BRLuFVWrmri2Xuc
	yiUPE21OQTQSMWnBlimqAWEHndZvgeckV5xdpFW1frpxR0wAFlAqoqfBx8/DAUnGJS2uPw8iRCvu
	SAWQwEkfWgkBU/PEQJjmWQYWz44iigY2+1SyhFAKsRmkrGvX28/kSFxCYpw/WVTYmVngawEUAun+
	LNtbD/6zDY1FIvSDxK0WjE5P+cLkSIKjgGa3tAH6q1Q/Gtv6kZcwMpQFYBQ7NSwGM+RAif1pdv4o
	vFdSLqr9KZIvzcr+QFtOShDuc0+A9TJc/xwFvw==

A long time ago the behavior of two /proc/meminfo Vmalloc<...> counters
has been modified twice without updating the doc:

- v4.4 removes the expensive 'vmalloc_info' bookkeeping behind VmallocUsed
  and VmallocChunk, and makes both counters return zero:

  commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from /proc/meminfo")

-  v5.3 reintroduces VmallocUsed, making it now report the physical memory
  allocated by vmalloc() calls rather than the vmalloc VA space:

  commit 97105f0ab7b8 ("mm: vmalloc: show number of vmalloc pages in
                        /proc/meminfo")

Let's update the doc to reflect the current behavior.

Signed-off-by: Herve Vico <herve.vico@sipearl.com>
---
 Documentation/filesystems/proc.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index b0c0d1b45b99..4a36ac960417 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1233,9 +1233,12 @@ Committed_AS
 VmallocTotal
               total size of vmalloc virtual address space
 VmallocUsed
-              amount of vmalloc area which is used
+              Amount of memory allocated by vmalloc() calls.
+              Note that VmallocTotal is a constant that refers to the size of
+              the vmalloc VA space, while VmallocUsed reports the amount of
+              memory allocated by vmalloc() calls.
 VmallocChunk
-              largest contiguous block of vmalloc area which is free
+              Deprecated, hardcoded to zero.
 Percpu
               Memory allocated to the percpu allocator used to back percpu
               allocations. This stat excludes the cost of metadata.

base-commit: d60bc140158342716e13ff0f8aa65642f43ba053
-- 
2.51.2


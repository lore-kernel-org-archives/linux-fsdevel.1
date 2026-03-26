Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA24369A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561944; cv=none; b=BtP5CDQ/NlS8jURckkLkFS9KD7EV8tV2XtQW6cmekhrAiq3RDmZJDUYOp7CDlz47n4gAu2DZ6aWQD2FezmzSCYeD/O9egv9Vm6FXqplb7M8Ah3TeKLzCG4Gc9v0JMAiyXxQ3fvhwDuhLQJTdoaXeGvp+teIxMC0n1qCLreRyspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561944; c=relaxed/simple;
	bh=8YKtESUd+ry1eh089CjiE/+moKUw2jEdMOsu4snisSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sWRWKo74Kgpqlr8uFH452EzwsIki5knF+9xLjXOc0fuE3Vwq2ssGoySC830Supbh5EeMhtP0G+aoeQbSveILzqJ/JsnBu99Zz1Gvoz2T6U2gEy+CutkZ4md6PxUocucJhKZFDtV/Ycv7cPCYe16xoY9vuyHbGuUBMYLClkZYDD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM9TAKSM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM9TAKSM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so13623425ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774561943; x=1775166743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V4oyKzz4b3EA663wVmmHFHX4Wwoa7eaLceNghywXPWg=;
        b=QM9TAKSMmIRSSIzRcVJChmR7IytCoz/t2q+HK3akC1phmfgVV5Em6QkVYIjNDreC2w
         bCeOYVFK/7VOK2PTIttmBa4MZuru/89soLyj7wjM2JycrpzbL6DHzbjJQO0ok0sQVx7c
         qutYnkPd1l6EaS4W6HqxRjS9w7FpIH2kqpo082gXg1+Zh2XhFSAOWrGXY3ynkmoTaWjV
         BLlq44a7wmk3CnEG+6oQG5ASgwYuUAFQ2NSViSLccYMAOpFBKAZUwjofOml4l5IMtV5H
         th0UMkSEDF5/2sYEoRrxKkS06sVPZSbofgZUWujUW8EymPnjwwNgHO+7Ocm3zgRMUZIh
         I4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774561943; x=1775166743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4oyKzz4b3EA663wVmmHFHX4Wwoa7eaLceNghywXPWg=;
        b=ssfVV5krAYPbuKs2KxPGOK7F/PU7/ZzSAeyLtFBN0IoOc1T+TxYF+lKX8Jdmou35xk
         sszEwYC7/EOoZqqRp5lrMpifikWEW90HWlo557OfuiWJoNAnjxwumZLJwIcBI4n0HyjX
         kIf4MD0ucQ99misMxWA7KgIdLbSco2iz+a/EL9k6I8MXsrXPxgJSI6rzgqAvL3SZ595s
         P4tW3vAWNbzY0vke3+earnngijBsiMPEY0Um5if7j6cCGzCu67V6xaB4Jg9pumNK191O
         StJdL1GZfKksfCmgEVpBynxpPM9wKvs5omu/h1wRnQcd+QxYKzt55crzMynvRrvG6NKs
         KGVw==
X-Forwarded-Encrypted: i=1; AJvYcCX5dZIvaMDjrjej21rrdqm1x0hHRIJBieZjoAiksPIqJGPHBmX+5JPr4YA4fI1Zaaw7p48HsR/0gias4Vns@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6+EEgD840Ok6pK3mUOzHRO304RDXpFALpPFLWsfjHCrLP/g7
	1Y/4DBvz/wf9YFPuTVd5hRR1rT0DU6qubr8Cvaa6cuZV0KHupYJLb0TJ
X-Gm-Gg: ATEYQzy/wNNo2fI/qYVB8stwpeHmzxvC5nFMjl5ecXH1wEAElMENnxvApF9CEYNQMB+
	k+HHUdcjcVm6B3dtUd6a8uigEiNWj6u9oigrDqpCZCflOg9ZqzfYEclsRUY1MukPSGgbZu48HoF
	EU5BqwVCWXz6I/OSoz03Kzzn13da25sUQvxC7aEKJr1P8UKlWbcdaLINxahekdJx+XuC/kEp3FZ
	aXCbdWHZQtw/2SZ/SPiS45+3bTkvluThPcoGjeJEkJYHJHlRDtIg7rF3cLggbiO8uxdHZIjpqO4
	GAI26I/saaorzIFF3MCoeq7JbfKaTlbfWqAkr6Gf8QPS75BAfqjWiyBZSUoKGdX3s8NKmjaVCC/
	45d2Foa0aUl5E6rrEcl04qrLk9lS6Zq/AJbiZQtLCk3PHdnxCIvyevNyrnoHK3BmOARxuUToAmn
	1386zAPUydB0CU6UxAd1e5bhbGxvdD
X-Received: by 2002:a17:903:943:b0:2b0:b258:2a57 with SMTP id d9443c01a7336-2b0c4945e09mr29417405ad.27.1774561942665;
        Thu, 26 Mar 2026 14:52:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8b5dcbsm38904565ad.57.2026.03.26.14.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 14:52:22 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: jack@suse.cz,
	hch@infradead.org,
	hannes@cmpxchg.org,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/1] mm: reinstate unconditional writeback start in balance_dirty_pages()
Date: Thu, 26 Mar 2026 14:51:26 -0700
Message-ID: <20260326215127.3857682-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
--------
v1: https://lore.kernel.org/linux-fsdevel/20260326001337.828947-1-joannelkoong@gmail.com/
v1 -> v2:
* fix it by bringing back the removed logic instead of the strictlimit wb
  check (Jan and Christoph)

Joanne Koong (1):
  mm: reinstate unconditional writeback start in balance_dirty_pages()

 mm/page-writeback.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.52.0


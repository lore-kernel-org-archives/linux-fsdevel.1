Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677654;
	b=4ZMY3ChbcfimqN2il9iF42twhEiTaWq9JcLFUUa0kZlvIwFyiBd2ATLqXTHrUH5azuLN
	 NNUf3Ik50ihCz4aGNRQLNKym+yz2P6Dt6YgMJHiLPj+bEAcWNEYt17paGaWlRPy+Z36CL
	 FkO2e3sX6z9H1atzPO3iEwcRCWhOONqEL7LXYjfnZSbk8TpNFVUwMFjkHwWlV40IdBurU
	 nUgEE+pFtTG1NndmPiD3DS88/bKUmJp8RWZB54tEmdGSH2J1Ukx9DI5lmlEcteQxcl3XB
	 +vz/+iHDHHrQN13uQUbsWA1cgyskA4UvBybgFNpZGGtUdDCpgEDwO6BrOeQM000qyPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5nTTF7dA0IAOUfaSQMNPTIUPCOpXWwbqh0S96Be5ADE=;
	b=AXHAGpVMJ+2qOfiGlcXqM+hdoM0i5TI+YAalM0tA8JABJzKujnh7khZKlyg262pswj32
	 mN+9Ptuz0GjBLvtGsWFzC3EcIyogkvgm9lUGf//soIDpPOw3KfHQ2O1mkFz8xj9cvQrng
	 OqW8E6fRg2xapC6e4v4s8qMeJg6sy+JPJNwvBoCFjkiRw7nygLiiKfPnMEGbMolHeUF6n
	 r9H+oqjGDObcMeypXTuYNWA87hqU593VBwTyImM8DiQr2nbpvh9iyfjprluyVNb9exD2R
	 KVyUJ0F9/XoPiKk4HMHXB1l5UHZBdY5SHyBp7KBZyA5RMGXuhEuFm5JbxpUR7uZ3Pvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n5r4vf3B;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF82606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 14:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF82606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n5r4vf3B
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35c76e9614aso3227175eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792677653; x=1793282453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nTTF7dA0IAOUfaSQMNPTIUPCOpXWwbqh0S96Be5ADE=;
        b=n5r4vf3Br2FEj4nvbE04yCzR6V1e1+bf9RvbCud/o0q1uAHYLQ5vEAyEcJCtj2RUBr
         +kAulUTU7H5ccJmRvmN67OMintaANL9jFFXlHuCeqm0d1+7br+kOi9lATIIbtb+W66oA
         NPDjYJh3aeeaGzSwLUYot9e/YFgY1XoyAK+V/zK4GqvVWjAEFWW0Uy4Fr3wuNaC1HCbz
         ltAFgW/IzHhzDXXLUCKT1WqVyXMV24hyyGBq3oY3EdcY/nD1PcsOiv3LMrRmA+3xPgT8
         8l7TAmccowAAT2YJjw5AImxSbtTzTN8nXFYQu0l2tGZkPLdPEQNxHoK95Q3yzQQhAmyY
         yRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677653; x=1793282453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5nTTF7dA0IAOUfaSQMNPTIUPCOpXWwbqh0S96Be5ADE=;
        b=18jZ/RLhsTdSPac/Fm5Ovt7Oiz9/hFTZ0dmsYvUJtsHQjZ5cmDJ79abzqQcCUNFQXV
         tl+RDzho1tKFTc81DQhjXutybd4xouqftcxawcXE4i/X9a1kQQb4K9SgaKxqnUlmBORa
         PGRm5v91G/6hJKmj5EDDBv1tqZDLv2imCECDxLuAKWvm5mNMfQHSamjibkCP3ojCciA3
         6Qa64/nQkrCaBDBqhamNe7YMgvYQoOv3frTMtnrcny39DVRpXx3JxHen9OEcqW/SZn5g
         2OhsB9Kp9kk9BeR4IN/4VvBGV1IC7gJcrZsxKYoMeBZqn5TyQ96Vq0wKjO6CtXIwmxvf
         Qmcg==
X-Forwarded-Encrypted: i=1; AKwUvBw1C0vJu5S+K0a6pMttb+3lO6dI55Uq3Iz5UCCq7iglWbclymxHOcpAE8fnS2tlF3XIzTntlwbpPK7P/a7U@vger.kernel.org
X-Gm-Message-State: AFq9FYJKsBUZDOOxS/Xhg/rhpLNhVXNvbjImpE6FedEPtWyBfRtR3KbQ
	5fE8Wqc5eWlH7V4nDIwF6Dtk4j9dZcfdQIZo2D/fzaNoP6fHnrkgzpZERHm6E+Gs
X-Gm-Gg: AYBFou11RErcmldVF54IxuDu9zyEEobdEqaJp2dEDzs0v+nKvpYjFoi5HzNtD6M7GRK
	/aZtVlyWMk8EqFwOINFyqTbZEme5zyj8vFCUSxSHv+IyfwdQiSnBUvKl9M+2yAWwGnjKQ7H6oG4
	AFuMY1hs+L38RrX4en/h/pC0byPMlvEjRQhuugoHo9hFmYK5tjaSUaXvzRbNRKvAapDE780Qy86
	xUP2EO3aOZGWGuAxD63Y6yhnZImh2PBY3CzvKVlSaRYKb4We+b6wWJkhZTkq7eYhCd9ZAnZg7Dd
	2EFU6UH5ke/DUzuSSDpO7cKch3l5un3DKFGfc/a9BZXoxJE4ewlZfCzYRI8GeaJ2HfgNlNISWkC
	UbCQxTz/FJBTtd8YaZalefCK781h3+EVYRzVU8LcHrt82/bJLuu4Glb7b26VIfNT0Imt8Hk6y8A
	wz0i2IL5kv0RCrgb6swqw2B8hAOp2ecsafQiKgI4UuhdfIcpMwb0Hij8ByPw3RtqyxobOF9CSiy
	0N1n9teY9wpumUwVlVZ6N2aYVsUV7wPY/2TZ4e8WspsPzRmncavmoN5Ii3LB1M7Wn1ZpHk2
X-Received: by 2002:a05:693c:41c9:10b0:35f:ef9e:f846 with SMTP id 5a478bee46e88-3674b531987mr7142175eec.3.1792677652558;
        Thu, 22 Oct 2026 07:00:52 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm29420342eec.2.2026.10.22.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:00:52 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 22 Oct 2026 22:00:37 +0800
Subject: [PATCH 2/2] mm/filemap: extend VM_SEQ_READ readahead below
 descending faults
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
Message-Id: <20261022-bug-mm-mmap-readahead-descending-v1-2-6d08b34862f2@gmail.com>
References: <20261022-bug-mm-mmap-readahead-descending-v1-0-6d08b34862f2@gmail.com>
In-Reply-To: <20261022-bug-mm-mmap-readahead-descending-v1-0-6d08b34862f2@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

On a VM_SEQ_READ mapping, a synchronous fault reads ahead from the
faulting page towards higher offsets through page_cache_sync_ra().

A reader that moves towards lower offsets, such as memmove() copying
backwards out of a mapping, finds the pages above the fault already
cached, so each of its faults reads a single new page.
page_cache_sync_ra() also looks for a stream only below the fault and
takes it for a small random read.

When the page above the fault is already cached, read the window of
ra_pages that ends at the faulting page instead, without a readahead
mark.

Reading one byte from each page of a 2 GiB file, last page first, in a
MADV_SEQUENTIAL mapping with a cold page cache, read_ahead_kb 8192:

                   before       after
  time            50.28 s      0.76 s
  major faults     524291         260

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 mm/filemap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8a7d1238ae75d..62d507f96f22b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3384,7 +3384,19 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 		if (vm_flags & VM_SEQ_READ) {
 			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-			page_cache_sync_ra(&ractl, ra->ra_pages);
+			if (!filemap_descending(mapping, vmf->pgoff, 1)) {
+				page_cache_sync_ra(&ractl, ra->ra_pages);
+				return fpin;
+			}
+			/* Read the window that ends at the faulting page */
+			ra->start = vmf->pgoff + 1 -
+				    min_t(unsigned long, ra->ra_pages,
+					  vmf->pgoff + 1);
+			ra->size = vmf->pgoff + 1 - ra->start;
+			ra->async_size = 0;
+			ra->order = 0;
+			ractl._index = ra->start;
+			page_cache_ra_order(&ractl, ra);
 			return fpin;
 		}
 	}

-- 
2.43.0


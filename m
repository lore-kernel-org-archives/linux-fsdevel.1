Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215732;
	b=Ee8l1yCODy/FlExoizVq9J40fUvywPzlITclwv0Jli6FOz3pWwhwBnt9/x1F2fMyIdI5
	 uSpJpmPCWmhe13wz6Z9XGtdC34W8i+Ohs5D6DCKr7nYcvEeJn+kW6yX0WgDQLPA8l4VDj
	 mJeE2u7NxtH2Na6m5yfCxXqogypbAAIbWvA3fGnE5rgqc8AkMmFjtg61NKGw4IDCqbHET
	 od1yWMMtKnUCraTYlM8wE8YKhfQzClyQPWVCllT2bOZYubOv84BICt3MyK50GQXHSWfE2
	 lXU0hTEVSfQ+4jRngH480AGimb/VRJhHOs9ltx7X3euCHpRLTiJB/UpkfJ8UWLwjEjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nAZcXDlQZddbY3M/muInvcNY1JTv1MgI/C6goEt1No4=;
	b=fErj76YJYh/TnFW7KJXzUxVlvT+0legNLlDqtLX7g1D4u7xsgZaoTjYt+cT6qzyjd43k
	 wLFX1pNQML1v7xUZ94e87Q9l7W2xG0MR33vECfnhqyPB/UKRJWcs5rF6xV4vEYkqtXCV4
	 X5kPPChbUp9ZsBoYgMn1ivIPPUETs28rn3d4piT7S7C0wsl2czytsJoKAOWhppgijg4+M
	 Ei90Oz4kcyB3e5xkedpGSdarhyGrV661dDoZpRJzz9ZBaNcbyub6UzfjR5jYIX0ZVcVmF
	 WAbZvexl6vzteyoJslaE5wzUY7oFvRFqHaecbIEzzg6Y2wo9oUboqz73hjLWxsbegXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EumOcsGU;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F83606D832
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 09:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F83606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EumOcsGU
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so740805c88.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 01:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794215731; x=1794820531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAZcXDlQZddbY3M/muInvcNY1JTv1MgI/C6goEt1No4=;
        b=EumOcsGUVgvV6f4EIH+ss1Yo0OuOX2Lpnk3VvwxNMWYoLWsAbpCyFZAEUxaiJGfm+c
         34QwvxyCf+23hcUVfaIHJDmgVm0XoqZiNbgTZ5TUn/mLejXnDp1MO+SgBB66yCsEUVKu
         96+aPOeNGOaR0Nn/W7Xzr1BvqfFtScUfIhDfa0P673LMDBqZ84oLuk1jSwSeDSwPQ7D3
         NC/jq2knesGuifhSLeY7+1mEf335ndDq28JT8tcAcHVCjf7hXuBq/547XOl502ngw1Cs
         W/FXfsvSERSAIeHHrTGkDnsbbVywHUyVCTv+57PhzoRpgj4x6/vHXC7xMJFkK5ROj0HX
         xQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215731; x=1794820531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAZcXDlQZddbY3M/muInvcNY1JTv1MgI/C6goEt1No4=;
        b=CbI0xQdazv2irtYV+6cqzEL+eOjeHFgfs5hXqvTDgUaWMslwQ0ewXD8XUYNJoZ4wPm
         hS5x08O921oW+Ara1qDe5p4azwgHD4RjNUtEj0twy2De92WNx8TYC93aRWro1eEYo0Kn
         WIYPeYy+1BJ/jZbPluO/rWef+9iCMju4I/JynN3fMwTLEuzRh1Oxn5UNc5KeoE1O3fei
         ktLdKRQDVQDTJB4mU1qv6VZjIZjSMKjDw7CnFvQ+Ii1nwf5mMqC3KjxWIcbsh60gQDMS
         6FvH6wOuvgxLn+v850PzP/Q1FkyK020ASSiptY29Xk9udkuHLSRCIrjR7S6EVwJycArI
         +TvQ==
X-Forwarded-Encrypted: i=1; AL+hErFsNwxmFujoUEkG96evmusDnDA8iSn7mgqR1lunJ6zohmKHRVhUOx/TD3Af2BecbLYUtNUXUF6cZC7HLmGw@vger.kernel.org
X-Gm-Message-State: APuU4Z8jhS5Mhr6gISlUXkIkqfK23RJ+N3ZAwlbpIOxndjZUnsOfFeua
	gGk+4huPKupSXYmN2YROzyYk7YNM4Bwooj8NpnmpBy+T9NOI9B2ElrLh
X-Gm-Gg: AYBFou0tZ1ddb1FWS6xn9+weaTXvW54cuobLiYociSPMyULODi4SZyLqw60ErkGItoi
	N/Tsg5cCJyv29EzAhnmhJrUe3FBlmjuJZ/xv4eBcZS9qojBSIIGsXT6T2ynW44lbY0gaM/d6t7q
	dzSr4GM5Ka+XQlZVFvDh3QVuCjaFidjKhQFn3NrgMBrJvLIhyKWNIJsM1hfmilfTwV3ATs69YBZ
	xrOroEO1aNeC4jO0LAUZ6ZPZmhRc0PJ2LyhO10qgMyhbKohXoTVqB+8m7Mx7xQd3+Vqxx5W9xAS
	ks//2A7y4AAkCi77S4lY9jfO3XF2RP+ZidNSdlQSKHG8FgZfMiZxgQdaJT1tArkNOTfk1KcHSZL
	zmTUZaQHPcqTtaQxqCaHvFAeBiVoMb6vklqr+x9XENDhO/R5gPOyknAqhQ88pZZtnW9HGviBjES
	E5vRnAokMKD35RUCzKBNba02jU4xgWnEX49GZAxns1UanGdea7EfD683UBK/pMXb0cSKcNUYjC9
	3FDK1Ydlg7dMpxLgPwaqs7MkxJg/xT9wGTv3E01qJK2TbLvL12PbZukDar3SWkU1RWP4zkiXF0u
	17l8oXxWUchJwYz0vQIehDzQdWMyh8LLz6/R7OGDfmR31alChlUr1eA5n+QBaOgIrQ==
X-Received: by 2002:a05:7022:e803:b0:1ad:4ef5:ffed with SMTP id a92af1059eb24-1b39fefb9e8mr5783381c88.38.1794215730818;
        Mon, 09 Nov 2026 01:15:30 -0800 (PST)
Received: from LAPTOP-KD1TH5BD.tail375eb4.ts.net ([47.11.106.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375604109sm14379505c88.10.2026.11.09.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:15:30 -0800 (PST)
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	fujunjie1@qq.com,
	vishal.moola@gmail.com,
	roman.gushchin@linux.dev,
	Trace <tracekotae@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/filemap: restart mmap readahead on sequential faults after many misses
Date: Mon,  9 Nov 2026 09:14:44 +0000
Message-ID: <20261109091444.128521-1-gopalmalaviya53@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105192517.228523-1-tracekotae@gmail.com>
References: <20261105192517.228523-1-tracekotae@gmail.com>
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

Since commit 9b0fcac3cfe7 ("mm/filemap: do not count FAULT_FLAG_TRIED
retries as mmap hits"), about a hundred sparse mmap faults push
mmap_miss over MMAP_LOTSAMISS and turn off mmap read-around, as
intended. But mmap_miss only comes down on hits on pages that
read-around brought in, and with read-around off there are none. A file
that is then read sequentially gets a synchronous single-page read for
every page until it is opened again.

When a miss above the limit is on the page right after the previous
miss, start readahead the way a sequential read() miss does, with
page_cache_sync_ra(), and keep mmap_miss at its cap so that hits on
that small first window do not bring back full read-around for random
access.

Tested in a KVM guest (x86_64, 2 vCPUs, 3 GiB) with ext4 on virtio-blk.
"base" is mm-hotfixes-unstable. "95b8e" is commit 95b8e432265f ("mm: use
zone lock guard in __offline_isolated_pages()"), the last one before the
series of 9b0fcac3cfe7. Commit 0b9c0aeba938 ("mm/filemap: count only the
faulting address as a mmap hit"), the first of that series, gives the
same results as 95b8e for the reproducer.

Reproducer from the report, read_ahead_kb 128, major faults:

                                         95b8e    base  patched
  sequential only                            1       1        1
  sparse pass, then sequential               1   16384        2
  sparse, MADV_SEQUENTIAL, sequential      512     512      512
  sparse, close and reopen, sequential       1       1        1

Touching 1% of the pages of a cold 20 GiB file, larger than memory,
MiB read from disk:

                       read_ahead_kb 128        read_ahead_kb 8192
                      95b8e  base patched     95b8e   base patched
  random               5656   215     215    344731   1032    1032
  stride 2053 pages    6545   216     216    419003    992     992
  random 2-page runs   2992   215     528    173093   1099    2248
  random 4-page runs   1570   216     594     86797   1266    2301

After the sparse pass, reading 32 regions of 2 MiB in turn takes 512
major faults per region on base and 2 with this patch.

Not tested: NFS, the GPU workload from the report, and other
architectures and page sizes.

An AI assistant (Claude) helped with the analysis and the approach, and
wrote the test programs and drafts of the comment and this changelog.
I reviewed, implemented, built and tested the change.

Fixes: 9b0fcac3cfe7 ("mm/filemap: do not count FAULT_FLAG_TRIED retries as mmap hits")
Reported-by: Trace <tracekotae@gmail.com>
Closes: https://lore.kernel.org/all/20261105192517.228523-1-tracekotae@gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>
---
Notes, not for the changelog:

- Keeping mmap_miss at its cap is the least obvious part. Without it,
  hits on each small window keep mmap_miss near the limit: random 4-page
  runs at read_ahead_kb 8192 read 25896 MiB instead of 2301. A cap of
  MMAP_LOTSAMISS * 2 gave the same results as the full cap in all tests,
  since each new run sets it again. The cost: a reader that jumps
  between sequential runs stays at 2 faults per region, where without
  the cap it is back to 1 after 16 regions.
- A full read-around on the adjacent miss instead of page_cache_sync_ra()
  also fixes the report, but random 2-page runs on a 2600 MiB file at
  read_ahead_kb 128 read 379 MiB instead of 76 (38 on base).
- At read_ahead_kb 8192, this guest's default, the reproducer shows 1
  fault for "sparse pass, then sequential" even on base: the 8 MiB
  windows reach the next sparse pages.
- Patched results matched within 1% over two runs (the 32-region test
  ran once). checkpatch is clean; mm/filemap.o builds without warnings
  with W=1 for x86_64 and i386.
- I can send the test programs if useful.

 mm/filemap.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 371a4bbd06..1548021472 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3398,9 +3398,27 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		/*
 		 * Do we miss much more than hit in this file? If so,
 		 * stop bothering with read-ahead. It will only hurt.
+		 *
+		 * But without read-around no hits are left to bring
+		 * mmap_miss down again, so a file that turns sequential
+		 * would stay without read-ahead. Remember where we missed,
+		 * and treat a miss on the next page like a sequential
+		 * read() miss: page_cache_sync_ra() starts with a small
+		 * window and only grows it while access stays sequential.
+		 * Keep mmap_miss at its limit, so that hits on that window
+		 * do not bring back full read-around for random access.
 		 */
-		if (mmap_miss > MMAP_LOTSAMISS)
+		if (mmap_miss > MMAP_LOTSAMISS) {
+			pgoff_t prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
+
+			ra->prev_pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
+			if (vmf->pgoff - prev_index != 1)
+				return fpin;
+			WRITE_ONCE(ra->mmap_miss, MMAP_LOTSAMISS * 10);
+			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+			page_cache_sync_ra(&ractl, 1);
 			return fpin;
+		}
 	}
 
 	if (force_thp_readahead) {

base-commit: 09f140d2cb078edfcd08a40a23ead0bdceea30a4
-- 
2.43.0


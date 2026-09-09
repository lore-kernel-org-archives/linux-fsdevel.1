Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56747DF99
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947496; cv=none; b=cN7ByfmXi4ms2mwsQ7dQwH9uLg8gYzW0YVgi8GbGg3xCq389qhbbvBiGXilgbRpn5P4mIpbig0Y2ZUhvbzH31wnMJN3DXxrccYDj2i+8w9XjwUZQy4ChVgngFx1W34e5pXWmgPwcJ0c0xW3C8AooWnxXE9Hyh0uvnNhCLH1LI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947496; c=relaxed/simple;
	bh=zEN3i+bht4wJK9nMYZ0X1V5lt+UAKAX+zLdvRlqVUhs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OYgvVnLVdXLGksBZRAifsZklMhPd0aSiu+ecF9YRBLqCdyKfMOaXsPO9zm77nYwoYXSHC9o3tSJ35sVH0ly/w6gytnuBdpzzGIofTi6CIj7dgD1BvPwm9IcJgvudalqrcrDSppOD3Rs2732epOfYMat4WTnJ7RIPg7jsI9fkRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGnX2DKj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGnX2DKj"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-861f30636f9so84714467b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788947494; x=1789552294; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mn+TRjSVVIAZoTaeIYbM//CzX6IvKNmptuaikzRYa5A=;
        b=kGnX2DKj5lnH5TOHANwvHWEMVwQIEp3f4GgGRZXADv0eNY2m2fw8q33D3/MO9JfAwT
         1ZcJZVgZQkSIDSzb6T5+E8sqTQg50xUC0+CCDRjDctfJAGKrlcSwy3UTnhB9Z4ENzo3x
         OPnvb4MBYE4UpXz6RCRFEQL/jktk64V0atEPf3rIwAcfpW9cTn0oThrLP9Y5xzRATvnx
         Mn0HTU8OPvLjn2OPvXDmGjOAJH7D//Mz7uj5WB9LCAYmppi0mer7j62U++HoqKCUsCgW
         SDECqbINvgOIRG6fubgzAGl3hGUrza5t3QDpB8YQpDTH1uuxa70krfzzYAD8aCv5vA4m
         4W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947494; x=1789552294;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mn+TRjSVVIAZoTaeIYbM//CzX6IvKNmptuaikzRYa5A=;
        b=M+T8Dcheh30Lx76GimD5eSuybIgpueMiNzJ0pQ5gsZFSOV1FFw/inv/I9gLNlDwtRC
         UVGIvXTpPupJETW0fHrAlwutX5/BTyPsD9imE99LouXf6mQ8qkA0P/MbW0XiGoFhsl4y
         YmEOIBByp9J5s9jzbsMNCQCXj6XdNe8iVvAFjQiuonGUtmvc9UpVKcKdCz3SyJvvPEz1
         JMJKwMOYi/9KBZd3LgqRgSnRrs2RAZsO/nUJT5iMnQgR2DrfsjS9/yh5SDmH++Q/Ybm9
         pxA7UJ3rtT0EDdsDDDQwWKSI6CFx+fo8112auhHWL8BccxZcXxkdTCXwwn27hayBpoqC
         2LdA==
X-Forwarded-Encrypted: i=1; AKwUvBzqYDsdqcL6l3FY2TXzJBR1W0wSap1QJR+D04Fc6fryhqvfzKbC6ItmavhK4ycqk89VnsLQBZgE3AmTM+f2@vger.kernel.org
X-Gm-Message-State: AFuF++kZ3ys0JgZQVuf4ug83BABX+mfWyJq3wXH1tX7R42tG8mFHlI9o
	cRwJVu097p5EUqd+uwxVMV2NI+/l1WftiQsO/RC3F0GrcPn6H/82rjJYtEOt3Lx5ww==
X-Gm-Gg: AYBFou3Ulgov+7g29TEnyDtbmoXTejfTYaEnRdKpnHFLYOH1834ltwt+4hAUSI4BWeI
	E1oPEGovJJWQYw0fXXiBRG/3w0KAMtguZNpJ7XjrvCEnjJTIluJXHdR5/5LWesCS5IhIE8/7taV
	1DuGZe+QLADz1DO+eyl+JxZgCCVJWOYgNEjShsJKzHbIpvgAPlZbwB2fEFH7mhIMt3N5wjNesZa
	8g2+ClLFwTdIhmhiwG3beT6L8chWKUsPN4jqEL63Ds2K3rK1DsOzfrfN5kYcsJ3kfIlS2Xc8bYk
	u91yRP6oR8gl5AUAnvkNYsdvEp3ggoYCuUmXwhaynCIKnNRVc6OcKagPZpJk2CHKv8JPuIS8Jhd
	AjjWBoBQ0s1Ps6gJ4gmIA55kPx4W33QzNNCeTdy8vyrG64pU5B2xCoq80dTZEXOxM8RAzqhy1tB
	rYfwWLPVTnc5T405gOvrSCva4NEfWE8y9OMrgSZ3qVw9xTwFGePKMxcQxqRRsrKykAnUpj+geKL
	zsNOUIZ+wwFbHkHL+pYRqH6jZtO7Rfn2HUHK4H6rXUpqc9ZcuWaS3nddv8=
X-Received: by 2002:a05:690e:b8d:b0:66f:c774:5b4 with SMTP id 956f58d0204a3-66fc77411b8mr7040210d50.78.1788947493066;
        Wed, 09 Sep 2026 02:51:33 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8749af79c56sm78820707b3.22.2026.09.09.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:51:32 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:51:27 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 05/26] mm/fbatch: lru_add_del_folio()+folio_add_lru()
 after clear_lru()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <b2e312f3-6909-5496-195f-ab71b45970ac@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Most callers of folio_test_clear_lru() then proceed to remove the folio
from its lru, and add it back at the end when they're done (if still in
use). But isolate_migratepages_block() and check_move_unevictable_pages()
sometimes decide against, and release immediately with a folio_set_lru().

Which usually works fine: but there's now a small chance that while they
held the folio with lru bit cleared, an lru_add fbatch drain came along,
and had to skip that folio because its lru bit was transiently cleared
(previously, the lru_add fbatch drain relied on finding lru bit never yet
set). This risks leaving that folio off lru, unreclaimable until freed.

Fix such cases by trying lru_add_del_folio() (which only takes action and
returns true if the folio was on an lru_add fbatch), then folio_add_lru()
if it succeeded: invalidating the old fbatch slot, appending in a new one.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/compaction.c | 13 +++++++++++--
 mm/vmscan.c     | 16 +++++++++-------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a049415512c6..9e045a90ba21 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1204,7 +1204,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				     !cc->alloc_contig)) {
 				low_pfn += folio_nr_pages(folio) - 1;
 				nr_scanned += folio_nr_pages(folio) - 1;
-				folio_set_lru(folio);
+				if (lru_add_del_folio(folio)) {
+					lruvec_unlock_irqrestore(locked, flags);
+					folio_add_lru(folio);
+					locked = NULL;
+				} else {
+					folio_set_lru(folio);
+				}
 				goto isolate_fail_put;
 			}
 		}
@@ -1293,7 +1299,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	if (locked)
 		lruvec_unlock_irqrestore(locked, flags);
 	if (folio) {
-		folio_set_lru(folio);
+		if (lru_add_del_folio(folio))
+			folio_add_lru(folio);
+		else
+			folio_set_lru(folio);
 		folio_put(folio);
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f11491ee9ed5..4e8d5cc34f07 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -8093,17 +8093,19 @@ void check_move_unevictable_folios(struct folio_batch *fbatch)
 			folio_clear_unevictable(folio);
 			lruvec_add_folio(lruvec, folio);
 			pgrescued += nr_pages;
+		} else if (lru_add_del_folio(folio)) {
+			lruvec_unlock_irq(lruvec);
+			folio_add_lru(folio);
+			lruvec = NULL;
 		}
-		folio_set_lru(folio);
+		if (lruvec)
+			folio_set_lru(folio);
 	}
 
-	if (lruvec) {
-		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
-		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
+	if (lruvec)
 		lruvec_unlock_irq(lruvec);
-	} else if (pgscanned) {
-		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-	}
+	count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
+	count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 }
 EXPORT_SYMBOL_GPL(check_move_unevictable_folios);
 
-- 
2.51.0


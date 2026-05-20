Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF71375F83
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310243; cv=none; b=MRXgCcMlrplLCSRWJzIVX13iY87h7d+VB9XW8ptN0soHcYPaPyL6PnGWr56nPineL0JSf1zV5Mt0b8q5rAeCdM2FYoi9oopCBlDEkQYew8PiLP8ksGtJCnE4f50bXyA99aR+xs/ZTYzpGJCWs5DS8j3Bh1K3R6PuCkXH9ricZEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310243; c=relaxed/simple;
	bh=69FMnFpCCkSEBZ7/2YJYSjRd1MbsazhKzcMtt9GaMPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pefTrPtdNuti/IJkzbQRvv7RqcRudO0seffZfpYj38fcCWcLC6kzSZtnSH2zvs56d1bXIPPrpPQafwouUc+t7C2M3xsW2cggtVk2Shnh6ZKm2+r85DJGrYSrSW5XNBHU16EjP5jZcQDJOGjUFOTTGoRtIS1uyWgjp7eGcME9D1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qsUbckLp; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qsUbckLp"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKO4mt708929
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=QM60
	WXSBSIQYQWVtbfbyKvBF8T4H0CKsBjV6qw2v1YM=; b=qsUbckLpGyB+A7AmVhc9
	P/EmpJQBFEfgFQ6Udn4ZjA6omKFZKlDMSjeq+f1ohfc78WtsZMLDzvRM9bgXvo2S
	MBCu5l/GGRXt2PE4FwGczaZWrztMv9TpwKXvnjuzF2MwdCpiVEWZN2c298ivtzBY
	QGeU+gxRvkX2o9DO0ASI46sJppe6M7llf5MTsfrdKQi0QBe1i7SrgiWLC9uBdx8A
	Otr7Czvz4SEuwUdiNhvICi3uaD1ReLSTI35+Pzo+fB/osgj0Tkc39UFscfFF/RbB
	gOXVynu+j3mGFznKdiOcXCL3AYt9RyTRfgkMl31LbUIKv7ZIFGqgCOcdTZBhY7UM
	vw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4e99ydd0r4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:38 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-90d6fe98316so1206827485a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310238; x=1779915038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QM60WXSBSIQYQWVtbfbyKvBF8T4H0CKsBjV6qw2v1YM=;
        b=L5O0fvoSuAhjyZhC8efcTNNHPcewm3HjSKEVuRols7O1vY7vhsvWa4chYHWFlK130q
         XVwwlYzjDrmB7J9Qv14BXF2r2KaREGAgfbQ2ikRRt/CD1d85QsXhbgm28NOYrn5Tfg7I
         d+axuvQ/Wwrv5FOEZLA5wUw9z9PS9E+YV3Vm2TebyKdfKlKrNZB21EVaNrRqXcZl7v/a
         AAGfTSkNh0CHx3kjlbO3UgCOcwOjv2IjfTde6BuZVx+7I6jmX30epRkCVvVCKbN0qmZc
         CarVXEA2ij1i0Dr5FtUABFNwbGq0j581hWZ0gZceEvc3Jcew7RfsqYNZzS2iRSYiimWU
         e4gQ==
X-Gm-Message-State: AOJu0YzCF9bhOlyUvG5W6rA5ohNGu6Xe8umx40O9sH861kNbzuiWnXjp
	HdEORdZWeMl1cP9u2z7g42SDlORdjJXV+nh+5BkgOOu9822b+4mYVfa4lXu0WvOkQH6RwlfIuJv
	D2Yd0pSJKp4aS8/mlgYfnEhedrIXY4vGzCj+o1WxjOUoHzacPjagKkQdufJEGoFt88u2tIbc=
X-Gm-Gg: Acq92OHmDctzJL/I/eUidiPck7Mai57LXYiG53zkUZkI66BvGzpXTvvr/31ESiM8U7v
	2gx2/1cdbSTFC7j+f/shbRrdcoj/jCQmheqnvJ6qOsMp/IYn4406k2lLYZuy8IuOQW8tBVcK/mg
	hlBBA78AZ1mqmWuCJiSsvBL5sXyexw+R+cWeK14+p7bE+TwqRGYpitYkjiWP8kK8gPPT+Nzq1So
	q11PMJvEPypKnhgrSeXR5+ULseOMu1m1xKVDeAzJHLxva0Z60Ym7/W5j7DrC6Xmp7wokQaNRRG9
	BmUpYhr6ak52XBbjrWYpujS3N0Ge5Tblq1ASGrvUwYusL/N8RDCONjZJh9T4keWHf9SAVv8sQtC
	TvT+J5CkHF31I052IHQ9xqBRDS8A0i1i1WaVY6VPMC+s7CrBh7s2UU43DbIf5A/Ar0pw=
X-Received: by 2002:a05:620a:cfb:b0:911:fc2c:c078 with SMTP id af79cd13be357-911fc2cd1c1mr3069129285a.1.1779310237093;
        Wed, 20 May 2026 13:50:37 -0700 (PDT)
X-Received: by 2002:a05:620a:cfb:b0:911:fc2c:c078 with SMTP id af79cd13be357-911fc2cd1c1mr3069124685a.1.1779310236449;
        Wed, 20 May 2026 13:50:36 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:35 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:48:56 -0400
Subject: [PATCH RFC 05/11] folio_wait: reformat comments and fix alignment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-5-c36ddc2b6cf2@columbia.edu>
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
In-Reply-To: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=21905;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=69FMnFpCCkSEBZ7/2YJYSjRd1MbsazhKzcMtt9GaMPw=;
 b=/LS05GFRr0I0dRdpIdwuCT27Qutf2Js6Cv+yKW0yfgbbJSYuTkFWu6MOkmEqTdIvlw3VRr5oV
 smS0ff/auk2DI+45+Yy/pAXtlKe+W4MsmUEGzwoOkLRM2bxQ/nX4MKZ
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: KBB7TSHnLhZXNR7QAkiZcNHha6EZjsQb
X-Authority-Analysis: v=2.4 cv=TbKmcxQh c=1 sm=1 tr=0 ts=6a0e1e9e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=ItFntl4SG6S2Zc4VtyUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfX2PjfzKAMJ6yz
 CDh+PQU5irDy/GADq41/KM5bSAUOdpz21QsQ05CeGz83LVed7uQBvtfmAgJZm2UOJTTnBeBpn/Y
 QKEVhs5PAjCprkt3PdLaFsIqFOIjIBxn4wQjJOMrR+HmvlBKpBPpy+cKxu5t7jTHiYo88zftb0N
 M/gse06DM8A07bAk+9mg7akz2qxT9gBZrtb69wsd5QA9Fcmm8EzIkauLNk7eBKR8I4bBWV1vOAO
 kE5iWggIRBV6yMKDl1YsDJI1rrIKwkF4SPT9C5GC7yk0jO+AZCNbnMSbte6WR32Uyn9UD5iC2ZA
 nhb1yXEoEElnB3aRl5jPDzySuQ83LDTuBMuIysKy9vgWLTSI8DhRmxGIgR1YJgQiZu+QEEdX2hc
 bWDgRi8TQc2CZAVKx3eOswi+E9vRKEefW7rrbdFAzX2wbKl9wmRiqqEyyUtIBi0y16hRw7vwUmN
 OtuI8XIJTsSss+VRqOQ==
X-Proofpoint-ORIG-GUID: KBB7TSHnLhZXNR7QAkiZcNHha6EZjsQb
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 clxscore=1015 priorityscore=1501 bulkscore=10
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=10 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200203

Reflow comments to fill 80 columns and fix indentation issues carried
over from the original locations in pagemap.h and filemap.c.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/folio_wait.h |  62 ++++++++-------
 mm/folio_wait.c            | 185 ++++++++++++++++++++-------------------------
 2 files changed, 113 insertions(+), 134 deletions(-)

diff --git a/include/linux/folio_wait.h b/include/linux/folio_wait.h
index 4a5cb2fcf046..57ccf9ffd243 100644
--- a/include/linux/folio_wait.h
+++ b/include/linux/folio_wait.h
@@ -19,10 +19,10 @@ struct wait_page_queue {
 };
 
 static inline bool wake_page_match(struct wait_page_queue *wait_page,
-				  struct wait_page_key *key)
+		struct wait_page_key *key)
 {
 	if (wait_page->folio != key->folio)
-	       return false;
+		return false;
 	key->page_match = 1;
 
 	if (wait_page->bit_nr != key->bit_nr)
@@ -41,10 +41,10 @@ void folio_unlock(struct folio *folio);
  * folio_trylock() - Attempt to lock a folio.
  * @folio: The folio to attempt to lock.
  *
- * Sometimes it is undesirable to wait for a folio to be unlocked (eg
- * when the locks are being taken in the wrong order, or if making
- * progress through a batch of folios is more important than processing
- * them in order).  Usually folio_lock() is the correct function to call.
+ * Sometimes it is undesirable to wait for a folio to be unlocked (e.g. when
+ * the locks are being taken in the wrong order, or if making progress through
+ * a batch of folios is more important than processing them in order). Usually
+ * folio_lock() is the correct function to call.
  *
  * Context: Any context.
  * Return: Whether the lock was successfully acquired.
@@ -66,23 +66,22 @@ static inline bool trylock_page(struct page *page)
  * folio_lock() - Lock this folio.
  * @folio: The folio to lock.
  *
- * The folio lock protects against many things, probably more than it
- * should.  It is primarily held while a folio is being brought uptodate,
- * either from its backing file or from swap.  It is also held while a
- * folio is being truncated from its address_space, so holding the lock
- * is sufficient to keep folio->mapping stable.
+ * The folio lock protects against many things, probably more than it should.
+ * It is primarily held while a folio is being brought uptodate, either from
+ * its backing file or from swap. It is also held while a folio is being
+ * truncated from its address_space, so holding the lock is sufficient to keep
+ * folio->mapping stable.
  *
- * The folio lock is also held while write() is modifying the page to
- * provide POSIX atomicity guarantees (as long as the write does not
- * cross a page boundary).  Other modifications to the data in the folio
- * do not hold the folio lock and can race with writes, eg DMA and stores
- * to mapped pages.
+ * The folio lock is also held while write() is modifying the folio to provide
+ * POSIX atomicity guarantees (as long as the write does not cross a page
+ * boundary). Other modifications to the data in the folio do not hold the
+ * folio lock and can race with writes, e.g. DMA and stores to mapped pages.
  *
- * Context: May sleep.  If you need to acquire the locks of two or
- * more folios, they must be in order of ascending index, if they are
- * in the same address_space.  If they are in different address_spaces,
- * acquire the lock of the folio which belongs to the address_space which
- * has the lowest address in memory first.
+ * Context: May sleep. If you need to acquire the locks of two or more folios,
+ * they must be in order of ascending index, if they are in the same
+ * address_space. If they are in different address_spaces, acquire the lock of
+ * the folio which belongs to the address_space which has the lowest address in
+ * memory first.
  */
 static inline void folio_lock(struct folio *folio)
 {
@@ -99,8 +98,8 @@ static inline void folio_lock(struct folio *folio)
  * This is a legacy function and new code should probably use folio_lock()
  * instead.
  *
- * Context: May sleep.  Pages in the same folio share a lock, so do not
- * attempt to lock two pages which share a folio.
+ * Context: May sleep. Pages in the same folio share a lock, so do not attempt
+ * to lock two pages which share a folio.
  */
 static inline void lock_page(struct page *page)
 {
@@ -116,8 +115,8 @@ static inline void lock_page(struct page *page)
  * folio_lock_killable() - Lock this folio, interruptible by a fatal signal.
  * @folio: The folio to lock.
  *
- * Attempts to lock the folio, like folio_lock(), except that the sleep
- * to acquire the lock is interruptible by a fatal signal.
+ * Attempts to lock the folio, like folio_lock(), except that the sleep to
+ * acquire the lock is interruptible by a fatal signal.
  *
  * Context: May sleep; see folio_lock().
  * Return: 0 if the lock was acquired; -EINTR if a fatal signal was received.
@@ -131,8 +130,8 @@ static inline int folio_lock_killable(struct folio *folio)
 }
 
 /*
- * folio_lock_or_retry - Lock the folio, unless this would block and the
- * caller indicated that it can handle a retry.
+ * folio_lock_or_retry - Lock the folio, unless this would block and the caller
+ * indicated that it can handle a retry.
  *
  * Return value and mmap_lock implications depend on flags; see
  * __folio_lock_or_retry().
@@ -147,8 +146,8 @@ static inline vm_fault_t folio_lock_or_retry(struct folio *folio,
 }
 
 /*
- * This is exported only for folio_wait_locked/folio_wait_writeback, etc.,
- * and should not be used directly.
+ * This is exported only for folio_wait_locked/folio_wait_writeback, etc., and
+ * should not be used directly.
  */
 void folio_wait_bit(struct folio *folio, int bit_nr);
 int folio_wait_bit_killable(struct folio *folio, int bit_nr);
@@ -156,9 +155,8 @@ int folio_wait_bit_killable(struct folio *folio, int bit_nr);
 /*
  * Wait for a folio to be unlocked.
  *
- * This must be called with the caller "holding" the folio,
- * ie with increased folio reference count so that the folio won't
- * go away during the wait.
+ * This must be called with the caller "holding" the folio, i.e. with increased
+ * folio reference count so that the folio won't go away during the wait.
  */
 static inline void folio_wait_locked(struct folio *folio)
 {
diff --git a/mm/folio_wait.c b/mm/folio_wait.c
index 9d3328717bb3..8d8237cdd73b 100644
--- a/mm/folio_wait.c
+++ b/mm/folio_wait.c
@@ -20,14 +20,12 @@
 #include "internal.h"
 
 /*
- * In order to wait for pages to become available there must be
- * waitqueues associated with pages. By using a hash table of
- * waitqueues where the bucket discipline is to maintain all
- * waiters on the same queue and wake all when any of the pages
- * become available, and for the woken contexts to check to be
- * sure the appropriate page became available, this saves space
- * at a cost of "thundering herd" phenomena during rare hash
- * collisions.
+ * In order to wait for pages to become available there must be waitqueues
+ * associated with pages. By using a hash table of waitqueues where the bucket
+ * discipline is to maintain all waiters on the same queue and wake all when any
+ * of the pages become available, and for the woken contexts to check to be
+ * sure the appropriate page became available, this saves space at a cost of
+ * "thundering herd" phenomena during rare hash collisions.
  */
 #define PAGE_WAIT_TABLE_BITS 8
 #define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
@@ -70,44 +68,42 @@ void __init folio_wait_init(void)
  *
  *  (a) no special bits set:
  *
- *	We're just waiting for the bit to be released, and when a waker
- *	calls the wakeup function, we set WQ_FLAG_WOKEN and wake it up,
- *	and remove it from the wait queue.
+ *	We're just waiting for the bit to be released, and when a waker calls
+ *	the wakeup function, we set WQ_FLAG_WOKEN and wake it up, and remove
+ *	it from the wait queue.
  *
  *	Simple and straightforward.
  *
  *  (b) WQ_FLAG_EXCLUSIVE:
  *
- *	The waiter is waiting to get the lock, and only one waiter should
- *	be woken up to avoid any thundering herd behavior. We'll set the
+ *	The waiter is waiting to get the lock, and only one waiter should be
+ *	woken up to avoid any thundering herd behavior. We'll set the
  *	WQ_FLAG_WOKEN bit, wake it up, and remove it from the wait queue.
  *
  *	This is the traditional exclusive wait.
  *
  *  (c) WQ_FLAG_EXCLUSIVE | WQ_FLAG_CUSTOM:
  *
- *	The waiter is waiting to get the bit, and additionally wants the
- *	lock to be transferred to it for fair lock behavior. If the lock
- *	cannot be taken, we stop walking the wait queue without waking
- *	the waiter.
+ *	The waiter is waiting to get the bit, and additionally wants the lock
+ *	to be transferred to it for fair lock behavior. If the lock cannot be
+ *	taken, we stop walking the wait queue without waking the waiter.
  *
  *	This is the "fair lock handoff" case, and in addition to setting
- *	WQ_FLAG_WOKEN, we set WQ_FLAG_DONE to let the waiter easily see
- *	that it now has the lock.
+ *	WQ_FLAG_WOKEN, we set WQ_FLAG_DONE to let the waiter easily see that
+ *	it now has the lock.
  */
-static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
+static int wake_page_function(wait_queue_entry_t *wait, unsigned int mode, int sync, void *arg)
 {
 	unsigned int flags;
 	struct wait_page_key *key = arg;
-	struct wait_page_queue *wait_page
-		= container_of(wait, struct wait_page_queue, wait);
+	struct wait_page_queue *wait_page = container_of(wait, struct wait_page_queue, wait);
 
 	if (!wake_page_match(wait_page, key))
 		return 0;
 
 	/*
-	 * If it's a lock handoff wait, we get the bit for it, and
-	 * stop walking (and do not wake it up) if we can't.
+	 * If it's a lock handoff wait, we get the bit for it, and stop walking
+	 * (and do not wake it up) if we can't.
 	 */
 	flags = wait->flags;
 	if (flags & WQ_FLAG_EXCLUSIVE) {
@@ -121,26 +117,24 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	}
 
 	/*
-	 * We are holding the wait-queue lock, but the waiter that
-	 * is waiting for this will be checking the flags without
-	 * any locking.
+	 * We are holding the wait-queue lock, but the waiter that is waiting
+	 * for this will be checking the flags without any locking.
 	 *
-	 * So update the flags atomically, and wake up the waiter
-	 * afterwards to avoid any races. This store-release pairs
-	 * with the load-acquire in folio_wait_bit_common().
+	 * So update the flags atomically, and wake up the waiter afterwards to
+	 * avoid any races. This store-release pairs with the load-acquire in
+	 * folio_wait_bit_common().
 	 */
 	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
 
 	/*
-	 * Ok, we have successfully done what we're waiting for,
-	 * and we can unconditionally remove the wait entry.
+	 * Ok, we have successfully done what we're waiting for, and we can
+	 * unconditionally remove the wait entry.
 	 *
-	 * Note that this pairs with the "finish_wait()" in the
-	 * waiter, and has to be the absolute last thing we do.
-	 * After this list_del_init(&wait->entry) the wait entry
-	 * might be de-allocated and the process might even have
-	 * exited.
+	 * Note that this pairs with the "finish_wait()" in the waiter, and has
+	 * to be the absolute last thing we do. After this
+	 * list_del_init(&wait->entry) the wait entry might be de-allocated and
+	 * the process might even have exited.
 	 */
 	list_del_init_careful(&wait->entry);
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
@@ -198,11 +192,10 @@ enum behavior {
 };
 
 /*
- * Attempt to check (or get) the folio flag, and mark us done
- * if successful.
+ * Attempt to check (or get) the folio flag, and mark as done if successful.
  */
 static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
-					struct wait_queue_entry *wait)
+		struct wait_queue_entry *wait)
 {
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &folio->flags.f))
@@ -246,18 +239,14 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	}
 
 	/*
-	 * Do one last check whether we can get the
-	 * page bit synchronously.
+	 * Do one last check whether we can get the page bit synchronously.
 	 *
-	 * Do the folio_set_waiters() marking before that
-	 * to let any waker we _just_ missed know they
-	 * need to wake us up (otherwise they'll never
-	 * even go to the slow case that looks at the
-	 * page queue), and add ourselves to the wait
-	 * queue if we need to sleep.
+	 * Do the folio_set_waiters() marking before that to let any waker we
+	 * _just_ missed know they need to wake us up (otherwise they'll never
+	 * even go to the slow case that looks at the wait queue), and add
+	 * ourselves to the wait queue if we need to sleep.
 	 *
-	 * This part needs to be done under the queue
-	 * lock to avoid races.
+	 * This part needs to be done under the queue lock to avoid races.
 	 */
 	spin_lock_irq(&q->lock);
 	folio_set_waiters(folio);
@@ -266,9 +255,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	spin_unlock_irq(&q->lock);
 
 	/*
-	 * From now on, all the logic will be based on
-	 * the WQ_FLAG_WOKEN and WQ_FLAG_DONE flag, to
-	 * see whether the page bit testing has already
+	 * From now on, all the logic will be based on the WQ_FLAG_WOKEN and
+	 * WQ_FLAG_DONE flag, to see whether the page bit testing has already
 	 * been done by the wake function.
 	 *
 	 * We can drop our reference to the folio.
@@ -277,10 +265,9 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		folio_put(folio);
 
 	/*
-	 * Note that until the "finish_wait()", or until
-	 * we see the WQ_FLAG_WOKEN flag, we need to
-	 * be very careful with the 'wait->flags', because
-	 * we may race with a waker that sets them.
+	 * Note that until the "finish_wait()", or until we see the
+	 * WQ_FLAG_WOKEN flag, we need to be very careful with the
+	 * 'wait->flags', because we may race with a waker that sets them.
 	 */
 	for (;;) {
 		unsigned int flags;
@@ -306,8 +293,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 			break;
 
 		/*
-		 * Otherwise, if we're getting the lock, we need to
-		 * try to get it ourselves.
+		 * Otherwise, if we're getting the lock, we need to try to get
+		 * it ourselves.
 		 *
 		 * And if that fails, we'll have to retry this all.
 		 */
@@ -333,13 +320,13 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 
 	/*
 	 * NOTE! The wait->flags weren't stable until we've done the
-	 * 'finish_wait()', and we could have exited the loop above due
-	 * to a signal, and had a wakeup event happen after the signal
-	 * test but before the 'finish_wait()'.
+	 * 'finish_wait()', and we could have exited the loop above due to a
+	 * signal, and had a wakeup event happen after the signal test but
+	 * before the 'finish_wait()'.
 	 *
-	 * So only after the finish_wait() can we reliably determine
-	 * if we got woken up or not, so we can now figure out the final
-	 * return value based on that state without races.
+	 * So only after the finish_wait() can we reliably determine if we got
+	 * woken up or not, so we can now figure out the final return value
+	 * based on that state without races.
 	 *
 	 * Also note that WQ_FLAG_WOKEN is sufficient for a non-exclusive
 	 * waiter, but an exclusive one requires WQ_FLAG_DONE.
@@ -452,11 +439,10 @@ EXPORT_SYMBOL(folio_wait_bit_killable);
  * @folio: The folio to wait for.
  * @state: The sleep state (TASK_KILLABLE, TASK_UNINTERRUPTIBLE, etc).
  *
- * The caller should hold a reference on @folio.  They expect the page to
- * become unlocked relatively soon, but do not wish to hold up migration
- * (for example) by holding the reference while waiting for the folio to
- * come unlocked.  After this function returns, the caller should not
- * dereference @folio.
+ * The caller should hold a reference on @folio. They expect the page to become
+ * unlocked relatively soon, but do not wish to hold up migration (for example)
+ * by holding the reference while waiting for the folio to come unlocked. After
+ * this function returns, the caller should not dereference @folio.
  *
  * Return: 0 if the folio was unlocked or -EINTR if interrupted by a signal.
  */
@@ -471,8 +457,8 @@ int folio_put_wait_locked(struct folio *folio, int state)
  *
  * Unlocks the folio and wakes up any thread sleeping on the page lock.
  *
- * Context: May be called from interrupt or process context.  May not be
- * called from NMI context.
+ * Context: May be called from interrupt or process context. May not be called
+ * from NMI context.
  */
 void folio_unlock(struct folio *folio)
 {
@@ -490,14 +476,13 @@ EXPORT_SYMBOL(folio_unlock);
  * @folio: The folio.
  * @success: True if all reads completed successfully.
  *
- * When all reads against a folio have completed, filesystems should
- * call this function to let the pagecache know that no more reads
- * are outstanding.  This will unlock the folio and wake up any thread
- * sleeping on the lock.  The folio will also be marked uptodate if all
- * reads succeeded.
+ * When all reads against a folio have completed, filesystems should call this
+ * function to let the pagecache know that no more reads are outstanding. This
+ * will unlock the folio and wake up any thread sleeping on the lock. The folio
+ * will also be marked uptodate if all reads succeeded.
  *
- * Context: May be called from interrupt or process context.  May not be
- * called from NMI context.
+ * Context: May be called from interrupt or process context. May not be called
+ * from NMI context.
  */
 void folio_end_read(struct folio *folio, bool success)
 {
@@ -577,13 +562,12 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
  * folio_wait_writeback - Wait for a folio to finish writeback.
  * @folio: The folio to wait for.
  *
- * If the folio is currently being written back to storage, wait for the
- * I/O to complete.
+ * If the folio is currently being written back to storage, wait for the I/O to
+ * complete.
  *
- * Context: Sleeps.  Must be called in process context and with
- * no spinlocks held.  Caller should hold a reference on the folio.
- * If the folio is not locked, writeback may start again after writeback
- * has finished.
+ * Context: Sleeps. Must be called in process context and with no spinlocks
+ * held. Caller should hold a reference on the folio. If the folio is not
+ * locked, writeback may start again after writeback has finished.
  */
 void folio_wait_writeback(struct folio *folio)
 {
@@ -598,13 +582,12 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback);
  * folio_wait_writeback_killable - Wait for a folio to finish writeback.
  * @folio: The folio to wait for.
  *
- * If the folio is currently being written back to storage, wait for the
- * I/O to complete or a fatal signal to arrive.
+ * If the folio is currently being written back to storage, wait for the I/O to
+ * complete or a fatal signal to arrive.
  *
- * Context: Sleeps.  Must be called in process context and with
- * no spinlocks held.  Caller should hold a reference on the folio.
- * If the folio is not locked, writeback may start again after writeback
- * has finished.
+ * Context: Sleeps. Must be called in process context and with no spinlocks
+ * held. Caller should hold a reference on the folio. If the folio is not
+ * locked, writeback may start again after writeback has finished.
  * Return: 0 on success, -EINTR if we get a fatal signal while waiting.
  */
 int folio_wait_writeback_killable(struct folio *folio)
@@ -623,14 +606,13 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
  * folio_wait_stable() - wait for writeback to finish, if necessary.
  * @folio: The folio to wait on.
  *
- * This function determines if the given folio is related to a backing
- * device that requires folio contents to be held stable during writeback.
- * If so, then it will wait for any pending writeback to complete.
+ * This function determines if the given folio is related to a backing device
+ * that requires folio contents to be held stable during writeback. If so, then
+ * it will wait for any pending writeback to complete.
  *
- * Context: Sleeps.  Must be called in process context and with
- * no spinlocks held.  Caller should hold a reference on the folio.
- * If the folio is not locked, writeback may start again after writeback
- * has finished.
+ * Context: Sleeps. Must be called in process context and with no spinlocks
+ * held. Caller should hold a reference on the folio. If the folio is not
+ * locked, writeback may start again after writeback has finished.
  */
 void folio_wait_stable(struct folio *folio)
 {
@@ -670,10 +652,9 @@ int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 	folio_set_waiters(folio);
 	ret = !folio_trylock(folio);
 	/*
-	 * If we were successful now, we know we're still on the
-	 * waitqueue as we're still under the lock. This means it's
-	 * safe to remove and return success, we know the callback
-	 * isn't going to trigger.
+	 * If we were successful now, we know we're still on the waitqueue as
+	 * we're still under the lock. This means it's safe to remove and
+	 * return success, we know the callback isn't going to trigger.
 	 */
 	if (!ret)
 		__remove_wait_queue(q, &wait->wait);

-- 
2.39.5


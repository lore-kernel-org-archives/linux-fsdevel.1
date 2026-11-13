Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606370;
	b=PY5T05lJGK4tn31vIH43oMb1OOfZcZb2hG6YVmL6x2rqqeRHyR4CjzcZdrcExwys6+k4
	 XtOs/3gf++VHHqSQkzIu78lbn6fpUDk0dGoXH7dQToZEz+1VnQdQOIYBGp+Ov0xy2hAP2
	 v6x+qtAGjZYe08oIJNowSOls1kNBT9yN+ZbA2F8TCJwO4pFIi+gOklUu5TSv8idPtAHrH
	 M4qcGXdaaVF104E3lHeI8hXP5VEMejs7UpoTSGWMyIxF0Hd5qrhCCCr4pe2CRK/E8ooGv
	 AnfyaSSl8KC+J5oaFbkfig2Sp4MEgARI3rVH8ARhFuI7w+SE3d1880JsxnrLPyVmhYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606370;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kSGDbQCcTAUSRH7G/fxYE5gB5OxnE3KFAroSX9Yeoig=;
	b=LscpXd+MUkxdw9uzwhgTiTkNN9zYgIjF4W+b3/fQWHlKyUTKDhpPUZatWzTiO6EuPosq
	 gdO4Ii7FNrNBXecn35wyLPQcPuqXkXNQN/Op21jHdIpnF9mS8JDfz+WkDg0OIK2G+rGWL
	 8GwqmpjBrvqS/adlsFkOA3JeITn4uc0m9C5U8SkIVuIDCsbOPH2YLzZG7jOsQs7fQzFw6
	 My8Wwd13TZBkWb268JvrF03JM8Ti/2u0/JaUIjy6WldONwL3NTq069z/eU8dsx2JnXYH9
	 /axeqMT8+wSIGSwGU4QzvBri53dvLggUrShh4Pp9j2nqXoVpkyqHKbduo+TRKIzwojA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+diSbf1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83CE606A323;
	Fri, 13 Nov 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h+diSbf1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783581F000C9;
	Fri, 13 Nov 2026 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606369;
	bh=kSGDbQCcTAUSRH7G/fxYE5gB5OxnE3KFAroSX9Yeoig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h+diSbf1SuhC6aFNsHOme977E1ZvwU97QzoXopEuhlIB8TKotYFMevmSp6UYzTjjn
	 FZeBCqM15Mnt2X2QQ2AB3koBYK+6mDB43xHWQszL+inYtuGHaR83oC9sbpFLS+f0C6
	 xkz3NWMU9n1zMVtX+l60Y74eUjxb0O0csn+shbuBTEqWXGhJYBK51xoqFzkuawsOMV
	 Q8zEswz9yY4YJBacnDHaha//uClVvE6rjjq9K940lycXG2YGhlU71NttRaWeUyYI7P
	 PADgp+xzd+leSC8aoGyMzk5lcig2i+1MEFKCo4ieNxRDJ7tUTtIjpSrNrbD0OnM24Z
	 ofN2wsrpH4Smw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:21 +0000
Subject: [PATCH v2 03/13] mm: cachestat: restart the walk after each entry
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-3-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2976; i=ljs@kernel.org;
 h=from:subject:message-id; bh=lUSIkZIR6P4SuNmqWQyzCX54g+mtKdeum9Py8TZcLQQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/zguiHA9DlRiPeX+wLWT9Yyk4tcdNnWH917zS3wp
 dwetthHHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjIPwVGhl+hxfcuPbsXZ6HV
 5B++6g3X3W0Wr3cdmDv3x8wyxqLNIvMZ/ikxn1r4KWXT6Qzru093Tf6oxM6YmXCuqu7/F8dlilX
 1HMwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

cachestat() can leave cached pages out of its counts. This happens if
the entry that the call has just counted is replaced by a larger folio
that starts in the same XArray slot.

The issue is that filemap_cachestat() walks the page cache under the RCU
read lock, so racing concurrent collapse/split is possible.

Thus, an entry can be replaced immediately after the walk has returned
it. When that happens, the next xas_find() skips the sibling entries that
point to the slot of that entry, since ordinarily they belong to that
entry.

However a concurrent collapse_file() or __filemap_add_folio() (when
replacing a shadow entry) can store a larger folio in the slot, in which
case the sibling entries belong to the new folio and the walk still skips
them.

Consider:

    cachestat                         collapse
    =========                         ========
    count a 64-page folio in slot 8
                                      store a 512-page folio in slot 8,
                                      with sibling entries in slots 9-15
    xas_find() starts at slot 8
    and skips slots 9-15
      /* 448 pages are never counted */

Also consider:

    filemap_cachestat()                  __filemap_add_folio()
    ===================                  =====================
    counts the shadow entry in slot 0
                                         slot 0: a folio of 32 pages
                                         slots 1-31: siblings of slot 0
    xas_find() skips slots 1-31
      /* 31 pages are never counted */

Essentially the fact that large folios might be present means we cannot
safely continue the XArray walk, and must reset the iterator each time.

Fix this by resetting the walk in each loop. This incurs a performance
penalty, but given that only the RCU lock is held here, it can't be
avoided.

Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: squashed 2 commits, fixed up comment in code, and commit message ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/filemap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7c05e4fad081..c4e82891767b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4731,10 +4731,11 @@ static void filemap_cachestat(struct address_space *mapping,
 		if (folio_last_index >= last_index)
 			break;
 
-		if (need_resched()) {
-			xas_set(&xas, curr_index);
+		/* Collapse or new folio spanning shadow entries needs reset. */
+		xas_set(&xas, curr_index);
+
+		if (need_resched())
 			cond_resched_rcu();
-		}
 	}
 	rcu_read_unlock();
 }

-- 
2.56.0


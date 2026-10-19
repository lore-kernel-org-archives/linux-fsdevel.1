Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424986;
	b=quq/i1GNrCP6HZH3dZRvTg7wkrmNa03BnAps9maeZN/VvbJd4LW9e/nbphBExK8GZvBB
	 e4gvqjDNco1idRsocsYDS3E7Qk7liMD56KUv02zejxsUQdMvXe7T2MsvZOxUVSGSoVhPh
	 1+bgzr//3+okCkqgegdh1aoFZzPnCdkejm2h8Pv8TSnxW1GLfBKxoZGYZCtbVaFkIPGaK
	 PD/nHXc4hBtamlQuHy+DZDW8oaq5txKbaQCwy7pKcUi5BagUpeJPrXowgIh+owKF7ssqf
	 JI0zwthcrgT+DJ6DEk62OTrrAwR9fkausOR4P+dOjYdmY1mYzOuj3yzzHSQ8K473rLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424986;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kbgj/cbxLipXGxpjxY36dW9YWtUesmr6PYKnaG71cGs=;
	b=qe2ZL9T0RuKMeZ6gzpxOBDRCmEg2DAyMeYwOqBDmll7uAlJ7M7lIjEReQbyLQkPRTbRS
	 ln+trqCAtTIPyusbI4JbxWEx8Zf1UdTE2ePoyxN/pZueudERZ8ssVcQubQyjvTkggGZ/j
	 GijqO5DshDFKShiLaRaLJJCQz9vvqfb9jtWO8lxkRv0+bS2Ktnb7ru5NHgs7xfrvii2XJ
	 Tq14Tp3FRrTYEU68xaHMU0xLV150irzjUbVQKqJiMQ6USrJ2Uupyfb/iIUuJ5iG8UGd5q
	 fQuBzubiQzSILu48o4TJlaN9R4CxEKXDJ4RStoNSnbUWLX+ahJ7j5C6w78CAGe1NEvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpAdjgpJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3A6078840;
	Mon, 19 Oct 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpAdjgpJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A49A1F000CB;
	Mon, 19 Oct 2026 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424986;
	bh=Kbgj/cbxLipXGxpjxY36dW9YWtUesmr6PYKnaG71cGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpAdjgpJLRrZt5vfapGYdm4s0/UzT09h2EUGkaB2CvZLAUbX7ETxtYHlcqaWNpg1g
	 eXbT5UAX6QRWY1N0d7O2jyoj+FytTUf/zuWrdHOBHp9K7lcvo2+qUHcjUj6mtIrIIQ
	 g2Lil7vJ5nw3PLkI/zpVBy7eeSwCPW5q+OHhZeRwH1BPDPIK6E/kKZpAkimGd2i61q
	 aEyTkBE8TLTHOPAdDdibTE7PkGGNx/ofoUxyZbNjYcSKlZQlm5ulqA7mqCsTzTY/8V
	 rhFsuVbHxzNj8PCeL3V+TGHpxS7tnF3GEXUuPQDMBG9QPEqSeH4BJpBcCeOdpd55Y7
	 5kzc6h820HMFg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.ams.internal (Postfix) with ESMTP id 6B6CF1980047;
	Mon, 19 Oct 2026 11:49:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 11:49:41 -0400
X-ME-Sender: <xms:EDzWalKKW2rLUrzcCGmEAjXNjh6INGLxQ9OY3FD-cACD_m0UdU6DtA>
    <xme:EDzWamaktN3t914H6nnQAtvre-q1v5NfKuv_Dc5jNOSSVyARhyTGBJTk9i4wk_wEP
    jkAOhnejOeO_MprDjcuBlZbK9uQ7lO5uHYC_z7B_bgFUvB7DGFlG1KA0Q>
X-ME-Received: <xmr:EDzWagXz8dftMhBzFjNvkUMrqN8Lf81lQ0KWnLgXpAniddrNFAczEmxc9iI>
X-ME-Proxy-Cause: dmFkZTESqR4vElUNfwe4Wb1kabMg9MdYUtHyNIvlHi5jfGRsEd0tjiYfzpqh5FemuLlMuA
    +QzWL/iolJzzDzQk8vzuoT2/u2xyL/YZG/CihU2eaSQe3uAw7YKu/Z/hQfgMIJpEQrBQkK
    hH3KJVpCmjg+gNXnnOIkdBMKpJa1pvTLqzuojrt68Uovke10kpOzVhZrNEf3d58NDgoR+6
    GBwzdAiHoLFFDGJo3/r+XBHeUTBbw+IeFaYdgC0j5JEQlKAOMB5I7tBUfVMuw5hMfUnXf2
    vE1DwOk7N/x2FbtU++Y3QX/1ODQhD5sTVGp3EMvK4jUTItTZrn4RBPsK+PhnbeHfl8Jcd/
    yYYEKmAGT8vWogHsS/MLpG4mGVeUeUcl8fzs7/zHA9gd8BbEgXpb1CoSUIZuL9AsGdcCeL
    +gXC3GBZVeiw6q1+GKFOmx8OVmgLnX3toJ5chCtufQcBsun6EpjJaG+M15ijPymLjtuB1N
    FD7FJ16WFMZH3bHDTYwl4ViatPxmQL4lcXqk/pVAVOGizVyQLMIwi0unAXmKltJ2BEqr5S
    32YVsgd9l8nrPOu7EChRRHchU7/xpjfB5k04bMWbcc2A+1JkfyBbqlxnUaxqdwKP/Ztfj7
    OS9iW/9oAv4Gm0mAtI4sFlKSdYDo0XfmQz3m1GzlmlQx0HIQJKcwJvH46hFA
X-ME-Proxy: <xmx:EDzWamETvnJHnrvb_jfF9MCEbmlHlDHpGhYwRKQmxJ86rD3lcu0nSg>
    <xmx:EDzWatD021DoQamQf30N_3YICdTTwNu1Jps7NLmgwrtOpkbTEqX8RA>
    <xmx:EDzWahUvs2AcCacNO783zoF_zNcXGlND7aaU_HULAoExtTs4KErymA>
    <xmx:EDzWat4jdA356dqYToLkpgozhEiRUV-5PoXbZAsqKgZUgGQSDbx5Cg>
    <xmx:ETzWaiH_L2oQ-xKhUgvpq5FBLVZGJO_fk39Fvf4EAZDrZXkYkOu14-KP>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:49:36 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Harry Yoo <harry@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: [RFC PATCH 03/18] fuse: don't move a folio with PG_rcu_free into a fuse file
Date: Mon, 19 Oct 2026 16:48:56 +0100
Message-ID: <20261019154913.1765974-4-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019154913.1765974-1-kas@kernel.org>
References: <20261019154913.1765974-1-kas@kernel.org>
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

fuse_try_move_folio() takes the folio of a pipe buffer and puts it into
a fuse file, where writes change it.  A folio with PG_rcu_free may still
be copied by a lockless page cache read that found it before it left
the page cache.

Such a folio reaches fuse when a mapped file page is gifted with
vmsplice(SPLICE_F_GIFT) and its file is then truncated.
fuse_check_folio() refuses it only because the flag is not among those
it allows, and with a dump_page().

Copy such a folio instead, as fuse does whenever it cannot take one.

Assisted-by: LLM
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/fuse/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..526929c7b3f1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1152,6 +1152,10 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 
 	newfolio = page_folio(buf->page);
 
+	/* A lockless page cache read may still be copying from it */
+	if (folio_test_rcu_free(newfolio))
+		goto out_fallback_unlock;
+
 	folio_clear_uptodate(newfolio);
 	folio_clear_mappedtodisk(newfolio);
 
-- 
2.54.0


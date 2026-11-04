Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797309;
	b=sC+Q1gcoHkkhcQ0KeLJskwnr8z8LggNN/BdHh9zVqmdU2+mPZ9OCsjh+W+Pgjg//gLcf
	 B5DBpLJLpeLZ2lDvk3t/r3f4sT1lKIogyOg25ZGGcr94XXrCvEwdKthJO3XeTJlHGhRRI
	 jL5amdg9m7gGdvK5B5rYppxO70yMxcgkUkWIck7Qbbw9zCwZu/LQBZ1jgx/vgZKPttJaL
	 h8ZNUFQlmNvqZ/UCwxkr9eZVXeMjicJpqXtcngsNljhuESVYp3AVgIPke6nZ2u24bbfkl
	 08izZ51cZwH7n02LpxkihjWYbq22YHmpxYaeXwaZT5cU3aDaZlKhgAcPrdDc074J6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797309;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I5JDyfdMkj2wCtOOfN649rnZ+9k1JAyMoYfLCV4c9D0=;
	b=j5XuUaqxH57zn//IzcygU+16dvTgsmADhYmULsYD2pMMI21Nr5cYf0dGMikjtdwZMePd
	 oiYD+mipG3huJ2MBZDQJeIqY5Jd01qkBOcbIG1avv62QZGv6YL/LnjrEikSCQqB4qBo5U
	 RlaOzMQ7325VCS3LcKD18Wo567lMNAeVkXrAzJpSA+hEfoDihG8VayoT/ikOOq/x4Z5og
	 +KU3AACcYPaF4/fRU0iI6ZVmQDmW4aW40HOUE27XW+lTqN74dy8Coe6uQRrzmXUxvt9CR
	 DvWBGiBipYYo3nUsJWR1eVVe/f5v1VNj7V0VsuK/kpgwnkzU08DDV2kpXvlpi65iTRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlhgFmtj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B485B606A329
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FlhgFmtj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209591F000C1;
	Wed,  4 Nov 2026 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797308;
	bh=I5JDyfdMkj2wCtOOfN649rnZ+9k1JAyMoYfLCV4c9D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FlhgFmtjaoxs8F6OOrSy0drAa0u9kVadieipPKRT27EcdrU8Qufb8WTlvZpP3Ke0H
	 OyBPPdvgdhaFhZ1S7sVERYdIlKUK4mdYDqcdf+Kd2W8LC79tJy+la9eUP8fU2lCbE9
	 duyzUrh65347AiT49EVSL5jyDlA6pWB+7CaSfhc3StK+H9BrGQv4utJpHUqeQEWE6q
	 MPxMhp/sfynDDRh8NW/rXE19x2JBAHlpt5p21lBXjqdeJ0Olf8vN/z2R+DLXbd1N/X
	 2GfSJrKNtcF+pG4hM6A0fUJKN+O4QnFvwok0Vl0E5mTxIeBiZw1Jzjn6aQG05jcJuF
	 e5r0ID9QVXhIA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 11C551980054;
	Wed,  4 Nov 2026 08:01:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 08:01:44 -0500
X-ME-Sender: <xms:tCzrasLnQ-6aoTAivy6dIwb3QAXiDgsOwkB7XNibpfHeE300IgzEIQ>
    <xme:tCzrahYN1w4j905SN3NhF4jplVsHNsXUlUc5JnqlrL7nOXX3rrLDNn6YZPutix5ri
    D1SJErl3C5VDQDAvUmssApnUGf7L3krnoy3BZsPIouzDdrEB0m8L6k>
X-ME-Received: <xmr:tCzravWl5s_fXCNZi1Y-t1CAFz9SGWtnNx5qTk_tp0POGVoUrk2uCd8vxAI>
X-ME-Proxy-Cause: dmFkZTGcnWxWNdwzviArTqwO8SleswujEAoF3G5cAnzgWuj9VIXYzVn8L/YtSSoCVpDQCx
    AFAjkaMBKJDECegKseyQPi3BoJ2ULdzgEWHQh0kOOdV3qcZ96T5qYw8zvnYBduU6y+7gOl
    ju1hRqdfaUd029Zpq0M1QKVfvNYpVJXA03mIXM/FVYF2n1TVZdGxcwDBil6kVRafbiJtv0
    QuPNDwYksKVrYzT4QGS7HIxmz8ayVgiPQk5G9zoQji1nSBMTr/zV+0QH6w0a9BT4L54N+d
    cRhB7KhKgiZgmWNJc1G8l9d+gvjQ75B75nEIsy2loqzEXGvtqjUcmfJ5UhZu2fDzNX4RJx
    MXTgBiPaExnSeSGdTd2uIQPIf04/vV8GeZZGlCpJD3MJZYqa3/ilpSwupO/6D8DuMuVdgf
    lRhydXCQ6Xa2S+8DXLnkhoRuc1AjZzapOvhFIm7zq8MW9dqCj5VxcPf4OCv5NvmFJ7UYZ2
    W5KDa8ES6KsPHniHYnWGGUwJ2J4K/1PV1PHsiPmmHvenRB0ZPoybQ89E0SeGb9bommOpqP
    nH7w/zl3rKWJgnqBtibtcvEVgCGNRaGZi5A1a5NqGqAreUQOZZ+flJMakBeKirePoTtvdm
    jmXr2MmwPG2xEc7XfTnFlMnp2TzDvQD9nw3/qiRcvcRcLHI9+hkvlT78GBIQ
X-ME-Proxy: <xmx:tCzrapHj8fNK7yMBcpF29XSoU7Co7uGuP-5XZ3IpQ9GIsIXoWSQu3w>
    <xmx:tCzrakC5Nm0lKtJYDGNGsLNIOv5n9mqZVigJ3V2aszFgd3UQ5JQEAw>
    <xmx:tCzrasVyFTfFltq4x2-saDnpvghTxCZn5zweaKj3fmmbIpygVzC22g>
    <xmx:tCzras4VW6TSobJGmtOJftnDT4qY_mRwirpxa-3AhBFeorfQ2rWlCg>
    <xmx:tCzralGiIlFvyC1gpv3jZPsZOa5eFtYPy0MBq-9V20rRKnakIHq6cEMm>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:01:40 -0500 (EST)
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Harry Yoo <harry@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ilya Gladyshev <ilya.gladyshev@linux.dev>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kernel-team@meta.com
Subject: [RFC PATCH v2 03/18] fuse: don't move a folio with PG_rcu_free into a fuse file
Date: Wed,  4 Nov 2026 13:00:59 +0000
Message-ID: <20261104130118.2507513-4-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104130118.2507513-1-kas@kernel.org>
References: <20261104130118.2507513-1-kas@kernel.org>
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


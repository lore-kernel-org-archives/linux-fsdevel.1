Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11006480336;
	Thu, 11 Jun 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198073; cv=none; b=VhGwsoqZx7LQopE7GNo90swDnEzjAjPMBj/gycVeVJSQ3BuY748Cju4Vcxp52pGcD4G4zvbhovjkLgdKuARrZ8EkFGiks7GxjykwfhHN8ZmkvIU6XVEntOwLErS1VxHm82ga4lGCxiRZzN1R+d5vk9RcxZsY7Hg+3NUUr4oL7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198073; c=relaxed/simple;
	bh=JfAEM3aUjV9uUMWZEiRcOGIAaKHG0E8Tz/cn04M7Nk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVho8ua9QZcEt3sq4KMazrjLzqdYog5Nd6McubMR5ZtCvimVfd7A1l3H5RwOQEX9azhmzAtdFVDCicYtKts44kZIuNi7U7OtaAlTdlNqJCxG9Pb13F8LLbaBrw7fgiLA3Cl0ES8LAnHZprWYYJATKhd02BN7hdkxJTSYf309gck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WxiXoVHj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WxiXoVHj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MZHJrCjRIjmtPr++aWYgFPkpaIkTjbAk/NLmMP37eM0=; b=WxiXoVHjysrq3RItCug93soCxb
	2VjyRH4Qp49fsKcViwGccmZl34fpTnir+NHJy9DjCFsnLZalH4lLKkioEAgMHTvdcECnGwfAbnFsg
	H/L6bHS1c3IDjOoJ5tW6Q6vyamZR9OZXIEO614M6TubVj021ELooqaTYQpaTBld3JQCt79djRJmAt
	FMiSOCmyRVPc9l/7z9ZqmwHptUBmpTHNmbSoiaR8Q6N5VXn1pjxXGWhbhCgS8BxWq4Tbm/bCH4tim
	gW/wyvcfq2TVjKVwDkvSpIWaB2VP+P2PYyjMKG2eWbuRdwHsBCJIBgnh0UDveEbmiyswSc3EDZShC
	xve+CO+Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wXiz4-000000070nA-2Lf1;
	Thu, 11 Jun 2026 17:14:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] make seq_file_cache statically allocated
Date: Thu, 11 Jun 2026 18:14:22 +0100
Message-ID: <20260611171425.1671254-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
References: <20260611171309.GN2636677@ZenIV>
 <20260611171425.1671254-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/seq_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 4745db2a34d1..7cb40ae83f9b 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -20,11 +20,13 @@
 #include <linux/printk.h>
 #include <linux/string_helpers.h>
 #include <linux/uio.h>
+#include <linux/slab-static.h>
 
 #include <linux/uaccess.h>
 #include <asm/page.h>
 
-static struct kmem_cache *seq_file_cache __ro_after_init;
+static struct kmem_cache_opaque __seq_file_cache;
+#define seq_file_cache to_kmem_cache(&__seq_file_cache)
 
 static void seq_set_overflow(struct seq_file *m)
 {
@@ -1140,5 +1142,5 @@ EXPORT_SYMBOL(seq_hlist_next_percpu);
 
 void __init seq_file_init(void)
 {
-	seq_file_cache = KMEM_CACHE(seq_file, SLAB_ACCOUNT|SLAB_PANIC);
+	KMEM_CACHE_SETUP(seq_file_cache, seq_file, SLAB_ACCOUNT|SLAB_PANIC);
 }
-- 
2.47.3


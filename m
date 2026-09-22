Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D84231839;
	Tue, 22 Sep 2026 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039750; cv=none; b=YjipOZ1qDUJdvqXxDPgNxPp+kt5Owne21XxliuTj+B0agmtvnfZ5P9WuC1CqxluklWnLu0U4olyVCP22yWt8A7DZF5W++FcyKK1PwG1q+9cb7ZOuPoIQfn8ozhHILg+9rYsKEYgpE6NR4iy4EO/iYHEvsSa9GKWEhFsMZlc3BFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039750; c=relaxed/simple;
	bh=OS28/qDSrkgQAt4Wn87ToojAAc9MNc2ldXkvTW5WVP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gZHngmZK3Y4nN+pLx57gaYAZ3U6uUG8puamtUgkdqeEtuKPqCsHF8uaPN3DaQ34NXWiem0q5dV9xMMRr1kJ/nViAeN9kHnEev/hPqIDNwlKcnFlorQhRMgD5TJ+5G4CfJunIFEm5TUaXzdvkP0QpbLbW1/3lr28UJbdh1E/LFYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6ezfEWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6ezfEWh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79210C2BCB3;
	Tue, 22 Sep 2026 01:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790039749;
	bh=OS28/qDSrkgQAt4Wn87ToojAAc9MNc2ldXkvTW5WVP4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=J6ezfEWhB/QYRo0ZvHGZqC/yNyPJhcJPi/OuIbwUXGfONaZjbI8Y9SmBQNkNKlGLu
	 kY7SZCh81PpUyuEKkhecjnwRetesvpyAP1HDkm4K4yf2jWKuomWq6q9AM9KcPF6F6t
	 P8LNu0TuEzGEW/7ZYsCq1btX/UzcXxFMa72UNeMAUNNE9F7sUH7lY2s3I6GZMOCXi/
	 Jz6JMMu8OJaHLXvLJt4yfEZYlDaAojab5yONt9JVK2Ssoxc96xUfE0ej7+ak2No1HG
	 OeLvIX34IoSxfjWiZUM9qIC/neVcpTN6JqGVqQU4SZmUFpDZHCiE7BbktJS4IrIZze
	 upO/qkSmH71Xw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABA0C982F0;
	Tue, 22 Sep 2026 01:15:49 +0000 (UTC)
From: Jaidev Shastri via B4 Relay <devnull+jaidevshastri.vt.edu@kernel.org>
Date: Mon, 21 Sep 2026 21:15:46 -0400
Subject: [PATCH] fs/buffer: publish max_buffer_heads with release semantics
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-mb-fs-buffer-v1-1-e9ce65e8df43@vt.edu>
X-B4-Tracking: v=1; b=H4sIAMHWsWoC/yXMwQ6CMBAE0F8he3ZNW7SIv2I8tHUrNbGSXSEkh
 H+3xeObzMwKQpxI4NqswDQnSZ9coA8NhMHlJ2F6FINRxqreaHx7jIJ+ipEYleu1vSjdWTpDmYx
 MMS373e3+t0z+ReFbP2rDOyH07HIYarRz7o4tcjjBtv0A/mia5JAAAAA=
X-Change-ID: 20260921-mb-fs-buffer-0a91680176e5
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jaidev Shastri <jaidevshastri@vt.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790039748; l=1742;
 i=jaidevshastri@vt.edu; s=20260921; h=from:subject:message-id;
 bh=aRDf9KVPAsphuf/RAWoLyikBZPnCUsIfRRlozDHhW4k=;
 b=hvfED0FmnfL4E5CMvNxgMWkLqHHkZEzP1hlzq5Ot1WwUxAg/nQius6FuuFx4zDJiFZenRkovx
 8dfqYU5rU0PD00m6R8Rbt42WXUL6bOK+v7zKOSVSvPFJE2WYily6HEe
X-Developer-Key: i=jaidevshastri@vt.edu; a=ed25519;
 pk=J7+xYJRlTPds+pv5hbqFFRqGCpDeJDzmZT1ggRwj7/0=
X-Endpoint-Received: by B4 Relay for jaidevshastri@vt.edu/20260921 with
 auth_id=1044
X-Original-From: Jaidev Shastri <jaidevshastri@vt.edu>
Reply-To: jaidevshastri@vt.edu

From: Jaidev Shastri <jaidevshastri@vt.edu>

buffer_init() creates bh_cachep and then computes max_buffer_heads, both
with plain stores. recalc_bh_state() reads max_buffer_heads with a plain
load from alloc_buffer_head() and free_buffer_head(), on any CPU.

Store it with smp_store_release() and read it with smp_load_acquire().

Found with MBCheck, a static herd7-based memory consistency checker.

Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
---
 fs/buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ed966fa73..bf5a674c1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2864,7 +2864,8 @@ static void recalc_bh_state(void)
 	__this_cpu_write(bh_accounting.ratelimit, 0);
 	for_each_online_cpu(i)
 		tot += per_cpu(bh_accounting, i).nr;
-	buffer_heads_over_limit = (tot > max_buffer_heads);
+	/* Pairs with the smp_store_release() in buffer_init(). */
+	buffer_heads_over_limit = (tot > smp_load_acquire(&max_buffer_heads));
 }
 
 struct buffer_head *alloc_buffer_head(gfp_t gfp_flags)
@@ -2998,7 +2999,9 @@ void __init buffer_init(void)
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
 	 */
 	nrpages = (nr_free_buffer_pages() * 10) / 100;
-	max_buffer_heads = nrpages * (PAGE_SIZE / sizeof(struct buffer_head));
+	/* Pairs with the smp_load_acquire() in recalc_bh_state(). */
+	smp_store_release(&max_buffer_heads,
+			  nrpages * (PAGE_SIZE / sizeof(struct buffer_head)));
 	ret = cpuhp_setup_state_nocalls(CPUHP_FS_BUFF_DEAD, "fs/buffer:dead",
 					NULL, buffer_exit_cpu_dead);
 	WARN_ON(ret < 0);

---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260921-mb-fs-buffer-0a91680176e5

Best regards,
--  
Jaidev Shastri <jaidevshastri@vt.edu>



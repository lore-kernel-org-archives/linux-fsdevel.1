Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75E33E7160;
	Wed, 19 Aug 2026 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181041; cv=none; b=PSbgNbXZ3ieFthFzGBmhGbPEht2h1rfqJIPI3FWmG7idz493+U6whmF4Vora5XiXVu44PWDCvjdj9fTWTN3bFDgjVUv6NfShEg8pzd37glRKCoIKqm8v1SNmdqYwcscN5CLN+UYVxGXXsnRuftBt3nypf60qqMLJ8IUL9bgLBIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181041; c=relaxed/simple;
	bh=xonH5OEmjGZ0T+LJRAZWyQJ2cLCDz3LlxuOJfpmUo8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oc6Z4caRup8GIL+iGuydSTfUn+LuHjlpmLjiJ3KmsTBl6BngqCUIOzv0s1feqq2mHK7LR1UUULWzd8OfXI8H1bin2dHQj/FbRl7RQ6mxOYAAJ6pEvS1cBktG9Zyf7B9R4mq14GIJViK84ETFYXynWJ380SokwMQIpMR2xLwuVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Heen4TOm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Heen4TOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49BC1F000E9;
	Wed, 19 Aug 2026 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181039;
	bh=aaMUb6PaGUkY1uYWWgN3cAeUq6l9h+PWt5o9AmFAt0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Heen4TOmnIFtyQjYyv7+PIzwbbZz42Npc0GW51hx4ud6x7Rqf5vC43y2nUEyf6ECq
	 pcOtUTCa4JHCyEcCor01N2FsrVzY4Xjm7i7SOASr/nhmsgg1panWWpwognCtck7bki
	 amyCR7G/xgubDR7CnBmNhnmShiSOXhCZV/EmhjyDGMOd6gpBaEBfm+7WrYTH4VOLe6
	 tXsyvPISipyoCmNDuotbnVIf6lTR6kOjJNL3xCZyYHZMVbKMd4DQD80VHObnZVHCMI
	 1Y1SlAo5BoouEupVho6PfMbHhNiwNVamHrCRweaUELDn/awZxVfgZVA4v7U39hHat8
	 ey9XD16ZR5ocA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:25 +0200
Subject: [PATCH v2 08/22] coredump: move the negotiated mask into struct
 coredump_params
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-8-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xonH5OEmjGZ0T+LJRAZWyQJ2cLCDz3LlxuOJfpmUo8A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me978e91/5SSmW3Hd9p4NXx6qdCyYpr/+dqUjoUst
 1Q28tkKd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkdCIjw42MXtMq5yP82dzF
 ZmKXY/pZpcJSc2XNFfnOrl+sa7iJkeF/EmfJzMjNwrER+n7NRrdtNXuSDntrCy5pULGROCMwcx0
 HAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The coredump server negotiates a set of COREDUMP_* options with the
kernel. The core dump path cannot see them though.

Move the mask into struct coredump_params to make them available.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c            | 15 +++++++--------
 include/linux/coredump.h |  2 ++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index c696b46c97ff..156688be3df0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -100,7 +100,6 @@ struct core_name {
 	unsigned int core_pipe_limit;
 	bool core_dumped;
 	enum coredump_type_t core_type;
-	u64 mask;
 };
 
 static int expand_corename(struct core_name *cn, int size)
@@ -245,9 +244,9 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
 	int pid_in_pattern = 0;
 	int err = 0;
 
-	cn->mask = COREDUMP_KERNEL;
+	cprm->mask = COREDUMP_KERNEL;
 	if (core_pipe_limit)
-		cn->mask |= COREDUMP_WAIT;
+		cprm->mask |= COREDUMP_WAIT;
 	cn->used = 0;
 	cn->corename = NULL;
 	cn->core_pipe_limit = 0;
@@ -860,7 +859,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
-	cn->mask = ack.mask;
+	cprm->mask = ack.mask;
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
 
@@ -1129,7 +1128,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	}
 
 	/* Don't even generate the coredump. */
-	if (cn->mask & COREDUMP_REJECT)
+	if (cprm->mask & COREDUMP_REJECT)
 		return;
 
 	/* get us an unshared descriptor table; almost always a no-op */
@@ -1137,13 +1136,13 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	if (unshare_files())
 		return;
 
-	if ((cn->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
+	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
 		return;
 
 	coredump_sock_shutdown(cprm->file);
 
 	/* Let the parent know that a coredump was generated. */
-	if (cn->mask & COREDUMP_USERSPACE)
+	if (cprm->mask & COREDUMP_USERSPACE)
 		cn->core_dumped = true;
 
 	/*
@@ -1151,7 +1150,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	 * or usermodehelper to finish before exiting so it can e.g.,
 	 * inspect /proc/<pid>.
 	 */
-	if (cn->mask & COREDUMP_WAIT) {
+	if (cprm->mask & COREDUMP_WAIT) {
 		switch (cn->core_type) {
 		case COREDUMP_PIPE:
 			wait_for_dump_helpers(cprm->file);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 7b38ee2e7913..dc7a05b1bb0a 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -26,6 +26,8 @@ struct coredump_params {
 	/* Snapshot of dumpable at dump start. */
 	enum task_dumpable dumpable;
 	int cpu;
+	/* COREDUMP_* options negotiated with the coredump server. */
+	u64 mask;
 	loff_t written;
 	loff_t pos;
 	loff_t to_skip;

-- 
2.53.0


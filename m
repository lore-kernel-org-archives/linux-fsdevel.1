Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3763B27D1;
	Tue, 11 Aug 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462074; cv=none; b=dSWXKY9SHPmoKjWEz1XFu4E8cLww25gEyo8+ITzj6+ossE9RjGjpTHkvyRo33EBXy9yu/YAdc5N05kRhO/UtJQ4wI0Ju+S2tHyVswv9Swx0FqYWXcnyY0Hxnmetl/hUVg7vZCreCYis3EZBT6dH8aFXiEKVDE7ZgmyHC4vyEX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462074; c=relaxed/simple;
	bh=K4UcjnUezF0qgQQhwKLrhjcWPbcfz3yDCnnpkkFGKnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7Hj0gyLkwytXtXUAxYXbE2+Ku+HunFn1qZMviVtX+I2DO5krs0dUAWPPDKIn5Tx7NYaAmXMohsn8G1zmXPC+naM/HG+gsNH4mrXzh0oFZa8/cD5rm4bbqJC+u44JQGMbVaOVkt3CSZQoiVvC9BXxfO1KpR5Osh+TbXdLnVGOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHzFovP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHzFovP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310B01F000E9;
	Tue, 11 Aug 2026 15:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462072;
	bh=scXxx601mt6vWMI18eOyOCejMZkwRvYbtnRftKjb/YQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FHzFovP2ddptgqb3hUEvdYZm6detD/ssggmG4/VehxrJFPlKYr3AoHpl+Cl061n/Q
	 XwHNbmac91L5kjKEbP44HyUcCzpoFZVEQOIFI3jE1qdDLunr+2K2rpPKO7nOQWJd/O
	 lCtxmyXeNzFLG5fKWBCQSBt6Ym7PbgQACBiQ/OCxgwLrSiwgtH8vQp1423vDzWY1Ca
	 /Fi8ttEuz/NMACiIjb1Ev/Ssa48QEZdVsKfjMZI9/rvwFE731aPQuWt5tlQm2wsNyo
	 W8E8lmiDjPnUZGb+h/iWbPwEv3lffjvcpoI/bbcOmS5WjuthK9+RlPBnBRonENDli7
	 bXol+3srViP+g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:25 +0200
Subject: [PATCH 04/11] coredump: move the negotiated mask into struct
 coredump_params
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-4-cd3e8b1e356d@kernel.org>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3058; i=brauner@kernel.org;
 h=from:subject:message-id; bh=K4UcjnUezF0qgQQhwKLrhjcWPbcfz3yDCnnpkkFGKnU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2ycEOEd3hNmfvLDqgNbj7Ue75e40zstJfHnv35OdK
 4wyj3z72lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR4mhGhstCNx/da2gS2O0z
 o7nKW/+dkFpcRI9pk/RJ/2V8bgye0xkZtn56VvldIHAfe1rbjNR4A76EJanPpX4mWJW7PHvy5U4
 ZPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The coredump server negotiates a set of COREDUMP_* options with the
kernel. The core dump path cannot see them though.

Move the mask into struct coredump_params so the negotiated options are
available to the core dump path.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c            | 15 +++++++--------
 include/linux/coredump.h |  2 ++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 235b54484107..e5463e3b3f4b 100644
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
@@ -853,7 +852,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
-	cn->mask = ack.mask;
+	cprm->mask = ack.mask;
 	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
 }
 
@@ -1122,7 +1121,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	}
 
 	/* Don't even generate the coredump. */
-	if (cn->mask & COREDUMP_REJECT)
+	if (cprm->mask & COREDUMP_REJECT)
 		return;
 
 	/* get us an unshared descriptor table; almost always a no-op */
@@ -1130,13 +1129,13 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
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
@@ -1144,7 +1143,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
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


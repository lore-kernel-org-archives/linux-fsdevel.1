Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B339FCA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549261; cv=none; b=LD5mEiAQ0vIaJWe86xcTbXhnr3Ka+E6fHsyNpbGGzhAXa8WA71x4J6fC+M16exAROJoEw00UF+Swoz+QEnwwKojLx7QGCUONu8ENoA3Y7d0MLYKYu/eRsOI8BJ95i5ALdeDlUKGPCYzVzRZ4Ozf4E04gwin99S01swjk5OfL9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549261; c=relaxed/simple;
	bh=WNg46g3df6saNK5G2Aum2Ymkqna2qK01Rs4ISdgpQ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqW7fmPjJhc+O+ZLuZmQNODMOQivnzDBZyU2N/X3oKN4cJ/1WvgEg/7SdwH0nudf+96XK4MRLJmHSCFCRyINNbNQAlfIpfqYYCJDlcrheQVoEVO4Udq7IRFAwH0nn/GaBOH3KSzyFU6YMO3OAL0c6T+mCskLBbp1caIeMfJ+/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=slu1QTEX; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="slu1QTEX"
X-KPN-MessageId: 879e0016-2940-11f1-8a9a-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 879e0016-2940-11f1-8a9a-005056ab378f;
	Thu, 26 Mar 2026 19:20:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=wp7ph0GxfocxZsIU1uEVImJtoPS/WVjNFCt1MEqrtvY=;
	b=slu1QTEXrHWgG05kimQmJ9a26FCWfbsOyhML+dzohYH8fNSkXm8pRLEZ2VvhQfuwiuEAg61K4BpzS
	 qSIvFiM86lTl/ktyELtM2JHpMQJHh/vEs+TFi4NN6IgrBxNV8d2Bouem4atvxsIFrf2lyFLYOOhXZr
	 aR3vPdz/nrzVTG2TGcgccw/323wPkurVKQhfZ09BRwHluMMkvjAluh1UyL0d1PLM6OHpexcDZ7PbpF
	 PWaRr/ONARl3udu3YGEbTgJunbW4rQ/b6n3MrB+QtzyFVupmKCN3mlXjG0f322lBzIvSxCU/OEDL+2
	 AEoNSYtSqO172AibZ0we7BqzPcHjPZg==
X-KPN-MID: 33|rH5hobd8/6jtUJ3oiLxHqIY7sIjORh1wdRl/NNNET8aIOoKQB9TYznHC+wzLkGu
 +57m2tu5xeMr3e4KDsxUsAsB1iiQISnb7AyjukJwtpRo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Jpl9iEIpLwgdokdBnzNtFB93C9Cc3shXD4J32mEevdlmUSsVQQVYz1ReT71Tocx
 0cfoCuOatNz/Nps0KCfm6yw==
Received: from daedalus.home (unknown [178.231.230.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 872137e8-2940-11f1-b8e8-005056ab7584;
	Thu, 26 Mar 2026 19:20:55 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	NeilBrown <neil@brown.name>,
	Oleg Nesterov <oleg@redhat.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 1/3] vfs: add support for empty path to openat2(2)
Date: Thu, 26 Mar 2026 19:20:12 +0100
Message-ID: <20260326182033.1809567-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
References: <20260326182033.1809567-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To get an operable version of an O_PATH file descriptor, it is possible
to use openat(fd, ".", O_DIRECTORY) for directories, but other files
currently require going through open("/proc/<pid>/fd/<nr>"), which
depends on a functioning procfs.

This patch adds the OPENAT2_EMPTY_PATH flag to openat2(2). If passed,
LOOKUP_EMPTY is set at path resolve time.

Note: This implies that you cannot rely anymore on disabling procfs from
being mounted (e.g. inside a container without procfs mounted and with
CAP_SYS_ADMIN dropped) to prevent O_PATH fds from being re-opened
read-write.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/fcntl.c                   |  4 ++--
 fs/open.c                    | 11 +++++------
 include/linux/fcntl.h        |  5 ++++-
 include/uapi/linux/openat2.h |  4 ++++
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index beab8080badf..d9ae3c71edfe 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1169,8 +1169,8 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
-		HWEIGHT32(
+	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+		HWEIGHT64(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC));
 
diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..e019ddecc73c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1160,12 +1160,12 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | OPENAT2_EMPTY_PATH)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
 	struct open_how how = {
-		.flags = flags & VALID_OPEN_FLAGS,
+		.flags = ((unsigned int) flags) & VALID_OPEN_FLAGS,
 		.mode = mode & S_IALLUGO,
 	};
 
@@ -1185,9 +1185,6 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
-	BUILD_BUG_ON_MSG(upper_32_bits(VALID_OPEN_FLAGS),
-			 "struct open_flags doesn't yet handle flags > 32 bits");
-
 	/*
 	 * Strip flags that aren't relevant in determining struct open_flags.
 	 */
@@ -1281,6 +1278,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & OPENAT2_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 
 	if (how->resolve & RESOLVE_NO_XDEV)
 		lookup_flags |= LOOKUP_NO_XDEV;
@@ -1362,7 +1361,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (unlikely(err))
 		return err;
 
-	CLASS(filename, name)(filename);
+	CLASS(filename_flags, name)(filename, op.lookup_flags);
 	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..d1bb87ff70e3 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -7,10 +7,13 @@
 
 /* List of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
+	 /* lower 32-bit flags */ \
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | \
+	 /* upper 32-bit flags (openat2(2) only) */ \
+	 OPENAT2_EMPTY_PATH)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..c34f32e6fa96 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -40,4 +40,8 @@ struct open_how {
 					return -EAGAIN if that's not
 					possible. */
 
+/* openat2(2) exclusive flags are defined in the upper 32 bits of
+   open_how->flags  */
+#define OPENAT2_EMPTY_PATH	0x100000000 /* (1ULL << 32) */
+
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.53.0


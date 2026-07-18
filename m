Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490298472
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784371455; cv=none; b=Yf9nRPS7bRqz66AzHErgvP+RoLCpXFdPEBQidry+/hGWkCe0e3jPW0lOF2iU2ljZfkQbibS9A8jT808Y6hGJYtzlyoE+6U+5DWrbEtbjC34Y56B/gJn/5O70CAbNN9wHOrTj6+qt0OaAJHGXiS3ILrn6mKYZiqs4e0KTfntJjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784371455; c=relaxed/simple;
	bh=sJZ/oVm+IyqW3W3J/56clRoccgMUsfCCDvhwOYP5DoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIpv7AV506fgjMdlo9jTypBG+r4VNbEJzR0Hy0L9Lgat2er8ebzTjDPFvihFSL7Fp6K8RrGdLUvm0N7NDCLRI184scjwrw7X/TJSAiso3w1kxgXyA6Z4FmImJHpk6qQCkXTMwm15OnZIaOvKDvgeicdZCte56YoaYDxa5F0HkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMt+NaKU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMt+NaKU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf452def93so4091885ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 03:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784371454; x=1784976254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2v0lgDxsHiWBF1xIQd5V0uZWU5jR2HpPjOJkDAUraK0=;
        b=LMt+NaKUmsbpJ6MKTLf8HMG99VGxoPgWJo6GRDwOGiJeheCaviMvdHlEi9Ya8rlrgJ
         JSIECUVWOhGYuJUsn3PNmO16Tf3I5/8QMHO8JnEN4tjWh0EXb6OFYBX5n7EHhrK0ILB/
         h51qx0Y+yTyMHiyhfnc5i22lxP3KILVu1VowaoO9uii9T94wthjfM3SdlXQc1hyO0XCK
         TW/pyOjMTBVwM3RtYlqU2Mt49EaYyO6MIlKHufTRLJL5LaUQ3SFP/6Vg4feTwn3UaKoT
         /AfK9n7MGUmcPkDlhevbeLN+8YWTH6t27dPfM9W4dbP9M3XNmajbAzp5HQZqJ7j190YL
         Jd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784371454; x=1784976254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2v0lgDxsHiWBF1xIQd5V0uZWU5jR2HpPjOJkDAUraK0=;
        b=qFQifoyp5Ibq529Y3qkAxs+EI7l/e74oO8jtYNymZUzhX8w1h2XDBLglwNKfDrFbAK
         7TKyokn1FlkP+DmBpzSiL0TA+H/VcR8lvmul9Zh95r8Zqi9VS63D2aINNnmzQpe78IfY
         JwzL1suvykhnVKdwAYj9It1locrGOEWNoNf3uycMAtQXRvWvqyd+KhOEJ8wQXaSL7dF4
         k/9anH2b8u8PO9i263oUDLGAWNALsVZ5BqTasvD5YqmHuIlg2EOOGzYDlkiLKgzkNg/s
         lez69+IRGVi07rHC2cmSpdGV2Du0brKUHV7mCJk8esPVB90i0KECUO287jAznZsS2UE4
         xeUA==
X-Forwarded-Encrypted: i=1; AHgh+RoZtNM5czK+/7a7LE5mXXPMwgiupvizt+DiAqgYmPA7JsPqyNq5AMeHTJ4YjpCPWMUYAv14sYucoBhY82mu@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2z9ySTXYTiJfzhME3tURK16Tw7D86sZIcx8VEu4e3E/J9B+8
	ivccezyc+jmAlGynYFBI8aDb3vZ+peLKyGBN7Cnsn0J/GY/swNyTTSDD
X-Gm-Gg: AfdE7cm/cv+Ypj04HpbhLCI9X6cl0/QzNB6z+84BtPZmYzNTSj+V9GzDOWHOvqpsmCl
	PIP5J98zhnCdhhOqOghXX1NX86vEMbYhcD38qGUZPqP6SI1YS36qGDgvU7xNSIa/3kSFj7KcuhA
	bHWstNa0+zQwmet+VJYXAZknQJHM4ayB4s6PCx4OS/rFFJrCsX6a2kto3H/tDVEKsbl+G26KtyB
	w5tPAIyR36rwv6v79r+taA5PQfbz6v0f8jeTiY3h/9UFdWMBedRqCAC083AHGWKt9nlVCk5oGIJ
	cy6CKSwpWJZIqGxJ6aCnWoXLMtHcgB138i0k0HkuDcT3K5CGZ7GvDylW5WJhK/Zf4Y5pcsvgpt2
	FQwTtjwCqJgF4W/M0jBGckFVb8Q/kkGh3NVpUGXVtoxZ/EgXByCiLM8nIODGsYzk7g4PaUTW3si
	IIZB3fB9hJMTU=
X-Received: by 2002:a17:903:3810:b0:2c9:fc0d:165b with SMTP id d9443c01a7336-2cf1f544ef8mr111893345ad.23.1784371453528;
        Sat, 18 Jul 2026 03:44:13 -0700 (PDT)
Received: from 2045L.localdomain ([36.112.122.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347119dfsm25525175ad.56.2026.07.18.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 03:44:12 -0700 (PDT)
From: Guidong Han <2045gemini@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Qi Tang <tpluszz77@gmail.com>,
	Junxi Qian <qjx1298677004@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eventpoll: pin files while checking reverse paths
Date: Sat, 18 Jul 2026 18:44:06 +0800
Message-ID: <20260718104406.27897-1-2045gemini@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 319c15174757 ("epoll: take epitem list out of struct file")
intentionally removed temporary file references from the reverse path
check list. At the time, both epitems and their files were freed after
an RCU grace period, so unlist_file() could obtain file->f_lock through
an epitem while clear_tfile_check_list() held rcu_read_lock().

Commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") made
struct file SLAB_TYPESAFE_BY_RCU and removed its RCU-delayed freeing.
RCU still protects the epitem, but no longer keeps the referenced file
from being freed and reused. A concurrent close can therefore make
unlist_file() lock or unlock f_lock in a recycled file object.

This violates the documented SLAB_TYPESAFE_BY_RCU rule requiring a
reference before acquiring an object's lock. The race was reproduced,
causing a wild unlock of f_lock in a recycled file and breaking its
mutual exclusion.

Add ->file to epitems_head to remember the pinned file independently of
->epitems. A concurrent EPOLL_CTL_DEL can empty ->epitems before the head
is unlisted, leaving no epi->ffd.file from which to drop the reference.

In list_file(), acquire the reference before adding the head to the
check list. The caller either owns a reference or holds the ep->mtx for
the epitem leading to the file. In the latter case, file_ref_get() can
fail after the last reference is dropped, but eventpoll_release_file()
must acquire the same mutex before the file can be freed. The dying leaf
can be skipped because removing links cannot increase the reverse path
count.

In unlist_file(), epnested_mutex excludes another list_file() or
unlist_file(), while head->next prevents a concurrent EPOLL_CTL_DEL from
freeing the head. Save head->file locally, clear it with head->next
under f_lock, and drop the reference after the RCU-protected operation.

Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Junxi Qian <qjx1298677004@gmail.com>
Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
Cc: stable@vger.kernel.org
Signed-off-by: Guidong Han <2045gemini@gmail.com>
---
SLAB_TYPESAFE_BY_RCU allows a slab slot to be reused while an RCU reader
still holds its old address. Once that address contains a new live
struct file, KASAN sees valid, unpoisoned memory and cannot distinguish
the stale object identity. CONFIG_DEBUG_SPINLOCK exposes the failure
instead.

The failing interleaving is:

CPU0: nested EPOLL_CTL_ADD             CPU1: close/open churn
------------------------------------   ---------------------------------
p = hlist_first_rcu(&head->epitems)
epi = container_of(p, ...)
                                       close(victim)
                                         __fput()
                                           eventpoll_release_file()
                                           file_free(victim)
                                       // the slot is free; f_lock remains
spin_lock(&epi->ffd.file->f_lock)
                                       open() reuses the slot as new_file
                                         spin_lock_init(&new_file->f_lock)
spin_unlock(&epi->ffd.file->f_lock)     // wild unlock of new_file's lock

CONFIG_DEBUG_SPINLOCK reports:

BUG: spinlock already unlocked on CPU#0, poc_unlist/150
 lock: 0xffff8880067fb200, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
CPU: 0 UID: 1000 PID: 150 Comm: poc_unlist Not tainted 7.2.0-rc3-dirty #22 PREEMPTLAZY 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x64/0x80
 do_raw_spin_unlock+0x75/0xb0
 _raw_spin_unlock+0xe/0x30
 clear_tfile_check_list+0x88/0xe0
 do_epoll_ctl_file+0x519/0xcf0
 ? __pfx_ep_ptable_queue_proc+0x10/0x10
 do_epoll_ctl+0x8f/0x100
 __x64_sys_epoll_ctl+0x6f/0xa0
 do_syscall_64+0xdc/0x520
 ? srso_alias_return_thunk+0x5/0xfbef5
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x42034e
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 e9 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007a657ff3c198 EFLAGS: 00000202 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007a657ff3ccdc RCX: 000000000042034e
RDX: 0000000000000003 RSI: 0000000000000001 RDI: 0000000000000004
RBP: 00007a657ff3c2f0 R08: 0000000000000000 R09: 00007a657ff3c6c0
R10: 00007a657ff3c1a4 R11: 0000000000000202 R12: 00007a657ff3c6c0
R13: ffffffffffffffb8 R14: 000000000000000d R15: 00007fffb7de0210
 </TASK>
------------[ cut here ]------------

unlist_file() does not appear as a separate frame because it was inlined
into clear_tfile_check_list(). This report was obtained with mdelay()
instrumentation immediately before spin_lock() and spin_unlock() in
unlist_file() to widen the two race windows.

More importantly, this is a wild unlock. The stale unlock can target
f_lock of a different live file and invalidate mutual exclusion for
state protected by that lock. Turning this into a reliable exploit
would require precise scheduling and same-slot reuse and is likely
difficult, but the primitive is potentially exploitable.

Qi Tang and Junxi Qian helped identify this issue and are therefore
credited by the Reported-by tags above.
---
 fs/eventpoll.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0e65c7431dfc..eed8cecd94e3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -459,11 +459,14 @@ static struct kmem_cache *pwq_cache __ro_after_init;
  * Wrapper anchor for file->f_ep when the watched file is not itself an
  * eventpoll; for the epoll-watches-epoll case, file->f_ep points at
  * &watched_ep->refs directly. The ->next field threads
- * ctx->tfile_check_list during one EPOLL_CTL_ADD path check.
+ * ctx->tfile_check_list during one EPOLL_CTL_ADD path check. The ->file
+ * field holds a reference to the associated file while the head is on
+ * the list.
  */
 struct epitems_head {
 	struct hlist_head epitems;
 	struct epitems_head *next;
+	struct file *file;
 };
 
 static struct kmem_cache *ephead_cache __ro_after_init;
@@ -480,6 +483,16 @@ static void list_file(struct file *file, struct ep_ctl_ctx *ctx)
 
 	head = container_of(file->f_ep, struct epitems_head, epitems);
 	if (!head->next) {
+		/*
+		 * The caller owns a reference to @file or holds the ep->mtx for the
+		 * epitem that led here. The latter blocks eventpoll_release_file()
+		 * before the file allocation can be freed and reused. A dying leaf
+		 * can be skipped since removing links cannot increase the reverse
+		 * path count.
+		 */
+		if (!file_ref_get(&file->f_ref))
+			return;
+		head->file = file;
 		head->next = ctx->tfile_check_list;
 		ctx->tfile_check_list = head;
 	}
@@ -489,15 +502,18 @@ static void unlist_file(struct epitems_head *head)
 {
 	struct epitems_head *to_free = head;
 	struct hlist_node *p = rcu_dereference(hlist_first_rcu(&head->epitems));
+	struct file *file = head->file;
 	if (p) {
 		struct epitem *epi= container_of(p, struct epitem, fllink);
 		spin_lock(&epi->ffd.file->f_lock);
 		if (!hlist_empty(&head->epitems))
 			to_free = NULL;
 		head->next = NULL;
+		head->file = NULL;
 		spin_unlock(&epi->ffd.file->f_lock);
 	}
 	free_ephead(to_free);
+	fput(file);
 }
 
 #ifdef CONFIG_SYSCTL
-- 
2.43.0

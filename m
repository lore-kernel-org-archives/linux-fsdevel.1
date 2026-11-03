Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707466;
	b=RMSmITiyXX2gGt2aIr5NfiqcZpxagYISJ6Z3rlb+qX0YyeQfHWREV++bGzlBl8duAgFv
	 87LyEwHtzlFHqJmYcyBLecahF41o4FqKP2vIPmDCh2la5Gv6dsm1WOKVXGrXwFlgl/26Y
	 uDyyft6gzuKL4qTnoBrjhRp7uZ/iVuHTTC/vUavIOBxhtZXXsbXsBrb2bk0GeNW0bo8Gy
	 rGr+6Ii5EO2KVy7OEc4zGjZXxLE4ID2LP6+SAR5JkgozlDRpKohJojgwk8WimRip9Vqqw
	 f3PqLNNsXVsh/0nFzJC0Fl47yJtLXQGyH2zar1K6pGltqhkK4HHcqTRgsxT0sZGtMMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707466;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mEwLLdrHJrQ/NsScjy7j1X0u8odezPCl9Iof1rhDrEA=;
	b=gv4KUPDBqHvN7Ol2ghrbb+GKUXtnizQelevbfNNeX6Z1FLYCB4QZ9i/FaB9Q3JR4uRRY
	 MfJLMge+32FDGQ3akJ8rWJp/8msL/Q2oc02kG3BINRnPYuLxcpxZo7CJeXBTLYfpEK5jh
	 PZ4ePYNuyClb9Ci7WR7YOL4qUPCSthwMtKB6z+Iwovqxr5YojZ+RykR0QNHBQuNT64nRL
	 bfmtr+1fXi48fsqQMAgjMQTo5yrSpQ1VMpbHJV4a52IT38lJedKau1IDXsUCOKN4gsrSW
	 kcVVyXP2lvC5QE3xqWWaY/ipR4Ea6gCJMUvSmTaGlFdT/FV+/U20PnvzWpN9maz8vTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id6VUuDg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BB6606A327;
	Tue,  3 Nov 2026 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=id6VUuDg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF3D1F000C1;
	Tue,  3 Nov 2026 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707466;
	bh=mEwLLdrHJrQ/NsScjy7j1X0u8odezPCl9Iof1rhDrEA=;
	h=From:Date:Subject:To:Cc;
	b=id6VUuDgDalCc/OLTw1GurziLky+sjL2wF7xdneKV9YoF9yX/kAIILTV0z+JoaozQ
	 JcZZjJNgkvyc4m8zPHKHweQ53unzTIItBLCw3lwTw4GjH5po9DCh036oPZd6FsAoO2
	 /7xrDBxdor7l/H7Dn4uQjgDaeTwG2mCk/7YfDfhR1PQlBS1jwI/tR5opo6qciNW4aA
	 mtCfus/rUQbjOTtYhzInAYeDTgJrQND73V9cg//h+9rUlAhXHMDA37jd/LBh7NfG5o
	 xZGSl5zvLhgxPr31cwcAjxwbZYDiW0dOHMG9vJqzOjxLafmJCGgT4+jcVI+KBWg69J
	 7gsNiUiI+T/Ag==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Nov 2026 07:04:00 -0500
Subject: [PATCH v2] statx: don't leak STATX_ATTR_CHANGE_MONOTONIC in
 stx_attributes_mask
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
Message-Id: <20261103-statx-v2-1-8b09aa8118ab@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQrDIBCF4auEWdeiBox21XuULBKdJEOLFhVJC
 d69Nssu/8fjOyBhJExw6w6IWChR8C3kpQO7TX5FRq41SC6V4NKwlKe8s34RTlunnR4GaN93xIX
 203mMrTdKOcTPyRbxW/+FIphgRnFu3ayNmvv7E6PH1zXEFcZa6xfJAKi/mwAAAA==
X-Change-ID: 20261029-statx-3f1d8cd8d877
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2562; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9BiR5klPaco+RCB2Fympo8uiJ4nYJ+mvlQXm+7gDyh4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBq6c3DIZ5jAtscRBJejfwqqD6iOdkrBrps1cWt4
 1r7rOZrDGCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaunNwwAKCRAADmhBGVaC
 FYchD/0faPlpb0O4UuuYvZp8NqBCF1f+Jp09ZsIdWWPUO/ZKsMBkVQ8qUuxeEZ+aoAWn2LIcuDd
 0HKFMYLwFjwzceSa+gcphaUvW6ZHSufJNHHd4j33Nm1l4twMVA0wAq6HsgTEgQ8EX2a6OCgXt3u
 3q2A9mm01R3B7ZTZvjrwjpJM7zG4AKnZvwStT0EY+4H9zZsqh7h5J8k29jwUiyYb8FtzOJTlrsv
 a2+B9puGXV5WGtHYDT0e6cDJrTVg3RU4fcLaKzXUPS451ak3MFzmRwyh7EVg9Rrynks6ib7g3+y
 yByk1vScNDWnp+KR9Q0CMq3z1aitmzNS5QsaAyTOnKx8NlKmovycilFQYIWb84OjQ4CksvtMs8+
 5knyQalkqLnaXQjy1FTR9Z/hrns+1riukBDdele3DzhLhExChesRFB5EQgkNBn8KxgbViiEIDlb
 UJ76Zrga3NZ7XLlTfkHxyvYdnn5IXyfE0ETLWJ+2QcTFE8J41pXfKuGiGTtSnoniMgbnNQTgI9D
 SD3W3eNhUJ4vfGZlNZiWrUQx+RLUJRDU/+r1Bb/jKbDWMBP7H968/L/4PPdDFfgQW52iod1gIRx
 sajDICFhyjaF+F8EtBbTer28miZZ3PMh3mm7z37bVUCYUEX4tnWyS8jp0Qc6S+q+AZz5VRhiYVp
 oYSL3OvbcojxeLg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

STATX_ATTR_CHANGE_MONOTONIC is kernel-internal. cp_statx() strips it
from stx_attributes but copies attributes_mask verbatim, so it leaks to
userland on filesystems that advertise it (nfs, ceph), e.g.
stx_attributes_mask = 0x8000000000303000 on NFS.

Add a new mask constant and apply it to both fields.

Fixes: a1175d6b1bda ("vfs: plumb i_version handling into struct kstat")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- Add new STATX_ATTR_INTERNAL_MASK constant
- Keep lines below 80 columns
- Link to v1: https://lore.kernel.org/r/20261029-statx-v1-1-9600cdb896b3@kernel.org
---
 fs/stat.c            | 6 +++---
 include/linux/stat.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index a2e63c6c45b7..34d786c1de3e 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -710,8 +710,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	/* STATX_CHANGE_COOKIE is kernel-only for now */
 	tmp.stx_mask = stat->result_mask & ~STATX_CHANGE_COOKIE;
 	tmp.stx_blksize = stat->blksize;
-	/* STATX_ATTR_CHANGE_MONOTONIC is kernel-only for now */
-	tmp.stx_attributes = stat->attributes & ~STATX_ATTR_CHANGE_MONOTONIC;
+	tmp.stx_attributes = stat->attributes & ~STATX_ATTR_INTERNAL_MASK;
 	tmp.stx_nlink = stat->nlink;
 	tmp.stx_uid = from_kuid_munged(current_user_ns(), stat->uid);
 	tmp.stx_gid = from_kgid_munged(current_user_ns(), stat->gid);
@@ -719,7 +718,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_ino = stat->ino;
 	tmp.stx_size = stat->size;
 	tmp.stx_blocks = stat->blocks;
-	tmp.stx_attributes_mask = stat->attributes_mask;
+	tmp.stx_attributes_mask = stat->attributes_mask &
+				  ~STATX_ATTR_INTERNAL_MASK;
 	tmp.stx_atime.tv_sec = stat->atime.tv_sec;
 	tmp.stx_atime.tv_nsec = stat->atime.tv_nsec;
 	tmp.stx_btime.tv_sec = stat->btime.tv_sec;
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 9c5709132862..4f0a4af7a067 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -69,4 +69,7 @@ struct kstat {
 /* file attribute values */
 #define STATX_ATTR_CHANGE_MONOTONIC	0x8000000000000000ULL /* version monotonically increases */
 
+/* mask of STATX_ATTR_* bits that is private to the kernel */
+#define STATX_ATTR_INTERNAL_MASK	(STATX_ATTR_CHANGE_MONOTONIC)
+
 #endif

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261029-statx-3f1d8cd8d877

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


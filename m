Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963422;
	b=aE+mpnCOO10t88WJOUXhEpk6LR7K/7E8kxMFEKjeFC2z1ktgzOz3z77DuuqjWCGX1EfM
	 RPAGKhWUyz5lTKty7EZbX0IPA4XLY0Nw3aRJAjBlSQ/ucKmhflk86FEUIoj/oVU+vP9HA
	 exD1ViiT0KAoKE6qUBybSq3fVjgFxLS0eZAa4VvKW0mkD7AhzYJo1DvQFi7Nr03eHrv6T
	 i7Q9flquEntwQdswv1yL0Qx1+vJ5DVwQSolqK+72DtyxpTq5VmraSkzTGkaXfYOxT/b1U
	 nuTOzFkBoY2dLLcMUcJBcuWhN0cTDbKlvJfWc1AgVTBFOuf6Pl+1/qePrklm6JF3Hwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oeattwECPU0zNFydieCS3AExCz1X9vo7Z8coC/cH1aQ=;
	b=13yCtsmXxSoo/lFfutMjoHM5DB0moSjNITAelCJGs5e9D6MQNrHdEzznEPPiVssFEPFi
	 +TRBwVnxh7e7pbWxxxd+uG2hj8CE3Sf7ItIk68+DGqG0l+3YySF16gFOg6Yy+votbXFyd
	 ByPqp6PX4ATCWgXihCFYfUZ5wcutN8HXHN0scBE0q3yU2HZB5ywLHohao3pZiZiFBE2Zn
	 y0Sy4UEogJAqS1jI68Dy8sBHztt14C81JO4EmQsxnv9+i4GONTxy1ohRTtLGDVF1RhpIh
	 GotqEOb6TRp+nuMUjBYoIi1jpVjN5Q9/3cy2qLwmwjI1M4fwqrc9lHa/FL7kgaAcPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjTwgHru;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A0606A33E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 11:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA7A0606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IjTwgHru
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so4550395e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 03:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793963420; x=1794568220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeattwECPU0zNFydieCS3AExCz1X9vo7Z8coC/cH1aQ=;
        b=IjTwgHru6kogC5bm2QamChGSGAqWL9U+tfdfrMbOj5Tpj047PDb+A7v3D6TEM+7zaR
         bh3453txCU6uG/bxC1k4KbSKT1jc9lBw8YToXw+oTJahs4PVgORklonU/XrwMKyUA+8/
         y8j6/m2mOSqap3xjPkxw0fWyaeHJpsBmcpN9zPk2oYFgiBa0fqL3yYjRlMfUXcbQhfg4
         141EQW3FnlEcEK74zR2OhBewpMe0vcYyXqhTkO7wbS99rH1Bft5ZGKVkH1WMckVKY8Ts
         CaVNpn5OKZYoy8Vq/zs1w0w/Pk7XKMH1InzCHtFsnBZGHjNmr2TOv90Qc4/3zlKZHu/s
         dguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793963420; x=1794568220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeattwECPU0zNFydieCS3AExCz1X9vo7Z8coC/cH1aQ=;
        b=CiRI5X1ssfzAh5ljPTqyBYsW8ASJCyZ+Ns/UxiLIRtLkwGgqzmunyzFZFJDrLHOubS
         ZbppcdLwR73Hf5LKSz/K/Oj3LUsMly2w1eJeymI5gkrdA+MPQzyfXVjxX+8b0B1yS1sy
         cL96FH06vRiR1dvNsACkKHczB9Gr1RjmVnbHzEMo0wZcwkSU56/DdAtKHpA6c5nAlgrP
         TPG9Cf+/XGWD/GJg9l+6GJ4X7lkCv9a2+Z3jlVZz4SDiFQrjzHL71UobknuGifaxWgtQ
         5IDpf5OMglZwdVvwUOuU8U7QomyJ1IwZo7C2rUWzM8OlI/7lpLAJyz+D7zzYMv5gd/w3
         fL5Q==
X-Forwarded-Encrypted: i=1; AKwUvByLcd2/f0NbkxmJKiD22qj/er6R0COH6tOlFsHL0a5NVpJ70I1oDpkFURJOkpOYSn0xesbvUCH9vZts2A7/@vger.kernel.org
X-Gm-Message-State: APuU4Z+R8qgZ/+eZPZiaTbNpBiirV1ixGTX8pn+XI7/nVBeEuEhKPfs5
	Jbpf71USEO1EPvSyV/sjfXXV5K14CdlEOgaE/YmZ70QnYfiPGDE+CUiZ
X-Gm-Gg: AYBFou2DxnDqWoFGnrlNQovSXWxWGCCjZCbTdY+RbgUr2awCzX/kUfcEzbPxaXVjxBJ
	2wrLtaH2GF/dnpJkgH5T61PFqxdJ7yzFJSL0CkDp6+YVp1jZCO5xRgvCdwrIaV/cu/kdWGeCkXk
	+1d4aK63KPXCRwufpXBrKDiXHK7a2aD101XyK1a35Ea1educkeaSu64/0Zhqtqs5/Udhxj2N8HQ
	HNfwDPtVwm6Uid1ue+hBSlYd+nFeUqrtnULIBjB0qyiBjVp2JjY3Ls0fN4vXZg26LzLPPS1NYmn
	NSJKtF1btsqIiutntqZU5SIAjx4bQwf+mw0r0eJ2+poF7oRf9a6T0Z8OaOEz9bRsQEtBGXGQbuj
	whd7+z1pWhSGRTbXjlCcc2h/1SAugjGLDaxfip1NjBL8ZCEjZc1O5N9nPD2QUe8PoNiGyRwvPDC
	tnJ18s5ypUWtjTF+WLwUil+7Ndp/hcvzCId/wUd4mwwk9ncdZOPDs7s/Xpo61BC0xOpX/vS/VXZ
	rkqsPczt+ivC2h/1Sa/i31l86atnHzNSUgJpKwudJMw/x3avoeqgrnmRQ0FpiNwmEx+K0ZDUeK8
	lKx9h9FmHiERhI5sA93YKDEqdGu40ctBEG2KyoAHWRM3hxaX70Vqmc4AhAb7DA0vbgwJTlN7TW7
	LSM8Q6Z4/dVp/0u2wr1iLOonFUN+m4MnCvFEDM+SeWiHThM2Y0HDYMNHIKvWZzwAPETPBja3Z7e
	/YVOE=
X-Received: by 2002:a05:600c:8708:b0:4a1:8dd1:305a with SMTP id 5b1f17b1804b1-4b55a00bdf3mr115102715e9.0.1793963420006;
        Fri, 06 Nov 2026 03:10:20 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.0.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7233297sm3280485f8f.27.2026.11.06.03.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:10:19 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Paul Moore <paul@paul-moore.com>,
	jmorris@namei.org,
	serge@hallyn.com
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com,
	neganhat@gmail.com,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH v2] lsm: don't call d_path() when current->fs is NULL
Date: Fri,  6 Nov 2026 12:10:16 +0100
Message-ID: <20261106111016.5783-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When the last reference to a file is put from exit_task_work(), the task
has already run exit_fs(), so current->fs is NULL.

syzbot reported:

Call trace:
 get_fs_root_rcu fs/d_path.c:244 [inline]
 d_path+0x224/0x4dc fs/d_path.c:287
 audit_log_d_path+0xdc/0x19c kernel/audit.c:2221
 audit_log_lsm_data+0xe0/0x12d0 security/lsm_audit.c:199
 dump_common_audit_data security/lsm_audit.c:421 [inline]
...
 security_file_open+0xec/0x258 security/security.c:2739
 do_dentry_open+0x2a8/0xfbc fs/open.c:973
 vfs_open+0x44/0x2dc fs/open.c:1101
 dentry_open+0x74/0xc0 fs/open.c:1124
...
 security_file_release+0x84/0x148 security/security.c:2424
 __fput+0x2c4/0x74c fs/file_table.c:506
 ____fput+0x20/0x30 fs/file_table.c:541
 task_work_run+0x1cc/0x25c kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x58c/0x1a74 kernel/exit.c:986

d_path() renders a path relative to current->fs->root.  After exit_fs()
there is no such root, and no substitute root is meaningful: the
record's pid/comm describe a task that can no longer name the file, and
the file may have been opened by a different task entirely.  Falling
back to another root would produce a well-formed but misleading path,
so report the field as path=?

Handle this in audit_log_lsm_data(), where the meaning of the field is
known, for LSM_AUDIT_DATA_PATH (Smack file_open), LSM_AUDIT_DATA_FILE
(SELinux file_open), LSM_AUDIT_DATA_IOCTL_OP and the AF_UNIX path in
LSM_AUDIT_DATA_NET.

Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
v2:
  - Replaced logging from path=(null) to path=?
  - Added audit_log_lsm_inode helper
v1: https://lore.kernel.org/all/20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com/
 security/lsm_audit.c | 70 ++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 39 deletions(-)

diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 955b2e7b2c8e..d92b0823e871 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -169,6 +169,27 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 		audit_log_format(ab, " %s=%d", name2, ntohs(port));
 }
 
+static void audit_log_lsm_inode(struct audit_buffer *ab, struct inode *inode)
+{
+	if (!inode)
+		return;
+
+	audit_log_format(ab, " dev=");
+	audit_log_untrustedstring(ab, inode->i_sb->s_id);
+	audit_log_format(ab, " ino=%llu", inode->i_ino);
+}
+
+static void audit_log_lsm_path(struct audit_buffer *ab, struct inode *inode,
+			       const struct path *path)
+{
+	if (current->fs)
+		audit_log_d_path(ab, " path=", path);
+	else
+		audit_log_format(ab, " path=?");
+
+	audit_log_lsm_inode(ab, inode);
+}
+
 /**
  * audit_log_lsm_data - helper to log common LSM audit data
  * @ab : the audit buffer
@@ -194,60 +215,33 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 		audit_log_format(ab, " capability=%d ", a->u.cap);
 		break;
 	case LSM_AUDIT_DATA_PATH: {
-		struct inode *inode;
-
-		audit_log_d_path(ab, " path=", &a->u.path);
+		struct inode *inode = d_backing_inode(a->u.path.dentry);
 
-		inode = d_backing_inode(a->u.path.dentry);
-		if (inode) {
-			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%llu", inode->i_ino);
-		}
+		audit_log_lsm_path(ab, inode, &a->u.path);
 		break;
 	}
 	case LSM_AUDIT_DATA_FILE: {
-		struct inode *inode;
-
-		audit_log_d_path(ab, " path=", &a->u.file->f_path);
+		struct inode *inode = file_inode(a->u.file);
 
-		inode = file_inode(a->u.file);
-		if (inode) {
-			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%llu", inode->i_ino);
-		}
+		audit_log_lsm_path(ab, inode, &a->u.file->f_path);
 		break;
 	}
 	case LSM_AUDIT_DATA_IOCTL_OP: {
-		struct inode *inode;
-
-		audit_log_d_path(ab, " path=", &a->u.op->path);
-
-		inode = a->u.op->path.dentry->d_inode;
-		if (inode) {
-			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%llu", inode->i_ino);
-		}
+		struct inode *inode = a->u.op->path.dentry->d_inode;
 
+		audit_log_lsm_path(ab, inode, &a->u.op->path);
 		audit_log_format(ab, " ioctlcmd=0x%x", a->u.op->cmd);
 		break;
 	}
 	case LSM_AUDIT_DATA_DENTRY: {
-		struct inode *inode;
+		struct inode *inode = d_backing_inode(a->u.dentry);
 
 		audit_log_format(ab, " name=");
 		spin_lock(&a->u.dentry->d_lock);
 		audit_log_untrustedstring(ab, a->u.dentry->d_name.name);
 		spin_unlock(&a->u.dentry->d_lock);
 
-		inode = d_backing_inode(a->u.dentry);
-		if (inode) {
-			audit_log_format(ab, " dev=");
-			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%llu", inode->i_ino);
-		}
+		audit_log_lsm_inode(ab, inode);
 		break;
 	}
 	case LSM_AUDIT_DATA_INODE: {
@@ -263,9 +257,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 			audit_log_untrustedstring(ab, dentry->d_name.name);
 			spin_unlock(&dentry->d_lock);
 		}
-		audit_log_format(ab, " dev=");
-		audit_log_untrustedstring(ab, inode->i_sb->s_id);
-		audit_log_format(ab, " ino=%llu", inode->i_ino);
+		audit_log_lsm_inode(ab, inode);
 		rcu_read_unlock();
 		break;
 	}
@@ -321,7 +313,7 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 				if (!addr)
 					break;
 				if (u->path.dentry) {
-					audit_log_d_path(ab, " path=", &u->path);
+					audit_log_lsm_path(ab, NULL, &u->path);
 					break;
 				}
 				len = addr->len-sizeof(short);
-- 
2.43.0


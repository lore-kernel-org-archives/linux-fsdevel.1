Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892215;
	b=ii84YE3jR7rljsdgVuaZXZJtd17ZHO6S4PxXY612jDQpnI7/R2o3hCKD5xpaVvgKmbTf
	 Z3VAG4nhD+ph+qMJMS3LQ11MZZGyHSjJMAcMQ4eDzVj+qY994oKNK0kDSJppwEuMhuMCP
	 rbTSWNAoh08MlXd1DW/ZT45QRR8O86T8cDv0/dskyOJy0B1z/wmbG7BoFjQctZNgiaT2q
	 cvvRNXpHVdoWEHiHcS1H+zSvGksRKAbGiy4k0G8cb/5YgDir7byfC/VbPiqtrxtSIbPin
	 WPk9R2El+rdzq915ydUJoklF9ORo2ozDHy7PyiHemHXnY71tXkPid/OyunHG6UHITFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=kdXj6//jxdtcWs7h4JxcJxKLQ6Lk98T2w2GxXOA8Ujw=;
	b=bTpdErjdvIQFNB+Jr/+DU0ehBCD14bmoM/CRVKIPww9Vq/AtIprAwETXB3AIWJbrhJuR
	 1Q7j4wTsvzZUp4ANBE77USqXVrOkm8lGPLR2RX+D+3QCdACIfM39RNKE7Na9tK2cdzMp9
	 BYv3j3mzIxp5fEZGngLTXEvKqEV97AaqZUOasKvGfvWBJZnYSZ4X2Qe408UXkhvAow0Ot
	 jxOhSsDLsGOS8znz/9zAIX8NqAfz2H3JS2jHNvJsszDgMSBMiOXgy0gDQKqExvMV91p7Q
	 ICSiL1bIpDHbLAa3g0tWUcQYB8bd9V/+CZudaIAz7K8m4xdriALu+hUoaILSLNdLODg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jFv7JG3X;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E9606A331
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 393E9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=jFv7JG3X
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so17113465e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892214; x=1794497014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdXj6//jxdtcWs7h4JxcJxKLQ6Lk98T2w2GxXOA8Ujw=;
        b=jFv7JG3XZaJkSmPlPLcfE9OCnqAnrFIHWurWtq5O25T0d3IKJTFJLQ/Tlh1cQdZdF5
         jZe0mRWMpOKGSKlVU7OnUUrtccQJos28SZAjnjAooX9EAk1qDqsSytT2/MABpT0o6cW4
         Te3Q+wfScQdbIEl9gzzkLutwHZkHOSstck/g9x4QgupyhN2uZxfhrATdnH6Aap6zGwje
         YY3hR3y9CsIxwLB/YjwmNnarq3DANSUZsv841ylnVyMBLXVDctsWvYB7fhs2JO7MbycC
         mKDrvns48LjXuMQogYbKDJupivw/9KKxj9x3UvvPVIXjbEMcj5jV4dSOfwjXKADHZKaV
         JYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892214; x=1794497014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdXj6//jxdtcWs7h4JxcJxKLQ6Lk98T2w2GxXOA8Ujw=;
        b=mqHT3w/3qUhmE+yMXrQ7DC0QbVip0Lm8N2S8Uy3bPxGpGFXQy3JJgMdzVCcWkI4/0c
         NK+8ctAuOyyxhm8Di3zEbI9xlAv2TXFTCoND1Rximb9JU/jnGB5s+Ls9JcmafrKoQC0F
         qWbCa9K6V/MMc2wbv6uS+WYOz8qtDUy+VgEJ+GTOqv0RNdW00gTCLo9IgSzEdL8v21vE
         7chm4os/qve5ONSD3hcqOjOnjQpX36N8r69nczJA070wRlocx5dkK5Gr0GKiML+mA7RS
         fFqL905q3Gd44PJcEFIUJT+lfUWKcvFZzf5qF+c0+rU9FEcUTtzMLLCswvE86eiXQWHR
         roRg==
X-Gm-Message-State: APuU4Z9fJK+J9Gi2+PRs4PNVj4bF8lXcMFBu4f6FQX3k3DRNvA8aiXSC
	Bfc4NHltginhKotZ+1/R9VDkkHCJfzi/jF7G/BwCISnFF7qaX6SQ84AOcNFlv3KHgx4=
X-Gm-Gg: AYBFou0iBwYvwNghYSGAirJYdcy1PKoEqifhwtMXN1VRRrFN8S2pP66PbLdCANedCaZ
	5NzvCS6B9y/NVDVgOQ93mJuu8CfxQuul9BiedubyZp/sGs2ook30MkMM2P3pTio5UHmnkmPM0Hn
	9PyxmJc68mR0NO2Ic5E+PXuB4KtG1EfXcjlMuDnDy4U2RAhSsBMSXzREpV2D75sMNfoGLWVyGks
	wcrNegHJezGCN/6l/g3p4xMBwvpHXH5x+7lq84UC0047+KiDZUUnuGrPhe5WIM56f3iV8/2PbH5
	EtG7TV5I4FxpkSDdsbgeN5yjrG7mKRknHqWex8QTKz9Qg/oOTxbSKQWG/o+1H4q48OM3eFkBYjh
	vJsH82mewh50jtHKIIQlI8O1t6vEaMFA/FOHwK+liRFmRmf92x6AdmT36IV3J0puF7BLUZRfnFD
	seKlYLq9irsCB/LVC2JTJAjRnrv8MlwIR+4k6WJ6JriZF98wm1RHw98ECcejOu24sfKR2fi6AHp
	cZVaK9AgZRQ7DU3Lh6RxUhyzelPapBIl4p5O1XQM8EZibJyu5R5E8B9WdO1vOTgayhsVTwqgcGr
	zzeb3kfNW8h8zEIivXHFJtVworOSjabHT768I9efz689
X-Received: by 2002:a05:600c:e547:10b0:4ad:5e09:ae43 with SMTP id 5b1f17b1804b1-4ad5e09ae61mr223607775e9.29.1793892213219;
        Thu, 05 Nov 2026 07:23:33 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fecac1caesm10086281f8f.17.2026.11.05.07.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:23:32 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:55 +0000
Subject: [PATCH RFC v3 63/90] fs: drop privileges from what a cell may
 write to
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
Message-Id: <20261105-b4-cells-v3-63-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=5024;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=/WLGeeEm8E2O/SOVtC/ElmM+tG1LfrcPrZQl9vVf+t8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKS5fAxTghKSICyzvxndkndKJSwBCeYnyHI67j2sLdsxkcKPY/AbqzZwCCaz7i90Wyltyf/Pup1
 em+ZpbT5sfgc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A write() clears the set-id bits and the file capabilities of a file. A
store through a shared mapping does not. So a task of a cell could replace
the contents of an existing set-uid file while the file keeps the bit.

Clear them as soon as a task of a cell opens a file for writing, and when
pidfd_configure() places a file that is open for writing.

This changes the inode at open time, like O_TRUNC, so it is done in the
same place as the truncation, in do_open(). The directory lock has been
dropped at that point, which is not the case in ->atomic_open(). The
change needs write access to the mount, so it waits if the filesystem is
frozen, but only if there is something to clear.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c           | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/namei.c           |  8 +++++++
 include/linux/cell.h |  7 ++++++
 kernel/embryo.c      |  6 ++++++
 4 files changed, 82 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index f63535ee3629..d32c14217420 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -4,6 +4,7 @@
  * (C) 1999 Andrea Arcangeli <andrea@suse.de> (dynamic inode allocation)
  */
 #include <linux/export.h>
+#include <linux/cell.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
 #include <linux/mm.h>
@@ -2379,6 +2380,66 @@ static int __remove_privs(const struct mnt_idmap *idmap,
 	return notify_change(idmap, dentry, &newattrs, NULL);
 }
 
+#ifdef CONFIG_CELLS
+static int cell_privs_to_kill(struct dentry *dentry)
+{
+	umode_t mode = d_inode(dentry)->i_mode;
+	int kill = 0, ret;
+
+	if (mode & S_ISUID)
+		kill |= ATTR_KILL_SUID;
+	if (mode & S_ISGID)
+		kill |= ATTR_KILL_SGID;
+	ret = security_inode_need_killpriv(dentry);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		kill |= ATTR_KILL_PRIV;
+	return kill;
+}
+
+/**
+ * cell_file_drop_privs - a task of a cell is about to be able to write @file
+ * @file: a file open for writing
+ *
+ * Nothing a cell writes imparts privilege. A write() drops the set-id bits and
+ * the file capabilities of what it writes to, a store through a shared mapping
+ * does not. So for a cell they go as soon as the file can be written at all,
+ * and they all go, whatever capabilities the caller has.
+ *
+ * This changes the inode, so the caller must hold no inode lock and no write
+ * access to the superblock. It waits for a frozen filesystem, but only if there
+ * is something to drop.
+ *
+ * Return: 0 or a negative error, in which case @file must not be handed out.
+ */
+int cell_file_drop_privs(struct file *file)
+{
+	struct dentry *dentry = file_dentry(file);
+	struct inode *inode = file_inode(file);
+	int kill;
+
+	if (!S_ISREG(inode->i_mode) || IS_NOSEC(inode))
+		return 0;
+
+	/* A look without the lock, as do_truncate() takes one. */
+	kill = cell_privs_to_kill(dentry);
+	if (kill <= 0)
+		return kill;
+
+	kill = mnt_want_write_file(file);
+	if (kill)
+		return kill;
+	inode_lock(inode);
+	kill = cell_privs_to_kill(dentry);
+	if (kill > 0)
+		kill = __remove_privs(file_mnt_idmap(file), dentry, kill);
+	inode_unlock(inode);
+	mnt_drop_write_file(file);
+	return kill;
+}
+#endif
+
 static int file_remove_privs_flags(struct file *file, unsigned int flags)
 {
 	struct dentry *dentry = file_dentry(file);
diff --git a/fs/namei.c b/fs/namei.c
index 49995c353292..f36c1a385d80 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4862,6 +4862,14 @@ static int do_open(struct nameidata *nd,
 		mnt_drop_write(mnt);
 		mntput(mnt);
 	}
+	/*
+	 * Nothing a cell writes imparts privilege. Here, like the truncation,
+	 * because it changes the inode: the lock of the directory has been
+	 * dropped, which is not so in ->atomic_open().
+	 */
+	if (!error && unlikely(current_cell()) &&
+	    (file->f_mode & (FMODE_WRITE | FMODE_CREATED)) == FMODE_WRITE)
+		error = cell_file_drop_privs(file);
 	return error;
 }
 
diff --git a/include/linux/cell.h b/include/linux/cell.h
index 1d0eec34acb9..0451055f74fc 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -284,4 +284,11 @@ static inline umode_t cell_strip_setid(umode_t mode)
 	return mode;
 }
 
+/* Nothing a cell writes imparts privilege: files that are already there. */
+#ifdef CONFIG_CELLS
+int cell_file_drop_privs(struct file *file);
+#else
+static inline int cell_file_drop_privs(struct file *file) { return 0; }
+#endif
+
 #endif /* _LINUX_CELL_H */
diff --git a/kernel/embryo.c b/kernel/embryo.c
index 0a04f39fa37a..657ce07441e0 100644
--- a/kernel/embryo.c
+++ b/kernel/embryo.c
@@ -113,6 +113,12 @@ static int embryo_install_fds(struct embryo *e)
 		ret = security_file_receive(file);
 		if (ret)
 			return ret;
+		/* As if the cell had opened it. */
+		if (file->f_mode & FMODE_WRITE) {
+			ret = cell_file_drop_privs(file);
+			if (ret)
+				return ret;
+		}
 		ret = replace_fd(e->fds[i].fd, file, 0);
 		if (ret < 0)
 			return ret;

-- 
2.55.0


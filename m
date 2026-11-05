Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892196;
	b=uN4XbAgognMj7ZTjAl8bU0Xlxij5xaRLG1VUVBse+1I3Gkz0VlZhusxmWXeXjbF0Ylpj
	 RzWPCr8JjU/eiKmhdu+IOUYaiXpaieRWcnCB/7/2mBN/4srAUcBdv/+dNtaKDCh3oVeAi
	 fApRQIo9mV2xqpZC8NGKxWUrhCpPexehZcpVHcIehQkQ58F1k+wi1T5wcPZesIiv7r952
	 G3ZQufw/2S0esvGPPpt6l7DtcFfjDEEhfXApt6X6TnxEDLnPJofsxEBW6TQRYuHb2aIbm
	 bBFCcAyurCTY3b8sgFwMpoO8poAV28L6k3yzZNGgaXTgDnTccuEWLnZQi2WzK1PoZDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7nibMrCIpte7jH5Y8CAGvaqEIBCNW+oSZWFZBxDYXLE=;
	b=oIq8K/CerEKWboRJ7l+auE0jvpnXe96Sud3W/oAECkVahtb8vwL+3/Ph2Ms+u2AyLOV+
	 o67mgNtEr1odgC49F3DHCTUxmOIj2+/jp3ewHKYEgi0QmcMij+HWdj9ZNHAiPVdMkaxJs
	 rm1M3+f8ptICeQW/vhXcjLdJrCvUappfXFdrVtXiUzNbeUKltbL9ZPOfAczPrEjCEFUOL
	 tz0ASv6UzvEDPNilKR6HCvq2x9LSGXnhlJ/EsKCvHJ0mIQLYfGSXT6ZEG5MnpSs5OMgq9
	 k4Kgq9EEzDdKoU2Rjw94ZL0ghDVwIkgKV8bVclhz4rsOUBk1+//SqKQ5lhRBO8WyAUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=a8wrXlvz;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546B606A329
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5546B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=a8wrXlvz
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5ecbfea5f51so125490e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892195; x=1794496995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7nibMrCIpte7jH5Y8CAGvaqEIBCNW+oSZWFZBxDYXLE=;
        b=a8wrXlvzXG316dQCmVyXiU5b2ORM/eCmyMjOkBwc12xOPJwDiDIXNpHvisHGtxr1U+
         Z1cNXK+F77P0PfulSJxrtz0ISU3NFi/2LLliQRt4TBwAOUZR0PjY/r3SCd1Z+DJpBwRH
         V5EAb9c+QfpE8lhPX7Pg/WgNIH2rRXb31oelNDMgQ8SLSYJOUfuj6Ji77Ll7sSJaBnTL
         ZdeKg7X0bOJeCBUd1qfzO3d/dpuihQpmIqCZ9zrFy4U0jcr55h8vhhORs8NaZeiJC2Js
         ziIpBgALKVxRgRUVDEbcZO6vJ4+3hCy04iQy3qNm38D0ynJq3xhJyXQn61MHY3BYVfG4
         SlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892195; x=1794496995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nibMrCIpte7jH5Y8CAGvaqEIBCNW+oSZWFZBxDYXLE=;
        b=hEXtKi2iHOIqP6NG8Y3ZQYHpkaO+WIEwTx7mSPbZ+8B8BtJiTYASFaC2pHlUFzTObS
         R494UhdDWKcblAYRQCEg0bxkf/P+4FNrObSKOhNwR12EwlXFS+fEgXEJiaCcvucDdIRy
         T2GEeqqNJtfMhx9vDQfnGT90cUTMPceMv6hB/pu5UfZjorooY8YWxvGtcy+ylrBuRknr
         PlH2mdVGTRterE7SHV7vaQld+8H3oed28uIIT0wlDduc7gEllwqo1XKIaUjYcIKuV2KU
         3yzecXbmFCbDYzUKna+6puCpBsbAZa0flvjwJEDMWznn9qYgCgsW5qKhGs1P/WkvwSy9
         rD3g==
X-Gm-Message-State: APuU4Z9R6TnMO1k2BnhqiMSb7r2S972X09qu6fOqeXusc7nj3IetFQdf
	GqgRwMHgfrSw98Ap5Zbdymb7qp/Zr+iXxlmbKrZH/AQp73vLdjSYPWgv5WZlbBcZxa0=
X-Gm-Gg: AYBFou01yi8ToMJFDDs4DP6KL2xGMKnG6Tmt5sHHa4Tolr+oqQVUjYn/RM6nnExQmJ3
	prlHu7ujHr4nfQwj2ylfuDjpXL4VGQF0xNq2p+IyJnl68hOd2On0y0wci0p7d82LoHImbJiIRgk
	0b/sKIo4eVlwKuZNO0csB1GrtjL/dpHcGxw0Gs/aYUZkTZovyvAP31aiZUjrN2r2Q3iAcC72RCH
	KIjkIdQ8aHUMYwI854Bx5AFjA1s6gBVa7rnmJGnkbcWp2vEgAz+c+1IQv5yZUBRQ5S5sDxrl4E3
	m1kKJnelC+9UwpqY1smY9w9ixkI9vkxh64lvgDpgffTJZhPGdmpmwXMgoVOqnnQL1sXl/1v9K/G
	5EPj5SK/U/FGI0WurAYBzi71lBX0pDG1xIxDhZwzo2Hmwc/BEFYnc0BetOj95ohPZuPr6PlLKh7
	XYpe/nj94FevPrysnkjxlU5ucP0EXKqnfD2fUBdhIz+0Q9CUhtHVM8zlTWFC8hdQTvOV1WkQstO
	FoD6luet/tfOMDrdD1C+yDFqFh+AxP1Rd+svn8fk9ww/HaNvVmc6pzK6bQdjFTG3/E9LoxjZtuq
	TZxGkQl2U+88yhmOsTI7C1Ud0SZkFw==
X-Received: by 2002:a05:6123:107:b0:5ce:76cf:fb2e with SMTP id 71dfb90a1353d-5ec6895c8e0mr9718425e0c.16.1793892190463;
        Thu, 05 Nov 2026 07:23:10 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8de4908sm4413311e0c.15.2026.11.05.07.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:23:09 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:54 +0000
Subject: [PATCH RFC v3 62/90] fs: let a cell set no set-id bits
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
Message-Id: <20261105-b4-cells-v3-62-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=4050;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=uGei2RogEpESKKmv/nP3/P9QyFXxqNI+laosDw1/MVg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJgeQkBfm+e1AUIUpI0YTHKRg5QtT3m8jleMm9315EAWQQ7tX8wlAjDhGVMBaPcUZxuhL9RYViZ
 zghTq45ZcVgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A file can give a process privilege at exec, through its set-id bits or
its file capabilities. Every task of a cell has no_new_privs, so nothing
that runs in a cell can gain privilege from a file. But that is only half
of the problem.

The ids of a cell usually map to on-disk ids from 0 upwards, because that
is how container images are stored. If the root user of a cell sets the
set-uid bit on a file, the result is a set-uid root file for anybody else
who can reach that filesystem. Only directory permissions, and a nosuid
mount option that the host has to remember, stand in the way.

File capabilities cannot be written without CAP_SETFCAP, which a task of a
cell never has. That leaves the mode bits. Clear S_ISUID, and S_ISGID on
anything that is not a directory, in two places: in vfs_prepare_mode(),
for a file that a task of a cell creates, and in notify_change(), for a
mode that it sets.

The bits are cleared silently instead of failing the call, so that
unpacking an archive keeps working. setattr_prepare() does the same with
S_ISGID for a caller that is not in the group of the file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/attr.c            |  5 +++++
 fs/namei.c           |  3 ++-
 include/linux/cell.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/attr.c b/fs/attr.c
index 10cf1b3827c6..946fba92b5c8 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/cell.h>
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/string.h>
@@ -457,6 +458,10 @@ int notify_change(const struct mnt_idmap *idmap, struct dentry *dentry,
 		if (S_ISLNK(inode->i_mode))
 			return -EOPNOTSUPP;
 
+		/* Nothing a cell writes imparts privilege. */
+		attr->ia_mode = cell_strip_setid((attr->ia_mode & ~S_IFMT) |
+						 (inode->i_mode & S_IFMT));
+
 		/* Flag setting protected by i_rwsem */
 		if (is_sxid(attr->ia_mode))
 			inode->i_flags &= ~S_NOSEC;
diff --git a/fs/namei.c b/fs/namei.c
index 925aeb63bfa1..49995c353292 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/cell.h>
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/wordpart.h>
@@ -4162,7 +4163,7 @@ static inline umode_t vfs_prepare_mode(const struct mnt_idmap *idmap,
 	mode &= (mask_perms & ~S_IFMT);
 	mode |= (type & S_IFMT);
 
-	return mode;
+	return cell_strip_setid(mode);
 }
 
 /**
diff --git a/include/linux/cell.h b/include/linux/cell.h
index f204c47ee783..1d0eec34acb9 100644
--- a/include/linux/cell.h
+++ b/include/linux/cell.h
@@ -256,4 +256,32 @@ struct user_namespace *cell_idmap_userns(const struct file *file);
 static inline struct user_namespace *cell_idmap_userns(const struct file *f) { return NULL; }
 #endif
 
+/* Nothing a cell writes imparts privilege: new files and new modes. */
+
+/**
+ * cell_strip_setid - take from a mode what a task of a cell may not set
+ * @mode: a file mode, file type included
+ *
+ * Nothing a cell runs can gain from a file, since every task of a cell has
+ * no_new_privs. This is the other half: nothing a cell writes can make anybody
+ * else gain. The ids of a cell commonly map to on-disk ids from 0 up, so a
+ * set-uid bit set from the inside would make a set-uid root file for whoever
+ * else looks at that filesystem.
+ *
+ * The bits are dropped, not refused, as setattr_prepare() drops S_ISGID for a
+ * caller that is not in the group of the file: unpacking an archive keeps
+ * working. On a directory S_ISGID is about inheritance and stays.
+ *
+ * Return: @mode, without S_ISUID and S_ISGID if the caller is in a cell.
+ */
+static inline umode_t cell_strip_setid(umode_t mode)
+{
+	if (likely(!(mode & (S_ISUID | S_ISGID))) || !current_cell())
+		return mode;
+	mode &= ~S_ISUID;
+	if (!S_ISDIR(mode))
+		mode &= ~S_ISGID;
+	return mode;
+}
+
 #endif /* _LINUX_CELL_H */

-- 
2.55.0


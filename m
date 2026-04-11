Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23C38F234
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920340; cv=none; b=umVBkSguLuut+icK5ghc6xBZCMOEWceabzPJncq3QVLkueSrYPl5rt3lZ9x4ISUHVm0zQYF3FXwkA/9WxtxGi3JOnkNIRtOQ61XbrcYnih86wmUuoR8HM7JIw4wF8GRrSlGHWmc4lyJwl//fFC4dlmaLI/0qXOK89Y/QMtyfg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920340; c=relaxed/simple;
	bh=XpDQNhU0YAgq6eWgBkxxt+03udeTHH945hMY8DgZpdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjYA6leluEFbbrfDy+ETqIlVbOya8KN+EWM1OSd5bybgr3rWzIyFvxANN/4orizvNguLBt/ykqQBfeUBP9ORzEb1soYZ8OIXnt0hZNYyBFtUZqFdGUjIfD6n+7VivdlsELCUe9cVwytpRYwr7uN3heGyeF2yyBerU6g4muntK9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7JmSZmO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7JmSZmO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488971db0fdso29559615e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 08:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775920337; x=1776525137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKlpdpark2ywyu/DKZmFr/LkIVCpBUEOyvYhEoA5byc=;
        b=s7JmSZmOCEchjQZ6m97Ol3pITUhK9kFyU2lEnJmop6IaFDBSyiWc3mwsTFBS7ngalT
         Nto0LQfISc3usmRDwu2JpuxLIznbM1nlHSDi/yFXqiSZ04aVGq1ARyqsEvPm56M+j9iM
         9P2zyTemYrCIqcUqh+wdG+lG/SNiyyPMBN4SQmlwztC/Mmdc7N1yY9yAbQZ7QRSEDyxV
         dGNw1PlHZf/DsH8Wvm9uKt8iCxT3eaFhtFqRf8koXQ4ZaNqi6wMFveYvAsN+ae+zI0mM
         kvtWQ1hx1UGrAqxBm+v6asd1t/lDgwfbEfQPLpg6vqDuNHK9j8D/+AUTTDv0de20G37p
         quRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775920337; x=1776525137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKlpdpark2ywyu/DKZmFr/LkIVCpBUEOyvYhEoA5byc=;
        b=a883eoRQpMDJfMZw4EGRmEqN1syLB8DaVshaPW9+SEflOWfI8Di4sBkFcGvYe1Zgi4
         zMPMa7nFo/A87TVHh2U9BTM+7g+486hEmxOQsl5OVlBj/OCLZlwxydmn8H3kgZPlAOnJ
         lzMWsmh983ndBi+LvlqXNpAFLWlc8sBqo0WDai8JGLszMgrPNKi2EAXjo/KdrR+C24DE
         vqjLQIcbnPI/jpzrMKiHd1ZIMeW5VlbPRhnlICdoCDN9KsClGiTRLUQzJZMWE6I37Bs3
         tq35YgmJzpsOQiNgEkgNxK/li2nab0nf5JuRi1VvcBuCs2kym2tbOdWkj7rd9W2y85Bu
         lCjQ==
X-Gm-Message-State: AOJu0YyW10Eg3xwcOBDQ55HyMU2U+N3o5QL0AVKexF5he7A9jzBRqwhm
	4o512YiORlqK2fD+d7wrBEJasIJGF5Oqcw+MhzXWF8Zp7bALyKQSJwaUFk17JQ==
X-Gm-Gg: AeBDietMZXvfZXEHXs0PsayLRloXbTpnrMgz5nUWwrKd29gTT0VFMwfiVMzjndjqaFQ
	h7W9Ff1f7fYtZ4zLsL6I8N++Uhw0aEmRNyo832b5DLjDZ6aEtjsjqVUs5UqF9s2bj5rA7UWSAjo
	pQ7XA6ReZDHawyW7SnQNRdMJWoAzbxuHFmVZbDICEC5dFNDFBzPaTUruGAkEa7ijelzzUWiVpqu
	tKRc8MZdsVgQFScERpO81+xcwsqur3qLFMqZwO+aZBZMf2ZLR4o49JeECdFv4XWN55Brabh/Gal
	yyo4EpToNIdpk8VpYNE7eZgGDqElaOjE/O2qs4KUXOTX5qAeXj1zqP58mOWdLjW2YDhxRG8wmg9
	WyZkgipwZkLDSy/bDkt875RhwLA/z39opnYHrfLQug9I+byRy4+u69BEtLZIbuBSK83xIzIHQuu
	bUsEXHmta48gtaEcMFPQGtg6SM9XzM5SKhDmbjz+ZX44QQWGF2P5gUD3DCoNFcxY2xuVtZsCBbg
	UQlEN+yqsD/jERgONmX
X-Received: by 2002:a05:600c:64c9:b0:488:c40b:c8b9 with SMTP id 5b1f17b1804b1-488d67b8d4emr108745565e9.3.1775920337258;
        Sat, 11 Apr 2026 08:12:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:37d6:c100:81d8:4e83:a60e:1a81])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm17167835f8f.33.2026.04.11.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:12:16 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: Linux FS development <linux-fsdevel@vger.kernel.org>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5 -v2] miscellaneous vmufat changes and additions
Date: Sat, 11 Apr 2026 16:11:39 +0100
Message-ID: <20260411151155.321214-6-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/filesystems/index.rst
Update the documentation index file to link to the VMUFAT documentation..

fs/Kconfig
Update the fs Kconfig to make the VMUFAT option available.

fs/Makefile
Update the fs Makefile to allow VMUFAT to be built.

fs/vmufat/Kconfig
Advise kernel builders on whether or not to build VMUFAT code.

fs/vmufat/Makefile
Add a makefile to build the VMUFAT code as a built-in or a module.

include/uapi/linux/magic.h
0x55555555 is used mark the VMUFAT superblock, add it as an indentifying
magic number.

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

---
 Documentation/filesystems/index.rst |  1 +
 fs/Kconfig                          |  1 +
 fs/Makefile                         |  1 +
 fs/vmufat/Kconfig                   | 14 ++++++++++++++
 fs/vmufat/Makefile                  |  7 +++++++
 include/uapi/linux/magic.h          |  1 +
 6 files changed, 25 insertions(+)
 create mode 100644 fs/vmufat/Kconfig
 create mode 100644 fs/vmufat/Makefile

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f4873197587d..893b585d17a9 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -120,5 +120,6 @@ Documentation for filesystem implementations.
    udf
    virtiofs
    vfat
+   vmufat
    xfs/index
    zonefs
diff --git a/fs/Kconfig b/fs/Kconfig
index 0bfdaecaa877..89a37c9c58a0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -332,6 +332,7 @@ source "fs/pstore/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
 source "fs/vboxsf/Kconfig"
+source "fs/vmufat/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index cf4a745e9679..3cdc3d7b804c 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
 obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
 obj-$(CONFIG_RESCTRL_FS)	+= resctrl/
+obj-$(CONFIG_VMUFAT_FS)		+= vmufat/
diff --git a/fs/vmufat/Kconfig b/fs/vmufat/Kconfig
new file mode 100644
index 000000000000..92553a246911
--- /dev/null
+++ b/fs/vmufat/Kconfig
@@ -0,0 +1,14 @@
+config VMUFAT_FS
+	tristate "Dreamcast VMU FAT filesystem"
+	depends on BLOCK
+	help
+	  This implements the simple FAT type filesystem found on SEGA
+	  Dreamcast visual memory units.
+
+	  Dreamcast users who want to mount their VMUs to view the native
+	  filesystem will say 'Y' here. The filesystem is hardware independent
+	  but is not recommended for use in other circumstances, so just about
+	  everyone else should say 'N'.
+
+	  To compile this as a module say 'M' here. The module will be called
+	  vmufat.
diff --git a/fs/vmufat/Makefile b/fs/vmufat/Makefile
new file mode 100644
index 000000000000..da423b0c7eec
--- /dev/null
+++ b/fs/vmufat/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for VMUFAT filesystem
+#
+
+obj-$(CONFIG_VMUFAT_FS) += vmufat.o
+
+vmufat-y := inode.o super.o
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 4f2da935a76c..7a3ab866ef48 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -54,6 +54,7 @@
 #define QNX4_SUPER_MAGIC	0x002f		/* qnx4 fs detection */
 #define QNX6_SUPER_MAGIC	0x68191122	/* qnx6 fs detection */
 #define AFS_FS_MAGIC		0x6B414653
+#define VMUFAT_SUPER_MAGIC	0x55555555  /* opening bytes of root */
 
 
 #define REISERFS_SUPER_MAGIC	0x52654973	/* used by gcc */
-- 
2.43.0


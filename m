Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F547D44C;
	Wed, 26 Aug 2026 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773395; cv=none; b=lJEHTE9RtED3NfMiu5nE7vycgMgBaBrshIuuV5qxaolV9VPxv2c53EN/Qwv1NuR9wHP4u+EtQusudbXq0he7exnvE47rKl/cHgrI5amH5RMVTuonBBG+5RhZWkHF287MS1nXbNX5osE9QhESC50hD/vZWVyyHhYTWamyG5TNSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773395; c=relaxed/simple;
	bh=xF8pK/M+SwTeA6iOCB3VGtmFgK5OEPkIcTwdAamqD78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXT1uVJesfA/6RDP76Rq9b+vZgfPMJDlgh5vshSIHT/+zPq1FsnI+MhvX8M4cgBZoITbzLPg1hKZfxbNUzE6f8EiMU5yxgipiet3jqJ+OycWYQrbulegW2u2QBdCoJgrRa2Aem5h0N4ZIx5YUq3iJNBrJrEjglVe5T9ZVjUbMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEpTYabU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEpTYabU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EEA1F00A3F;
	Wed, 26 Aug 2026 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773383;
	bh=RTbsdQk9JQPWb7veHN53XZYrnrEHp01WnXFpBEFYp7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEpTYabUtCC3z22vRnt34ZVQLn8YRdY1vuMdtoEfYje6pTC6iF023qiG8hLFgfdbr
	 Ib7gF2Yf4mCNtEAWwMDI7ksa7TumVHA2fBMQhitVSVsPIrFR1QjDBJjExwbTKE+kE6
	 Z0g6EjKTq+0KaKfOnfrJ83qum9iuKPQWYWtGBkqzbCXEu6+/4a31ij2cPmhxYmtU7S
	 pbpi2LUq7YDeMUkQLXBgk0BP3Q1M26/bujQcsseVu/JoU4Wr9o/aboMGMQLJOVwEny
	 +EABlRtit+Uhj5kouKIuZk4dsXhbZLVzDBqNaLAvDCnLtObgIPHUkIl7HNFvNKVdvb
	 zn0WmZBYCVB1Q==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 02/30] sysctl: add unsigned int limit constants
Date: Wed, 26 Aug 2026 21:42:06 +0200
Message-ID: <fce1d72f48635206738b076d2e13e28f27a7b804.1787771905.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787771905.git.legion@kernel.org>
References: <cover.1787771905.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some sysctl handlers use unsigned int storage for their limit arguments.
In particular, proc_dou8vec_minmax() expects extra1 and extra2 to point
to unsigned int values even though the controlled data is an u8.

Provide shared unsigned int constants so typed sysctl descriptors can
pass correctly typed min and max pointers without casting the existing
int constants.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/sysctl.h | 7 +++++++
 kernel/sysctl.c        | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2886fbceb5d6..8d993ba1488b 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -59,6 +59,12 @@ extern const int sysctl_vals[];
 #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
 #define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
 
+#define SYSCTL_UINT_ZERO	((unsigned int *)&sysctl_uint_vals[0])
+#define SYSCTL_UINT_ONE		((unsigned int *)&sysctl_uint_vals[1])
+#define SYSCTL_UINT_TWO		((unsigned int *)&sysctl_uint_vals[2])
+#define SYSCTL_UINT_THREE	((unsigned int *)&sysctl_uint_vals[3])
+#define SYSCTL_UINT_FOUR	((unsigned int *)&sysctl_uint_vals[4])
+
 /**
  *
  * "dir" originates from read_iter (dir = 0) or write_iter (dir = 1)
@@ -73,6 +79,7 @@ extern const int sysctl_vals[];
 #define SYSCTL_KERN_TO_USER(dir) (!dir)
 
 extern const unsigned long sysctl_long_vals[];
+extern const unsigned int sysctl_uint_vals[];
 
 typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9efb17cc255..d1b5284141c4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -29,6 +29,9 @@ EXPORT_SYMBOL(sysctl_vals);
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
 EXPORT_SYMBOL_GPL(sysctl_long_vals);
 
+const unsigned int sysctl_uint_vals[] = { 0, 1, 2, 3, 4 };
+EXPORT_SYMBOL_GPL(sysctl_uint_vals);
+
 #if defined(CONFIG_SYSCTL)
 
 /* Constants used for minimum and maximum */
-- 
2.55.0


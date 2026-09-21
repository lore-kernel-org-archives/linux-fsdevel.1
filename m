Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C06483837;
	Mon, 21 Sep 2026 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988147; cv=none; b=jpZdrchYfqOgl4hMigjP0dXx0r2hJqL9GBJGGhHNOeg4fKkP0LkmCeZegz2OQsIxPF6I7yvhFJP92406YfESmRGksS2RnU1GW9RpECjW8bH3DrZjLWm0eY3/HHeiHzDVclFfT0j/nJVJbEUGQ0BJtbHIUGgNVu61k/bMM2HIKn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988147; c=relaxed/simple;
	bh=8Lfv6XCfTAuYPL6y3JSn7GjLFYAsQsDAdmKVmDaOVmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbALyKtEP3jh2NXGF/023wazPjHEhzlmR2BUX+EXVVzb8DwDvaPNXBv2DOWXobU7Rf05ir3bPaWTkjI4XManpTmwdXwSq17UK0o4Au3Yt9nd5mCGpdl78Nm5GJ7AX+m3skTGfGReyZbDKqUlFGVjoFz2vSBejl9X5AgjVQPA5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvpBgWLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvpBgWLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173A51F000FF;
	Mon, 21 Sep 2026 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789988146;
	bh=jAg6HTThhqMYPxhAkTvD2YZYu+Rj+1Mpyut1XrJJv8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvpBgWLnj2sH2FqV1MxWiJ5nWbPzVIvP3an6rPcvUmOzjAytpGM+7ZsWNUjuORNgo
	 FUadAM8c7KpSKbBVJVI44OuK0lxy6MXXmGaL4OL42l1v+BhwBymk2fz1jBa0cf68RB
	 S/aQjQHpPrEn3149IYS7HqJ7mvVyT+vkmV38E1sP/TN8lTaB2t6BPxR2yEBJKw/k81
	 B6hLDnTCY7+sapSe0HLwZhzblDvrMKTQ948jNuOVCrRxR33PLBEUv7off5sNXaOiV1
	 BzKwJ+LnTunhWWMrCIUSTY4zxI6gHk0+biZZcNSwpiBXjEogvYblFOLLlDyOWMzL0n
	 S4fo7tJ9mcAnw==
From: Alexey Gladkov <legion@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Serge Hallyn <serge@hallyn.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/6] sysctl: add unsigned int limit constants
Date: Mon, 21 Sep 2026 12:54:49 +0200
Message-ID: <92b31e85fbb91af953aee911a44787142cddee3f.1789987960.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789987960.git.legion@kernel.org>
References: <cover.1789987960.git.legion@kernel.org>
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
index e5d7226ab6f5..7139a4c72736 100644
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
 /*
  *
  * "dir" originates from read_iter (dir = 0) or write_iter (dir = 1)
@@ -73,6 +79,7 @@ extern const int sysctl_vals[];
 #define SYSCTL_KERN_TO_USER(dir) (!dir)
 
 extern const unsigned long sysctl_long_vals[];
+extern const unsigned int sysctl_uint_vals[];
 
 typedef int proc_handler(const struct ctl_table *ctl, int dir, void *buf,
 			 size_t *lenp, loff_t *ppos);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f7b75985d542..54edaa2fd5d5 100644
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


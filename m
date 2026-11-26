Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693684;
	b=ajLSQsi3jcfQcPpOQb8yQTyUQPMqECn11B+OjWfoqt5uXIEy1uhlBMUi/A39Jr61ae3e
	 BuHe6/R617g0tDkvurjNMdQUaHNb3D5qC7+0k6I0hyUI3ib4Nyqafts3FGsyrCdgwCXmO
	 kt8rvgIeKI3kWB3RkW4WZgk2hRI4sYguo1yxv1ErjQZ8TFKBkblYSjjbOgCv03iHLg0fo
	 xPV9gGJ+BeXPL9olWQwZYcDrDNICuuT1A1qjam/qGY2cF3Rh4uAJfKRqovihwc52+fkJs
	 qy2yIBJh7b3quGPVlBGIwv4Nj584kvNmkcoreLn9kWyixL19nlw+s5ZkrYc/QJjvWZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693684;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=S/Sp6lSR44vtdgSZSOfmC8kBc2FFryA2aIlMSnTxx1c=;
	b=o/2w5qe6Bw+KXH/JGIP8cNucFlrS6PIVfX4hleDmzRlofwduZ+IdKlfeYFRFJluzFHjN
	 GyqtaGSAu902R08vzDwz6qU/NksMhgr/Tyrdc1EZPECKTfxS5QRuKAC3mDy4Pesp3FMAL
	 C7z/8GSw7g+WZgAm1MXaFBbU8FsWLSG6PpsrqArMgZonqfn7yeuvhz+UX+lFnAi2doi0I
	 J7t4zpgBoocAx6sbTgjo4e/270D9effJmWCdy5qUmFxXP8rQ8fIioEd/lDj0TmQ40jDep
	 +S5jHMmK38yUPSVdBprnYQw18N04PFTJ+ue3u1ekionmhM1lKA2xtll13OyHn6c8QmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtPvRNLe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86D606A686;
	Thu, 26 Nov 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtPvRNLe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795693684;
	b=G1E89QFDnVsC8xFThxXF4/ekamh4toV4lNRtL/SWKGrr2FtN95Nom2TVS4oc5OoocHfs
	 wRTiQECaqeQ+YkHQLwUHOXJbJSELN1my7aQFlBSpyLxiKvR55d/hHJfHA/d9HMGsxJ7ny
	 HsIas3PJrveo+EaZCtSDM7tqmE0iCniByUNT9pLblUxkWCvtpTtWEYHJr43LiZ8UlvkB4
	 9UvRQ0e6JvlPKSuQ9PO90yNpK4ppJkFe9iW3GwKlvvyXplwh1o7PF8uJf1H8ZM5xrAoQx
	 M1kh12hnBXJc74l/KgDLz/Bkm15T+pieKFRfSMlFq0Rdn/cE5oXhHRRXY6JaARkT6tA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795693684;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=S/Sp6lSR44vtdgSZSOfmC8kBc2FFryA2aIlMSnTxx1c=;
	b=hpEutlQNPhqI4fI2LI6v8lWYUi0XYukg24/ytVsR+ZsXO1mud+Y1Sh9rwn5Q2ZF65CPy
	 2sONU6I3E7TjMi1938LY07hujNMdKfP8BkPlCcSZarLEVyEr/xmXq/T3X2BstI5vFHlnx
	 LhMvZ+hd0iI9PAtRgGf1ybpALD3asQbHEbsfYCJ4cnORO81L0Lr604A8YjVi1yKWDK+eY
	 f5Q+6WAG2iU59QzjV0Oqtfpx6ZCT1JYzAXQBE6TAwscNi4BSnE950gtWpoR/Lesf2NHr1
	 FElTp5BO9RowBH9tzUfIE7Aj/JZZ+DenrHtMnhlhYBBlLRbxnNMa2C+DcPPap5RWwqg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5F7321F000D0;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693684;
	bh=S/Sp6lSR44vtdgSZSOfmC8kBc2FFryA2aIlMSnTxx1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OtPvRNLenBrRL03dxVOLCBP0vV9CjT6Q2ZyMQ0vtP2T7x1IBEaO9TEvbAfCmtzaEj
	 CsCke4a87Lo1HjQD6iSmzXVFnIlCTJRnyghKLo/JMQuER7gRwv67UrzVVaPvRDsYrK
	 58gUuwftN31Ayb0YiCx74eIFfIYwJStH/zgOjPyFrmfLrU63MKCmEj9/m+OI01Ttmy
	 Hsggj2sZQDLFbTYFwgw4RHIq7TwDvAoOHUDiyp23DNZW1Hw1K3Qr8An+doszExh3Vm
	 4Lps+OZEDX4KGCC4moM05gu6pWavmFqLzji8vD1Vy2Vhrda7HcBx1HyzVEp7OecMw7
	 j6Z4DQud4azAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DCAD34D489;
	Thu, 26 Nov 2026 11:47:52 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 26 Nov 2026 12:47:42 +0100
Subject: [PATCH RFC 2/9] sysctl: Add flags to struct ctl_table
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
Message-Id: <20261126-lklm-sysctl-ctx-flatarray-v1-2-d7fc9cc9b03e@kernel.org>
References: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org>
In-Reply-To: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, Wen Yang <wen.yang@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=DY+HxOzdABni9v9bD3uPkozrQ4a6lDrBzkd5JicpEjs=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsIHGLx4UEqP7piMBaHEE+9RcZmrKgPhodlz
 pGFsRexVh03CokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrCBxiAAoJELqXzVK3
 lkFPfVcL/0pAjqZiTKzWf8xFC0+7EggYrREPyr1I/M0H1jeU6C+752/PYdLPZ/Qi1DjapjRR07v
 lm6q77XJNvQlPWQLp2pwvKxHT2wBdgHzz2eFLcKLJUrn32tCe+4C5hcIhbpfg5TtlNvGU/NPgcR
 knw9gOQ0ThC9BVdBQL6oYmVnladtmOovxEfxo1q/P819vOi6E6ThF6wBNzRXZV6/Z4SGVpKIKx/
 N7sVWDaNFcZ5BPwOmEgCgfU8c6v+Ri2F9C4FxF9OEJG+dELFAbyrCxPh9f5cjKNTIWdWsgJpbIy
 eS0G9BQlqzpoBSNGR2XeZZUjUVBhoaoh4U8IKXlM8PPaxljqTFafEx2XTKiA5ZR2+xfXb93fztd
 b/RKh7U8TTYPYSloxEJrLBHTAt1dnJwyQPSnsTVtiR5DyMR+1rN531hOX8Ih3vrCNozRma2e3I0
 qP5CDoEEEKtdEAKBK7A+2agj+/xyBuZbHGD/g3Df/DwmHkZoGKuOUBV4dqnA6g7xBAkAnjHNSo5
 aI=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add a u8 flags member. It takes one byte of the two-byte hole after
mode, so struct ctl_table stays the same size. Even though we are adding
it to house the overlay flags for the ctl_table_tmpl template, it can be
used as a general way to modify the registration and read/write
operation of the ctl path.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 fs/proc/proc_sysctl.c  | 1 +
 include/linux/sysctl.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c0859c6656356f39010e9d47debc0487b751a32..1c5ccb29707d83bacad06198c0dcab39c8b7b347 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1343,6 +1343,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * data     - a pointer to data for use by proc_handler
  * maxlen   - the maximum size in bytes of the data
  * mode     - the file permissions for the /proc/sys file
+ * flags    - Used in registration and write/read ops
  * type     - Defines the target type (described in struct definition)
  * proc_handler - the text handler routine (described below)
  *
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 4faa3bc189e7afbc270f4ba14b04b32a3f2d1413..3654fd31e3cc4f9217ae61b0bb4d6f4c677ea237 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -22,6 +22,7 @@
 #ifndef _LINUX_SYSCTL_H
 #define _LINUX_SYSCTL_H
 
+#include <linux/bits.h>
 #include <linux/build_bug.h>
 #include <linux/list.h>
 #include <linux/rcupdate.h>
@@ -219,12 +220,19 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 #define DEFINE_CTL_TABLE_POLL(name)					\
 	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
 
+/* Overlay types. Describes what is overlain when registering a template */
+#define SYSCTL_OVERLAY_DATA	BIT(0)
+#define SYSCTL_OVERLAY_EXTRA1	BIT(1)
+#define SYSCTL_OVERLAY_EXTRA2	BIT(2)
+#define SYSCTL_OVERLAY_MODE	BIT(3)
+
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys */
 	void *data;
 	int maxlen;
 	umode_t mode;
+	u8 flags;			/* Used in registration and write/read ops */
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
 	void *extra1;

-- 
2.50.1



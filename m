Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929023;
	b=2OKG7TppmYgz8MYd2dM9JXvS0L5qG+65gix0/dM18fS1DFmDQo6osOjlQkzYk/Hn2w0X
	 TgN3NNH6O1S4DGH3sHPWRHdisPHdYBh+L+jyACWpCH4NZinGdNkaYSDud19/4QiXRYHpu
	 rwhT7+dB8aij0wZu38RHARMDAmNRBVvI/Hhj4ehXYtqOPnJ7Moc7FFlLaXpb3RlZ+ZbLw
	 9wgQ6iZNEjOQuXquL08XEVxOL2LVsj7N3BtxBe285eGSYuJtfQXwyXA8RX8CtgIrX3fGS
	 M67/PSMRTjB8AYpah9+7a34DDQe8/z8uAntOpSOySOYVsz79XmX/SfCJ8GPjNUr3IGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ofm5M00KSieqbiSYXgLgnUfya5lLhDxnmUYEkWnouA8=;
	b=H+2xSpoBNgo1WXkvLqxBvdX+23OaLBrOJtAzp2/H/aEitBtpu+iKY/At9Wa/PRB87/bi
	 B+v7vyi3DIjCPLmZDD5iW0u87Gb6ngYlLxkKkLGvxVWJrjC7Inc1pZHfTCFdOL2i3sXub
	 7Jb95RnvFvp+9ZKTMD5FWR5svTSZ9BQQXftS3ZvrwZiDrfnnROsls6E8QV2jjvMlTxah+
	 6MiHJC5nI2alaX0qWucKDTEp9BiDCPB8unuvW5PZTIpi1sc9B8ZrKUoRBpyg6VCrjM7JT
	 k/citVAeSy1wgYEF5Rgu/NHJ8E8PkFqzJbzAwgahXf7pzuPRfO3ioVhcCDudw+uSQ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XV3bc96W;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D303606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 15:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D303606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XV3bc96W
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2eac75d4143so2483135ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 07:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794929023; x=1795533823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ofm5M00KSieqbiSYXgLgnUfya5lLhDxnmUYEkWnouA8=;
        b=XV3bc96Wca2hr4zPcYBq+6ILfG4SItRkT9ixosvgf8aLWT7sp4FRkWmuU5PygrAEGV
         Qcf0/PL4h/BapNu+C0n2NNeojaM6oeFadF7xNy303yiNtETTiWoLLuFlgELIniFSgdJK
         EmeUAMDRzabdoJbDza9DfpcqRaaTxdt5ftTzc0SQ471H38RStbjozBTtkuV5VXuVuj1L
         sUSku5rS+DdSqCPy4nwYQ5bciIETSOsxlJpzlZb9oqVjx0YFvgtFvlcUutP+2imTHHi5
         02aa1GWK+DapP4yFjaDL4i19YYOeDix1ZfFMG/aU2qsCLPxsvPLFIEjI6NTDcPXlw4FO
         +wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794929023; x=1795533823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ofm5M00KSieqbiSYXgLgnUfya5lLhDxnmUYEkWnouA8=;
        b=SiLUHNe0YhS5EPk1JVUhfwLJdG0faWabkt80mAFe0GgACXWxGn2XkiLztdVarRY3oe
         CLfe9nbOmDen+lJkvWZmyoXHqXUnBX9hG1w/n1GB5ViCt8b5vb9dY8rYyAaVZZolwZ8s
         yi8FT3hn9jmwuWUj0whWEgIFPitnPRVdaMSYFQrOY18YysCbTvUaTJ8WhSsqKAxwzl6I
         +Htkmt/buhjeK4VPTQDzCZ1CXTWkELOAMTaWB8E7n1Eoi+I6ZcH2dQhZXRXt+KkZtwYc
         r1HV+zz8fmbvFBq7aY5yZaai2gqQAIuDjqIzeuoPt2yXObStBHUQr/VkvMJKxZA7Vzwq
         N/gw==
X-Forwarded-Encrypted: i=1; AL+hErHXIfvwA0i7vh/puRkNouUgpDzZJk1N5gAxZ2Z1A5IQ6cXWNX3FJY0kfaoOtQTGiKhQ0XP87QJUqstBvyRJ@vger.kernel.org
X-Gm-Message-State: APuU4Z+JhAXDEniTJHAQ/iBKlwfFk7uAl7dbDIKBGbvYJKDJRGDlSSfA
	NmuS9m0lM5yCQkGyyV1cjYG5BoB0+y9NakboX5jtsIf4A9TXYicPluV7
X-Gm-Gg: AZFdTZeGN7PaoJm2tpk5DAPd4gCdV3twviRA3nZ60DqCqzLthW7BxOiRplVg+JnuNbM
	QzymV7/k9yLhfd3U3VdVzXpU4CL8sf5zZzmOTeAzQ0WvzkGjhtIqxoPXD3821apkkQdCuyzheAa
	LyJo/vD4D4wEQwey9+Zinjzlh0AHpKTkhT9gWQ+BfvI32QToXSVGmJHD7Uz7FakUhrfB0InNKy/
	j8Yla4U1R1oCdW0tueeGVKuK9pTE9hNKFulz0ETzTVLtLKnJKJUmoqDzKGDlPlcUeNBDqdx4Ok5
	mBTuYkbzkHaolFkVllkn54VQayqiqs/qmSc0Ljytj5QGgmbx+W+q28VJqMyAMlVixH4yH8NJ75D
	mvYGdDPlmhVpRcMElBAgbKIaa7o4uFyaokjjYmf3k9aB7cVdCMAHqJxmXUB6xD3YMcytO18O6wM
	/Ty0f/vH2qBN0q3uJqyQipsIiIapSEhOytMIA0GLt8s1cZY+txPykSkHwPXaSkOw+h88nI9bvWy
	NhUAMVIfM/M09cAtj7N1mdKJoUoe/x/6BjV1JwsBIFaWFeP67ck3PP6qGdXhCJotFHEjVBZ912Q
	Q7bYDw+2ACn7GffnQp58ISwbB83VKbx5gxN8xe8X7Ix00oeVSd4vkvapWAwBpnsL48sjLNoU855
	2rAI=
X-Received: by 2002:a17:902:e852:b0:2ed:29a5:782d with SMTP id d9443c01a7336-2ee0dd0f21amr218160435ad.2.1794929022438;
        Tue, 17 Nov 2026 07:23:42 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a11da1sm17810695ad.16.2026.11.17.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 07:23:42 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Sargun Dhillon <sargun@sargun.me>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Chen Linxuan <me@black-desk.cn>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: restrict pidfd_getfd() to the caller's pid namespace
Date: Wed, 18 Nov 2026 00:23:32 +0900
Message-ID: <20261117152332.1221-1-arpe1618@gmail.com>
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

pidfds can cross pid namespace boundaries: a task can obtain one for a
process outside of its own pid namespace hierarchy through SO_PASSPIDFD
or SO_PEERPIDFD, via SCM_RIGHTS, or through file descriptor
inheritance.

Commit ee8323fdc827 ("pidfd: restrict task access ioctls to the caller's
pid namespace") made the pidfs namespace ioctls fail with -EREMOTE
unless the target is visible in the caller's active pid namespace, as
PIDFD_GET_INFO already does, following the rule that operations which
grant access to additional resources of the target require this [1].

pidfd_getfd() grants access to the target's open files, but it only
performs the ptrace access check, which does not take the pid namespace
relationship between the caller and the target into account. With the
caller in a child pid namespace and in the same user namespace as the
target, PIDFD_GET_INFO and PIDFD_GET_UTS_NAMESPACE fail with -EREMOTE
for such a pidfd, while pidfd_getfd() on the same pidfd returns a
duplicate of the target's file descriptor.

Apply the same rule to pidfd_getfd() and fail with -EREMOTE unless the
target is visible in the caller's active pid namespace. Callers in
ancestor pid namespaces are unaffected.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. The problem was reproduced in a QEMU guest,
and the fix was tested there.

Link: https://lore.kernel.org/all/20260925-gewischt-auftrag-tierzucht-c153cb3f9f74@brauner/ [1]
Fixes: 8649c322f75c ("pid: Implement pidfd_getfd syscall")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
-EREMOTE is a new error for pidfd_getfd(). The check is done before the
task lookup, so, as with PIDFD_GET_INFO, a reaped target outside of the
caller's pid namespace hierarchy gives -EREMOTE rather than -ESRCH, and
the check comes before the ptrace access check.

setns() also accepts such pidfds without this check, but it requires
CAP_SYS_ADMIN over the namespaces being joined, so it is left alone
here.

A reproducer is available on request.

 kernel/pid.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index adf721606768..4f9a29eb29de 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -893,6 +893,13 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	struct file *file;
 	int ret;
 
+	/*
+	 * Require the target to be visible in the caller's pid namespace,
+	 * like the pidfs ioctls that grant access to its resources.
+	 */
+	if (!pid_vnr(pid))
+		return -EREMOTE;
+
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		return -ESRCH;
@@ -917,9 +924,10 @@ static int pidfd_getfd(struct pid *pid, int fd)
  *
  * This syscall gets a copy of a file descriptor from another process
  * based on the pidfd, and file descriptor number. It requires that
- * the calling process has the ability to ptrace the process represented
- * by the pidfd. The process which is having its file descriptor copied
- * is otherwise unaffected.
+ * the process represented by the pidfd is visible in the caller's pid
+ * namespace and that the calling process has the ability to ptrace it.
+ * The process which is having its file descriptor copied is otherwise
+ * unaffected.
  *
  * Return: On success, a cloexec file descriptor is returned.
  *         On error, a negative errno number will be returned.

base-commit: 44cc27050381e92de64cc3d7836376eda4d92a5f
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891853;
	b=JDrFe/A+PMkjdicnXBfps20xuliueMlF1aU86C4FACITvX17BkDltvrKigSofJpqlcDD
	 Re3zyYLZ76IlVsleYxrOK1t1b2WEsI/kuxwTpyx0c9VKh5f1YlcmEsGp7cOWQL+KNqaRN
	 rAVaTP16TQGRoB4QZiVH9tYf3pFvsI3V7WJHOVBuiROkE67j1zhh4idW25+Xfhx70APTt
	 mmke5kWwHBbpQMrLts2LgAbzegepaUvGPchfiMjYqQt5oY3WFwgDZONu8btgHOZtT5pZ8
	 g9cTv00RDJSFwXyL1r6dpfTgyyNIjqrl+g7i1yM3hdKjwEixmg4D6N2yIM/YZvpYC1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hCrRDaWNdKi4upmnleWZagusoBbB25CEWE0iViCpCb8=;
	b=j0HX4l0ijlq+IZHBddiMGognOqSR321TIQYhN7NLj5hc+3kbfX3t3CIvfmSaknlfNe1P
	 mOT8ij5DpZoGPVdDAYZagaLXONFI9v28g4qXF9PPtmWZiVyOrLxrijDfzBvsS2/03+NL1
	 fE0ZOEqnJXopB3ilKqbtd7/Q3rbKx7UHhXK4NQ5sa4b1NkSqsGbdwv22EyOfA2j+WpszE
	 EZjUL8DH2xXNFe94ZQ4I1tzRV3340F9/QluKfYfxa6Rvx8dsURvbLQaSahdyzxK2cVGVb
	 VSlhn6nVDO1GFv8JCRivjnLfjv11+eUCsd42WkXtON12ir63TwGVUNqQJNTfmmvy15Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=C8TImVMe;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B7606D805
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 685B7606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=C8TImVMe
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b305d38bafso20426607b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793891852; x=1794496652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hCrRDaWNdKi4upmnleWZagusoBbB25CEWE0iViCpCb8=;
        b=C8TImVMeR5JHDNE7JleZZD5zOWU+4CRoS2EoF24DKNkClMcmi/++eVVH+HEek2+DyZ
         OVd/6NREo6JNMLDtvWth5AiZC25r2u31XVtNqU2w3h/L7n5ETjApH34KhIfNJqECUn2K
         jjKrOAb7F53Yxr1WcOilHSbjrhoRyMMP9evm/M5+GgIhEN+zigzw4pGoAc3JOl5FbZ9e
         gMseJy2oLaLz8YECm45HWVwiui7/oV1EN3z/rx8PvkJMFwTjcQ53LTcdjRdxL8B+ZhMy
         OKWXlWWgcVvpnbVkdr8xIyHimZfa2o+iOXgmbGI7EIjPV81lFvwJuzSu+K7zG6e333XU
         GoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793891852; x=1794496652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hCrRDaWNdKi4upmnleWZagusoBbB25CEWE0iViCpCb8=;
        b=OjCOP96ffAC9QYoBiNurxg7/Sw3kZVxtXMS01PgSSFJ18V70acIh3J8giSlAabh6wq
         Y26TBvavF00dltdKoD4dgwhLGF22AtsfyR21TuyAHiboKMjMENlQQaOAnBhxlb4y/gVH
         MnN7O9UZjVEdICx1e2y0A1E9R9oo6vqGbATImi1qr0dLEMPxphwuR1LT8DxAD2iX5UA+
         wSS/k0Afh48cZe+itljRK8o8PIdwNIskxN8A18ykhrMk5nWlwfTRiWqJaUSOq0DHQwTK
         xla57zB6ceXbOxTe1t62EZ6H0AKerS4/2CDpy2FBDduQfyYlHfJGKwZL2EocC7mvZRTP
         jOfg==
X-Gm-Message-State: APuU4Z9zaDvko7NsqGDgQcOWkrAfApyv0ahP94QGFR+24k7hIacp2Vvb
	06f4Dye2VzRrDgahAdqvA/d7FBvG1Lw3HIoOB4pqcfcfty4nKjSwu8+lK0aQv8XvbWw=
X-Gm-Gg: AYBFou2OCo17Xp6sF1Veix2cscisxF+c3Z/lV0HJ1LNzAiHSsZg9SMrmkLl3Kz3s6io
	MF3iNwfF9IIEt4Y8vFMNlab3ZWsPr+7uanw35Jkkc9lOpDR90UOYQLr11vg60HwWSAt/t5yt1Pc
	9shUblXcaZXQHs05Ly87MbnAe/TnQfjv+YzoogjIapi8l2sVvNxH6x4evZps5JeYlbcjMSWRQRa
	OzEijogjUl+47qmSxtJFg5lhNz3/t3yD3z08jRTCyXMrOtUcXquIa2LnuUcvwDomf6Jyuzy3wr5
	eRFctRs5zuchSus7itAZ3Jn+4Ofc92JOtoSFk2XubZa4bYQItHLNhSJDnSxJAoQSWWeffubK1Bo
	z3xY1RlgjjpdSzuTyjFwDn1F/UCHpAUWkgpw3MvfmFJgg6wyf5tI5Y2GpoKMQaTlPRIyk2HGEsg
	8HWWunYnGO39uiYrQVkuUak4bBeeUrS7ZY4uAQbdg//i8yGeKF0RDWwDwTc/7BoUCaCpq9Ah4eH
	1gnWYPBgK4rHCeq/wLgpm382D+nJAVYhYoegz2QnZ1nVf4ZKjsCfmOLfP1uqfw1ziDZ2Uz1lzFg
	a5yIZ7MT0KltH+rd+xR/FyqptNTKBT1ymDPTwQwZOiC6hQ==
X-Received: by 2002:a05:690c:c702:b0:8b3:5d3:4f17 with SMTP id 00721157ae682-8b305d38d03mr38816967b3.2.1793891852126;
        Thu, 05 Nov 2026 07:17:32 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b32f0f9631sm12377047b3.36.2026.11.05.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:17:31 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:39 +0000
Subject: [PATCH RFC v3 47/90] cells: refuse a task of a cell a change of
 namespaces
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
Message-Id: <20261105-b4-cells-v3-47-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890934; l=2030;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=I2NhuCLSjPnuPpaxv/cLj2N44Ay4J4ZB0gMzgaeFU3w=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPEwElGC3io0zEiypNNS2/bqSNHE3cPBK1FdSHbV8JxWqh5/8fMvlDcC4n2tbdYoEItntOiJyNJ
 Q0IFb6Xcs1wY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The point of a cell is that inside and outside are fixed once and for all.
setns() and unshare() turn that into a property of each task at each
moment. Tasks that are half way between two sets of namespaces have been
the source of many bugs.

For a task of a cell, refuse setns(), unshare(), and clone() with any
CLONE_NEW* flag.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/fork.c    | 8 ++++++++
 kernel/nsproxy.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 119b59f30f4d..134409910215 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2080,6 +2080,10 @@ __latent_entropy struct task_struct *copy_process(
 	if ((clone_flags & (CLONE_NEWUSER|CLONE_FS)) == (CLONE_NEWUSER|CLONE_FS))
 		return ERR_PTR(-EINVAL);
 
+	/* The namespaces of a cell are the cell's. A task has no say in them. */
+	if ((clone_flags & CLONE_NS_ALL) && current_cell())
+		return ERR_PTR(-EPERM);
+
 	/*
 	 * Thread groups must share signals as well, and detached threads
 	 * can only be started up within the thread group.
@@ -3300,6 +3304,10 @@ int ksys_unshare(unsigned long unshare_flags)
 	int do_sysvsem = 0;
 	int err;
 
+	/* The namespaces of a cell are the cell's. A task has no say in them. */
+	if ((unshare_flags & (CLONE_NS_ALL | UNSHARE_EMPTY_MNTNS)) && current_cell())
+		return -EPERM;
+
 	/*
 	 * If unsharing a user namespace must also unshare the thread group
 	 * and unshare the filesystem root and working directories.
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dfe47a235cb5..5d6cec2dc4ce 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -664,6 +664,10 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	if (fd_empty(f))
 		return -EBADF;
 
+	/* The namespaces of a cell are the cell's. A task has no say in them. */
+	if (current_cell())
+		return -EPERM;
+
 	if (proc_ns_file(fd_file(f))) {
 		ns = get_proc_ns(file_inode(fd_file(f)));
 		if (flags && (ns->ns_type != flags))

-- 
2.55.0


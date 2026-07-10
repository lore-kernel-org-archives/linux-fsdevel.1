Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03E243367
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650723; cv=none; b=jZc6m6hv7buk7tzHc3dZzLsAf8xuAzu4uDMrfR9gECBgHu1gKI26/LUvIbp1db+uRR9w2VN2x85MJ6LyrLy4G7z8Yh9rNgSlvVdLDYLQcdFUWUEDLEF4hYC5R0E0K3S0AlL9DaJBRgQIg0UUiAe1LSputcDVgLNiiRUmUjS0+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650723; c=relaxed/simple;
	bh=XAdJ/tsGYcNj7MCZVoa+YxBZ7K9W6w6UcY+bnzhzGUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTdjLFPBaoBRyn/pQGmbjYv7PNpYROH0X7lBy9rtT2CtzJJCq7aZVJLW2PS3rYV0bYQAhiwllhHATZDjGaOOQ2Rj2MVEOOYIpJ5W0qMkGuTW0n5qJG+MyuLe4JDk8VXaKG6Bb1cmiY3BynbSYUoSiLYpCYKtpjFKuH3OLcFmNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjEFUDN3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjEFUDN3"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92eafc94c9cso20640385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 19:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650722; x=1784255522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfQtbikmekSxNqjFjSAFJmT5+XBv2183xfWostgHcOU=;
        b=kjEFUDN3LGkljnZFiJA18m+T4QR508MdGPeEXJB3wtxIx+VM94W6jJbUwn99Rq6PB1
         t//ZmmSmXV07L8b5jzk//4jPEYPfe1VkA3lRQYl2bXyMWFcDcpXmkj9EKCnYRCJVcvwk
         I8O2A8Z+A4HsBr3DA1ItG1krXtav/4Ew/a/6jRdwb6zSQd1b7pE6iHOWeUwc3E4+8Pd0
         vBr6fIOujint7gFTcXv17NLKjCeQsDdIwgeerGocHRjpa6xNb8e2m7BT87Kdq/AqmN8A
         uiwULvXBSHxEbqRp0reGCyl1BnPNITR0HHv3gFyI5AMKFJRv9R9XIdRoYrEEDWtkkRsd
         WfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650722; x=1784255522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfQtbikmekSxNqjFjSAFJmT5+XBv2183xfWostgHcOU=;
        b=fWGCI1qQosf3OcmgrN3yQkkHXTqm4ZtZYw+Sa6Aw1J7aYNl4ivkpGJrSlINdZrkKG5
         9oxMrpxEXTIPG/6wSuctqs3DFu7jr9pt5KOfxTV2WiuZu+Ufoe+z4PmQLoGzAYUHbldg
         NJDiRNApmN1Yyk0yeYMzStRz5a4eNYyOc3RrI5hUgW0XrnD6dLRkWlKXZkAQ6yOapdMc
         vdms2txcGz21ESWsrtEEnnVZ5bN2fBYT0APYRFgEwLuJJ3PmX/U7wRdPrLU49XJ/4Kie
         EJDLXtV9gF7RmUuAlVc03PIshO4j7x2OMQSrMiu1wdqtSYavvv83U1lhOtaw3EUf1kN+
         3a1w==
X-Gm-Message-State: AOJu0YxLQvRlDb4mdAkQH6YM/dqiszsSk/Fz8HWd2OAl38boFTC8UPVa
	/WAhabJQKfHd4ULfXmiAp0LH3Stc0RnBWrBwLDf/08BGVOc/WTq9uYlV
X-Gm-Gg: AfdE7cmu5BNhV6uG+Tl7ApCvnyim7vB0AFhfZiUHRUYz4p7ytE4kOe/KkzvAfG+O0B4
	Z5pToldvGZXdlaCm4ioKOAsdwayS64NKiO202UwGArDX1NHgMrBhfW/ZF9lbOt7IjEsZDXQWawq
	+E7W1EhDu5L+jBCUi11QS1FKsZH8JVVnSuB0roMXwQJHefmY4nfLCH64VmVRkL3mEvCMMIiPA16
	xoo3sRDxPRe+0lY3rG1cwgyVPr1D63kctYb6g76+vm9CG+FSwcS6DNGLXzvdmCz1VY7R3+hx38D
	TBJ4VgtWp7DICcfEyd3X4Em9fcTHlqaFwebsEO9FidEirW2cgshGQzoLg0Xr9DLq9upPsEwny/6
	BC2rQU6rySdhYGQxQow4d3TdtcpwzgQt8rLgdAI42m3mJQ3BKoh9pzrVJ7guIqzZur5OuRiIUE9
	w/Xc8DOhjOyBkzWCAaTC/lNAF+gYlY7Qd4yDjKdgHu0d9bcUIKEKpRUFCHHDWoPCEWFQpVZudyJ
	IMjQdBdTG5yE9pYLF8zuciX9pMyZ4Hbc8w44hv8/58=
X-Received: by 2002:a05:620a:4410:b0:92e:6fb0:e79a with SMTP id af79cd13be357-92ecf527f6cmr992424485a.2.1783650721652;
        Thu, 09 Jul 2026 19:32:01 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cfdbc7sm89500985a.22.2026.07.09.19.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:32:01 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vboxsf: validate directory entry name length
Date: Thu,  9 Jul 2026 22:31:56 -0400
Message-ID: <20260710023156.3749541-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Shared-folder dir entries carry host-reported size and length fields.
vboxsf_dir_emit() checks that name.size fits in the returned buffer, but
later passes name.length to vboxsf_nlscpy() or dir_emit() unchecked, so
malformed host data can make the guest read past the shfl_string buffer.

Reject entries whose name.length exceeds name.size before either consumer.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Assisted-by: Claude:claude-fable-5
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/vboxsf/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af7..702d243169936 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -129,6 +129,8 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
 		end = &info->name.string.utf8[info->name.size];
 		if (WARN_ON(end > (b->buf + b->used)))
 			return false;
+		if (info->name.length > info->name.size)
+			return false;
 
 		/* Info now points to the right entry, emit it. */
 		d_type = vboxsf_get_d_type(info->info.attr.mode);
-- 
2.53.0


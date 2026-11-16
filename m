Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800001;
	b=QRDQnZWT7JfLgp61EWFZnJ5BzFBOLA/zf5aFxBAuWikzAgkGeGDbIv0NtHgKu6dgtsmk
	 qy/zJcXp+SPc1AHiMyoi/KXj7KwlhRHvOWph25jn6UNC6hiar0GRHMYqB9kMhd3gZB8O3
	 cH+HntsHhcBzm5fezsH8DhbhysaKGzlSkv+fpswdvgXzyaxGiqXBTnaqPeYKHHb2Uk64X
	 jlWwIQbWTl5A1jkl3tMgtGxjOhKuBGl3Nn+dzWtvO5RdsvuXGfkOr7dIn4fuvZkLm9Xn6
	 55sMMTNtAJDC8lP9gt8ZvetdL7jET9y/FKeKktEGWGVR0VRkfH9kPDLP6j8L/aDh/3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800001;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=nlTtnR+wCpHl9FSCHLEGv7xGmXmxOT2nZcPf4/lr2y4=;
	b=lJOkWAk2hTpCCT7pqAoYcKy9GFMfql2rR8stRGnSe/NiezZJM5jVxLZxrqF2sdMt56T8
	 0I6QQHKeQYiSsH/l6+s96URFdDy9NbV9M+1plrHDWQmCe3J4zNKv8z+jbnUsNatCvWBKF
	 2MOv6/32EKMsa6neObKIi5i9KXqxYlOfb595EH6JhuLZzF+kX+J6KrIOKBgiqaMZSTMOX
	 1C4wcjvymivdD20/xSIHf4fFUHE4YpyVUzgIEtjtKGI2JQGknq1+KMCYljwi2PgiDjGhb
	 WAVrIMPzV/3lwMVnpw18PJI9FuhJ1fGZZe+QCDPvul7a+wAClOM9bRUXf/l9Az+UxbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgaUM0ak;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6B606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 03:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4E6B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgaUM0ak
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-94961ed97bcso234008985a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 19:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794799999; x=1795404799; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlTtnR+wCpHl9FSCHLEGv7xGmXmxOT2nZcPf4/lr2y4=;
        b=hgaUM0akhfIblJZRHS1um/ResgJtAxAoSHYbf4DebsNzZSgSEOTK2PUUFJYr46ycbO
         SvWxtAghL3ugAZ9pai5SU6+wNpu+O9I3gK3N1i5RZMuiWf+59EDoF67X+yQGTmWaDo6c
         8V4HYkdesumvwLnYssRCdcJB25yQNTfhnma7NQNRpRzsoCt4MLeF7Ia7ZMEC5YYn8fUm
         UoEHspP2YPaP2rFpG2KWdLg/f2d2n41NxSjOdw9txt8/iddqYt9CxJQhpzGFzhZE+RSM
         o6aXlJjWDz/vL1egZ6Y7tUMkgakD0MUgVXKktRggv0cn7BZ88ASPRxmwXt/9bEeu2vQW
         qQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794799999; x=1795404799;
        h=content-type:content-transfer-encoding:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nlTtnR+wCpHl9FSCHLEGv7xGmXmxOT2nZcPf4/lr2y4=;
        b=uC70cM2j/BOGZMaIK6WAqXYJBv65FFK1nwWJEDvIAk3X9QFoB2t9GCw8u4ITmy+76h
         ctHio/lI/yy4fdhqNja/VgiHgA2vrPzm3A+MLeVCZlsf1i8g+HXLJd8YfxlD2+oq1qG6
         01I7W7oRCEEHzbNvoCfpzRdqi62EuNBI3iSUKjvEfBTEJZlSrYS4HhURKBwNn9WHP6lK
         5+uYy//cEljFPV6kvC7YCP17NN4L14BcFDkb77WsAvGyaowY65ZtY8FoNLcv5gjl+NJq
         OYL80OMVtK3aKFakAfGu5VoZpQRbw1JtVwQt7rVsjinrQGbtY+vF+2xi56qAbsgPgtZJ
         F0JA==
X-Forwarded-Encrypted: i=1; AL+hErEHqd9Fszbn1tL2UZZszClwHrMvn0e1kfqdkt8BlYDLA82sgpum3T883IiPnSVRLzxR3ep/maW5/SQdqmro@vger.kernel.org
X-Gm-Message-State: APuU4Z9yixVwSmxejgGsBJkW4s7/xWmd7nU1hOLezdHcarrqcvuUM5MN
	Vsdu+oWU6KyrfZXNm8jauGWJYbxdmrLwPYOAxAWJcEW1aifKvr9vJU7X
X-Gm-Gg: AYBFou2E7BY8v1vRuEwjWganQtS3+N2n8IOruKn8zml6ezNjlCN09eWGX+GAjiJlEla
	zHZYgDq0OVGZPqGgmgVJJp/gQA9wBJCoXScqeJqO7/B/GkYeJkS9rhti8L1b01k3IbaNyzKrcQm
	7d2qpl9ETK7S+HZ0QlK0d5qvCMivwJreNdnsT6KxT4NmS4Ok+O+JS+FXuVU+51pukIieV8oDa7l
	nAaLVeAihsjFKsNFK8YvfTES3LDjQROH3Dst7v3s3asw9TXWhJZMMVb/SYqzBoeIQG36DFCBxbF
	MAgR9PR1vxckoeUmctNqtW6VqzuQ5l8wL1pumgwAJ6eYU65xNBOKzETUBHzoz3feipkOvIDCA0W
	Pp36Iqa7yy9URZWNYBNkoDgtp0t/gpRWrdxIYj7ECbPCub8zXG7u3a9X0mHv+XZpj7xlNOaJDzz
	jfH5fPOCPDNfpYKZxwEEiVNyvZLuOdwngcNi3rianWd5Q47vCSH0B/aq3enb4wEuaANg6tdNF/K
	i+HkZ14teJfItLi95cCb2BhyuW9gP63HLmCdSHyLMyH78+VbmBCeX1+V5a0qkQAx/Zbl+FyJPPX
	2D1pB7YdhENgcCUwPpgmtOIPEHKRn42EmFdggD4KtVY87erJV0p1dXlKYFg=
X-Received: by 2002:a05:620a:40d2:b0:949:76ed:591f with SMTP id af79cd13be357-94976ed5e0emr393702685a.8.1794799999296;
        Sun, 15 Nov 2026 19:33:19 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.77.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836f62sm753411885a.23.2026.11.15.19.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 19:33:18 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-man@vger.kernel.org,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Alejandro Colomar <alx.manpages@gmail.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] mount_setattr.2: Fix nonexistent perf_setattr
Date: Sun, 15 Nov 2026 22:33:16 -0500
Message-ID: <6099049.DvuYhMxLoT@daniel-desktop3>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

The problematic reference had been copied from openat2.2, where it was
fixed in bbed82c0693a ("openat2.2: tfix: fix minor reference typo"). I
performed the same fix for mount_setattr.2.

Fixes: f3a5ba3f0151 ("mount_setattr.2: New manual page documenting the mount_setattr() system call")
Link: https://lore.kernel.org/linux-man/20200929223509.11783-2-cyphar@cyphar.com/
Link: https://lore.kernel.org/linux-man/20191003145542.17490-1-cyphar@cyphar.com/
Link: https://lore.kernel.org/linux-man/20210730094121.3252024-1-brauner@kernel.org/
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 man2/mount_setattr.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/mount_setattr.2 b/man2/mount_setattr.2
index 77233f589..5f26119cc 100644
--- a/man2/mount_setattr.2
+++ b/man2/mount_setattr.2
@@ -786,7 +786,7 @@ acting as an implicit version number.
 (Because new extension fields will always
 be appended, the structure size will always increase.)
 This extensibility design is very similar to other system calls such as
-.BR perf_setattr (2),
+.BR sched_setattr (2),
 .BR perf_event_open (2),
 .BR clone3 (2)
 and
-- 
2.53.0




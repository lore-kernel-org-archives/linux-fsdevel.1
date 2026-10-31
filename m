Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440770;
	b=ehsoC0tG1wKim3QWr8LAQzEOyQDOrKfWVDrpua//5x3LHiS5CXoKFNXtyskvFZtY2V0W
	 OFKvQavI3q0dnBFaos0HAACHDa4x3Dp0jBceV1A9pTWSUl4L8b53awdEw3CUc1GcNtPMA
	 bt9BHP0Wx7FblDU0trt5b8ZQ3+ikSGI6NBe9LU0rCRTpZQlC0hS3ARESjbh/mvSYXCjNe
	 530j/J3HDOsMCfcx6lOCLJRdQzDbx3lXWHP2MkfhZ+sOiJx2GqdGhvdBD7O5qiVxvQg5k
	 2Vp1mCbTLGU/VmIasfSreoCYHxcdviXOqj8HT2WEGvZI1Xm+6LOU9PBkPwGDmHPHF8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lrg91VXppCw++dPJi09YCHr1ozvZZtqaDezxwuYyj1c=;
	b=Zkv+8UdEHbO5jzPlC6pDkxDuh7ACBsFJk1z8vvdrzL63z01yUXn+lQm2TLGtDqkC86c0
	 uI4v3AdlApBb5JJbIZES/HcN68KJf6hxSddoXPSYS6YtSWKnTsK2ax6T9hGkDfq+wKuN4
	 hqfsDY8v3ORzkQOKcFcypEcs2dcElXvjZcsH2AfDi1HUpvg6PHP357RdixQ1mrbEuehpA
	 ighOBWLtGkA4X6VM5PUTOr7xhN+dLUNR3QHF4o/Cx5wZvkMrxaHflevhIQapKXQx6lGeV
	 GSgy726jjAu1EmTmBiQiZVgpFlCS46OhEQk+l+6jmJXCwSorDLgSF0HRw+lCIybveQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJCloE6b;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06128606A31C
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 09:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06128606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJCloE6b
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so9456165e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793440768; x=1794045568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrg91VXppCw++dPJi09YCHr1ozvZZtqaDezxwuYyj1c=;
        b=VJCloE6b86yvWABy075rF+peJ+s9iHi9Oj8A8xN3AKg90+d9lov+D2SVeH1MIqS5U1
         fZMPNtsj1CDhKMGFKUhX/Y7SioiFJHDFZxK1BxSniSDdO6XkDzaNITmT2/EfHCNE/VCu
         EEp1yBILY8uUu/44qbbq0HxUgf1g8gKaFstU+2foeow9x0g5wfA98wGXpn83HWo/jveg
         kibon7+vRr0Od96+ZX/Uzr5kKCEc3JBcwuMkag/EL2OvqxbAlZU9AdfjPuK2nNyWgA9H
         33vDNRwhXbsSV/htjoVhUdVWpO/imuheL2Z2PUKcle3/hLWR08BQO1L5n0lsoWKiy37T
         nb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793440768; x=1794045568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrg91VXppCw++dPJi09YCHr1ozvZZtqaDezxwuYyj1c=;
        b=QmoGTQ5u/+KDpsToeUZfDlFfxxarvtEKDX+w2318frdny1x12flMSlHaRn3oZqTgON
         BvvhqosqnsERPCfeRJiYYHUWB3PIrew8GCGbrztJFA/IIG+P0kTSP8kRg7RMeM5hjp3o
         ffSHpg/wqNEwNxTMnrFb4Klf88IoMoTPWRa20MCdSg5aUW/H+U5g6GEsXqgZkUfWD7jv
         e5v+fCUxyEXSMLD8BVHfiAOJ71JAG2rylbk3M35STWyOCkvgxbZTMmKX2Z9byaXY6brt
         y6B8FAwC5++yMDNij2t+2Tfu2gKRrISNDad7iPw2sQrkkEAN7yYwTkfwRNyxzvfPJSBZ
         XYbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMyJV+GcnHvudRgWFnumYs4SkjjXQ7F2WFU2fjdGpX5TzSDF4mnHaQzXTf71f2qvRCYMWZ2LieQW4SejPE@vger.kernel.org
X-Gm-Message-State: AFq9FYL2A1H1FAuVRmYJ9xKtsV/fHPT/rKMDBUQ92ERv1UjC82xBVy6D
	/QHLjdy7m2jMcwduMDALqg0x9Fz82QWd6a83RJ8ejBghuurcsTrpv4k/
X-Gm-Gg: AYBFou1nMDaPR+HDkE90i6RQao75+3cwES5jPcgCUhJJ4qusaAg8NR0jjnMRfx8+5WX
	FE2FwtR81bCQKMfBl5AclU8dcjmHM619+UVfzNzvGdJ2+hfvd8KTGCe7JAGXZiC/HBa464Ra7nZ
	o11SX1eb3o3oHLfUXtX9plqTIev7WzBGz2XU8+HhxchpvzfwY4InPBzx36d3pAvNqX1aBOYw/CR
	mwWDXlsKWEmV+CiY9OuxVJhulfy0+nD5PGMouDpZL/Tx0z3VUS6e/646zxjI6XOOZyp/MlbRoK4
	kS0Twym6jFeqpmiJ0XEFLShsRE1CtGrbxryQcyyhI/WgvXp8Hpx+G/qr0fTvtspi6n4oAVNvZ+E
	5K46ToR3MzIyrC1a37EH5pvJdVsimP1ZQIiUPclxY7XlCjwWin/JDtoR/0vOGDOMaPF5WtXovLZ
	KToAJVee7e203AopcBjdnzJ7NkBrCHDlgdPk19MgRipFPKFCLUO+CustHjL9ApXvOYV9m+xXTaf
	8dGLbV1ruBhISwHdpOTYYt8rGqB/3RQg4Hw5ZDel/1lads5qRuOd/vTpTstQsw5980NiNWk9fya
	o3USqRlzYjCGqpKy7Nry9jjLffoQ11X9nrciAShzcWS4
X-Received: by 2002:a05:600c:8b4c:b0:4a5:1cf1:b7b8 with SMTP id 5b1f17b1804b1-4ac17b2cf8amr106495125e9.28.1793440768232;
        Sat, 31 Oct 2026 02:59:28 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe77053fesm55354435e9.0.2026.10.31.02.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:59:27 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] splice, net: avoid MSG_MORE when the bvec array fills
Date: Sat, 31 Oct 2026 11:59:23 +0200
Message-ID: <20261031095922.3577591-2-thnkslprpt@gmail.com>
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

splice_to_socket() leaves tail at the last included pipe buffer when
its 16-entry bvec array fills. If the requested length exceeds the
available pipe data, pipe_occupancy() counts that buffer again and sets
MSG_MORE even though the pipe is empty. Small TCP transfers can then be
delayed until the cork timeout expires.

Advance tail before checking the array limit so the occupancy test
counts only pipe buffers that have not been included in the send.

Fixes: ca2d49f77ce4 ("splice, net: Fix splice_to_socket() to handle pipe bufs larger than a page")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index bc243ab8dc43..7c67e0375ae2 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -863,9 +863,9 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 
 			bvec_set_page(&bvec[bc++], buf->page, seg, buf->offset);
 			remain -= seg;
+			tail++;
 			if (remain == 0 || bc >= ARRAY_SIZE(bvec))
 				break;
-			tail++;
 		}
 
 		if (!bc)
-- 
2.43.0


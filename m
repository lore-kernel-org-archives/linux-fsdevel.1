Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4BC1427A
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189342; cv=none; b=AMrbb53m3RodPyIAs9hQ7AaLtylNA2kQN9X7F1dThmWJDTLz17vBM1rm5PpSZ3huCKr5qk2eyV17zlUByWv8IQkA0c0I6SvxBAjVjXopID1ZCBwEFktk+UOjHBkUaIhNUuwoG0UgmP5iBl2WKyaR12Prwd5f991Kjk78KjsStaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189342; c=relaxed/simple;
	bh=vsb+QThfs2Jw6QSiFQtsk0PMTT4LF7TO2lj9pLcB1Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxKjMukZw0O23DOxmTz14c+GkXY5LoIV7WPcGR+7grV6v0+qOfEDN/4dvy+uWyFan3WF2w5qpte+sZTmOBw9e0uMJ/FEO2wXekWW53MLa+CN/HtVbwwdEHz7i1dtGgCFqzqfQrJA3iDbYH4jWq+XpC9zTFWd+hOyCJrhoxJKHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAvMMyEJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAvMMyEJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so68627935e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189340; x=1780794140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcbBqWTkzkDxwNMdgJ7xVJp7N/TN/+GdHi920u4savY=;
        b=YAvMMyEJ51N9vhC53xnEEhMm64qQqG1nVXXeYsDkF8PoTdCjhLyZnmzfCSYThtdoy1
         xQsUDvOWfjZEmUxZMrd9oIqvRZNrBe6DS3VWZlDIMcgXjpn2cJcdJNnFBr/XqhB96PJU
         HBSmZ6TBf4E9VdaAhL/aQODtYVa6xsf9T38CbwVsI4S3+2yt0zjO8SndLk/jA/1OffH2
         ZaVds/eSQ4VuDx11SuHsFijcAuRxyQ4YsPRgmLwekBU/X7ylJBNUFqTSL0pxA7dPhDq3
         +oBnDHnZnJl5UV9B+7sXOzS0EcMnC8BefxAnlSrPj8VyAxLHQjRV3k3PD5oBoLo4cQgo
         GZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189340; x=1780794140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BcbBqWTkzkDxwNMdgJ7xVJp7N/TN/+GdHi920u4savY=;
        b=UeFfkaJmhGCwEgqeffatlVTMa5vFGTmKxhzHjV1KpCZcbd/i8PbBFG8rP8C+c7bs/5
         hx3jYw3frQhWVwjmJgdHLfV7JFtyTRZAsDXXYZ8nbZ3wpnx/0gBwS0m9M6T+FMoVMfrT
         r49xWtZTsJ/37VXfhwa/FXvZVApqgPB3oQgkRUdYv5Ee1hItktgxkIFC+jGbH3XysXeI
         1xWMhzk0BmfmFv2nwsfyD6hATi0Sc7ywp8rh++0ltuoX6Z9NSJA2Co6OjxCqVI0Dw/k+
         CN86a8519+aiZ9xwcVIlCnswaOl2cfOa4IX1SzXScLS1PWoHsm6BLzt6StibjccNp0Tr
         OiTw==
X-Gm-Message-State: AOJu0Yyz5pKbNLXzu4PxEPhfi+FOUSgTqF2YXtASBWKhtuazZ904LsVF
	7xFTcN/9qYL9IqjffKbqP6+tjHC3w822G/K+BZMRIF9JsTZZMpYOnguITw4RpA==
X-Gm-Gg: Acq92OEGynJUFNohOKX5zncsq89iu8oIl2L/PtcRJymtxFuICoBCrBv8VO8J4m4nwMy
	63z1LAoEu+EwpzHntE1+4/9naFnsmfhm5YtVkXObtuDWiHkCw7cTVJk2H6VrRuGcOEJNfPHvyVE
	R+sPJY6uh1AoOCTK0DP6W1APkfrig1wvL19EnVWymmNS6n91ZHknh3OJE+W8ZMqzgehcp2oZzlt
	GavF/Tz9Exv9r7BxMaRpvAUpuWpeFHyWrP3Nq1dBzrI6NMdnP2bBFNEWDORiMgSB8opp3fmEGMj
	PuzRakqCZ3CtLiPUFz7uwkg6H884g5FaraLk2/Q9NjfAHiIQQlxkWzStUxio+Mg8jmzgbfdKWd6
	9cSKN/juQ0geer5D2zLZ+lc1+5WBIHjUWAoakduEjeupmcPZZWwOIs8OXWYikqUVllpOPzh52rc
	TCLBoHYMWWOgQUDK7iJCFRJgC0Mwu/PQ==
X-Received: by 2002:a05:600d:8648:20b0:490:9d5c:a3e0 with SMTP id 5b1f17b1804b1-490a29215ebmr71216825e9.9.1780189339981;
        Sat, 30 May 2026 18:02:19 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c103908sm45297445e9.22.2026.05.30.18.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:02:19 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: [PATCH 1/3] tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
Date: Sun, 31 May 2026 01:01:05 +0000
Message-ID: <20260531010107.1953702-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused parameter "flags" from "link_pipe".

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..59adbc2fa4d6 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1849,7 +1849,7 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
  */
 static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 			 struct pipe_inode_info *opipe,
-			 size_t len, unsigned int flags)
+			 size_t len)
 {
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
@@ -1962,7 +1962,7 @@ ssize_t do_tee(struct file *in, struct file *out, size_t len,
 		if (!ret) {
 			ret = opipe_prep(opipe, flags);
 			if (!ret)
-				ret = link_pipe(ipipe, opipe, len, flags);
+				ret = link_pipe(ipipe, opipe, len);
 		}
 	}
 
-- 
2.47.3


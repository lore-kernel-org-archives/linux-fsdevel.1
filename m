Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3D380FD3
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376634; cv=none; b=T6tx7Kb53h5zf58xLwvD7oJfv/C8Kz1rugMUF7SIxSlZ7A0FhZRDLa0bGm6rC2yW7Cm9y0lj/5zKuE8e1WskgJgxYc/hBT3n3wgz1NR+Po7mGMmiy+owr9U04qITElUKrMuxt9TojWze1N01+lS6+sLJBgpeUPYBGLYHpSsub7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376634; c=relaxed/simple;
	bh=vfuzqAAI4Z7JfbLKu/I0egbH5sPpHBKYRHIHNaxeamI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH2V9XLubOUg+nuO3F2zFAY7ah7/heLBmbRcr79Q19edh/Nyks+F1vyEkic8A+OXGpFk+1LEigoBNTgIGh1tdJVYdc8qRi1y7c+cIACRe38piOx8drngSe8obHywZN22f3lSrhICKVxLLt61iiKOCghv8el+m3eHjz6DtTjZ/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY8bp4vJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SY8bp4vJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-462342ac290so2364338f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376632; x=1782981432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vxs0grT+d4GM87KSfFWu+blunYqTUopWsPT4iLI/6Q=;
        b=SY8bp4vJ76cjT0gwKLLfSbNmYwKD0fXJ2UuZWI5dUi3h5u1WOMEJ4YDKo8cnZ6hGEJ
         cpQKdCndXE1AnzLlhE/8gKp7lenq/s9rx0RzLaVh2asZuPgWoVTZ1h6pAmLnhoYB9YDR
         Awtmr/mCJwudvY6e8qBjC390B4GH6a7K4UaUNaxu/gkzBGYlnJKYvL6f5LFhpxrcYx9W
         SasWkRH7b+KGkyy0Oc+3PGet2f2EzR3AasepQkvpKyMqFM3TTr9lihS+UhncODRCjpzd
         OhUARFvI4q+VmDPchhHBaNE1BkDcdJKC81n9QrRTZTVapEbzd/ffjeoqO32LOXnGojr/
         9K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376632; x=1782981432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Vxs0grT+d4GM87KSfFWu+blunYqTUopWsPT4iLI/6Q=;
        b=FYHwHpdRME67j1n8Sgsl4Y7Lg6cpc6tk1j2hAd0Hd+/xzxZM9rNneDdNgC9dsjbXh0
         v5dG6G4Qrn4V9xzMQJLlSZ+FSkBkBdWWE/XF3GlH3MmEh01fdBQvArq+1nhtt9xEJje3
         ii4OfioUeylCI0fKas3uawftwbV44lKKfY+XvSmCSVowBF1XsnbcAFkZbm3PMDKQh5hY
         GinhcL7o4Bp/sVDf7DtMBxNn19NKLNDTq9avNizmbDMAPMKrzdtwnt6MfjIsjHyb0wAo
         +wWwHXM7IKu9g9DjQ4mySidcripHkFTlfmvGDt4+ccB3vjNTADI02Q+J3qNC3Jo/QwoA
         Dpcw==
X-Gm-Message-State: AOJu0YyKmWBakocNMfUSDD0KQqrBjiRTxvg30x4r4f9CKUOs7F8cI6qc
	7DuVtzJyev1O7Qm4oW+YDAPUdOD9dR9OH/D3QxDyw2QmKxz5Chwj9bpFZLdDUI1cYFQ=
X-Gm-Gg: AfdE7cmIQFxo+SFkyCf5FSrlgLcB6oA9VpbeXQrmEJy8zde5lnScjwrTKXSfjMOv/5o
	sskW8EQemPwsYMoc6pUAZd/mwQ6qjOj71GyLlQOz3jIgDbGF5pd2Fxs4axfsDH98Dgyq6X7zygA
	5x0Y31ycPwjd5urWUqsHD/7stDe90yRGnB8xGbq2kkdF9k40plUoXa6HI9QJTzvJ9HQPcEfD+m6
	UygEljgEitynvjxNImt8GjUPdRowUCo6Alg/HgaZy2eGzhjjlxjjNuKH1Sc+vbWU2qJycoBQ55H
	am3GqQ+WL5SIegLZ/Hk/unaVNMuZUcDqgdBa9OA8F4UrBFVu/DykGYBtgFmdA1JVwvLEue5/oIM
	3GvPQFMrZ++bkJdOdS7UGlqgMVCvWhxWQSzdDlZ/AcyiE6a6ga9oPJ5QX36pSEXbT8Snu7tk91k
	tytGluIUgi
X-Received: by 2002:a5d:5e81:0:b0:468:4f81:5aa4 with SMTP id ffacd0b85a97d-46dc026de2bmr2181270f8f.10.1782376631864;
        Thu, 25 Jun 2026 01:37:11 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c221d93eesm13786367f8f.20.2026.06.25.01.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:37:11 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 6/7] vmsplice: return -EINVAL for particular combination of flags
Date: Thu, 25 Jun 2026 08:34:08 +0000
Message-ID: <20260625083409.3769242-7-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See comment for details.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index dbd0debc2..b1f71b142 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1258,6 +1258,16 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		bool non_block = (flags & SPLICE_F_NONBLOCK) || (fd_file(f)->f_flags & O_NONBLOCK);
 		ssize_t ret;
 
+		/*
+		 * libfuse relies on sharing vmsplice behavior.
+		 * So we detect particular combination of flags to
+		 * pipe2(2) and vmsplice(2) and return -EINVAL.
+		 * This forces libfuse to fail back to non-vmsplice
+		 * code path.
+		 */
+		if ((flags == SPLICE_F_NONBLOCK) && (fd_file(f)->f_flags & O_NONBLOCK))
+			return -EINVAL;
+
 		do {
 			pipe_lock(pipe);
 			ret = pipe_wait_for_space(pipe, non_block);
-- 
2.47.3


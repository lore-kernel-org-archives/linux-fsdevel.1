Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794142584;
	b=Ged6g+cFX7hJZnV4rU/7c4ZvejF1G6kNY1RjeE7VlRPP3/BmTz40GjNzsD3tlQpu21bN
	 S5oxbxxm94hSJy5g+22Xpaqc5e9qvx0WT0UQKbnkixj4pwthRfViFJBlcc8VHLouf6Djb
	 KkWSJCFUOCvosP6KONRmEIS6L45n7ix8YV/R6CyXWM3t9IkLSVWEqVY/nLaf9hDflyTMv
	 1hBNV/XdbiVuCZSEafiNTn/fDoEk2ldudsR8OuR3E3S5zAqzBm2QmteBY1zn5KPV3p+AO
	 HJizscB1Za/Y4RR1DfsCj1/eB6GddyziOyXpzQ/Hgd2tN4cSrb6Ju8sqTVtEwrohogg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794142584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=84P1pX4lpO1OaC5mRIJtD7cq9/wTHeywebmO1thFbP4=;
	b=0jp9oWEbgC6h6UucYk9MKoBIkIM05XxkHmNLWgtGQjni0V633Glrmt4ECQdIuktxpV2w
	 YD1bFd/4ClKovbELd7rjhr9dytVdbaZViX92KZNwY6FYsP9YOgNGDZwyYdv2XNGK+cAR9
	 FEX7j47vsQl4yOQCt8aIfN+Q9x5O6RK1CYZySAHoHMz1tY6SWui81DPQvBbDeac2gdqfS
	 NyRXm3KR7/ZI/Auqpb+2AqHDZtgshHOWdqBp+/EcN+PBiWtEZHtpjfLqeR2mJRvPGjUNK
	 l1cIg1AF2lr8N2ZJwQBSepAkVUzwV7SDoZpY69Zbkd1a04a13vGVtly4FTrziUgANDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQ3k+R4T;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE33606A320
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 12:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE33606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQ3k+R4T
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so595555e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 04:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794142582; x=1794747382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=84P1pX4lpO1OaC5mRIJtD7cq9/wTHeywebmO1thFbP4=;
        b=fQ3k+R4TuSIVy1/ILvvwM/1nQWgb0HmiYPFP30x/5WAe9G30RaXrSD/nAL16Z0KqUg
         mJaqeIkU8lz482fRKlicx39SSzEEYgvFrWkkAkq2q8eI02PSFxCQY9ekK5yew+zaOU8J
         RuBvSGpK1K6UJMR9I3DiyWkCC7UtENOoCFN3DJX09l9LDdFCQbhoKn81m7DG0hyjBws6
         yhD0z74OvTdOuY+hkvfwkgYwtarHtazXr4pMMNJdQ7g1TrA5wVz/7h/brxcH6jUSoRtm
         oy6rwMs+nmz17rXcbcRlNvOJpbFgwT+okYNScssnsVIhr5Zz8ukfZu6N0I9YDZ80ZLad
         OAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794142582; x=1794747382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=84P1pX4lpO1OaC5mRIJtD7cq9/wTHeywebmO1thFbP4=;
        b=FzmtN4y8ERKQsmcqsFbYNchjzfNx0nn30/wwmaaNGtgYwxYZCmOsuB7u5660Vp7sVx
         R6IoDYK/3/l11Fg6rc1DF8cQ7sXWyOE+/9Q1qYiX0I5xhdRUd39ZU+CogVEVBmCwabgL
         0MVG10uUmtTHqbwP65Wqzwx6ITTEMJhaX8N8uSH/Prwggqe2MqzNWu9LZBy3M4CAIA/f
         zVCkUo87xSUQAOw16sCN3i3Cw4hzBdQ63VYh9PrH2HiKl4pwo38T2F9Pek16pHvoDezu
         kVBpkTsMSBvDyyuDG6t8VehYTP8ne1ojDYVIipooZ6Jk0huQPfXbcIQSNwun15JZkxkA
         rQ9g==
X-Forwarded-Encrypted: i=1; AL+hErHjTPX63Aa4+Qm8ZAUlr2DrSbO6Hs69pcExQtiMd4EdrGp2ddY4yLx1Kb3qr9g5G8RPjrHOnEoVx7SJWhJ4@vger.kernel.org
X-Gm-Message-State: APuU4Z+zXFVxvIxZ2v+IPL1iZnx+XPkamj9xFdPAdeLSFPNi49yW73hS
	YNM0G7CVP1UhSKpxE6nO4ad7fqlrbx7Fj5QPYm5pEgjVdbgMAgQ947vR
X-Gm-Gg: AYBFou14Mla45sD6wZcrT0qq0alPNB8y3q9g1T6h2nDBtZtWHhu5OHVFwbuewOjQXQo
	1YeeR3zSWAXwbPQ1/bCoRkyBTkswoOmq7wlgQJwp+2UiYEWOpKIERlwvXoYyQUVlMZTnyZPyD4I
	0eR5XLRtzNlGTi1aVbgW9P13wq5mWV06cmD76pgHMAjzEQ1rHFGpnQDyIwNj87n9xjipji/ejqm
	xj1FPU6JDRC0zq1ykRJOVt0j6ghlTNzCcVKFd17toBpJasIkW0BBATAKU+zfjU2O9ELJr9jDVxI
	A6HqQVnxC46pPIgveQk74uReEkMBPKrtGjABjrZRems6nUPUNQDpOtixEO7ofXu+m8A1eYsYK5N
	QXpApzqWTJ+aDx7Z+yV6R518wFlJ3UK1kmjkokmJBwM8UhIxdS+zD0Wj+OmMtZaXXGnTz+vyAgU
	k3/AG2M4rBsMRDM/bR2n+1YzeWclXYzX4Tx++MweFqruMZDAIK4RmjqxRt7fZ8DRmt6TIDPUGbR
	CrsdzcuAxd8x9ApvhHlkHbOCOKMO6VGXwHhvneHKKN4jMaSnDsrSzDoOBt0KSfguOOocSM+ixmV
	vXWvliibnCOWZxsv/6q0JF8tQpUh8iYhoA==
X-Received: by 2002:a05:600c:4f86:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4b960d9b17dmr26242365e9.9.1794142581814;
        Sun, 08 Nov 2026 04:56:21 -0800 (PST)
Received: from LAPTOP-AVI.lan ([147.235.199.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597d0a775sm4114641f8f.55.2026.11.08.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:56:21 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2] fs/stat: reject invalid flags for empty paths
Date: Sun,  8 Nov 2026 14:56:18 +0200
Message-ID: <20261108125617.2383285-2-thnkslprpt@gmail.com>
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

vfs_fstatat() and statx() take the file descriptor fast path for empty
paths when AT_EMPTY_PATH is set. These paths bypass the flag validation
in vfs_statx(), allowing unsupported flags such as AT_RECURSIVE to
succeed.

Return -EINVAL for unsupported flags in the vfs_fstatat() fast path,
and validate flags in vfs_statx_fd() as is already done in vfs_statx().

Fixes: e896474fe485 ("getname_maybe_null() - the third variant of pathname copy-in")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
v2:
- return -EINVAL directly for unsupported flags in vfs_fstatat()
- validate flags in vfs_statx_fd() instead of changing statx()
  dispatch (as suggested by Jan Kara)

 fs/stat.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index a2e63c6c45b7..3013e4ece011 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -322,6 +322,11 @@ static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	CLASS(fd_raw, f)(fd);
+
+	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
+		      AT_EMPTY_PATH | AT_STATX_SYNC_TYPE))
+		return -EINVAL;
+
 	if (fd_empty(f))
 		return -EBADF;
 	return vfs_statx_path(&fd_file(f)->f_path, flags, stat, request_mask);
@@ -371,8 +376,12 @@ int vfs_fstatat(int dfd, const char __user *filename,
 {
 	CLASS(filename_maybe_null, name)(filename, flags);
 
-	if (!name && dfd >= 0)
+	if (!name && dfd >= 0) {
+		if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
+			      AT_EMPTY_PATH | AT_STATX_SYNC_TYPE))
+			return -EINVAL;
 		return vfs_fstat(dfd, stat);
+	}
 
 	return vfs_statx(dfd, name, flags | AT_NO_AUTOMOUNT,
 			 stat, STATX_BASIC_STATS);

base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
-- 
2.43.0


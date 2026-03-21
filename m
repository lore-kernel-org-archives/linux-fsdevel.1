Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEFB2D5925
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774135357; cv=none; b=FQHZERAL5xNa7t//ulQotaAI7c9t6wF5hWjg0onNgXsx/MR5Jp1ADR+ojdjkeLXdreL/imJjWUozh1SURl24zS08V8Y9DKAkfkYtwLaRztwMYb+Q3TszzIfKf0/nXM8Q7NmtZhalxCdBmSTyKwavUqRXc3jeN/ARNaDDdaq2aKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774135357; c=relaxed/simple;
	bh=2A7HAwFCyO84F13+VNf41l4t3XJGRxOx8ZgxsW5FLNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idtRPTekZeJZr1q8GokQgR6osdz1UQFYwsTBlrGZNmw9xzZnFsax5lUyCJiqfp+j/5hbDD9AOTlMQPSEGlBMJmN6xbcFTXEcVZEMxVXB3XXxzMg6qUfRzPd+tynd8wwbEk9VeVEol3NlxLn7vxLC2807Ps1WbrSstsuB6DWoAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYy1VqNI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYy1VqNI"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b9b190easo2305258f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774135355; x=1774740155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk94Sdj/ITRyjAWZq3WAiEMd1s7mDg5eakazuQCLZCI=;
        b=EYy1VqNILsvBCqXqq/jw4w8ZFsZtMR/JwPMzcj0SkjUATtmaDVfJskoprXuxQn9wJ7
         l/YGB3i3+ilhUwFOnmDX/2RmhvxGD6GvyhNbXR6eMIrajdXSXZ23lRn8x0qd0ICA68f9
         jLZnYjpZ+zqJ4107UVasZi40VVEehekbQkJCwIw4QmovBSFVGV8BjvMV8K0sCs1NKzaX
         8zKjZMgqRH+5g0bRuERgXTzg7C1c3PIreuf0tA7cvqS1fDj8A0vHgy6UpsOa60zrrJ/S
         A4B5Z6lmfvVlOgsZWh/8l9D8+tSgR8n7yShCXrXjIU//eLP3OOuhtiuR9If7Wyk7OQRt
         m3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774135355; x=1774740155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fk94Sdj/ITRyjAWZq3WAiEMd1s7mDg5eakazuQCLZCI=;
        b=LN+xp2vMd2P/mplUeuZ1tby2myvfP9WXSyYQ/3Vcese9Y+PMMU/GIsbzOtbfroqHxs
         4/WQEdBlloi30gHc2+K8Sjw4NO7g/1Dtjos5Mja8mV3fR3JO/TM/hOI9Dw7ciYovAUBb
         qISzIOCFakqHBxp29ZihF5E9wC201ly0otbzEi32TFlFpaFppoCE/Qs45LxRwVKdtJch
         S39F1jCItBgvXc2mW55z1F0sTxTuHbl3CNbICen6OctWdgvKPMzwDNIN7l7n3oaYxOkR
         eM8B9QOqMzv2rd0HNytkOCl72YQDVkg/cMeZ+cGUbIn/KXNmr9Dm6Ml/L/BsP1Xl8IxZ
         OWww==
X-Forwarded-Encrypted: i=1; AJvYcCW12bb91QmGLuaGuOWkNeOKmQ2p5T2djky8AIsHFd3aTsxFW9cYxIHPRqde+yaTqfpu29xjm29plULknvjq@vger.kernel.org
X-Gm-Message-State: AOJu0YwBP7BgMSBfFTVVSNjz8Zf+MMq6SF0Z3sXE/JNEAZ6zPTeLer4y
	lNmoyGhF5m062k1C8AA1KMoHzaETZjbRsiXORYhGsvZJBCcha9y2vkUQ
X-Gm-Gg: ATEYQzwOYKJHWOunC5Kvq4sb0gdKnalmj0QMcGnDkL0VceeF5YaQOIm+wTYm0C196Vk
	Hj/j3OVNuHz9z2sDqpqGcrNcvyOfr/w9ECoomYPyA0MEB+GHkngrcmLKKU+T1ydIijzOc5LmU2X
	LyHxYZ+Q0AkGlov35z/b7xFTZ3AMZ2Iz9pdvMS1w2lFlWqNx1+sLZtB6HqMS0PzWYV5hUFRHfKL
	U1ZuGTfuIf3Dfy7XqlR+eRAP8631nvHUmEUG7LtNJwgMb2tXBjey8FDNATS9xzkfbmO0/l/QWCl
	8w83wWkJqWdUNrjyY9wICJIX6kfm/TQq3gWolaGEhDObGwH7avmeRUktBrQbrnwt+w1GQEtmfaQ
	zv+lgG6pstqyPiKUHYiYw9MDVN0GZvJB6rddMZZ9v+vgzGX0cGglGHRjYFSv6KmlrelGuxCxUxs
	+3TMPOTWFBDlVCNZyCtGOej+ltbFsmoKohim8cRProSE17pC9Tt4+34nIn+l7w1HFtbZRa6w==
X-Received: by 2002:a05:6000:2383:b0:43b:445f:3177 with SMTP id ffacd0b85a97d-43b6427db29mr12416953f8f.31.1774135354500;
        Sat, 21 Mar 2026 16:22:34 -0700 (PDT)
Received: from ddp-thinkpad.tail20b0d.ts.net ([95.141.20.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm15609897f8f.0.2026.03.21.16.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:22:33 -0700 (PDT)
From: Daniele Di Proietto <daniele.di.proietto@gmail.com>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Daniele Di Proietto <daniele.di.proietto@gmail.com>
Subject: [PATCH v3 2/4] fs: Export expand_files()
Date: Sat, 21 Mar 2026 23:21:40 +0000
Message-ID: <20260321232142.911280-3-daniele.di.proietto@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
References: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's going to be used in a future commit.

Signed-off-by: Daniele Di Proietto <daniele.di.proietto@gmail.com>
---
 fs/file.c     | 5 ++---
 fs/internal.h | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 384c83ce768d..573ab3b5191e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -285,9 +285,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
  * Return <0 error code on error; 0 on success.
  * The files->file_lock should be held on entry, and will be held on exit.
  */
-static int expand_files(struct files_struct *files, unsigned int nr)
-	__releases(files->file_lock)
-	__acquires(files->file_lock)
+int expand_files(struct files_struct *files, unsigned int nr)
+	__releases(files->file_lock) __acquires(files->file_lock)
 {
 	struct fdtable *fdt;
 	int error;
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..3a26252dcdae 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -197,6 +197,8 @@ extern struct file *do_file_open_root(const struct path *,
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
+int expand_files(struct files_struct *files, unsigned int nr)
+	__releases(files->file_lock) __acquires(files->file_lock);
 
 int do_ftruncate(struct file *file, loff_t length, int small);
 int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
-- 
2.43.0


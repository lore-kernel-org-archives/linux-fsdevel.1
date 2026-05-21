Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E13CE0B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368441; cv=none; b=Zd55t+mhtoWUwfMxudPQSUKk7pKQ/ah9Htfcv0UpNvO1OKSDwWlJmFoaaQFoTecLLwAsY+TEzr9FnEWm9RrUdBbfFIPlv9uO8GuCpAQ3+5lJGDegqu4LMtAHnPjZGySKhy6ywwn45KA6PBYwErd5iKhCKWbzY0Ls4KJUTuLL3XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368441; c=relaxed/simple;
	bh=/DWc/21g9inXKmvGrguCVoASZnB9td6j3vz+VAB4B/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0XUPUAtO7bDp33hvdSqJ6pcwXsx9duo4/zEYSkLypviU2DNWbNx4hwuAMidWkD+1vUNnI/6TZJXNDJr/h+cFuHkmY5/XO3bpOS+QtFBZz6k/d954S5WAtTtxgDFpLNKUPS3Xey/IhDDa+4YG+MTXQJsVuin0u0PUSc8544IoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQClNk0C; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQClNk0C"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8015bdf1b5so479592a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368439; x=1779973239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pO6x8dH77Fth79N5r1T9JUIJlEWo1Lrxw0QlFm833hg=;
        b=TQClNk0CmoD1dJ3ZD+EktTNkfFCbDcSHom3n3lYSwXV72aXHPJ7HreWUFncTBYk//y
         55ZgWT5KUuZq6NKl0rZGOs8OBUBu3zgsdWHNcqsnu0y8EYuDBe7O6SfiaIaJqC/oFk+7
         bMmJcOz4pbGwZpJamg47dBjlBF/RDlcyfTGmy+KglmQtQOmXV9PEb5TYwXaaL2/o6Y+Y
         zvNvGi8IsrLSZw54NrC18e+sYTJ96w07rvxdvI7t45+wjYgYscYUfGX5Hkkff1PfXb06
         je0j6oekCWz2P+pRWVL1TWlpztEfRdxfpILLpeVTAkfZj8PXiTJOOWAA3hM68hKuJpM8
         RQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368439; x=1779973239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pO6x8dH77Fth79N5r1T9JUIJlEWo1Lrxw0QlFm833hg=;
        b=WNprxMjW2F/JCWEX0LknX0BLBO/G8gsFQFfm3hEb1AJOELVkT7bBBUpm190+J/gYDY
         NcH+X7qpXTGhyM7pPbza3kZztlTj3XIoRXYhFkKMY6CRcC2vQNtRgrrbK7CIIiobyXMM
         vJ4bFTdAlDmXE42w1vQ4IJwAY5QHbg+RFWxJoBi6rTFDyEj7I24I1FnEtvgQwlKqdGBy
         PxJfTtnmUh0HCvGeTN5dkqJXbsU0DkU7n3nf4hg5pHYFf+qKDt0iMwRl+oJyVuNWJWAQ
         d+CIbn7IfdlB5chWz2Q4xB8NLWqWq++q7tKr+ZyQMFr8GvbWZ6gpK4sM7IKfTxPLynhy
         lxYg==
X-Gm-Message-State: AOJu0Yxljikf3PqwLc0qp2xRFaeT7gGzBtw6B8r1BdJod7et1s5eWyiQ
	jAOsEimUgQiDe0ULJaF7GhqWnE8Otaxf6Q7YhH0B4nPiYO4OAV8cu+rDd2M4Lw==
X-Gm-Gg: Acq92OFp+So9aeiEuoNkakfHspG6DxHWCmIb78/7xwCl6rqjBlN0+xNGef3OtcSJIm0
	iwWVplC28UjnmkKk4tCvbb5OAj4Syib1zQLAWWP7jW3Sl8mFrCo9ppQyyJOhiulR3bQQAyWjDpm
	3zKLcs9krgSOURe6kYaRERxjM1YbxHU48GRdbyCjoIJLypCk/1XcLo+4ZV0Uuv5VzTKxpYXmu5D
	6KBhv1wpIn1ph9O0Glme57+xV8R+8uvqfBzvikgpwyfd4uYI0A5L6cdEQsBxI0oUcOXD7c5acqy
	NAXkkSBdzNPVfEQcvC7gJsCYErz8JJSTH4I9tP8KUj06nJwahys8jV193fU5GzDgErYvlof8hvt
	jhX7tgglMtzH04DhaHsiK7kyp1Gk+LNve9K+OJ6JUlqi6c8a8SGx+ttTFSqenhh30Edeyo0dHe/
	w2+RsGJ1UsJy5r+ncm8wMLU6OJlnc=
X-Received: by 2002:a05:6a20:7484:b0:3a0:b812:3a84 with SMTP id adf61e73a8af0-3b308530a6bmr1862508637.1.1779368439012;
        Thu, 21 May 2026 06:00:39 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c851993d8a7sm284340a12.27.2026.05.21.06.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:00:38 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v3 3/3] ntfs: only alias volume $UpCase to default on exact match
Date: Thu, 21 May 2026 22:00:17 +0900
Message-ID: <20260521130017.713848-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521130017.713848-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
 <20260521130017.713848-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

load_and_init_upcase() currently aliases vol->upcase to the global
default upcase whenever the shared prefix matches, and then truncates
vol->upcase_len to that shorter prefix.  The result is correct only by
accident: upcase[] accesses in name collation are gated by upcase_len,
so the prefix-equality alias produces the same fold output as keeping
the volume's own shorter table.

Still, prefix equality is not equality: the volume table is logically
distinct from the default and should not be replaced by it unless they
are byte-for-byte identical.  Use memcmp() to compare the complete table
in one expression and drop the now-redundant upcase_len rewrite.

No user-visible change is expected for compliant volumes whose $UpCase
has exactly default_upcase_len entries; shorter volume tables are no
longer aliased to the default.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index d2c4fb6ea0d4..876e978370ba 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1323,7 +1323,6 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
 	u8 *addr;
 	pgoff_t index, max_index;
 	unsigned int size;
-	int i, max;
 
 	ntfs_debug("Entering.");
 	/* Read upcase table and setup vol->upcase and vol->upcase_len. */
@@ -1374,16 +1373,11 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
 		mutex_unlock(&ntfs_lock);
 		return true;
 	}
-	max = default_upcase_len;
-	if (max > vol->upcase_len)
-		max = vol->upcase_len;
-	for (i = 0; i < max; i++)
-		if (vol->upcase[i] != default_upcase[i])
-			break;
-	if (i == max) {
+	if (default_upcase_len == vol->upcase_len &&
+	    !memcmp(vol->upcase, default_upcase,
+		    default_upcase_len * sizeof(*default_upcase))) {
 		kvfree(vol->upcase);
 		vol->upcase = default_upcase;
-		vol->upcase_len = max;
 		ntfs_nr_upcase_users++;
 		mutex_unlock(&ntfs_lock);
 		ntfs_debug("Volume specified $UpCase matches default. Using default.");
-- 
2.43.0


Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2C436BCCC
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774968399; cv=none; b=nyeO28lhmNur5+TVwrZX07k0ElUoCJ/8jrbE2ig8nfWLYmok3Es7mdr2OgiguFwhxHy1ZwVWjxeVR3J2kshJQzIpl3kAOiLkVs4wCi2EoZOUZ3x0OLXihnLTpe6Qe5uPhUXU/8vHgA95QFNFEUgrR8A91KK/dSoaI489Mdpm96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774968399; c=relaxed/simple;
	bh=VODwtv8tqg77Qyrd2kE5ik1A7E4u1DH8nvDXjdEOiS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o2vz7sDuGNuYFBFKgNbIEmkuPzcAe1/GdMWiQLBTNL16DCav9YlMo8lircbGdP9+ZpQkn7YsfdGZaPSvfge6tbhdOJCNHqAy9wJrVAWQnewIlYQ0qOMnODMIAb1btASD0bPr2UI8olkriTSdFAlrOVn/C5eA7h9jE3Wx1ik8NgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=S45bJKH9; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="S45bJKH9"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so1391408a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1774968397; x=1775573197; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYRpL6HZ5g+EveC88wD0rmWXlgJIwtaLsSKUra9EGSs=;
        b=S45bJKH9YZW04hWJ1ucfVfiYOOtmYbvG8RVG7wEuDXsko14GsF+Y8kMy/EsBh/t7Fs
         2APio3qEpryceYjS+2fQkIFurA/3nP65T21R3lXyMxk8ZrTdsYtudGI2FmEyv8QKzVLg
         xzb9ki551+Qy5d6K5xIJZCnZF5JtHK3Xzsfw7m7hi+axEBv/RXupyYGUPctd08aEwBQM
         27EX3gCmhzDtOKzQ7V/HLun30JaykjIP+y8YnvPbQq8RWVJwZvfM+mFxZ8OuNM/JQbx6
         98YEGOLcD5cNCf0DBbmLBnjF2hEtHfmW9ObQWWM2TC5WRf+axxnlhMmNPG62wBoPSssi
         DDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774968397; x=1775573197;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYRpL6HZ5g+EveC88wD0rmWXlgJIwtaLsSKUra9EGSs=;
        b=N9hZqnNZB7VbU0AfftC7Y4+lDNCpWkIkgZOdPFliLYVZ4dEYewHemCZ3uW2ThOBy7x
         6O/rfEnABy1LtMiRRliQUUxwybDwVRaRROXvo01sQ6hqjqXv5OsOJ7XX2bpCUPuO6CWw
         4oTkdGq5QUqYOCi48xvpOqD6m2FzD9AeDpD+8CLRke3XApD+QXHlfXvbIQBWNBQw4qGf
         WF5EBSdl0cKdG4WadlxL9LKtRnHmsnhRR4GO4WtXz3bo5Adlj1v+9WgFAM++/Fz9q7v8
         itJwFGsc9X1FtA2DPitqrDVd2tWOLgZ3mSjlAWda+dr0OIFASM6JDA/K7fUmubtO2GJ5
         q4TA==
X-Forwarded-Encrypted: i=1; AJvYcCWGGFm0YktPkJtHnbeQfz0fOV+aqsRpEHSAlYbxXmeyjh/Uo+OZGGwcwMs3U0qVDWe945zEAQTq3rrBT9L4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+8HfSyZTlGmRYh5KUZ5XEBPm/S2gU/gzsaEydMSJfhH7T7lWn
	NqlDmT8uPHizeX0E85Rj0a9lWKhCLyh8vefeOYs9564AyBvz6ZnszwHJSOxjx57kzsqo
X-Gm-Gg: ATEYQzyDtkYQHCH9z/8IVWKogOkVStEF6P3D7Gmiau2ywa37Qu9NvENVsreSLs+LZw4
	ysIvxHkuvh3ml9xqa60er0+zMYeyCHe5aL6N10NEVdW4lkCvIWMedPuJg/kBZA4zSpVj8vCSd00
	QGd57H+ZfoY7okHtVpmrqu8ibv4bPZRc1Rm9P/jORFp+jnqfbtNCDbpRLCgTkg+T/if5PB3NHJ8
	deAB29dY3fSRxunkTnLmFgQryPyXLeSjk/a9GS+gLr49kqgXGAjk/M2liwzswbVSLNMN0cBtFuO
	n4w0l/q+1etzHqpyhc1RNMqXF3YpJRw21i3eo5H/ihyLR5Ynxh1LqFShdOd1WoZCAPsXTATr+U7
	wdgzSyE2S7hWx0VoeS6cgTESgIULQ2cBKoogPkPG9HJQiO3NhLXLQ3XEE4L1ZIYi2Wpv+hQPGPr
	OGnQi1MXCyqXPgIk+r/hWOt9zf70GbG8a6wqXdeyY87a7BuNwyeSWMGji4TjUm5KLxYOoD2Ps9J
	E0CQD/7WScL6aTH81Ptq8DgLg==
X-Received: by 2002:a17:902:fccd:b0:2ae:a45b:42f7 with SMTP id d9443c01a7336-2b0cdd03fdcmr112665235ad.36.1774968397305;
        Tue, 31 Mar 2026 07:46:37 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427ae07fsm118719305ad.69.2026.03.31.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:46:36 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Date: Wed, 01 Apr 2026 01:46:21 +1100
Subject: [PATCH RFC] dcache: permit dynamic_dname()s up to NAME_MAX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-dynamic-dname-name_max-v1-1-8ca20ab2642e@amutable.com>
X-B4-Tracking: v=1; b=H4sIADzey2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3ZTKvMTczGTdFCCVqgsi4nMTK3QtUgxNUpKTLBOTUwyUgJoLilL
 TMivABkcrBbk5K8XW1gIAqXukfm0AAAA=
X-Change-ID: 20260401-dynamic-dname-name_max-8d14dcb9acd0
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
 Eric Dumazet <dada1@cosmosbay.com>, Christoph Hellwig <hch@infradead.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aleksa Sarai <aleksa@amutable.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=VODwtv8tqg77Qyrd2kE5ik1A7E4u1DH8nvDXjdEOiS4=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSevuf+bsNz0wg200wuNrPlObxeC9Z7RkWGRl9lWqZ27
 q5PSalLxwQWBjEuBksxRZZtfp6hm+YvvpL8aSUbzBxWJpAh0iINDAwMDCwMfLmJeaVGOkZ6ptqG
 eoZGOkY6RgxcnAIw1Yl/GP4XnU3fY3ng2eW7Fl61Yc/TcsNU+OPfKns9XxPtJ/HgzpoAhu+JE47
 wvBR5cjxnot00s/Q07f5vkssVtymfOVXiVHpDjRUA
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

dynamic_dname() has had an implicit limit of 64 characters since it was
introduced in commit c23fbb6bcb3e ("VFS: delay the dentry name
generation on sockets and pipes"), however it seems that this was a
fairly arbitrary number (suspiciously it was double the previously
hardcoded buffer size).

NAME_MAX seems like a more reasonable and consistent limit for d_name
lengths. While we're at it, we can also remove the unnecessary
stack-allocated array and just memmove() the formatted string to the end
of the buffer.

It should also be noted that at least one driver (in particular,
liveupdate's usage of anon_inode for session files) already exceeded
this limit without noticing that readlink(/proc/self/fd/$n) always
returns -ENAMETOOLONG, so this fixes those drivers as well.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Fixes: c23fbb6bcb3e ("VFS: delay the dentry name generation on sockets and pipes")
Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
 fs/d_path.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/d_path.c b/fs/d_path.c
index bb365511066b..a48957c0971e 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -301,18 +301,19 @@ EXPORT_SYMBOL(d_path);
 char *dynamic_dname(char *buffer, int buflen, const char *fmt, ...)
 {
 	va_list args;
-	char temp[64];
+	char *start;
 	int sz;
 
 	va_start(args, fmt);
-	sz = vsnprintf(temp, sizeof(temp), fmt, args) + 1;
+	sz = vsnprintf(buffer, buflen, fmt, args) + 1;
 	va_end(args);
 
-	if (sz > sizeof(temp) || sz > buflen)
+	if (sz > NAME_MAX || sz > buflen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	buffer += buflen - sz;
-	return memcpy(buffer, temp, sz);
+	/* Move the formatted d_name to the end of the buffer. */
+	start = buffer + (buflen - sz);
+	return memmove(start, buffer, sz);
 }
 
 char *simple_dname(struct dentry *dentry, char *buffer, int buflen)

---
base-commit: 84f524dca4b8bc9e9aca8ea1dbbd2aa3a239d998
change-id: 20260401-dynamic-dname-name_max-8d14dcb9acd0


Kind regards,
-- 
Aleksa Sarai
https://www.cyphar.com/


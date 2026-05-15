Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56002949E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862853; cv=none; b=T7SaVhZQQE1zWqNidWQe1pZ8/wpx3bw7NJwPdrZUF452f5JZQSnlvTZPXQ7q4egIuAA8tLzGXHz74W625CzQ6FtlJa7SWwPT76hTroLYeV790+fBUjtcPD7GU00Rh7ehN1EAj3rjl5mem23JKzj+wUJhGOAch4z29zRodE6PjJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862853; c=relaxed/simple;
	bh=7Df2gMCwHySOM5tzzLwMPrmlUXYyTp68cLZgj5pJeVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=COzisPX/lY2Yjyk73oGnAfd7aTtVqY6LdqCHXh1ZyXUp2cM96h60rQ0fQ+IIJ2sANeV/6+FkvGlnlOYQlV3NQlqMTjz14SaQXnRECkcptrDYqLogn7mr7Wz6Ln3DZAnK9rIO1V0SwRVPyKSWG+WmTE7NshSoK5U/z878LhTqRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjTpkg2g; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjTpkg2g"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8c92737a8d3so13836586d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778862851; x=1779467651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6NAfPYKbFnWXLt9agv/gcIEWKO0+qxbRSgNKDk/o5mk=;
        b=MjTpkg2gLh/Syl0Q2c9bxqsa/eS5yD/E2ORxg6yeAytGfD9byfv9AN/Upk2AmSQkrC
         f4qCxnanQFk3n7P8FgizLycRkdgSlk38jawOc5TLNDY8sixqLUE2S+LgdjRPsHiQgWk3
         Quzi7Z1+6CqKa8BwWIOlMK4SbCEj1BQ8WeKuqvaJI9BUx1y/f6G2o3JZaJDYOthzWUqG
         zvkCcKei190ee+akcTJs6aVS5qWddqnQfN/lFBwxCQWUjTh0t8ipZZwAtZ4yOgnYrUOR
         aNYRaZZMbsdnWq9rCb+yHk/34ISvmUHDcC1s20VZOtk8UZmfhmITIn1Mmu6DQPyb3ZYa
         pIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862851; x=1779467651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NAfPYKbFnWXLt9agv/gcIEWKO0+qxbRSgNKDk/o5mk=;
        b=b2Dwf5H0A4Enk9MTe14pN+BT1WoN/HpOGaHYXet/OYkkorfKrtyW9yZUjSL6ywiHkV
         mO3Rd5IsigjSTw/EX/9fSzpxfSS/q58Knjq87NEfCISIeXvCyKu0D6Eklnesj2GoeFLL
         QFKR83f7gpCTSCtYGgN5yCu3rTWsCto3xuokdzyk6bqom6Qe0tz0CwKwD2hEkNOrtu3f
         QDSHekOkJyzWFLvCub71OV/HXrHiiWz8b808rF+gB29J7wqK9QAHvjYJOCXiLbutFw98
         ybEy5woBxL5V+UYaKP9TIeCdDyCXI/R60xYbxlAwuj2We/xevmyXWVE6i3MiKGW8+8F4
         9FHA==
X-Forwarded-Encrypted: i=1; AFNElJ916viuJV+9vt5yJ0h0tiaxd+dAhbLlike952IXtUuf9bjfXaArLFRqjas9wpUhEHuGaUPTExpahp8Uu41c@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTi3DieMAfRmx2kUAeAzRONf/YujoStZFYXWyzJR9F4VmN+nF
	j/qKDsOx9aEoKtozgQQS09F5YgdeKxIUJwSglekrU9BUw6SSSFlelh2w
X-Gm-Gg: Acq92OGh9nLx/FYh+ZxAw/gKQX61VIRd4NsU/f+vWUFP4pn77v+z1/ruWdtEviPXL4C
	dIQ5+wrsvNIZNr5qTRzRJWfZ38NFQp5q+rYDZXXQI/Givi1BEvKb5FnZkkFjPejKBaz3RJQI7As
	XQ3Ur6hn2rOA0E2J186DLXGceamwtqMlRyJKfRBywaBVVvIcgBoFAO3OhOw49gx6r1fSjAdJCTZ
	1kOSfWo1yZxqoGFW0C1/x+vSNVd0XU/gmOGn7qZVLrTOQCcy3DBt6TCqH9N30FEwPgvtft9MtNR
	PJcd1a0bu/BhlQGI6AXFQMjV9alz8csQc4ngUU3CwYrvmPqWwXzvPJem8agO+FlsbvpJrzabAY+
	VASSkMk+UA+2UeuapoNu8H4wD0lTmWa7OIr1TEjifc4pZBLKHJfN1yne7jNOaJht+idTmLBbtna
	LPzDDW1YCAlQNrTiBvJCwXvRkTu+LPZGGcY2hQzQ+4kjFpbAsIfa5mwFU2GfIxdYeFIoy0G30YO
	MzGHd/NVCb370rglom/aYCrC8ZKc3ujJEIxhniNCMNNt1dD4BGMHg==
X-Received: by 2002:a05:6214:4384:b0:8ca:174d:187a with SMTP id 6a1803df08f44-8ca174d1b42mr42827216d6.15.1778862850633;
        Fri, 15 May 2026 09:34:10 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e4besm55861956d6.2.2026.05.15.09.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:34:10 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] fs/ntfs3: bound copy_lcns dp->page_lcns[] index in analysis pass
Date: Fri, 15 May 2026 12:34:05 -0400
Message-ID: <20260515163405.1574574-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

In log_replay()'s analysis pass, after find_dp() returns a
valid DIR_PAGE_ENTRY for the (target_attr, target_vcn) tuple,
the copy_lcns block walks lrh->lcns_follow further entries:

	t16 = le16_to_cpu(lrh->lcns_follow);
	for (i = 0; i < t16; i++) {
	    size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
	                        le64_to_cpu(dp->vcn));
	    dp->page_lcns[j + i] = lrh->page_lcns[i];
	}

find_dp() only validates that target_vcn falls within
[dp->vcn, dp->vcn + dp->lcns_follow), i.e., that the FIRST
cluster is covered.  The walk through the further entries is
not bounded against dp->lcns_follow.  For a malformed LRH
where target_vcn = dp->vcn + dp->lcns_follow - 1 and
lrh->lcns_follow > 1, the i > 0 writes overflow the dp's
allocated page_lcns[] array.

Add the missing j + lrh->lcns_follow <= dp->lcns_follow guard.

Reproduced under UML+KASAN on mainline 8d90b09e6741 as a
slab-out-of-bounds write of size 8 from log_replay+0x68d4 on
the mount path.

This is distinct from Pavitra Jha's 2026-05-02 patch
("fs/ntfs3: validate lcns_follow in log_replay conversion",
<20260502154252.164586-1-jhapavitra98@gmail.com>) which
addresses the separate version-0 dirty-page-table conversion
path's memmove(&dp->vcn, ...) call.  The two fixes are
complementary; both should land.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/ntfs3/fslog.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index acfa18b84401e..f409611f2530d 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4547,6 +4547,19 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		 * whole routine a loop, case Lcns do not fit below.
 		 */
 		t16 = le16_to_cpu(lrh->lcns_follow);
+		/*
+		 * find_dp() only validates that target_vcn is the first
+		 * cluster covered by dp.  The walk through lrh->lcns_follow
+		 * further entries must stay within the allocated
+		 * dp->page_lcns[] array, which is sized by dp->lcns_follow.
+		 */
+		if (le64_to_cpu(lrh->target_vcn) - le64_to_cpu(dp->vcn) + t16 >
+		    le32_to_cpu(dp->lcns_follow)) {
+			err = -EINVAL;
+			log->set_dirty = true;
+			goto out;
+		}
+
 		for (i = 0; i < t16; i++) {
 			size_t j = (size_t)(le64_to_cpu(lrh->target_vcn) -
 					    le64_to_cpu(dp->vcn));
-- 
2.53.0


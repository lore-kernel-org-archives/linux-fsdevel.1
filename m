Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3538839D
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779541499; cv=none; b=BQobWuXprRlp3xf4zFyZzFkrB7Br0zbaSz8EBip3gCIqPahTHY39vw8uVy+/V4CCVfpVh04WDyqph/zTcvyDNNIxHSG8jbHhYbryGo+bGemPuYmoOcW0DzFbMocAlREEA3K7PEaddWxE0hhgvu+inawWu3RQoRGQKjxB+L9/dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779541499; c=relaxed/simple;
	bh=DRJjE9vsCXjdjxIStUsGvKLhsln60Vuu8YQDjDuAKmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBU/E2zGjhMRYlJhxtWyzBjQ4vxHx2nl8bEcqXoJ1vNjl+Jz4iB0z/TYzIRFXd5W89USq7xHW6MLTGdUW+CoUPo5r24+Bhk0U5ihSRciMtAEh/0KSJ50YbOT2jndtvJrLqmOo1Ip6BUabotZzSspnSFi9tqjpbLNJSB3Byhf9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=QIK115db; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="QIK115db"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b788a98557so52527965ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1779541496; x=1780146296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qqdwlNXYZJEyRP9+E0HpJHlS8fNjZ4FkiE4ZdDF/FA8=;
        b=QIK115dbER1GhO5sPsXSDTmTQi7DyJAmn8pNoM1CKPa+EMgEFVaG3WenqluB4xbBd6
         Mpqvpejk4fOsR/gYVikw/Dr/uu8V75gjO/DIkw049AOx/lCOITdkmJLYah5iveqm3hfu
         Viq4CwtIcNPRSOEGh/lTBNJpP9O492Shh2dxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779541496; x=1780146296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqdwlNXYZJEyRP9+E0HpJHlS8fNjZ4FkiE4ZdDF/FA8=;
        b=JLE7Ac/oeX96p1l4yjn9pT78cpOKGvK2ImToj8AGJ5jdnwj2rm0pong9/7jKSKk6C0
         HGALsbeacdDbKQJGhFnxSbxXa23mTXz+cNDBnuYfcUgy5SWt7AeTrvaaMrhlI+zMvkaK
         8A8yQJBLJLALNDPzqNkgpW7EFjKtyjy7eG02UK7m41LSt/3X7FIB0YOLKv+KWewlxPB2
         ACfmxqztHKHnYYCv9gZgTve94+eiHtQxfn9l79exN1E0YSfI2YpD2/WKjQFtSH/Fkk26
         EossieLkZTM68bu4yUgYWE7bmFHP6rY8ilypwP23aJqNQoFkYggjIbr9WJu0XmDzKqJZ
         A7EQ==
X-Gm-Message-State: AOJu0YxwX+7PQOAfV1+VjD36L6UrZuvqHSYadf+WwryvEbanncDDnTC/
	9usjg75hNLyDofN7G9wgq1bzKCtP6T3Xz3qoodC0QXerIX5SFL0ELUrGwIIvVaYGqlyIaGNTghQ
	N7Rm/
X-Gm-Gg: Acq92OF8tXkRSrLHQq1k1FHauKSmmpLW4AGBQoXV9CqtF7fSu12OZ7b6+KgPMXOykVc
	8w3gpQqzlJOKtOfy9bd0tQRwAK2GE8tlU/6OhMRvsTub61Jxj50htaBZkK9gbevxkqfsja+nnS4
	PwBsAEfANVQBGVqkApHn/vRTUgM9dAXUJLYJg0Pl+7oRT+rag5eXQYsbIsynRGMWRL7BCJWLu6w
	c5zhSK/DwZqV3HIduW+Rr70cc0hX8UwY2WTnxdGciKZJjLyT/LPJYfJ8oBa/3+ji/n2kpOjYfDq
	kG0g8YZ7JbCcck2Hqz9Ks5nLmVGL0xjQQrQTPD8JCX20DGDtRViqYQQ5rcp9oFsk4AXFbT5N7i0
	e7e6DGfB5yroqF94/VPverFY2OtjxoooMc2SOF27KmDSuP82TBpER8+3XbISHloadBR7a03DcvM
	uftyVXs4L15G4ypafK2DzlmutsTlP9EzO/Q4J2UHrhDSf4+PNY/Rs4p22xwOYcIr886IKlOcwm3
	X9ri7tVnTTXSg==
X-Received: by 2002:a17:903:19e8:b0:2b0:6e4a:32d0 with SMTP id d9443c01a7336-2beb06a6053mr85007925ad.35.1779541495768;
        Sat, 23 May 2026 06:04:55 -0700 (PDT)
Received: from kinako.work.home.arpa (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2beb58c3016sm63173795ad.56.2026.05.23.06.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:04:53 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] tmpfs/ramfs: Let memfd_create() work on nommu
Date: Sat, 23 May 2026 22:04:45 +0900
Message-ID: <20260523130445.1101818-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently trying to use memfd_create() on nommu returns
an error with errno set to EFBIG. The manpage memfd_create()
doesn't have EFBIG as a possible error value.

Doing some digging this is coming from 0 getting passed as
newsize to ramfs_nommu_expand_for_mapping() and that getting
into get_order() and there "The result is undefined if the size is 0".

Whatever comes out of get_order() is then used in the following
logic and that results in the EFBIG that causes the syscall
to fail and the errno in userspace.

If newsize is 0 there is nothing to do so just return.

Roughly tested on m68k nommu by creating a process, creating
an memfd, forking another process, mmap()ing the memfd in the
child, writing into the mapping, then mmap()ing in the parent
and checking that the right data is there.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---

Really not sure if this is correct. It works for me but on
nommu a lot of things just work because there is no MMU to
shout about badness.

Maybe shashiko will say this is a dumb patch and explain
the proper fix. :)

Also I had almost no idea who to send this to from the output
of get_maintainer.pl.

 fs/ramfs/file-nommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 2f79bcb89d2e..fb471bf88ab7 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -69,6 +69,9 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
 	gfp_t gfp = mapping_gfp_mask(inode->i_mapping);
 
 	/* make various checks */
+	if (!newsize)
+		return 0;
+
 	order = get_order(newsize);
 	if (unlikely(order > MAX_PAGE_ORDER))
 		return -EFBIG;
-- 
2.53.0


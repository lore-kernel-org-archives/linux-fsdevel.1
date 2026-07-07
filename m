Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF45739D6F6
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783461920; cv=none; b=b8cLz1GiPagaZNBsMU2Youi/X/SrTxT91StqPQxYsa6z2hZoKSFmZBt+rdUrPMNY27g3WEPX+rvA4xFGTg8y6gbUVDFwJk8hFK9O91K83Mp2jDL4RIM84yVE1vo2jMvefGdtmyppXIc/SLASkfzBFY4izGRjggS7r/elQTdZkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783461920; c=relaxed/simple;
	bh=YF7F0DA9Y1p34/BtJACfmzlKoYIyBIWxfKh/ILxph7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/3liP+ObbaLMtIdZe1ZngBvJnlbMQKNWE2PnUtOYdQNolvlZOHie/ohO3Uf3nPi9AwPj9n1qtkg8TaZgQNA68VMjZhNz49N+bVXRJIOLIxNWV7em+gOowWR4Ys+vhoZT/LSJHysVY3Wv2fJbsMkVDDcyUBL7bSS4ovk4LxxaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU0npaLE; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU0npaLE"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a17f6cce4fso2269974eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783461917; x=1784066717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lVFpGTRo01EWWKtVyIoMJ2C0z3kl8sKCJEHJVlYCz4=;
        b=jU0npaLEaBB0Ssr3s847bEv2JvPJtprwurV8bvV3OeNl9FYQv6w9HmsyqG8nN5pmiM
         e4H8olX2GZRTe3odAZtB0bkySnow2gYAeM83/nXw76hVObMuSCYCYtfk25UTj5VMbr53
         +yb0NA2Ko7rVVe5LQWDQPzKaToNMOlKXhTkKSpmZbF+F6egtJkW9mTaSEXhbFdxYn2Km
         5WlKwaDFBcDctvQTF7HpwaYybund6qq3Qso/f727B951yh1bUoyraUj/gCMiW5oL8N6p
         MBLNCgdX4IovNzVCB4fA3OncpNry8ammcanDCRuHusO/ngsgAh7BSFbH5U4Y6k35p4Sl
         MDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783461917; x=1784066717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1lVFpGTRo01EWWKtVyIoMJ2C0z3kl8sKCJEHJVlYCz4=;
        b=rOY77WECrc2Q2pelLaEhklOHyMtywqO5i4qdX8seJ1WaRTpbGIOoUNmOmkMgNN2coo
         Rj3pGBH55dnwK8vuDx5pEXk2QT2uijohY41BDDTmGrEEnyRG4hKuvuYFqESGio6LCD2P
         f8nFBuLwJrtcEKGFx7o4l0m7XXDbUyAWsRyxO5qbi/wFyDmiEAAyC0L0xRweeXQ1t8Ex
         SpOjIkMhHH3emZo9h+c9HSuyPdDMdVi3TtAPBiM5O1WnYZLfW0uOUM5sJqpldbEBYpvl
         jPa+/XCjH+wJ1+yHnc/licpM/XzGZ9lesAI10sFPnAfq928a+vHCUYyJQxwPKiV+N/N9
         y9hg==
X-Forwarded-Encrypted: i=1; AFNElJ9QxB/vWKaxQIWR4FsOmc9i9k4XJc1FBnof+1b2EHax94SdbtB+1Iu5JQmo034RD2j3sSgH8xQcfUu4uxTh@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrQR51rIfW//F0ydlI7sM4haFguCvEY/2JS5aicfBrFOAmuuw
	I+VfO12Mv4Bn7P4Qd6Ysp0oo29IwM7m4La/ng8RjoSWj46h0nwuU6IgietjFTQ==
X-Gm-Gg: AfdE7cm7jvjcj/3FMBxTtTiAIBSRvVxP5vJKao2doIvdmmxoww3NEEcRaMNErRfjncs
	4gb2GEBd5Oz0CeObwI1uh/NZCm9kFSN7PqbqaZcwLA2uKK7VEqr6W+w7i3PnIVsCyjFF8tMehXx
	kQ7Oo4g1nSHAptNkR+z/c4reoNAaMiW1ZuKHRKlvCAxL8gPywoZvbm+eAzNT7v3VaWHUobzUR6z
	9nxZclT+NoYprnIWh/NNtBux5C+z/9b8VEq7v4ZOTbiCraVFw+96xTECOjN2sJ+XTbf8ZICvZgW
	wkIfru5jmDjmzXWfllhrT6hSmoNhENTZCfwB5KRduchdJhwzQPUf0rhh2n6+TCblJf4Eo/Yodpv
	e/2lGp4JlYP4KoY/I+gpjhZO08J2ZU+i47WEbAq5jmoomW0nBEP6TnjRjHet4DxcYhjqs0E38R8
	oB8i7Ia/zrda6yJDUSsAcV8T9W4Q/CY32pFZc8Yv3QKZJ03nfARYVJyv1jYset0a18
X-Received: by 2002:a05:6820:1886:b0:6a0:e329:5a4a with SMTP id 006d021491bc7-6a35552f160mr4517123eaf.44.1783461917592;
        Tue, 07 Jul 2026 15:05:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a36a632ff6sm508077eaf.7.2026.07.07.15.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:05:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@lst.de,
	miklos@szeredi.hu,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH v3 1/3] fuse: don't clear folio uptodate on writethrough errors
Date: Tue,  7 Jul 2026 15:04:48 -0700
Message-ID: <20260707220450.1200943-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707220450.1200943-1-joannelkoong@gmail.com>
References: <20260707220450.1200943-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the writethrough path (fuse_send_write_pages()), if the write to the
server failed or was a short write, the uptodate flag on the folios are
cleared.

As explained by Matthew in [1], this is dangerous because the folio may
be mapped into userspace. The mm code has the invariant that a
non-uptodate folio must never be visible to userspace (to avoid
potentially leaking confidental information to userspace) and has checks
in place for this that if violated can bring down the whole machine.

Practically speaking, the effect of this change for the fuse
writethrough error path is that if an application does a write and then
the server fails to persist the data or only services a short write, the
page cache folio keeps the data the application wrote instead of being
reverted to the server's contents on the next read. The failure is still
reported to the application synchronously through the short count /
error return of the write() syscall. Folios that were only partially
written are unaffected since they were never marked uptodate in the
first place (fuse_fill_write_page() only marks a folio as uptodate if
the whole folio was written to).

[1] https://lore.kernel.org/linux-fsdevel/ajtPMgO65FA1TXhi@casper.infradead.org/

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..a72959dbcf12 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1227,8 +1227,7 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	struct file *file = iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
-	unsigned int offset, i;
-	bool short_write;
+	unsigned int i;
 	int err;
 
 	for (i = 0; i < ap->num_folios; i++)
@@ -1243,24 +1242,9 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
-	short_write = ia->write.out.size < count;
-	offset = ap->descs[0].offset;
-	count = ia->write.out.size;
 	for (i = 0; i < ap->num_folios; i++) {
 		struct folio *folio = ap->folios[i];
 
-		if (err) {
-			folio_clear_uptodate(folio);
-		} else {
-			if (count >= folio_size(folio) - offset)
-				count -= folio_size(folio) - offset;
-			else {
-				if (short_write)
-					folio_clear_uptodate(folio);
-				count = 0;
-			}
-			offset = 0;
-		}
 		if (ia->write.folio_locked && (i == ap->num_folios - 1))
 			folio_unlock(folio);
 		folio_put(folio);
-- 
2.52.0


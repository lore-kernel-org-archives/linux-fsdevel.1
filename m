Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F643B3DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695818; cv=none; b=k2htX9FuKk/4VrCewUKHkb6twnIqnWjDNrrq4vidA/psA+sVDYKjSsBnJc9TOcp/HWN+7sOkDpWsUvCkf6iRJnn5vKMqE6Ao1Tt4fl40/7xydCMUEzL/1xRw+Fk3NEwlyiamEYE6l86bOXbdXQfpQy1c0kwdu0Jns0kYDi60CVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695818; c=relaxed/simple;
	bh=/d5UaxWRRebSUX1yWVvOqKotoQ8sdFO8+5euVROcwF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTlL5O8pA3zSSjalozXcyy7tt2fd4XdMpIKrZFKcrB26x8O88QnUFs86FBVDYQHMR9UC7qGr387QFR7tLyTuR2MKIduPyObVIQLp7SLedFIqf9QCYKrdDsLU26fXPRnpfuaitnbZ5ydEB4MgyvvckUr++dQzBqD6FS1/PL5weLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uc3kg0NI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc3kg0NI"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so1049065a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 01:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786695813; x=1787300613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWjXRu/ESGgkh0xA8ezmxXOb+ei9vpWmx/ory7FD4Z0=;
        b=Uc3kg0NIuy4lVcNAJMTue4q4XUViig7JWAc0up2SJ7kw9EEk4Pq4ctwA/l351s0mMa
         kkVELK1dHXM2ntgMAjlKBKqbeBs4Usajn3InZ+mmLi3V632fOo4rwM6OWMIk+3OZW7tQ
         LscWOpS218h8CmlfoX5ElmkWnJ3LQ+uf5ydir6yHEHPPfC7v2pKbHKYZ1HJvrzA0iApy
         BU4XJlSGNJX+ZCP5ufSOfVSui8IqW6Sn41fSGugshuR3yhW384cY8UNfsg97GDVjZ/0S
         y//77GGa9y0s535UL752s7UTXBF5J+Z1zrNeJ/+pB7nJyZIECYoRJd0WsmeJpTZAf9Ub
         KtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695813; x=1787300613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PWjXRu/ESGgkh0xA8ezmxXOb+ei9vpWmx/ory7FD4Z0=;
        b=AAbGG9dIItkOk00SiDuGgE4+50ytUC7HeFkScFfYfz0NjrSVAk4pV3+sBHhOpdVzCl
         ZqfVAvf7oEBtvm83LwZ09IENbZYTuetWZB3IXKr5BOhXWwmC9X8BWR7mlDBplex76Gcg
         DZfUpAbf9BpyACzcgwBwkdCTXI9J5ytB1xEH57M/tVlHfpJITPL2hVKx0r3GRy9hocns
         T3MsIkOq4fbqP6DplxuZpseNPXxQOFNbB8ai11q7FEGjy9ZlDn589xP6mFXAx4JJUUch
         5n0y5XmGeXacfh9YX9mqKGaIoj1JCPt07tBC2EwDopDTNLytSEOkRUoTnrlGy9UlDaX6
         BLog==
X-Gm-Message-State: AOJu0Yw9MZacAdGtOj+I87lwG9mu5RLVDfVSqPhAzX3Vx+C+/VmWwjOw
	BYRS+kPrabkdEnMvMi26XFfGxo1GUCRjDp+TzQuRsXsTJA/byRI4HcwukuGeirBClHY=
X-Gm-Gg: AR+sD12IvPFuVREFxsP7snEGDtyN1zj1nuehe8H3Dp+WWUDGjDjrNsQxF3Z+XQsmKa5
	whWf6P6NLuZNF6QZyYVxFb1CJ7raFrp8Gg0X2omMpgIZPgOZdrgRIFmtyh1gAF/0t/dUriucMG8
	N14nVSqTWGqAhTOkqzSL6w3jHGekrJNHjOGa61A6cdUuwrDlz+66v0uIw1rLiKpWFfTUVyj0BKS
	B7PPn2x2vLKTcNDH7uw7kDq/+kAXTCxQCsb5d4Z6TaypPpUrbEopyI9na4UDpudhhgCP577JRGZ
	E++c0/U0cFd1vSOM2dhsk3D7c2khcXF2sU5SxkeA5ptMkzfpuzis91ZZdcCrS1d8OdjaBsJMojU
	2nialzuUthxyGkNx6v1OW2eUkZytg1hAqzDR62FjKWwwciepwr+IAeP/Ckr1naR/uACNlcad9F6
	fL3ZFJQlakJ5shaVLG/MD+/j8oMwQHDUiCY+6WY3nuXMNkKGTtwZb19/5KufEr90uiKLHX3hbTO
	Oh3LSX/+XlPL+cvXUVmo7KvJdmF5dOKk+IqqZTO7Ajhbp6ujIQ7DWdQFeR87DfBjYbL7AiGooSy
	23U1pwpu319AUn7YODnCyXZjs3/IoQRWTKnwuqGQEwXSJ0GiNTyu
X-Received: by 2002:a17:90b:1a87:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-3933b956294mr4159956a91.13.1786695812875;
        Fri, 14 Aug 2026 01:23:32 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ebb888cbsm1588075a91.9.2026.08.14.01.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:23:32 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	ansgar.loesser@kom.tu-darmstadt.de,
	djwong@kernel.org,
	david@fromorbit.com,
	amir73il@gmail.com
Subject: [PATCH v2] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
Date: Fri, 14 Aug 2026 16:23:26 +0800
Message-ID: <20260814082326.3756669-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814082326.3756669-1-matthias.goergens@gmail.com>
References: <20260805071414.3414870-1-matthias.goergens@gmail.com>
 <20260814082326.3756669-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIDEDUPERANGE reports the requested length in bytes_deduped even when
the filesystem shortens a destination range and deduplicates fewer
bytes.  This predates the VFS hoisting of the ioctl (the btrfs ioctl
behaved the same way), and changing the default would change an ABI
that deployed consumers such as duperemove depend on: they advance
their offsets by bytes_deduped and expect the historical semantics.

Add a flag to opt into the truthful behaviour: with
FILE_DEDUPE_RANGE_REPORT_PROGRESS set, bytes_deduped reports the bytes
actually deduplicated, and a non-zero request shortened to zero fails
per destination with -EINVAL instead of reporting success with no
progress.  Unknown flag bits are rejected.

The flag leaves every existing caller's behaviour unchanged and lets
new callers request accurate progress reporting.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Link: https://lore.kernel.org/linux-fsdevel/20260805071414.3414870-1-matthias.goergens@gmail.com/
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/remap_range.c        | 7 ++++++-
 include/uapi/linux/fs.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 26afbbbfb10c2..16192ec19bb6d 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -503,7 +503,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	if (!(file->f_mode & FMODE_READ))
 		return -EINVAL;
 
-	if (same->reserved1 || same->reserved2)
+	if (same->reserved1 || (same->flags & ~FILE_DEDUPE_RANGE_REPORT_PROGRESS))
 		return -EINVAL;
 
 	off = same->src_offset;
@@ -555,6 +555,11 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 			info->status = FILE_DEDUPE_RANGE_DIFFERS;
 		else if (deduped < 0)
 			info->status = deduped;
+		else if ((same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS) &&
+			 !deduped && len)
+			info->status = -EINVAL;
+		else if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS)
+			info->bytes_deduped = deduped;
 		else
 			info->bytes_deduped = len;
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bd87262f2e349..abee40359bfd5 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -179,12 +179,14 @@ struct file_dedupe_range_info {
 };
 
 /* from struct btrfs_ioctl_file_extent_same_args */
+#define FILE_DEDUPE_RANGE_REPORT_PROGRESS 0x1
+
 struct file_dedupe_range {
 	__u64 src_offset;	/* in - start of extent in source */
 	__u64 src_length;	/* in - length of extent */
 	__u16 dest_count;	/* in - total elements in info array */
 	__u16 reserved1;	/* must be zero */
-	__u32 reserved2;	/* must be zero */
+	__u32 flags;		/* FILE_DEDUPE_RANGE_* flags; was reserved2 */
 	struct file_dedupe_range_info info[];
 };
 
-- 
2.55.0


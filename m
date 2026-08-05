Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5087A3E2AD3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914069; cv=none; b=bpGZRZa66DZdeuMkPnhV3mcepEbMAGBTGQ4oQdQxW/F+o8LvDKv0YH7OK48zUNPSgIyTLE5MYd390TB0mlcdjuPfm9EpHW9gWsz24LFlt+fTMC6Sva6EL4j3goaASkYuSIU6ntcJILC8S+ryudRRYqcWWPPMl8NP9Oum6UdWpaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914069; c=relaxed/simple;
	bh=Cbors7LYoRtUFE3UxPDL9X6jDJmMzv9wqC58FSZ74rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5ZC2KNOg4z7e06rmUOuIyqinu9R/xxk2cUFhz84Lh7VMo2+nQ60JPUPKPPAMFhREiFj9nV/B+sP+DEy0o75hxTBQC04MMvfbqtpm0ECfz3OtSVIHcHxYMPa3Ey8cwP/POYJmWldc1AacMhb+Ji9PWShZ3fVWHoKusAFlPkMM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWH927wK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWH927wK"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so745457a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914065; x=1786518865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9yS6OSlFyckyo9C2NOANFCam/YF/XXAlqIaEJvC654=;
        b=BWH927wK6IS1nIuqnLGL5e9EOZ7JQj4c1NDuWiATVRQBSFbMMXdHg7JgsWo5+xf+Vm
         zFQ0cKv+Aly6DiRISuJlHjr6FHANYpvA7lt0585V0nhMxY31wDGZilhY+qiu9FiL15kJ
         +tmywDyuzAD51dA43q4PuPr42Eow9emktk3p1eudX5caf2tQkjay1SA/sQr9u6o9AhIH
         Skz4v9rEJrdWOCGOhL0GqjSCHqf8DLQXdg43OJN8fQ8ZIQMHGBohZ8OB7oxgVbQs5yae
         woywrkMEeHnrxwniOPsvJ6x74yUK+T0YkeloBvcnaCKLG9S2xFYam0Mf/3dbTkYdIpHc
         YFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914065; x=1786518865;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9yS6OSlFyckyo9C2NOANFCam/YF/XXAlqIaEJvC654=;
        b=VNWa6gGjKhmjFn9mKwlQJleX1xkh6PvPsdi0z/imFLAtnm/oJ7Gp7UA+Y8RiYmNLc9
         SihhxieJHU9EiHy8iKkM178OIcyUcR+ZnVwIBXLP2V9LYXfuVPSuBFhGQYvEk42Wj7WQ
         ULjLliNmlG9RilsOxUxwj82m+zZOsZSgNakISuyv5CoKV+MNU2rBru37rK2MT+mvFnqK
         urLtWVnLCixxmX8LrnYXoZ5Bnld41A9yDtgtkGaHX2I041uRX5WB8gfOAQu/DcQkOVMF
         iJRBOqQb+mtutgtvpou3JDciWK+2nU8ppAz3Y59aunniUicagNT+zh7wgwlKxWanfUeO
         TwMA==
X-Forwarded-Encrypted: i=1; AHgh+RrP/EjtxbKiTfJhqSzT9JM5YIzzOedFK3qlcI4zL7NI9n7GM94dlQv1alEujE9bxQXwtmYBnvCYxLPN8BU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83zzWmKE0BBgnrlmrOS/VaUJsiKXl69nKiWjXXpqKWrhfEW9D
	8qXoj6atdq2BQr+90VczHgAXJh//pMAI5i5Mh1Z6+mvyBQ9lETj9MiMGP5JAqSwx
X-Gm-Gg: AR+sD1310cHj/AgfIIGxuDBeBdRXefSvSFuFvvtY+mscrw9PoBi3Kga2gkY/63KwZzo
	iBR4HfEEaZ1mAvZu3jnO+rHXrb990M4ohBoLjJGYKlkID0Y51ryFQcAiGBDzQplc6cKMAbRKX1C
	h5oBVkAd1xJH284Y5cwJR/xhCwekSJj5RXMXQg3o4daiUVggopayQ6xMatM/6rR4WR0+Ax0OFUb
	YO/QxDN+ZQw9oMylB5V6xfwZadPRP/uygNNDPBc1jPgBuAecW0vLXpeXlo14wTVCDqunyTCyFSb
	si43Bgg0T8jrYK//jyy86tohZj9zq3g9l2cRMRYxifLehuaSmH1lFC8X6RUY4s9xn3dIoGLyAwf
	5l1sxpwG5Ecxssp4Krb4iwVYp4byi9p6yICQfdEMtYT/19n84YsuwVwa8D2Uez4o7Ce7dwDTQ2y
	XWbP/1LQpk7+t0/McSohhdsrCKN88as8j08IDNdMEwhN1xCeFOggkhynJ1pQrMgqlKpdx2wQoPp
	6isifdFhU9y9WYC6O/f/JnHUdqATLB4OtDi9rDhguctgPXduuRUH58g19Mxy4CpMeq1RFfKJTVG
	MbyJT+oasR2kfsFvnl7SX7IHxAT3sZ5w18WT60PQgx3PqpAjaSIyMgs0OqHNQic=
X-Received: by 2002:a17:90b:1809:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3903c583c08mr4196054a91.9.1785914065537;
        Wed, 05 Aug 2026 00:14:25 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390392aef87sm2158639a91.13.2026.08.05.00.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:14:25 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ansgar=20L=C3=B6=C3=9Fer?= <ansgar.loesser@kom.tu-darmstadt.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 2/2] vfs: report the amount of bytes actually deduplicated
Date: Wed,  5 Aug 2026 15:14:14 +0800
Message-ID: <20260805071414.3414870-3-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805071414.3414870-1-matthias.goergens@gmail.com>
References: <20260805071414.3414870-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

FIDEDUPERANGE promises to return the number of bytes successfully
deduplicated in bytes_deduped.  vfs_dedupe_file_range_one() can shorten
a request and returns the resulting byte count.  However,
vfs_dedupe_file_range() discards that value and reports the original
request length.

The VFS ioctl originally accumulated the returned byte count in commit
54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs").
Commit 5740c99e9d30 ("vfs: dedupe: return int") changed the filesystem
callback to return status and substituted the requested length.  The
helper once again returns a loff_t byte count, but the stale assignment
remained.

Ansgar Lößer corrected the assignment in commit 4a57a8400075
("vf/remap: return the amount of bytes actually deduplicated"), after
reports from Max Schlecht and Björn Scheuermann.  The change was reverted
the next day after generic/517 exposed its expectation of the
over-reported value and the userspace impact still needed investigation.

Restore that correction.  A nonzero request shortened to zero now fails
with -EINVAL due to the preceding change.  Callers that advance by
bytes_deduped therefore cannot retry such a range forever.

Updated generic/517 and raw multi-destination coverage in generic/806
pass on both btrfs and XFS.  Installed duperemove rounded its match to
98304 bytes and exited with status 0.  Installed rmlint received 98304
bytes of progress followed by 0/-EINVAL for the 1696-byte remainder and
exited with status 1 instead of silently accepting the over-reported
request.

Link: https://lore.kernel.org/linux-fsdevel/5548ef63-62f9-4f46-5793-03165ceccacc@tu-darmstadt.de/
Link: https://lore.kernel.org/all/20220714223238.GH3600936@dread.disaster.area/
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/remap_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 53330aa26b86f..9fedc22b52761 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -558,7 +558,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 		else if (!deduped && len)
 			info->status = -EINVAL;
 		else
-			info->bytes_deduped = len;
+			info->bytes_deduped = deduped;
 
 next_loop:
 		if (fatal_signal_pending(current))
-- 
2.55.0


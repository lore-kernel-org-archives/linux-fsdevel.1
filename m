Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE83242DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785002; cv=none; b=ODTxjXBpWAzf+YWVRmdL175qUIHkQhfOAsNxfgGWGz7tia3jndxNxyQqaVQjdOcQFWoUsg0+Y6YxyiClOcwyPNRK/wUty4q7ca2vHo4XO539jAuKau9uFI6cpF8PB29WooGxo/g6kA/a5UeKmJWVfowdQQ9KRS1F9OmBXR+0tnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785002; c=relaxed/simple;
	bh=OVJzpWfHSM6a6wCkK3C71K/fLknshrLRt2xkWr7HMRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsJXNSiJsKlHllmTYXd6ieVZPowyvQq1Uds5RkFrM6ub3CA+ry+QP+xMAOwGK6U14l1viaR7pRmDhS5E6ilqsNkU8b75E9MBpKoh9EbwayyG6vHEF5lDHlV1OaJNegDRhIljBXidRFbbfm9RreN8AVRGnEF5l9hYPcFJCY35Pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=GCFtOYd7; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="GCFtOYd7"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66dee7a0c09so658880d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787784998; x=1788389798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUa9GDJb+Q4jhCXihDpgFN+RTSjVzxtIFk+RZAxtdhM=;
        b=GCFtOYd7F7o+HQPMeQkTSmYS6PZFAEBqhFZYLYCNc4d9ZDTrWRMDVXpC0x0zt5UrWw
         gGw8gqejsAvSCcJYszvnimBCsMNvEWLHY04aCb9lCS/0R5UJO/U5cueEQGzl4gjUIrGj
         KL5fXsle6B3PGsqyBsd6gVYVUTMyKf8gBSccHw1XctvC/hMz8Ge3QzLIYk1MF1cYnww6
         6luOZSxwzFq6BmFNLjl+I3kTcyojQbUOXiPe3MOYbIKSLSO6hsGMY3pXtLtWAFrXqUXt
         7gwjMvGu/K7qBfY1PbmTU5g3WHG0kn9FOwacm6569jAHNApxq3FctsJE/7ZS235yFLDk
         VJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787784998; x=1788389798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUa9GDJb+Q4jhCXihDpgFN+RTSjVzxtIFk+RZAxtdhM=;
        b=pbp/4+okWsMewlMemlm1Zn8wQlkF4BQqVTTfA41e6Vl2j7e7gI+WNL/rXXbxb1rBnK
         neIc9TYlJ1V4aZnT4LCLtChqPSEcKOiKFBgOaJhJ12Nzm0ahi9n8XpKTKg0NHx9uFogA
         E81WyyCNJd7xweSgqkqv92U5An75qqa2IrjI+6sfTnwxN0rHazAL1GqoIhHc8SAdA1OA
         r/RJ9hvBMMocXZZdbmcBlHvdIDswgxvKSKbrS+TRlP897JsG62D88zyRtOCwCdFLILKR
         s3oEBU22bjvxuRmT/rrTZtRx+kPA0cYYbzxtUZD61RzeDveHC1sEoU0VCryomZM1RzBe
         gZ/Q==
X-Gm-Message-State: AFuF++l0Xzq1RKKAodBw8NfX9NbLJ8uYj1xlO6PIoow/KKvGtgtUdVPJ
	TWq71tq/1Dhg3/JpGkibVlEAyvdIJDJoUgeKNmFL2XShYa/ELvSd82ievQTcdIN0dCE=
X-Gm-Gg: AR+sD13sC2nJTEZaqE5RIEut8sXuP9gXcV/KkXiE7nMH5d1JdxBlzFLtjkshkQDOVM0
	4T11/JKtcldglJwBWofmnOTPqTm/pueuAC2Tn/rPxgccYPv2xYhNZK4jpLwHscEtOKfGUkJRMjL
	ky33WW+Ao4VKsH/veZYQssakU/3tBfx3VHbHSknkFIMRBrNYhxI96/czVc9ZDcxjmGb+IMn7b7f
	Yq02nCTuwd+kYxCjBv/Ztp/ntaIwTdxQwB+4jHxSUfVp/0B6fulaOLGWPgY8a4f7UgsQyicXJ7E
	taLO3dsXWJ96PNmGUFVXyUOQoQmsRr1ZqSuwTEfnh6RQDk6ccLWob7kEF/rdNee94QM8/97OB5U
	JAlOFExIYTV1UUCJA5tVpaG/6n57zvQVbVltXvt+pwLrke622O49+AeB9wkTITolSKPc3s/1nFP
	aKZGBg9tG24zHMmVXweKVXukKqXPfswaDiALhoH9+pXDffHSn/mbP43kBCi3x9DK2RXU3CTwbn9
	3rFpPrVFQflNX7zphMcivZ3bPVu6RqQLACIa0/tERtLcmEa0z+KuEoGf2rjo/PIwwVQyIWBGAhO
	QZXInly5onrzdUKbOnRUJ+EqW47dQg==
X-Received: by 2002:a05:690e:c45:b0:66d:236b:dc75 with SMTP id 956f58d0204a3-66d2584942emr4269871d50.48.1787784997716;
        Wed, 26 Aug 2026 15:56:37 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:36 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 1/7] hfs/hfsplus: exchange hardcoded number of extents on named constants
Date: Wed, 26 Aug 2026 15:56:08 -0700
Message-ID: <20260826225614.486112-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826225614.486112-1-slava@dubeyko.com>
References: <20260826225614.486112-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the magic 8/3 fork extent-count literals with named
constants (HFS_FORK_EXTENT_COUNT and HFSPLUS_FORK_EXTENT_COUNT).
No functional change.

cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 include/linux/hfs_common.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74b26..8673933bbee5 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -171,18 +171,22 @@ enum {
 	HFS_XATTR_NAME,
 };
 
+#define HFS_FORK_EXTENT_COUNT	(3)
+
 struct hfs_extent {
 	__be16 block;
 	__be16 count;
 };
-typedef struct hfs_extent hfs_extent_rec[3];
+typedef struct hfs_extent hfs_extent_rec[HFS_FORK_EXTENT_COUNT];
+
+#define HFSPLUS_FORK_EXTENT_COUNT	(8)
 
 /* A single contiguous area of a file */
 struct hfsplus_extent {
 	__be32 start_block;
 	__be32 block_count;
 } __packed;
-typedef struct hfsplus_extent hfsplus_extent_rec[8];
+typedef struct hfsplus_extent hfsplus_extent_rec[HFSPLUS_FORK_EXTENT_COUNT];
 
 /* Information for a "Fork" in a file */
 struct hfsplus_fork_raw {
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793536024;
	b=h2Ij4RtnG9mBL0MuUDGBSZt72c0vM6DSlbmDbqW3lPRK2ZRU1yqNDV3z/mWimbrhLX/H
	 fLdqpskNF4cCFAagTPZrXCXwdLtXSqoBHwmEVQ0pQfd3KHOhb00VNNNbhuLxisHOT/Axk
	 ePG80se8E28P2D13XN8WdTYI1fNzlkEL2zxIUqZu9dXW3NlRIRMxrIdp8BG3W+2LeeUHr
	 bsgd1GkOJR+cjCco+vQO2ahOtt1Sr+49fW5XYFhtI3KpLWFhQOxRPR4IiQFUlqrjHkiJ2
	 Z1aFixB1quMPBawRPwzLHD+jR3MF94xCVhEBmsuZycfDWxWMf5fdGbozyxIT+UV3mtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793536024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dA762MiX0XGurLRN9b/6HziROeNi9rk6flm5jzR8jYo=;
	b=lGMM8bBbc75URogLuRFCSj7yZERrCUJapolALKA0t6yfLoACDhvAgD+g/317Nwr1ktgI
	 Cr20CggZudIpSxBoXLsNOAspPzvKHo3P26DMtXbzklgFNM07IgzGh59rQpVnvomq5x+JT
	 UIIzc4vCPS57I28BBEou120O4B3TryWv6G4/UMOTORQQCkHSFveOL7PaQsD7jR73mgAK6
	 BcW1IetwLR/YWvJWHGdO6a8OBhwkK+aQSMV1nTwX3vPKUb3Hxe/53cYSFysD7nFTA9dC2
	 MMnVrnH+kIiUYWLz2UepJmWiBujRnllmCg0ARWuwiL9lNx9zvKjajZvKKnkRMv4QcuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6D1uRfG;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68E606A325
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 12:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD68E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P6D1uRfG
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so1282525eec.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 04:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793536023; x=1794140823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dA762MiX0XGurLRN9b/6HziROeNi9rk6flm5jzR8jYo=;
        b=P6D1uRfG8WudZj/+HecnHpsWSnmftBDN7rVF8yIkxqhq2ChaZZKowDsM4BkO2na5Mc
         yLxxVJ7Wo3+FdtbcBiD6qiqfwa/QRFGI2gcSfYQKro3frJSMTyehnAlSRv3TlJGJx3Cb
         7YcC1tqaP3v+Tch2I/ty7Ts2xkLBk984B3KFD9TBN58x66f1YhN29BSCMqMjBgnHE8zD
         snsnDGDhg4XyIsUCXNSnjFBwaaPY6MhMt7vXXnc9DsA5CMXC+oSFOdkkSlAessETm3mk
         MALGFJAD89YXM+y+nODxqWdv0S/GEIij6llGIGzWEH2D09xjFndxNA20IOoKkcnX7Hwo
         zgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793536023; x=1794140823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dA762MiX0XGurLRN9b/6HziROeNi9rk6flm5jzR8jYo=;
        b=CZPfWDnBgPQXZpvutXwO+Vjx8xLGHHrimmjW7jr69ILtsBfSVw93EAT8l7bcaeTG85
         di6Zaoi/KGWqSSzseimFzt62ad61iQ2fOKzL3dDKwiqF4baFDkkm7bSYvqZJ50/t66TS
         PQ7I/Ex38xFpqEDbYBszxSR53xFzQX9gDi5sTyOOA84CSJSi84kXkBFFqxg9+qBWJSy/
         aK99yC1fDVvt//o5H7xctV4C6QMyT8HirmlgWN597rcowhRT5b9OdP70dq8IWynfuk/0
         K0Cqs6VqFy3eWwRNfbW1gPoI52FbbUOwc/fQpr4uvKoymClYX6SMcq8RbvalYBtJGMCi
         ASZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJe62kk0QoWJc5Kin8s3L1y/qNO4lffJ3tYcr2i+dYi3C/MzjG0okDaNgpDtE4kQqZcsARWCwTfpH8SzWi@vger.kernel.org
X-Gm-Message-State: AFq9FYLzsb5ARbbuO8D8l6TIwcbJe1xUmbmGQeuihIMziw7pCpDZ/3h0
	emPxDqKlaig0ausPg7IH4P2v6FXATaNoTq4deHk8NnEa1cVlzSGdW62w
X-Gm-Gg: AYBFou0uMT38iwr2sx897+ROvIao5aTOEp00rt4WWdJmb8G+7jhkAVraG5NwVpjbKMW
	fBP6RELWcYeqiiHQmeXHc//zB/MJL2RB6dl5ondYpMIcnk7YoDOcyvdS5xspZWjZbcW3PS2sipN
	g+kjEDsipKtvSq8xfkqc0gR/GDbgZdjplYAzIlACESrNt+sShOk5AyZo9g+8OJ9FLiV6SEuh+sD
	BalfeB+fOQdLUPoZ7jkecTG5jk38QcfW1v5MAbxP5GDogDtVQ830uZOs0UUy0cDxSoTJYHHyfJq
	lEqUbzadr2qIFYoELO/NXgTILDpvhCAgFCqgJ0CHx4j7a/PfM3FxDstdANd/KJGMgI+TXNDd/9F
	VDLF1H3K9dIyEh0eKmxi7dATDfvTjY+k0RD8VnBTUZBne/S3Bkh/S9713ZvjxIrhe8aMJcIazVJ
	/3EayfRMC3iNjEnsJ6ins8GQa9dz8HLGY/kZ4d6tmhTzW6P3NFqKL0f/qfm11VM60epQD7rCrYt
	O83PRgZgDu8DpHwOGuyIeFixZUeyzSE28BzBnfHz8YRZ4Q5M7I22N7rL2c3lJDnZz/hKbP6QLMh
	1twM+LM8onYZf/gGr9j1inCBxIrCySN/oXZ1BNyrKGhYJLr+hCYiBoJcMs29YiRMiC+IX1IZRy8
	q8A==
X-Received: by 2002:a05:701b:4206:20b0:1a4:9eaa:d01d with SMTP id a92af1059eb24-1ac5fd08905mr10832402c88.45.1793536022578;
        Sun, 01 Nov 2026 04:27:02 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428aed76sm27845234eec.9.2026.11.01.04.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 04:27:02 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] hugetlbfs: report inode limits without a memory subpool
Date: Sun,  1 Nov 2026 12:26:53 +0000
Message-ID: <20261101122653.53982-1-dennylin0707@gmail.com>
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

A hugetlbfs mount can limit inodes with nr_inodes independently of size
or min_size. hugetlbfs_statfs() only fills f_files and f_ffree when a
memory subpool exists, so an inode-only limit is enforced but its inode
counts are reported as zero.

For example, a fresh mount with nr_inodes=4 reports zero total and free
inodes instead of 4 and 3. This hides the inode limit from tools such
as df -i, even when creating another file fails with ENOSPC.

Report the inode counters when an inode limit is configured,
independently of the memory subpool. Preserve the existing zero and -1
results for unlimited inode counts.

Fixes: 74a8a65c5261 ("[PATCH] Fix hugetlbfs_statfs() reporting of block limits")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/hugetlbfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe..e94ee8e17004 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1113,6 +1113,8 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 				- sbinfo->spool->used_hpages;
 			buf->f_bavail = buf->f_bfree = free_pages;
 			spin_unlock_irq(&sbinfo->spool->lock);
+		}
+		if (sbinfo->spool || sbinfo->max_inodes >= 0) {
 			buf->f_files = sbinfo->max_inodes;
 			buf->f_ffree = sbinfo->free_inodes;
 		}
-- 
2.43.0


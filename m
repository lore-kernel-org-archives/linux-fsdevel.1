Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9513D091A
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787124356; cv=none; b=Cb88Bv9YTu9U6WrEdi9HlACStEHIA5dY80FXcq3lKuutNZ8wvk2UfiJzJTE3IAedSMCJOJxR0N1yv++aeS14lYbtzp2epx8NVXpNrfTn7Id4iqnYO3NNDL2fi/are83Ku5jdj/9nJYMrDi0WEV/K/nbbs/XCglcEe6NprZ2XHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787124356; c=relaxed/simple;
	bh=1SKvNuodvM4OwhBJC4Z48L6XzJ6g65MSRP432dByJY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L00ji6VK0wjIVL3a5aZrriq8tVnnyt4LwL80RQnhomENbLSea5JuuJUaj3ib6rxD8LUgSTqXNd6XrKYE0woHz0dgZ6keGJniLORZZ0eUmqerWIIYFj+evltcZHcErztmAKrSbyCAamUBagxMLomTkAouxGpNG/2r2MpSFp31caY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFZdster; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFZdster"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc61541f8cso21516915ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 00:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787124354; x=1787729154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Mm+hNQIKG/+cPvkkWvrNkKfzoHrRz74IsCNnWp5RgY=;
        b=sFZdster7FaZmFb2DIz5DsvQ3SH3DVyumK7sSk4dn8iyUK+P+RJ57ob9pv8KpN0Zp4
         cagKqgEGrjwOLrzn41webp/cejpdI7Le2SV/KoXtXZ0NiGcX2g0qetEqqpG1r+YaAlhC
         5RJ0Vicnksx1Riw29fSK/oLBHFoYWUaYcNkb70ELpYOQHJ7hZU6/TpXhuuuJZuthrrKG
         v0e7TN17JFs33m2ROjJ0r6Sa96I6hvEHr8+ZCHYvdFLxDMG+ezoK9tVTYxrssd9K6UtT
         Nmk/0d8iNyX8a5Ubg5yTMzkKm/6hVsGgjxIncoXcRF8PdYhAeT3Y/kBb7e7810O9UmNV
         m69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787124354; x=1787729154;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2Mm+hNQIKG/+cPvkkWvrNkKfzoHrRz74IsCNnWp5RgY=;
        b=ediaj1k/HnxGZYKXCSRxIWMNJJK9L37a09vDWb9Mz1gq5Hky72aZUJTUqf7haZ9PDn
         nSwKxXs+6CV5F76eYh/a7lQf7+adnTHfNVcTGt00LOGSRbZTtaxFEsLbihyI2swgoDKo
         wNlGm+eodzQCZDbhe79ejUOlD3NeZAM8PgPtUWuxERWxHXeYs1WIHZkzzb0p5J3SchqI
         Zwti7YVEA77hVo6DiAmncD3nnedW9XuOlkYWoxBd4aDwXzBlKE62JYZi+oafuvcpLvF8
         6L2jcqPCKtLF2kFJPmd47m8RoI0I6OYi3vl+Wefk+KSQVj5TENG5rE3zgDyfGQYsG71K
         KiSw==
X-Forwarded-Encrypted: i=1; AHgh+RppjeDRGX8jJQCSo4hT+TD6LsI/BcfZSlcXFs2fjhcWF4LnMPCIki+vXXTp+YpkLQXHfb+2dO7dVDMtsWsY@vger.kernel.org
X-Gm-Message-State: AOJu0YyuKw/dcABZZteb0lS5zr3oIlmnRiSBfsPGUVU+IHkFZQ81ABHw
	XYeq/H4sWybf0aRFbaJCtM8rZOwBZFskiwTOPL+FRKFLKUcSnsn+Yuo0
X-Gm-Gg: AR+sD10wO23pVzTAeMxFCbiUHakuM4eabnMMX1GPC05dEDdoc9U6GESkveYFc7JaL9l
	+J3XbBikJsgHtBppAQ9j5un0LXQ7pzhHI4lA50dBAPIrScqKQFTWj3T5DyQeHtqh1DTGLRxBHow
	MNkqh6IaYS/iKZ9lnGFqRegR4rw6ydnZpdMjsZxkDsfuQ4674svrcjcI1656qrelWSWB3J7p4zY
	kLjy/9W7Ufa1GVj15qp46dwl82aW9sCHl/sqqir1CL4acdhUX/FjIbbX7WbHANvE0nBgwiIVgRg
	4Npszk/OuQ6agXILkqGxxfMwC8fbhK2pjma5Q9B2EuhXr4bDT8Du1gCrWFzJ4/K1o3N7UzGFMTv
	OYmXxTnXGA9T/3aONjv07UgGH7ox+PklyeZf2ZUGwz1SZmIIIruLX4WatvrJFG/wSHXoyq5p8BE
	zi/v0wFP88MckRHqpnECoxjTxNFhIQ39V5TY1Fsi7fcjt5DxleSZc62RRQeiUkD8ngL7QvthaLR
	44q1A==
X-Received: by 2002:a17:902:da92:b0:2cf:b9f9:18bb with SMTP id d9443c01a7336-2d5fc8fa30cmr34329735ad.4.1787124353840;
        Wed, 19 Aug 2026 00:25:53 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5bb519531sm24347575ad.30.2026.08.19.00.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 00:25:53 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Robert Morris <rtm@csail.mit.edu>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs: reject invalid empty mapping pairs
Date: Wed, 19 Aug 2026 16:25:34 +0900
Message-ID: <20260819-fix-empty-mp-v1-1-fb60b2eeca51@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=1SKvNuodvM4OwhBJC4Z48L6XzJ6g65MSRP432dByJY4=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqhVpE8b8Ph78bUuUwJSYZ4K3GsmASzykzzSYnp
 U5eJ3+UOneJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaoVaRAAKCRA08jD6945I
 03F0D/9goMM/ibv2hPXpkM/r1IjoJXqESVButGhXi2x01EGzuvo0LqCE9x8TSZWbH8jq0Mr7qxR
 knZuwMoZl6xPAS3A0SPqB7b1Av1i7dJqEbT8ZexV+IgWy1LGFCnKu+LhC6j1shFP3ZE2MJplC+j
 ajDvXYZWMe2r01MLXGyxPmM9yAbaAKQ+omTQdSTk7FXgT01kAm7bjho9U5PGSl2QbaT7EJ7jENp
 kmcNC9sqgvAfwLyx+QnRkb9waw9ZWNKtTo2jF7xwFeAgH0mzBeRQniUiGttYG197Mgb+lK7JVM7
 b4JBOaEWPNSqvnAJdokTTty7S3XSGvluQzC1jho+XObcehITp8ejZ2TML3F5e28cGThOIZo6JWU
 pLZRzwMyF7vJuGoX8lWTr7Z5vOXqEkKv6Shhv50bxDPU/KTQI8vqRshxv2j0oh56Ez3myEu4JG/
 rF0889RCSc+5WiPbdhPPu5OajZsjw6hja7E9g2bxRaA62XDTNAJwPKIK93DEIJjVmnqFb4a+nHO
 skbgopUe9tt1OFLhwZMEAeVzGGmqazdyQg+yGP5syDT6aY8qvMXwJn8soTyM8ouMQvmrTxivxEx
 9k3hijZduhHFym0hV237a9bDDAqN5mcUIaDjIsZ7HdyBilqO5LKVbm4+63YOW8hdzYWJaq9O0CL JAUbuMZBFa9RS0g==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Reject an attribute with empty mapping pairs if it has inconsistent
highest VCN and size.

Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/all/9519.1786907182@localhost/
Cc: stable@vger.kernel.org
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/runlist.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 9eaadbc0ef47..c775b7df074f 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -763,6 +763,7 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 	/* Start at vcn = lowest_vcn and lcn 0. */
 	vcn = lowest_vcn;
 	lcn = 0;
+	deltaxcn = le64_to_cpu(attr->data.non_resident.highest_vcn);
 	/* Get start of the mapping pairs array. */
 	buf = (u8 *)attr +
 		le16_to_cpu(attr->data.non_resident.mapping_pairs_offset);
@@ -772,6 +773,23 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 		return ERR_PTR(-EIO);
 	}
 
+	/*
+	 * An empty mapping-pairs array is valid only for a zero-length
+	 * attribute.
+	 */
+	if (!vcn && !*buf &&
+	    (deltaxcn != -1 ||
+	     le64_to_cpu(attr->data.non_resident.allocated_size) ||
+	     le64_to_cpu(attr->data.non_resident.data_size) ||
+	     le64_to_cpu(attr->data.non_resident.initialized_size))) {
+		ntfs_error(vol->sb, "Invalid empty mapping pairs array.");
+		return ERR_PTR(-EIO);
+	}
+	if (!vcn && !*buf && old_runlist && old_runlist->rl) {
+		*new_rl_count = old_runlist->count;
+		return old_runlist->rl;
+	}
+
 	/* Current position in runlist array. */
 	rlpos = 0;
 	/* Allocate first page and set current runlist size to one page. */
@@ -942,7 +960,6 @@ struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *
 	 * If there is a highest_vcn specified, it must be equal to the final
 	 * vcn in the runlist - 1, or something has gone badly wrong.
 	 */
-	deltaxcn = le64_to_cpu(attr->data.non_resident.highest_vcn);
 	if (unlikely(deltaxcn && vcn - 1 != deltaxcn)) {
 mpa_err:
 		ntfs_error(vol->sb, "Corrupt mapping pairs array in non-resident attribute.");

---
base-commit: df7dce2090342170b7643d36f694204cae7792a9
change-id: 20260819-fix-empty-mp-3f32eb769112

Best regards,
-- 
Thanks,
Hyunchul


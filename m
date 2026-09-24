Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF583E1D16
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235568; cv=none; b=qgmDzfOrypZLWtqiM5fmJ9STPnpE1lmnQPmVCngw5EMJFD1ZHvdEyyMA5BiaeIKJgBsD5Pgz6Rva9yqucAoV8nl7QKfWYdc3zeYetBVGnCHZjcdrVwdzZCoOgHB0N+R3dmSgHd6zUIcGKjGLMEtN1FmWB7T9/hM7sKn7gAuRi70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235568; c=relaxed/simple;
	bh=7YWyQW2nIT/DP7AA69wm7GhY7/fhiC2zL73JCRhmnho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAqoatkGVBgQcWmi1+IV191K58b/HutAYy0fM01VhQmv+0VPxgu1jtNL+TOvOP4XaiyLIlO9YrIuwwe0hTmA6pDLfblal1U51oVqV8gBq69uN7cFBs4fcg0H6rJavpPg6QBAmjLQL08pYpvUqmfP93OpmTviwGnmJZkKbkvOzPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiF8C91n; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiF8C91n"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-86b90133ae8so946285b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235563; x=1790840363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXIXng5mMMcvqXckQNVDsp9c78xkHqRtRXjDnEK7bWg=;
        b=NiF8C91notgKl4By9arR9KVwFe8+irxjBR+Kfh83LhkPjgdVLpHVtban+jtKE7mTuH
         KujtCJiSvA4i3f2v8LynMnAJujP0fh6ctBX8MI2KKCaZVxT1p1Suwr0E/YOutsk9/9qP
         bgZ5Aiqf9azds5xePAuYXMKYVpUcIvYr8WuvTYSzkrUzRJ8nu33tkvxEeLj6F5OQtBwB
         t608DUN9fcjJizcptoPI71CuB/E3CIP5aIXCo8leMaVaGTYYLN1SkiBKyu8LB4GLZdL6
         67LMuV2fTecoE7hcDrRQq6IHHomf7rGLKKxY9Ca4FEv92KGiKfsgY/gGtU/XZgTf8moP
         6j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235563; x=1790840363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXIXng5mMMcvqXckQNVDsp9c78xkHqRtRXjDnEK7bWg=;
        b=fo3KKs0r3Yl4OONxJgmK/RDnhTpB9zBb8GygRFj3bgz/TDmdfVT3my/wHQUqlfuT2q
         EwODW4cKdft2TlIXNKBIYg4IDDzTeH/c9aaewHj38NuZbQCaVUdVeVLMoXNU51DnHCQz
         1fK1DIEydJRF8WA8hmhpuhERiauf75Wqry+oyRXsCtr7NiEmDki1L44pGuYzpYJQz13Q
         DBZC2QfBUu1jjWqP0WAlkUunlKn+73Zkh9JcPWLzsecY8jNGN82K/I44ww/Uuox9L820
         772k3OeKXxGFPtJsFuETE5e5LlKa8iPAdf+jWOJfhg3GWccVFck2uLaC/XBnNUBqkJsI
         C4tA==
X-Gm-Message-State: AFuF++njOJCKyY4w3p4tjWNVjME96iN/Etoc5itcGd+x2n9CX1UPfYyQ
	Tt5BljbKV/4hacV4df2ddsLglJTpfo1l/Upz8ZdfH2uk01L15LwX8NSs
X-Gm-Gg: AYBFou01F/smxpJ36LaXXyAw/V9miYhpkdN6gAH4qXKkgzWlPq7LhY1zHkqQOV3gts2
	WNuDf28cSkiRNW267FDO58tvFRMkDwVKg4rNJ00JbeGfEngs/hkEz0TLgpWcb94sIuioJCeAqR/
	YOrS4Oli3++96QcV7aLgAwDtKJrVEX4k18SA0MPqAEZNzfYD5xyg8b8hFjd2hGmoann7+Y0b4FF
	9TvFvAHy8NdLWVe0eYPTxbiKcly4iOedQyLDsnIYFVO2lz6jdkAsDccYbtbMuuvy9cOTdtWwaLs
	5NNZZxJt/DJBahO3azw/hK8hujuwMNBtO5HvgZ1EOYGX8Lk7aTOAl13/adahvNUKf70j4ZFrrQg
	8eVlChNA4As6xlEe3bsbksUpWj8TROWbcUNFJrlaNZ2LZc0EQTpZuakQNO0+YCkpE8YlFXhr8w0
	f/XslJ4+j8kP1bSJwkz7vpA39Syqm+oCTIhXD758DsKr8JseZwE8BAFXK2YtfEgPBWGT+IKk2f9
	bkMxgPLTiznjnFiWne7JBmrtxcNQU4jRX6ltUhgQ//1RL9iMOOQJS/V54LYvQhwqseK57Ts0uTL
	Wvn7k9tHOA==
X-Received: by 2002:a05:6a00:2a0f:b0:874:705d:f63e with SMTP id d2e1a72fcca58-87e9b896643mr1227518b3a.32.1790235562568;
        Thu, 24 Sep 2026 00:39:22 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 2/6] qnx6: release bh on error path in qnx6_block_map()
Date: Thu, 24 Sep 2026 07:39:15 +0000
Message-ID: <20260924073920.2782917-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-3-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-3-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_block_map(), when sb_bread() succeeds for an intermediate indirect
block, bh is assigned to hold the buffer head reference. If a subsequent
sb_bread() call fails inside the loop (or if block number validation
fails), qnx6_block_map() returns 0 without calling brelse(bh), leaking the
buffer head reference.

Call brelse(bh) on error return paths in qnx6_block_map().

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Tested-by and Reviewed-by tags from Matthias Goergens.
- Update Fixes: tag SHA to 5d026c724220 ("fs: initial qnx6fs addition").

Changes in v2:
- Split out as patch 2/6 as requested by maintainers.

 fs/qnx6/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index e1981e4ae47d..444458ce3e77 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -242,8 +242,10 @@ unsigned qnx6_block_map(struct inode *inode, unsigned iblock)
 				ptr = bh->b_data;
 			} else {
 				pr_err("i_block exceed max blocks\n");
+				brelse(bh);
 				return 0;
 			}
 		} else {
+			brelse(bh);
 			return 0;
 		}
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog

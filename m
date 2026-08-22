Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530133148BF
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787409225; cv=none; b=WQkV68vZdeTJ6oizgVg8wd+auomTGCUJr3thl13t+SztBo8bEL/jNAgCbmIc9ppEf98rcjkoJmrHsNGUyT3RfFsdZTVBSXuQzinGQHhQ0hmhMjAJUwXJCKhlWEDNTN5HLnKTIDRblJKCo8CiG+8dUzpRcR69zKR+jjeoZITMcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787409225; c=relaxed/simple;
	bh=O75aJsjqWRTKOyF9lF+KMK/BaLq0JLQHHNFq2vo1ctQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZQS718uW1k9FhnZwdrdK5Kk95e9+qnhKIb0Z9u42OZvib14eUyhVFMaZb+Qv+JlI8wxKQu002CVUNfQBqb+NadPr6uN3xTfrGV9DhfWbQ1mRw80GDoQ1sF/Olt/pQBZD/DtOV3kn010ux4CPbU/yV6fRoguZ0T3rZAHcSetc6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpzU4693; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpzU4693"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c160420289bso298924066b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787409220; x=1788014020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IdHnfPP19LuCe1htvM6rTR3Vijz/0/LUnIK+qvqxgNU=;
        b=JpzU4693kaZxV1j04Si2uWuUMhFhqUPFtBAUksealoAlZ5p9D8oXteXXZPI0xOMhLx
         bkHMrl9lzlNkfTfiicwx+xf6b+2ms3E6UFJ39ZgDNsXSu6NRSTKLl1HSPcAFE2Fz2f5v
         vJWPpjYAK/5vb0gYUw0qpus3lQbDRAzSzYHP/rBrC9wqlhWTvcmsPlPRKEDkwOzjsK5O
         wzgZYIZwWyVcsIQkVXjzeNXHKGFpbd3YfyhlMuQjpPUSTWR9AeInu+NEcHqYClw9ZGd7
         8c1bbayWW1gdVtrMPMG6uWDcMthqYvGEwEFTZodUe/RYkKsV/1ZU+pE2Y5tNo1SFWvHw
         4pZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787409220; x=1788014020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IdHnfPP19LuCe1htvM6rTR3Vijz/0/LUnIK+qvqxgNU=;
        b=ce0cq7wNXmVmTGo6HSDvu+KbvFhCIHn+CIRbymoo//8hH3Wdy6zL935yHqtSEQmrdB
         dRP2kroMrCAjzGGYAqn6h4rlTel+X86lK9PivTZBIwn8fBGOgFIpAM1Cb9fRWh0d+Gko
         r3zBB32B6c4+R0rJsS2WvG+FCAyZsXnOw0V6zOsy1lrfxmZyz0f0DHgxE8ocHKCiuD2I
         2k5P5B4VTyzYo1AH4vcvzibsQ8qKZCdxMhBH5/xdNm+mZ8m1rKaflckYLtPQ2m0j5FdH
         Mqh6aovVzAyc3D/tcyrs4ec0TaV05yQRUrw9cGb5ZN0+zKoUQJ1L6jIssTQBesWbEnOZ
         ND8g==
X-Forwarded-Encrypted: i=1; AHgh+RoXviDg0tqcbehbtkQh8/3HVD6h+5YpqZiEuMh7moS/A1CZsc629M9JdafZS03wdMOfkHcuxxoPltoAOQJS@vger.kernel.org
X-Gm-Message-State: AFuF++lGaYx7kLfiGxmgknUKdKRJ6zWp0Lgf7/1nrkiWWP+iaoz0zVoQ
	48ueBtaAkZ9skjqaJIe8x7Qm1lVrHgrjw915ohIMO/Re162lBp+oFsgW
X-Gm-Gg: AR+sD12K/rgFr1V8MMukzO6IjQ4FrM0v3F+YTEPN/LNQVErR37ghtXj09tdM/3n3M2+
	q65EUn/cDtnm8/gNStZNuI4YaZ+27UBxr64MVMofl697cyIIVVcukh/lB0gYTEo8bHYwHFJzO7L
	AtfSTRls1WhFjew5NhzQHz2yOYyLPfE/M5CKtA6VxPfEexlAT3X+WvzGvinkQHU9WzHgij5K9Qm
	M1UimJrsYrsogZT+oPF5gOCqQarcrL21s1DurLQU0aV3zeTTcCdePEXChRiRL2bAxqTuhnlhjct
	mVECSl5QjJvahfgejbjkDfK3eYe9M5cuocDA+/3ZiW92BF7xl6rz96Jrr2msEF1R54RLX92UiFg
	6NwV9hgbqn5N4laviUuWKLmv5bDPg6YbxrCXs9mTqGRfuex7oQbupo3roAcBRdBriDv+7AwNnWK
	53DRUJ/7Zd1KEiItGjRlwU/NcwGONWDugssaxJAwonJDXpMVDivmX2xpVYD8KicBpFPR3lVTXrl
	iEQiednMeRiz7Y8efE2x2+xtaXEHO34eJ6xQDXjF1igdjMvomg1/1n1N+4yjjIyLQhBqpfaZf6a
	Tg33sb3hABsVwtLaS378XKIaqcihh922Qjz3U9K0FTWXRG/atEBfy9CGB2DjGWaAi650
X-Received: by 2002:a17:906:fd81:b0:c21:35d0:f43d with SMTP id a640c23a62f3a-c246a6c52c2mr1473232666b.16.1787409219699;
        Sat, 22 Aug 2026 07:33:39 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm326597666b.48.2026.08.22.07.33.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 07:33:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] squashfs: make the fragment index table bounds check overflow-safe
Date: Sat, 22 Aug 2026 16:33:28 +0200
Message-Id: <20260822143328.68867-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822143328.68867-1-kmehltretter@gmail.com>
References: <20260822143328.68867-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

squashfs_read_fragment_index_table() checks that the table fits before
the next one with:

	if (fragment_table_start + length > next_table)
		return ERR_PTR(-EINVAL);

fragment_table_start comes from the superblock and is not validated
before this point. A start of 2^64 - length wraps the sum to zero, so
the check passes regardless of next_table and fails to reject the
invalid table ordering.

length then reaches kmalloc() through squashfs_read_table(). A
fragment count of 0xffffffff asks for 64MB, order 14. GFP_KERNEL does
not include __GFP_NOWARN, so the page allocator warns before the mount
fails with -ENOMEM. With panic_on_warn, the warning panics the kernel.

Compare the operands instead of adding them. id.c and export.c avoid
the same wrap with an exact-size check. Keep the inequality here because
a gap before the next table is still allowed.

Fixes: 1cac63cc9b2f ("Squashfs: add sanity checks to fragment reading at mount time")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/squashfs/fragment.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/fragment.c b/fs/squashfs/fragment.c
index 49602b9a42e19..b46673d1077a0 100644
--- a/fs/squashfs/fragment.c
+++ b/fs/squashfs/fragment.c
@@ -69,9 +69,11 @@ __le64 *squashfs_read_fragment_index_table(struct super_block *sb,
 	/*
 	 * Sanity check, length bytes should not extend into the next table -
 	 * this check also traps instances where fragment_table_start is
-	 * incorrectly larger than the next table start
+	 * incorrectly larger than the next table start.  Both values are read
+	 * from the filesystem image, so compare without adding them.
 	 */
-	if (fragment_table_start + length > next_table)
+	if (fragment_table_start > next_table ||
+	    length > next_table - fragment_table_start)
 		return ERR_PTR(-EINVAL);
 
 	table = squashfs_read_table(sb, fragment_table_start, length);
-- 
2.53.0

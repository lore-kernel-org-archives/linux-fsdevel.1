Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C7371CF8
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791701328; cv=none; b=BdO35+Y0gIABWOu1aLEep0mjUIeEw9qzwixstFshPx2dfmvMMp2YUARr9PTzj28F0qgJbcest11Vlq7YAMQlzLnPFzdqXRmgsmXDHREZz6EaW+vCKr+w4Ir8XDBeYixM82/B3dWrJ0rbRo+kS/gzRZ/Z58L8hAlRhil56xmuiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791701328; c=relaxed/simple;
	bh=12x4Fjiyi/4PbSLt4bmLyJ/B6akX95r8sgWYZNezRSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UtJNGsE3nc8/Q2jwhUyzZk/FThZ31RgoTx9pDNs2X5b4MYW8oc/GmUkU14Kkf3i+bL+qRvpDSa+cQ/qDrXd5iQbwicXRQ4eo+gIImE4QCQ59QNP0/DbE6Z0dibliPlOyIkdVsrWFI0RiGyLoveWHhEduWZzFbs0oGMoMQlbx71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na2XRAmj; arc=none smtp.client-ip=74.125.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na2XRAmj"
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-3538045633fso899578eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2026 23:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791701325; x=1792306125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=koNO8fBOwK5rhKY5/q8SE/NGFcISiEzKzkHra3TeJ/M=;
        b=Na2XRAmjD/IGf3kac+xsO54ghH+42NuPAocWr/RLWTVdkXfv/KpQj23IZ1ShHAQ9ma
         UAI4uwy7zd2XXyX1hup98h/TMmNUtHNWToQVk6zuiqNQujT6KstLge8QGE5k6tu+h73t
         yrVaSK0L7CvF51Rid7GNm4aLpv/o3i0QTTd2fAYTWAIlP1xb7/pE5zIAP+yy6CbHn3XG
         1EooESLRi97X3ay1HI4IxzXJBgujP4/RW2ZZeJHhG6m66R0869xYdph5ZB9Z5UeCeL0J
         QYzc1LehW4v+2RibgXrQIrYMLM8/8RkycUInEEYr8kaai9qeQ5h2ZRQpinYhTHypizOr
         TKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791701325; x=1792306125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koNO8fBOwK5rhKY5/q8SE/NGFcISiEzKzkHra3TeJ/M=;
        b=g9W+ZfuFiJktPkJFvampRc7NQn8Y8VDBmgTI5zBTOkMCyW4zBmHFexfRjqUo3mBS2y
         qsDfWkK5liL3NMPR1OUVTPVit2VeSb94I/9ocQSGxTG9ZHdAZHEB9ZABQ1Vyj+GXkv+b
         Y8iDzgo4AQIl89YJedlgticZLj2FPoxAOmVZzasF8ocasYNAe49pKPJ15VZSqgsyXic4
         ImrvdfM1bgjcjzxYvrRtxGUAkerG+tkxsgc6ZOBZ31X829qahPFMGFL9F82a6mtzQERS
         DiONqHpIgnP0FM3GEQ4h+gsHkVGIQ6gzhdoLZcLvec/dNmq7SIjK4yUXCsBzXG7h3e8U
         PGBw==
X-Forwarded-Encrypted: i=1; AKwUvBwI3iUxrn32fe4FmU5S0izPzmTt10dH4/8Uui1P+wBveluPJx/BoxauokV5oSpcdIHGoK0DLqwPPvISGfpo@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8hBJfg18xPL72b9BMwrW4+z195UzJL2sW+wvubg1DBbvXp2nQ
	HWXkfCGrsPH2hzAO9UfS8Nj1D6lc8rlKIOjulwoWS5S3BpYVHdXGV2Gs
X-Gm-Gg: AYBFou1fetbeWtA83bcFXsSHZIr/AHM36uW3thmkW/TZcueTBmq/KY1eKQuJpMvBnn1
	/GKCSr6dpdaoChtRj+dnWUKkfhD1GrAtykIFe6Nji/NcSh/IPoewOVTbheIKTWE3koBYYFFtuyB
	VSQb78xtu7H54zeuEqQYbmpX4FhYlRN2QlnfCl4rV8Bieu2pinLcgsWTooSOrPw6y63zf+1d6uC
	ApSZ5Gc9spqOtJGhdDeQr6MHn+1B5rvPl8hFfGEjdHzhW1Cwkx5l9RZzPQu1DU+3jZpmaNfaOCV
	LApv7maGKMv1/kqYs3UZ98Q09FfXVfdyrUyCCt4pRkQHKvasZIpqDY6ZcLwlQBwoT5e5LceoVsr
	PQE8rjwQJeyEyAMKcHs+TBQVFqw/4XxLiSdpG1wHXAJNC1Q0vc0Z00x6Z9gtaHoNtybHmIcN1Js
	LD4rNFydbY3HS2ct22+8/yyOjl9+CvEhzMFWQSFEWYYYZosMe/lm18RGkemxHV6zPsZ5pH/0M7W
	XsoYRCl72QyNf8UOF9DPA+eny4dexYO284qzjuLaB1Z7p2i00H0pjOnvaA=
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id 5a478bee46e88-3537db99e8amr12245241eec.0.1791701325373;
        Sat, 10 Oct 2026 23:48:45 -0700 (PDT)
Received: from localhost (ec2-18-143-158-86.ap-southeast-1.compute.amazonaws.com. [18.143.158.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-359789fde97sm4534786eec.20.2026.10.10.23.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:48:44 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	nvdimm@lists.linux.dev (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH v2] dax: fix dax_range_compare_iter() to use correct size and address offset
Date: Sun, 11 Oct 2026 14:48:39 +0800
Message-Id: <20261011064840.1296-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

dax_range_compare_iter() has two bugs in how it calls
dax_iomap_direct_access() and uses the returned addresses:

1. The size argument passed to dax_iomap_direct_access() is
   ALIGN(pos + len, PAGE_SIZE), which is an absolute file offset
   rather than a length. This causes the underlying dax_direct_access()
   to request a massively inflated nr_pages via PHYS_PFN(size).

2. The addresses returned by dax_iomap_direct_access() are page-aligned
   starting addresses, but memcmp() compares from saddr/daddr directly
   without adding the page-in-page offset of pos1/pos2. When pos1/pos2
   are not page-aligned, this compares the wrong data.

Fix the size by computing ALIGN(len + offset_in_page(pos), PAGE_SIZE),
matching the pattern used in dax_iomap_copy_around(). Fix the address
by adding offset_in_page(pos1)/offset_in_page(pos2) to saddr/daddr in
the memcmp() call.

Fixes: 6f7db3894ae2 ("fsdax: dedup file range to use a compare function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---

Changes in v2:
- Add offset_in_page(pos1)/offset_in_page(pos2) to the saddr/daddr
  arguments in memcmp() to fix the page-in-page offset issue pointed
  out in the v1 review.
- Use offset_in_page() macro instead of (pos & ~PAGE_MASK) for
  consistency with the rest of the codebase.

v1: https://lore.kernel.org/lkml/20261010071453.6028-1-jianyungao89@gmail.com/

 fs/dax.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6ba50142eeb2..b08d408418bd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2197,6 +2197,7 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	const struct iomap *dmap = &it_dest->iomap;
 	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
 	void *saddr, *daddr;
+	size_t size1, size2;
 	int id, ret;
 
 	len = min(len, min(smap->length, dmap->length));
@@ -2212,17 +2213,18 @@ static int dax_range_compare_iter(struct iomap_iter *it_src,
 	}
 
 	id = dax_read_lock();
-	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
-				      &saddr, NULL);
+	size1 = ALIGN(len + offset_in_page(pos1), PAGE_SIZE);
+	ret = dax_iomap_direct_access(smap, pos1, size1, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
-				      &daddr, NULL);
+	size2 = ALIGN(len + offset_in_page(pos2), PAGE_SIZE);
+	ret = dax_iomap_direct_access(dmap, pos2, size2, &daddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	*same = !memcmp(saddr, daddr, len);
+	*same = !memcmp(saddr + offset_in_page(pos1),
+			daddr + offset_in_page(pos2), len);
 	if (!*same)
 		len = 0;
 	dax_read_unlock(id);
-- 
2.34.1


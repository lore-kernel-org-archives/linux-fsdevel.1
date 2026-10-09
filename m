Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F33BCD12;
	Fri,  9 Oct 2026 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566265; cv=none; b=cYPOHl6RRfeJfZEWY9Zi0fgg/kEaRecqAUpb/c5W4RseE5rtw6wP4/ftI8XwuCGVMQcooYCYZB3VdJcZnhiImMilyZt7lsTszfrtD6X4HNW3gJ5/fys3QArP56nT41ZG6+qVJqpEzz4lEYcVPeZTeuO2k1UoZNdh71yWACWgG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566265; c=relaxed/simple;
	bh=bssRQV+jlc2ZN+Qdgcn+A4JH6f0AVdcGie28j5RuqF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXgSQGcHbC8KdNEWIOQIU2FCNne4fY0Ci/TdvrBksKH0fIyICum5mAruY9LUtOVj9D9/LZfktCUZp2xKQi9gIsuSJtU/pDnhpz1S/qZQoOq5Xf3rHZ8anBZU7vZ/fw7xsv+XsHLQbnxfKR1A7Dabs8wIVNiMXLvJR9DHTQofGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=DvfRtDvQ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="DvfRtDvQ"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1383E1D70;
	Fri,  9 Oct 2026 17:18:34 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=DvfRtDvQ;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id CF44021AD;
	Fri,  9 Oct 2026 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566262;
	bh=WybjilAa6LE2Q7gxywX2tEJIwk5AwMeYPdJ4FSHki1Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DvfRtDvQOOw/FfQOglmOjnYUZCx7j76cYUFZF2/3ODX2PcEKj/rEvQ9ux96Trr8PU
	 R6F7AjBp7wNxilfZMkLIoXR+2udK0/fhxBGBbIESi4k5LHGiVO8tUqBZP5aUhxIi6v
	 2J0gikxSY3M7m93moDxCPkqWZYevDWbLU0ePDOfo=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:41 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 10/11] fs/ntfs3: reject unaligned hole punching on compressed files
Date: Fri, 9 Oct 2026 19:17:03 +0200
Message-ID: <20261009171704.11379-11-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
References: <20261009171704.11379-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

attr_punch_hole() handles a range that is not cluster aligned by
reporting the frame size back to the caller, which zeroes the partial
clusters and retries.

Return -EINVAL for an unaligned punch on a compressed attribute; the
sparse case is unaffected.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 254037763a86..928c91b57da5 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2386,6 +2386,12 @@ int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size)
 
 	if ((vbo | bytes) & mask) {
 		/* We have to zero a range(s). */
+		if (is_attr_compressed(attr_b)) {
+			/* Compressed file punch must be frame aligned. */
+			return -EINVAL;
+		}
+
+		/* Sparse files can be punched. */
 		if (!frame_size) {
 			/* Caller insists range is aligned. */
 			return -EINVAL;
-- 
2.43.0


Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020993BE154;
	Fri,  9 Oct 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566244; cv=none; b=EkOtL8QvKo0CgxPlcLqJ0thxKsrpjj7MmXFrvbkkHZ3OVDdWA86WWp2V83Q48zJHyWvwBaFvAlL0mKPRr64bbMLNORzG6J5OIwOYbxItqR4hjUBmEco86Frk1twQnnLlIaVofpqB4nLHkdS0J3B1jpo2OOs3prEQy7E83ao00/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566244; c=relaxed/simple;
	bh=Qptyk9vHOLz6emttmuMCd3ivQySLrhmlRcX+WkvDm4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPeqFomEixv8bXDyWLQjJIxj+YSpYKDxC7S4aD+wKd/7yJ+2AaEv92wHXiBzdwFhXvHImxLVwcLyWQrSeZvg18PXrpOns/m72g1VasvEUt3suuN5M89Sb0rQPLkyomnNIo6o5FiP3CfmAWMkm0FAoobq1Bxm83YaxFZ7HOAsi+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ZSyWNw2N; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ZSyWNw2N"
Received: from relayfre-01.paragon-software.com (relayfre-01.paragon-software.com [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 669131D70;
	Fri,  9 Oct 2026 17:18:12 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=ZSyWNw2N;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2F56821AD;
	Fri,  9 Oct 2026 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1791566241;
	bh=i76ktsMMLepwBg4/HopSHF5pWMPbzU7zEbsbjQOVOf0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZSyWNw2NUjEjrFf3u0FcK6cFiUoajLPZO2zPoYhPXw99XJLbxo2r1M43MvH8WOWub
	 lXHJwfFCQtONstFG6FinzZ25zlRMi2MBeMhzmfuUqe2H8IongsKYrkTUJP//zlpLZE
	 yM5WMZb+sd1tS6WHXSTWavAqbPFqin8Zf1vTKHIk=
Received: from localhost.localdomain (172.30.20.199) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 9 Oct 2026 20:17:19 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 02/11] fs/ntfs3: zero newly allocated clusters when the request is smaller than the frame
Date: Fri, 9 Oct 2026 19:16:55 +0200
Message-ID: <20261009171704.11379-3-almaz.alexandrovich@paragon-software.com>
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

For compressed attributes, allocation is rounded up to a whole
compression frame, so a request covering only part of a frame still
allocates clst_per_frame clusters. The clusters outside the requested
range are then allocated but never written by the caller.

Until now 'zero' was set only when allocation had to start before the
requested VCN. When it started at vcn0 but extended past the end of
the request, the tail clusters were left holding whatever was
previously on disk.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 3b4ef15162da..cd6d4b75d328 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1164,7 +1164,7 @@ int attr_data_get_block_locked(struct ntfs_inode *ni, CLST vcn, CLST clen,
 		to_alloc = ((vcn0 + clen + clst_per_frame - 1) & cmask) - vcn;
 		if (fr < clst_per_frame)
 			fr = clst_per_frame;
-		if (vcn != vcn0)
+		if (vcn != vcn0 || clen < to_alloc)
 			zero = true;
 
 		/* Check if 'vcn' and 'vcn0' in different attribute segments. */
-- 
2.43.0


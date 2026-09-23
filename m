Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59004052AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790204942; cv=none; b=L5Ypn1TCN1QTmfklIgFcTsdtGVD2tQgx4LXmtKE0fKhUL+QjEvdcbl3kJ5FhLn5ZcOlGAzqijIbpzDzjS+csb8Scc/ORa5vkBvMAK6hf4zzbdybwLTDStDs/SpSABiHfxwBq5qChR+aMJpT7OzlqZCEl2UY+PpAgakuPnMHKUsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790204942; c=relaxed/simple;
	bh=PcLdQwevGSir1y0AvR5Mf4CvuQvTWdGFvEaf/XUFbDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK7yqXYef1xiw8u82RyVleJ5ZyI7munORkPRl5svSICMCyDpOt+RT4XUBElUF5Ux3j3SpQHOHT2y4SXAAWxd3aYaIcVCGr8FeIiHDqrXkEMxH+VQHAM66xpewVmPLnXiz0oCQJGqKoVp+2G1NJpGBNJW9r0yEywwpSXofT0mpfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4ouqL1P; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4ouqL1P"
Received: by mail-vs2-f41.google.com with SMTP id 71dfb90a1353d-5c67e5059fbso480475e0c.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790204940; x=1790809740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koc05Ptr7vMQZtPAxa29PikWzWhqn3jY5R5ERgF0Hpw=;
        b=j4ouqL1PSWxqb093i98kzWpMN+ltlvyl4lPYlWRrSO4+ahGS7o48M3GfD7ev6CwSO7
         RY3K3OuPO9UlcW3PrbQj8TNvDF/K6zex7p45UJW3p00/M6yW/Dh4WVtUSfhBuQtIw5eL
         j1nQW8fTmNPpX1Ca3XVXMn9L7xNLFvYprwPl/VdOMRXcWtANKVKI4CIJKRPMjirIKwaU
         c6U0AV/Y3vsamkcjaX56s/3MTcuf090YYUhGVAdnJwYmFpR9CT12LqhNt33RY9XiPhcl
         KqAoBwhRvAJiTr2uii84ysus2Jy7UJMOW9XMBzMudkV1jBBXlII/18KZ8dqHfHRTj+KF
         V37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790204940; x=1790809740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=koc05Ptr7vMQZtPAxa29PikWzWhqn3jY5R5ERgF0Hpw=;
        b=erQczYeapy4cu2XG5+dirMb9QJe7ozFkRqvpjCx69QtsGkvkTl9kYeLHeHZqCslgD+
         NspwCiL98juPE4xZUzLecHn/kDPsZfcQqUTNl6Axr2bAm2lzcotvZHc+hxxQajiri4n/
         5/l6uPBDNOMc/dELMMyyjWFW0xC9Ifp52EwCtkoKTOrvp1F9wvG6iHEp5OCdiUTVodFK
         3jn6Xl/feUkim4TKoS6e+Hj8VfgaHtB+95IjN1N1RAVQ7yzQ5C5a17o+fs9dFbncQ6vu
         hb6YkatDNS1wpgjQsVnmIhNBfpCQNng9c+xucWSoQMbwf8syokHpDnJZ61qKZTStnshG
         g3FA==
X-Forwarded-Encrypted: i=1; AKwUvBxgJTPABRGYBI0tLPd+QeYeF5AWU8zH6X4/HVZhLOw47gn4VFa2ciysOzbi1FEIPPRVlvlIhDsRcAJlIeuG@vger.kernel.org
X-Gm-Message-State: AFuF++nHqtGaSdl5j1TSxqoI2trV3NX9HBDOJmqJhfkp6z5Za9kpKNW1
	sQX9KjCSSUO9h1GRXA7H4P2EEGJnvV5Frmyihy/wKkFEbdv+MEwb2Y5DnCAYpEq4oJw=
X-Gm-Gg: AYBFou3lDLrahpW/50QNF4vDAaOK24z5jNzTJFj7Z6fijzABXF9pGTcs4YqgpNU6e1m
	orULn+V8MW+F/RxJ0U+iODxPUTKD6IubgntDiEG49A+dS3j6+B/M+pG+NffKvgrIsOCnHAIz3BN
	f1mbxPQubbI/f5bbeYUo8JjD3aTJu+eC1x82kuPhU9kBZPVkJtvSbX3agroW2ntNm6gFjZMeLw8
	0TzbaPLFy9TcJkGB4DE4wJcFvcwsQzoUeuNd3LE7rAPHzdyKW7ptIMfxFMWsGjK1LdyUY7q4W2Q
	HaPRm2WERyYwFOm4W/R6Cg7B64mRxZJZrhF1yPppnL07QUbCvZiSH3QufOtfk6VFlM4C3MvTQK2
	Ci0TgHXoPKKU90bZaZOi/bjzVZyESektOckKKg9ZN4Q4wFbAKXlp1QjE1J2KVfzl4rp0rAFnDqn
	TqggcwoNY8lOUWlZAfGTPBLUJMyvA7IsQ8OqILGiVc2Sh8JrXiQtpr0jGyNkhj1ceA5Fd3JDR6J
	pS2UcshdNaMg23ioQ+ODqfUFWv1+vFK9hKFSO53yWo6EM+XJOEDYlucQg==
X-Received: by 2002:a05:6102:4b1a:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7af1e4f8b12mr479173137.24.1790204939613;
        Wed, 23 Sep 2026 16:08:59 -0700 (PDT)
Received: from bazzite ([138.122.221.5])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af25964441sm753777137.10.2026.09.23.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:08:59 -0700 (PDT)
From: Davy Felipe <davyfelipe34@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Davy Felipe <davyfelipe34@gmail.com>
Subject: [PATCH v3] hfs: handle extent B-tree write errors
Date: Wed, 23 Sep 2026 20:08:07 -0300
Message-ID: <20260923230807.1742801-1-davyfelipe34@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <4fdba50ccb0327d7dedaa937774d0c6ae7b77919.camel@dubeyko.com>
References: <4fdba50ccb0327d7dedaa937774d0c6ae7b77919.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_brec_insert() may fail while inserting a new extent record, but
__hfs_ext_write_extent() currently ignores its return value and clears
HFS_FLG_EXT_DIRTY and HFS_FLG_EXT_NEW as if the insertion had
succeeded.

Propagate errors returned by hfs_brec_insert() and only clear the
extent flags after a successful insertion.

When updating an existing extent record, hfs_bnode_write() returns
void. The helper may reject an invalid offset or shorten an overlong
write without returning status to its caller. Validate the extent
record length and write range before calling hfs_bnode_write() so an
invalid update is reported as -EIO instead of being treated as
successful.

Negative-path testing in QEMU confirmed that an insertion error is
propagated to the caller. Testing the existing-record path also
confirmed that invalid write parameters are rejected before
HFS_FLG_EXT_DIRTY is cleared.

Signed-off-by: Davy Felipe <davyfelipe34@gmail.com>

Changes in v3:
- Preserve the original insertion-error propagation.
- Validate the existing extent record before hfs_bnode_write().
- Return -EIO for invalid extent write parameters instead of clearing
  HFS_FLG_EXT_DIRTY after a rejected write.
- Clarify that hfs_bnode_write() returns void and therefore has no
  error value for this caller to propagate.
- Keep test-only instrumentation outside the submitted patch.

---
 fs/hfs/extent.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index f066a99a863b..13426503fbb3 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -121,12 +121,21 @@ static int __hfs_ext_write_extent(struct inode *inode, struct hfs_find_data *fd)
 		res = hfs_bmap_reserve(fd->tree, fd->tree->depth + 1);
 		if (res)
 			return res;
-		hfs_brec_insert(fd, HFS_I(inode)->cached_extents, sizeof(hfs_extent_rec));
+		res = hfs_brec_insert(fd, HFS_I(inode)->cached_extents,
+				      sizeof(hfs_extent_rec));
+		if (res)
+			return res;
 		HFS_I(inode)->flags &= ~(HFS_FLG_EXT_DIRTY|HFS_FLG_EXT_NEW);
 	} else {
 		if (res)
 			return res;
-		hfs_bnode_write(fd->bnode, HFS_I(inode)->cached_extents, fd->entryoffset, fd->entrylength);
+		if (fd->entrylength != sizeof(hfs_extent_rec) ||
+		    fd->entryoffset < 0 ||
+		    (u64)fd->entryoffset + fd->entrylength >
+			    fd->tree->node_size)
+			return -EIO;
+		hfs_bnode_write(fd->bnode, HFS_I(inode)->cached_extents,
+				fd->entryoffset, fd->entrylength);
 		HFS_I(inode)->flags &= ~HFS_FLG_EXT_DIRTY;
 	}
 	return 0;
-- 
2.55.0


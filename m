Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AC33C1970
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564626; cv=none; b=rUOpMuLgr7PPWO64DfBr5KLvWqU3jTM/QKJTsKQnQBO67/DMmnXnhJN0I20RA3HWERn/1HCppLMeCSuUYCfMlGOMGN0UDsWqWV5rQSawLts33J5OmYVFVYIJOV1hkJR0eEQVI5q7xVp6AH7E/3Wsvq2/J6KP1e6hblWU+3cCH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564626; c=relaxed/simple;
	bh=8OGb3qPQgDkNcNviBN0K0rNS7a4oi8Q3FVacV/Nt9jM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTdiY3XSdlzVqi8loO2nY0Cl7sgLNQNyApZ1Sq76gZwDTOxOPjDjCyk8q2t+uaB0wxjyyrp7CMHmvu+UCxqNcTZsHmlHNpOg4QxLrJbtDhSl4KCu2ly/oLlmdx+kZhBX1kmVT27PQicMV/OTJftMb8qFRJxmTdlSSFB8nm7iC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZCjvv+jo; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=BGH+OipO; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZCjvv+jo";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="BGH+OipO"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYI4G3932422
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Oct 2026 12:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=J0Ga
	yEBSzv+QelRuV9iRmM/2d+1IsDKap3LFlt6v21c=; b=ZCjvv+joRAcNozY+TgHH
	wmbOC5GOX+mNUMR4uNlnbn2FL5zVr5WNF6Gako0n7iClUizHlicZ1zI6bPiCRK/2
	uMViT1MXXzOqP98SqDeyuTdL6R+E6wtySKZQictgrTu7knT4Tsog5bYS+qNiRYsJ
	A8fk6vejgpN/hEHKmHd27i49OSbmeBQThk/jBik81Kk5b0PjxKyB5qeIM3UG42re
	9UptMvIMDdVUs75IXuTXCyxf2odnx+ArwFr1MXO+Z/Bg3jfHxkZtXtz/TXWHXJse
	qcIpJcin6HDMmAOTJGZZVDd1J2vXNagurlCJJgCTXi0xtwcEehgvL7PMN7FSR+ng
	yw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h6vkqbefs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 12:50:24 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-535252004e9so127656841cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564623; x=1792169423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J0GayEBSzv+QelRuV9iRmM/2d+1IsDKap3LFlt6v21c=;
        b=BGH+OipOT8U+fV/Q3TCueyh5NT3oCNItPrJfkUNGCG2Pa0MqCZAIKp2yBr8O+cIvBM
         lY0rNE2wrgDIOYQQFiBA5RwXU7JoLbUhLHJtK56EaEs8vZA9FRyinv9bQdIvRijWgd90
         QaRHVMJMwL8N+KiH5owHANSrTzvNu+QiSLxiEIQGf+VYGY5MnXALVJd37Agg1PEDH8Vp
         jgRVuEP+Dk5dqYAQg/m7u+K9QloEvuH5r1AedGSKB4rbysJnW7zF68UJ6jtY141jTIHy
         eM/Fy1jsTyRRRhFTEMqDEEmoxjLIXqxuzXJNuqyaF5KdNM5JGJViJ11eIpdE2WpCSnUQ
         dRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564623; x=1792169423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0GayEBSzv+QelRuV9iRmM/2d+1IsDKap3LFlt6v21c=;
        b=OoNtKw0W1gajp7vg550zvdQapc1q/dL1JYtZdjKkIvNA8YjqsslIBwbp5MOtJTnbQV
         pkmlHgCaMbZMqW50yV22isfjw73ZM2pr2qckPeCsejLwsMkROtGyn/GwP4N0oRf22CWT
         K1iG0rcG19LaonhMk6hg8WdHAStjBL0Hnzo/JkmqHfliLf6z2s8Dl8rwuD7XLUeyvA3D
         4Ee46tN6MBkwOUX2/Mu/4Lkhcc5ZXM9STdA4KpSPdZIqKun1sqNobKo5SbkdMvV8Oz6Y
         e71/Avq+MmOYHtTyyQd7lEPE4kUH1I3gziFqd4q4vhGpvtDrfURhNTxcTZYlLtrdDPMv
         kHYA==
X-Forwarded-Encrypted: i=1; AKwUvBwcwij1SBaeHmPTcj9P9XSeg7wCos8lk3NX8I+udu/sI4GiWJz2NdEZmxxM1LliL2wX/SZ0WYPC46Z/nEYU@vger.kernel.org
X-Gm-Message-State: AFq9FYLBli8+xQof1/zDwv4W8pMkdEVrAvkzn5dEHXXEygJMLZuEGJ05
	opeARkVQpaAfoCJ2OUehnmWmdUEx1omDqDbjwKfPKIY/vz6eDt/2o+z2CSZ16KMNtYdc/7rFofq
	sWnzA1Vvh0nFbzMNeSEYkTcOJGoB7W26oJgSMrRcYkYtuSbWGKPQK+cRcDPXOn3Q=
X-Gm-Gg: AYBFou3NCxWqmV69WQGC1sof+vgRB/qNOoiAXmyUP58dCP3asbSWTeMRO36xyHiyyML
	AMLhc6oEXDA+yoo++Z2Tmq8Fv58U3eKgl6cmOX/J2PXBiTazvKaj1C0TOO7XRCxs9uC1HByc9m8
	1po+rdlcHTLH3/D5B/4PgUU5vcVMneN7vVV9jh1Dsipa21E9wH+OBUbBNyaJfCdpbG1bXpGNJpy
	PmSnmdA24ghB1MZ8429SVAVN3Xr28HnW7kSgAgdzTCzqqNV4bzHcMxRjWrLlA303sJ2u1IerRrw
	vyYZ3O1ltjpsZxq5HktcIND32TsEyvk+Ykj3oMpSl3+pUnjxPBlz7RltJ9kMAx6YkgflVGGYqS9
	g2sn4I4HVRN3iz1nnQLP9ljqiqEDDxR2ejfA3RQI8Ql52AeU=
X-Received: by 2002:ac8:5d45:0:b0:535:134a:2c83 with SMTP id d75a77b69052e-5359fb6a8cbmr39888131cf.41.1791564623211;
        Fri, 09 Oct 2026 09:50:23 -0700 (PDT)
X-Received: by 2002:ac8:5d45:0:b0:535:134a:2c83 with SMTP id d75a77b69052e-5359fb6a8cbmr39887741cf.41.1791564622800;
        Fri, 09 Oct 2026 09:50:22 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:22 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:12 -0400
Subject: [PATCH v6 4/9] block: honor IOCB_NOWAIT in the block device
 buffered read path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-4-307939c387df@columbia.edu>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=1869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=8OGb3qPQgDkNcNviBN0K0rNS7a4oi8Q3FVacV/Nt9jM=;
 b=3w47/7LOKxZec3w+0Vpj8v9f9aG1aRFOZnvQaqM9Yws0tiyt28d+DBIkuzvMpuwjPhXqV2VCO
 bIiMZVN0NnFBo0Q4+cwwjukT8ukBUhJzY74tSFs+Yglqo7VQU02FLH7
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX/zHc+s+CyDYG
 1VgTlcSGDBrde5/Irvb2STtYq5i425ntWH2F/4FbNOhCQnuv88J7TmglKgmrurhI4Q9expQf67h
 nY8+Uc38w0+oxDoyGdv4L0E4CX+AeqQlt/dvhkMeRyaah0WOz7Yq
X-Proofpoint-ORIG-GUID: WKouaC5YAYrhnEoOGHphjaDwlDBmluvr
X-Proofpoint-GUID: WKouaC5YAYrhnEoOGHphjaDwlDBmluvr
X-Authority-Analysis: v=2.4 cv=JaUpPkKV c=1 sm=1 tr=0 ts=6ac91b50 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=s8mzj7eOnaliLhoSWqYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX1KjAHSXEeVWJ
 oy3VvMx0DsY4BKkqWXgmJYSaUvfhbzKhMXFv2VCxE6xTPGj65SlzmcjQyfntiwEo3PhvsKYCDf9
 h750pltutHsaN2DbZHXw3fCqbCK/1bKQB9t4HwZ053kaim2mzmklVurVWfHVBAIFv3VcImy8E43
 ZgqPoVgH/g56hpzMkpIzuf1a3Dc/2CrhwMTSTT0ByeU5l5axok7tzvwL3kQvdEnH7Fj2otWz681
 wQiMkxe3ixl65BKmxj1JylVB2a5c5iNU94J9LjmN10aH4+q3XfHwfEvaNUtfg7+9oHVR2N64EUC
 nvJr9uZkOeyKF5O4dQWgJ0R+LW1Lj1tud7A1lE6CfSscFKEsPc0vq9iIAASNFNXk/QA6f0uJ/hP
 7mkViglw2og7U0yPiMNj6y9SjWMGsmpMmSC3j1L6UyEc0zyDrzrNtJ0cnnRirhj6qoxToPGpMva
 IVCTmBEvO4ZVhgY+mBw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 suspectscore=0 bulkscore=10 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=10 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

blkdev_read_iter() takes inode_lock_shared() unconditionally around
filemap_read(). Unlike blkdev_write_iter(), it does not reject
IOCB_NOWAIT for buffered I/O, so a non-blocking read, or the buffered
tail of a short IOCB_NOWAIT direct read, blocks behind set_blocksize()
holding i_rwsem across sync_blockdev().

A preadv2(RWF_NOWAIT) issued while another thread changes the block
size with a dirty page cache blocks for as long as sync_blockdev()
takes, 4 to 6 seconds on a scsi_debug device with delay=5.

Use inode_trylock_shared() for IOCB_NOWAIT and return the bytes the
direct path already read, or -EAGAIN if none, when the lock is
contended, preserving NOWAIT semantics.

Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 9c556bd08c6b..2022c7cb2ee3 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -873,7 +873,15 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
 	 * changing i_blkbits/folio order and punching out the pagecache.
 	 */
-	inode_lock_shared(bd_inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(bd_inode)) {
+			if (!ret)
+				ret = -EAGAIN;
+			goto reexpand;
+		}
+	} else {
+		inode_lock_shared(bd_inode);
+	}
 	ret = filemap_read(iocb, to, ret);
 	inode_unlock_shared(bd_inode);
 

-- 
2.39.5


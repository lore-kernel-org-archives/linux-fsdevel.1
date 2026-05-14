Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD22DEA6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795530; cv=none; b=Vga1QCzdRtEsUfcXTk+l/sNHm1OZhyvDkQMfCzGwooBJ/mB6ZihEt8/o3mSFbaparDjRWqwV/eTP4utIFRN9NKkS9gGVvvh8Dcrruas0EupMeioNAquJPZyxY4JVLMHaqkn8/BBRuwUfPSRzPP6WxJiK32QLgclwJxbeD1sSuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795530; c=relaxed/simple;
	bh=4kYnZvc+owx18DdRK+b0WjIntKdQQVbjejy+2ia87ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJiE1AIypmC3Qo5wNMcwVCc4o3OEH6TacPASSozYvlnSj8BqLex6fCVKn1oaSCTecHS88Fl6a+4UpYX7azmruI7OzSv/r/6MEDafj6xrT+GHboT+HpZIPDhEVuFpZsWYXvbSGc9NVXAtesD7gR7z+MlVoq3O94Iz7iRHHUo56iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=eZyHj6/o; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="eZyHj6/o"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ELgahL1544822
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 17:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=3Hr8
	xytd8pzj0HErDwC1OWfZgJX2Msw8AYmLwQIxWTo=; b=eZyHj6/o229FuGb6obFP
	y01//iQN2R10GEr4qVdWRAcKfbBn39iOW7pDeiamYsItYvBz9nE/Pon62/FrHbRT
	ca25JObOyp6I0YgF1LVja0LAoUrXTH8PN4c9FaJLVX4cocBvkgvr8P1/bXRUtYEU
	ezdeGP/xD8FpSO71pFPt2m+7sM8WNaM3qd7Ykfu81marJvVKRJ43F9LEndWsCW/H
	RNqSJjAMDbssaOoJUGGgGwOzvmON7E+wXPvY9wvASbmqJ2uqaCGwOtc7KTVgCX9l
	VxxXI7XPNFK0AnLfKFz1TVkvCMAgh/s6LpNCtKUT3llAjiwNjZdOQCTCQf/Jzy6W
	FA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e5m25hdsm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 17:51:53 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91207972031so26390785a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 14:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795513; x=1779400313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Hr8xytd8pzj0HErDwC1OWfZgJX2Msw8AYmLwQIxWTo=;
        b=AI+UeR8PylLcc4KVPgnoyrifXCA6EzTG4yvdW478Ukdg8vbbbrcQKoiY1Cng3eVSdW
         OTvVdb58d/NduJxb6dR4j6F9kOEDAjrG7f8qMKgevj92KM7hHwu/ldfvQnkSnk/K/dsP
         5Ed38K44z/Hej/cYPOKO2qNYrflWNt+Xq9g/arMk8aQaE7b3Q558jC6QfhBc1cKtpRWj
         o2CDqjuTS/V8rm1rRBYt3RGYRt4VzuE7n4YxEEO/tjCxxyggQRr1288gwVkrqyf59CHp
         3gV4XENWlFR0nEVLed3eCmXzdR0nAMT4sUBNnkI6ndsDc+U9Y6vvQLLy7Y9L8nLcm86i
         Jj2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/WUsxIubRzcmTpi/wod8VdWtot/PvymjfFL5faUeMBKbM4PsSWb9UuiAKaww5Kf3Fyqqk/58YlFUIdz5DY@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsXTiIbsWGHC1fFta1EQfHSqHyzyfMTI2Dx+tpyvlOJfYXM8g
	ww3A9ErutXpXo3NOyaNUjfpcT2sMFzbZi3KS1o6djAM8fet3vi2e6tHdb5B8ke75tkn3nqXYsbf
	uRc3voPVZ44o1H+tSav3RgvD7m4lZIXUFtqCQkqAQfNVK+4E+sz8ibM+1xozH6tc=
X-Gm-Gg: Acq92OHUcNWSRxWfVzlduJJ3lM/nL0+1lZ7aBctayK79H049cPIfNKoJrpBdngx02or
	kUo2aET+q4Uq8YGEkBgYTim5rkARe1KYVl2LkKRuxj9j6XEYdiiFkxBtuSBu+xIyDvKasjB6akF
	EMmp9XDGtgLPFl+RmEeymLkzRiP+sCSW5seg6Hn2A9H3yCmMOgGE9R37ki/JxfHKNhqkfh3K7/O
	FEeuMFt474N/s/qROZyuyn75u9VdueEQx+PMwLe6nV0vTn34biXwBcCQjMaLcypVshRCY4gVfzz
	sekqbokg9JJamC1/ug+bhCOX1j7YhhCtX2hp03lvEpom3q02YJVXEndenuddGsxt/CaSAeLSsFJ
	3cOROcdyeoaHafW+NxqQYebqdnUYXRwZD
X-Received: by 2002:a05:620a:2987:b0:8eb:605f:6cd6 with SMTP id af79cd13be357-911d0c5d023mr239924385a.60.1778795513399;
        Thu, 14 May 2026 14:51:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:8eb:605f:6cd6 with SMTP id af79cd13be357-911d0c5d023mr239919185a.60.1778795512909;
        Thu, 14 May 2026 14:51:52 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.229.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba18132fsm354966085a.6.2026.05.14.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:51:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 14 May 2026 17:51:17 -0400
Subject: [PATCH v6 4/4] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-blk-dontcache-v6-4-782e2fa7477b@columbia.edu>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
In-Reply-To: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778795507; l=1606;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=4kYnZvc+owx18DdRK+b0WjIntKdQQVbjejy+2ia87ck=;
 b=h/wC1HCfLFItwTEGisusw9jduZm6p1jTrRpV6ed4zqtg5o3ocYnG/8kC6WqedCRsxxH5uzIMI
 xkDRAyq8KAYA0Vpg3tuCs1ya2+fmJNNoRSOmfuMYQk5UpCQHPwkaVV6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=JOcLdcKb c=1 sm=1 tr=0 ts=6a0643f9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nkegbr1AwBRna+m8FBH0UQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=hW3giJO2Q2g30DqAd_4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: KjPO4kv3DP8ayoXhwPBiS_0Ghzwp36-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIxNiBTYWx0ZWRfX5XVOqkaaITyK
 MP5GcF0OycdFRs9K0+OSzfACMcPRABHB/7MkpUsHFYMeYAr+OP+sS1+a7drQ8bQR5tH0CcyY/sl
 gkkbB+1mzo2iqZLzApmmM+VLRabHJzLGSga6JNF9QxXwOTD/w2SQ0b09o9xm6Bej8YDYJN90Y2M
 v9bVycegpMoWbadF+aK/2y0PAIsYK5VDFoEufm0kl7PJ7JJJjjvu776wO2Ztk6IakbpbPxkvSlE
 JM5fsSAV7FAqyt0XfQA/gvuuUa02A1j1LB18tGr2ISAJBuNLH2DDdubnJ8R0H8rFDvxvy2aofKw
 T8n7nK9q6Qq0POnM8i32sdPxgU3m/N5P4O1WkK95ozSFK3QNRsInmXRNANafpCnXkgljxuXV2vj
 5jzbmSNbEjA+QgoBgUs/DQOZvn1CUpkSDMXlucSg14fsqrGPQc3ulPAfxMYrEBPaYwmubA78Ihc
 vhwwRbVOauheivHmJSw==
X-Proofpoint-ORIG-GUID: KjPO4kv3DP8ayoXhwPBiS_0Ghzwp36-8
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11786
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=10 priorityscore=1501 suspectscore=0
 bulkscore=10 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=10
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140216

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD=y paths, use block_write_begin_iocb() in
blkdev_write_begin() to thread the kiocb through so that buffer_head
writeback gets dropbehind support.

CONFIG_BUFFER_HEAD=n paths are handled by the previously added iomap
BIO_COMPLETE_IN_TASK support.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..31b073181d87 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -504,7 +504,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
 			      unsigned len, struct folio **foliop,
 			      void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     blkdev_get_block);
 }
 
 static int blkdev_write_end(const struct kiocb *iocb,
@@ -966,7 +967,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)

-- 
2.39.5


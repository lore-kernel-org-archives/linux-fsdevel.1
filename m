Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEC41F7D4
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207824; cv=none; b=eXV4vdtu+DSjM2/urC2WdFmGzdqYEy1G68taF2r+iVg+Vb4VKfMA6x7hQudkvardj2y+yYZVIWY6c/QhlShvw0rfZi7gQ0dp310prQB6co1LlcG2A0QMzUBhfkhYkz4zCEf/Brn/67hqJbrEtA0PMwnMKVjaK71ziYFe6WqeGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207824; c=relaxed/simple;
	bh=spLOCm9oIGjNLT3/zOuEwP/vu912oCh+c2ZtPG1gx+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrQLXjzyWHIFwQ/UQWwJjKARyXJt2FssGMVChN0x+pdq7nQgyzI5kmRPab8ogcZU6d8rdjVAvEsZDys7YwYMv10Xd16Q/oFhckRxW8O/RuxH52HRhlY9kOHvu31I3pLpiMfE2wI78PPS6XATNuCYqY2gLE5Y6ZWitYtXdKMOdck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=mqzYsTUV; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=SvWAL0ty; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="mqzYsTUV";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="SvWAL0ty"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNChHX2931581
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=LyqV
	U+CLvutgdAtA5rnYnRg4S9pI27Ht0vSVxZHopDI=; b=mqzYsTUVo/ZrCTXqP7Ka
	ACYFjQ/n/6iQyeUtZ5OMBEOR4QYgVR8ovosSXb1p1PaNGl1dPqy+gHVmtBwJWRNW
	o6gTKErA0ayWMTu9/0DADQ2Wf9khQh0eQajX3qCq9cD/1wdkDAa1SxJZ5NNdH0jG
	KBsQ60JSSCFC101vHPcUubxgZgkT5FIfgMewLfdvoQwwRTfUiwIut1OsVvWrOJ1N
	qHg0aoYbX0oyGMhwjAG3eRqm77ybcveEWqq4qWxPql6Sizs66ZOVLYP57zT5GYs9
	CbAqNDxkXfYkB/PstY+ILENwzrMP/BSFq0vjZZRtXx8uTGaLzAZAS6JSNB+5xOSy
	1Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvh6a4h4t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:57:01 -0400 (EDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso1113145a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 16:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207821; x=1790812621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LyqVU+CLvutgdAtA5rnYnRg4S9pI27Ht0vSVxZHopDI=;
        b=SvWAL0tyk+KhugtwWwuKeFgX/qpipyl/zDY/fAV0buCLtskr/zsCFjkhgJsjSNuC/Q
         uJlmQYESqjfEenA6lGH4N27urgOZj7jXd5OgOQH2RHQ6rmcJPumR4EFx0XTQk53cInFF
         6hlPpWcvzw3cH7+5TVuTTPXu2Vr/eJGRGUjjT7lOFJGVLq1m5Zb/EvjhPyo82IUIrd5X
         M2fIN4kC1eLhijXNnY5UK3KllUa/OmxSNHcvn0AM1u41Mac/MEH1szzzTFPqViHsDFK4
         mDgEaJlQGVqYRZ106hJK5TKIlh1hA4kbgyct2el7SfPC9MP4tlIEBaFWnBrIUkT83BXO
         4Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207821; x=1790812621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LyqVU+CLvutgdAtA5rnYnRg4S9pI27Ht0vSVxZHopDI=;
        b=v9QxyP0RZO6Y2D7/4T621pLjA3c0tarTdBzs1I18+yyLLqo/+lZqMMnhIQUmRZDSwI
         W0N0MhLBU/+zDQKs718h1nAbbAhNq8dxiQQNPRlvGgbu+IvHQhTXGut8Bgjp/earanv5
         kU40Q67ypWekUXoMkBVOtPXlhez8AbTsVfsJoQUL/jjFF68IzN/ZjeByLxPncM4HL2NN
         vHK8fDG2byCyWN0UdaVKTvt6yafTcaKPtznp6OEuIew+9yyDNJyP6An7qD7p+7D5/NFg
         rD1SpQWrnPy2wjGasNzDN/Qs3CyEhx9fghFsocWFdvg3iz36Q+W/Dq08qCZBPzBL6ZmC
         2nvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmbOk03Bhbyxk36e+Nu/bGnrkR6g6g8+shf307Eb1PwjkKXV4d6ILKpfVw7/AMmXZOPSxlG3z1yzZfWWs0@vger.kernel.org
X-Gm-Message-State: AFuF++l9Ef0joB4tS6fSxdH4twET5njaFHwJrBiLJ9j39+WTjzGbXCes
	hRypRbvjQ/tM2to3HtvFPdBJzZhqrCVfSWmK2nhX4Lz04vvh+CgdrMuSvotcofXXlgwqlmc1+Yb
	edijEGDDK05o+PZ37zU0XoGGklChjozYXGiEKpeBnJquhQEzm18RaM5IZcH+pQn0=
X-Gm-Gg: AYBFou1eTsUBJC30fZDzF31rlygZPSvcw6cR8On/QJyOSr7tDardaokHYrwlHU8KAWF
	fczI00MvWE9uFysv5ko3cibMrCBQCTGG/5wiwo5TUlMuPD/WaiVqYrx3yjP54m1XqaMVZGYPpuU
	ye8s37/wORD3i1Qj06Pmr64pip720FgWnzG4QIUwz2uvkNI2nRTysM5iEqS8/zHT5F/hrlvYTxX
	JV0eIi9dRGF70lM6eOx6opmrayBIOv1lZWgWIwdeUN3Bdav5t6Vk4tj2hbDBUkh6BKxTIUfLf+f
	1X1OVEs5H0dwqDP68EbTBvyuLtnAyAmQFjIX2CV3zeOG8Aayy8v7Sm9U+/rhSDhUit/WysSS6ZK
	+I6gz68EYcn141XveQMQPx8s9nd9O7MKeo74vYcUdJXypow==
X-Received: by 2002:a17:90b:28d0:b0:39e:6a81:c920 with SMTP id 98e67ed59e1d1-3a098724784mr555255a91.19.1790207820674;
        Wed, 23 Sep 2026 16:57:00 -0700 (PDT)
X-Received: by 2002:a17:90b:28d0:b0:39e:6a81:c920 with SMTP id 98e67ed59e1d1-3a098724784mr555217a91.19.1790207820196;
        Wed, 23 Sep 2026 16:57:00 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:56:59 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:37 -0400
Subject: [PATCH v5 4/9] block: honor IOCB_NOWAIT in the block device
 buffered read path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-4-89e60d66eb38@columbia.edu>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
In-Reply-To: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
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
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=1869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=spLOCm9oIGjNLT3/zOuEwP/vu912oCh+c2ZtPG1gx+E=;
 b=xk+BkWRoenjTdGReG9uXLP9A4qN4gTtvtRRKSU8g5yBN5P/np5trElupUCU8rZS97yuSy0wxd
 xVbV2pMTglADr3gYSLzkvGQ4lNdyhNYMN1Azm5e3AA2NKB4iBqsONT4
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX+45j9ysluSqb
 aJf677WfIYJcmqoKIkLWuUQsxN5xwBf/E7rgUE9GRZpQjzSQGOZh6VqH3UfMhFBoarxUL1TwHKB
 U9gokBl2cou6LZeT0CiOzvFIPW/wV9yVxKjdZbE5qiXqRCzT/uTk
X-Proofpoint-ORIG-GUID: HOiaKTMmsWRVVaVOpQg0gNJxsv8vO5iJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfXyfHUEll29GeZ
 /AcZF9g1bsmwVMr5HAqvg6j49Hffq9H0YyeHy7qK1PQF7rdPWBccecSMZduOUZkz/dw8NfgoleJ
 Xuf0upzk5kYPjGoZQq/pXOd7hfDDfjUNvT5N9nsZyYlnv3xOkhrt1LUnEosHKsojPPyuhnsfeOE
 5ct4ezDw3jN7TGheUKwDdrAXEOR3EGf9ZlQJ/7i2CTmAKXRxTmxHiOu0gfmoDGETT3IQ949lOrr
 37YLrsBKxGUolSkIkTXVOzpAAQDxB+aVppmvvUo2Uz0XgyYoaXGJ9Ah1TqvdRqLoYCg6htSXQLu
 7Exk8bBvwLefkIDVEzEPuPzAcjrtQYzKit1FSKzkjuL30ZGoCuJRmBFfPYPiE+gX/1S3bLaR6bg
 1vd5mO49EEWqfTLd2naq44gWFXPV+ahoWjjPzaxnFgx/F7ZjFdxTWIU+wThsRS+VkMDWxG7s78Q
 RXLC+vlc0A4OsMQpWYA==
X-Authority-Analysis: v=2.4 cv=D6nSufRj c=1 sm=1 tr=0 ts=6ab4674d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=s8mzj7eOnaliLhoSWqYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: HOiaKTMmsWRVVaVOpQg0gNJxsv8vO5iJ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=10 clxscore=1015 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

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
index 652297cd90b4..f61d250e49c8 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -850,7 +850,15 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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


Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017B3B42E5
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564624; cv=none; b=SI0ULuhbSteEvqTwwI7CSpMms1ftvj0G66uaYElQ3i/yQ5XuD44cKxd8DBNs3iouVYcy018I5x2/HKpLrqrZ7OGyxdVbGibExvg1/WmRM3u6xnkZP9s8l8AlTjn/fCPJ5xvJynqzSDlLVzA5WYFUv+HkEKMj8AFKxQ9ReIrgBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564624; c=relaxed/simple;
	bh=dDshcLMc+GbAJE5S53bKt5KKBIFrr+TFSMnkBV9A44Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8ShK0QWB6pHv5bErTPD5RMitBTIhziT4GEPjIIqKZbLHjgFMdxppisjYNmL+JGilP6sT6XxCttuwQXS1toqhA6Oz9092mLPgJsm8qbtpmLfJfFaa6h5Fs/Z//QFnsWq8LKsUWuf04c1YJ4ZggLqWq0ceUbObCMXLGCXHmvL7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=N4SPD5JB; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=USuOXGdV; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="N4SPD5JB";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="USuOXGdV"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GZrZa4092463
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Oct 2026 12:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7+SK
	9Hsocl/1FR69kerT0MC33AS/WWqivFjKplkjQYM=; b=N4SPD5JBASgZ9tnVZZk5
	CLWTKnWhqTMn8911JbdVrEkGhInt2thnlmOSOX5B+5Ib9FgpjM74ujtTY3tMC3f6
	eMpes6Ug9Lga5RuHMvrl0e9RVNOjcw25Qmk+/Mr+U7iqHcvL+MBuK3XvEMwzNAoY
	D8kmHjzaF+7UvIkjOaMg2XFRyWEGHO1UkJmDPa6nPWjqzn2+6SdCKEDNhzfT/wmM
	+MeqMbdep808D0nQvm42ZoqDl9Q9kk3YZULKeet9eo34Fp42OQNxFzsW3WfsuMLK
	fCU3IWSQfnQIqxwvKneTiNN4YF3rakc30QJsJ7XtVROcOs9O8yi8v/JD3EcOA3k7
	+Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4h6qgavh6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 12:50:21 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5350bf63ba3so173583151cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564621; x=1792169421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+SK9Hsocl/1FR69kerT0MC33AS/WWqivFjKplkjQYM=;
        b=USuOXGdVac0YuM77kqmFFfXYminOpuSaifqoP2jPm8nMHYsM9STm9SEMt4FDZN0lgA
         qTj3AmJen9pmEqixi8RYf2r/QZXjxwViqjTzy1X6QlTtf2TrQ5MTaWRb3YGGRadVVIGy
         RjIEh+Y7Jk1zzNbOIJd3+XLXH7opt7236NDmZwGKsdlBRYVuew2/7ROVBvSHAuyfEtj+
         RjnPfnP+YoJ6DHBJh1SHLUhRCVBILu00jcEIz+VuzMMdueAW5tKbPjMNhNehhwj+qg7w
         e+ZSx1lEgrdBJ3T6rjCA9LTYIiZuo4h7vf7VN+wAKXe3fx2P6F2vT8LTACkK4kJ9BiVV
         YXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564621; x=1792169421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+SK9Hsocl/1FR69kerT0MC33AS/WWqivFjKplkjQYM=;
        b=ME0uv4EVWhoK3lxeTTjXZGGlnK9segxi0EYSc+DT4ubLiqUdJAGcbIuZBmd1flyx7p
         c+dOvsM9KNJCkqz9KBZ4baO3wpJVv8sPqfoB1KfBR/+aQ+ZwwVT4Vz7QXLQCoT4RhQBt
         KIuDXyucQCqblg/D7B/K6ucQYRLahLd4fvr2BOAQmf7aCgSJEXLo94TdpZLhSsZ8QFVK
         9NzkkHot9+MqftOTUzde6lDRl4B52rVTiqTWhkd470dyETXJSeomrt0B2ovBJbirQY1F
         vNFMRDBXyIswIGPNi79UBeLYTc0VqyMcn1WPih+gDupKxAPR1YkTNMmV3Vb28SAZ0t4c
         c2aw==
X-Forwarded-Encrypted: i=1; AKwUvBwD/+waSM5rDSgRHWsSJ0/Nu3ejGxZ02u8ciN58Z8b8DFfPcvFQBoKRAV4EsgaocspW/PyaiM11ODrx/hBu@vger.kernel.org
X-Gm-Message-State: AFq9FYKSlWaOqzgEupOVNW3ceRC3OOJ8vRDOwJ3jUn0clcFJzW/PhLOB
	+zkVcKY3kUx5Tb3n9KW4QIfI3X4JM/YP2DSveQmcJ5YhALrdoVRpVqCY6VcvjZ3uB/Z5CKwZEDk
	5CRYGZXumw+dZd6kHuvM3O5x7wT5Z8++AJkZga8G3Mgj7//CYV9W4neal1CGC+Io=
X-Gm-Gg: AYBFou17LoJdcpeMdpv9T2pRgYe24AqrjXUW3nxl1Tk1tZhbKmp+5yWlofTJTYniKIG
	UjQEGCiTgBT3I5uc2xZfJ9Z1Iy1sikZ6Jt9zzjOHoccbAytJ+5nfuaM96Vfq96Ctt3DbWO93Mxl
	G86+XdgxPVkN0nkjciPR2+hKfIPmBCjUNKMiAu4GHQVQr4W/ry/A36joMsRUXVG7fNfuL3qcwJy
	+QjJ4fPVUx0tgMtd0s+1gH3x91FEotzphcI5kLyzHCIFLhGj189QtB+L7c+ZBvPIFsuOddQ4IFL
	7bB1JR61fqhjpdQpTY68EHpAn8p350SjOFfODEmOgvzshJO/d8M5QqR7qMdMTah/CNXrf2hazOV
	dBSeIJarIaDgpL7SlDyWoREby8tEimN+yGa5OyJu7iyOFTiU=
X-Received: by 2002:ac8:5a54:0:b0:530:dc5e:27b3 with SMTP id d75a77b69052e-5359f488e49mr42742841cf.3.1791564620686;
        Fri, 09 Oct 2026 09:50:20 -0700 (PDT)
X-Received: by 2002:ac8:5a54:0:b0:530:dc5e:27b3 with SMTP id d75a77b69052e-5359f488e49mr42742391cf.3.1791564620048;
        Fri, 09 Oct 2026 09:50:20 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:19 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:10 -0400
Subject: [PATCH v6 2/9] block: take i_rwsem for the direct I/O write
 fallback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-2-307939c387df@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=4956;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dDshcLMc+GbAJE5S53bKt5KKBIFrr+TFSMnkBV9A44Y=;
 b=7iAc8SSFEcROQAmY5eXrAlCLPwKvbAPfKwfIahwUaDAk1njSzpupgTlu/IHHM9pwn2aub7CuC
 ZJMB1CHuFXcCNvsMzOHNMWqYeOxvlit2uqZEyHjSzPx2pzu/55NgWVA
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX2H5BY2MUps7v
 YBTKdHEKFZA+gY4wrzJGDmASwggvSzGS5cLMjxvYuQzHjhvNSVQBc1hcbWmAFyoOcVN13JlAHf4
 K7x5o/ikIprwiVCvwc2Qvx8seduoPYLnoYOfI2/ou1t3aRPFdSJQ
X-Authority-Analysis: v=2.4 cv=WLHqzXsR c=1 sm=1 tr=0 ts=6ac91b4d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8
 a=hYhY-2XO39JmFoxvHv4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: LWOh_cPxrPHHffxXghfqP1jO2vm0Yu8A
X-Proofpoint-ORIG-GUID: LWOh_cPxrPHHffxXghfqP1jO2vm0Yu8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX3kQmMPRLHdwT
 oqbtminvrgI1Hh41ihZAJ1pVE7fV2l0hpv5ACJTKUap2pM7Aw+Ul4COvV8xCNcR+ADUTqeWbDry
 IIREulqlJ6wLKXe3ztiKiqtliOMZ0tQV6jRowk1f/gCIrSXOgrZkRxtJ/ipyrXQfg0vh6pzUs9x
 5Dy8ME3pADcjMz4FsdIhN9Q2fEnrZ8vjqYFhpJxPcBzquAFbviWzNe6yC2S5ApUfMiiEvQ9eSx6
 YEywyvKMvI3rwzlC02zUchvbX2r+u/yNcD8ayLbPFYDQRAg6wxI1U4C64tsUKhDmHrarXtDa9+4
 v0/pTmXmQNQ9J1o8djzWaKi529DaHEaUB6coq9Wxa8o0jvatRPgEl3lCSuZqETiIA3JDv1HzDj/
 bin5PX+fXEXLF/9XfZqL2oPFWR0w0AYw1AfF+nmKCkC07g+lXXwzFuviBj6DVWyeEB/VniCuhNJ
 TfjyHdCtVOncejxJ3zA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=10
 lowpriorityscore=10 priorityscore=1501 impostorscore=10 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

Commit c0e473a0d226 ("block: fix race between set_blocksize and read
paths") closed a race between set_blocksize() and block device I/O: with
large sector size support, set_blocksize() can change i_blkbits and the
mapping's minimum folio order while a concurrent reader still holds a
folio of the old, smaller order, leading to crashes. In particular, it
made blkdev_write_iter() wrap buffered writes in inode_lock_shared().

However, the direct I/O fallback path was missed in that conversion.
blkdev_write_iter() passes blkdev_buffered_write() as an argument to
direct_write_fallback() with no lock held. A direct write that completes
only partially then finishes as a buffered write with no protection.

This can cause a BUG by racing partial direct writes against
ioctl(BLKBSZSET). Writer threads issue O_DIRECT pwritev() with a
two-segment iovec whose second segment is an unreadable PROT_NONE
mapping. The direct path then writes the first segment, fails to pin the
second, and returns short, entering the fallback. A second thread keeps
toggling the second segment's protection so that some fallbacks get past
fault_in_iov_iter_readable() and reach the page cache, a third thread
populates the page cache with folios of the current block size via
pread() and readahead(), and a fourth thread toggles the block size
between 512 bytes and 64K with BLKBSZSET. The minimum folio order only
moves with block sizes above PAGE_SIZE, i.e. with
CONFIG_TRANSPARENT_HUGEPAGE raising BLK_MAX_BLOCK_SIZE to 64K.

On a CONFIG_DEBUG_VM kernel this yields the following BUG:

  page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
  kernel BUG at mm/filemap.c:858!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:__filemap_add_folio+0x860/0x8d0
  Call Trace:
   filemap_add_folio+0xc9/0x1f0
   __filemap_get_folio_mpol+0x240/0x660
   iomap_write_begin+0xa87/0xd70
   iomap_file_buffered_write+0x304/0x6a0
   blkdev_write_iter+0x255/0x510
   do_iter_readv_writev+0x23d/0x3c0
   vfs_writev+0x211/0x7d0
   do_pwritev+0x121/0x190
   do_syscall_64+0x121/0x630
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

The same workload also trips WARN_ON_ONCE(pos >= folio_pos(folio) +
fsize) in iomap_trim_folio_range().

Fix this by calling blkdev_buffered_write() in the fallback path under
inode_lock_shared(), matching the plain buffered-write branch. With the
fix the same workload runs clean.

A short IOCB_NOWAIT direct write reaches the same fallback. Taking
i_rwsem there can now block behind set_blocksize(), and the fallback
already blocks on writeback of the data it copied in
direct_write_fallback(). blkdev_write_iter() already rejects a purely
buffered IOCB_NOWAIT write with -EOPNOTSUPP, so do not enter the
fallback for IOCB_NOWAIT at all: return the bytes the direct path
already wrote, or -EAGAIN if none, and let the caller retry.

The reproducer used was written by an LLM, and is available at [1].

[1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74

Fixes: 3c20917120ce ("block/bdev: enable large folio support for large logical block sizes")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 5a559fcfadf9..52ebf5bd1443 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -782,9 +782,28 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
 		if (ret >= 0 && iov_iter_count(from)) {
-			ret = direct_write_fallback(iocb, from, ret,
-					blkdev_buffered_write(iocb, from));
-			need_sync = true;
+			if (iocb->ki_flags & IOCB_NOWAIT) {
+				/*
+				 * The buffered fallback blocks on i_rwsem and
+				 * on writeback of the data it copied: return
+				 * the short direct write instead and let the
+				 * caller retry. The bytes already written
+				 * still need a flush if REQ_FUA was not set.
+				 */
+				if (!ret)
+					ret = -EAGAIN;
+				else if (!blkdev_dio_fua(iocb, bdev))
+					need_sync = true;
+			} else {
+				ssize_t ret2;
+
+				inode_lock_shared(bd_inode);
+				ret2 = blkdev_buffered_write(iocb, from);
+				inode_unlock_shared(bd_inode);
+				ret = direct_write_fallback(iocb, from, ret,
+							    ret2);
+				need_sync = true;
+			}
 		} else if (ret > 0 && !blkdev_dio_fua(iocb, bdev)) {
 			/*
 			 * The device does not support FUA, so REQ_FUA was not

-- 
2.39.5


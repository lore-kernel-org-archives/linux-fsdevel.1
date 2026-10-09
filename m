Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2449946D559
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564633; cv=none; b=Ahu9veC6BHTufIYtZJ6t4k4eIp8/FQ8GCr8J7D61227Rbrqbw8NB0XxA4ckG0JtjBvLAmcbWAs97qyLEKXhkkUEbDxGiW35LzghNcaJRdaD0vYBbdnNKrFbji+psm3XTN5VTTbf6tteBJnBb+Y6hCOMxpgJ4PCHifhe9AnzayHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564633; c=relaxed/simple;
	bh=TjEmrIwoDfGD/tJl+VVnQl6XHOIQk68grd/DlzMzZsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JeQobDUPk5gaiNkzFk/CNa8f7hYW88+glvrRMNejQbQzlP/Y6cm6aaHCaPq5QqfUZFsovwVoOAZIYr/ub/WE0rj1FooIucsu3a7TZNp/4hhL3AgCVJXpFflwyAxYEQOro2jVvtE3zLziiMdaNLFvG4N5lpIGa8PKr8nGfg5+yHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=KjFOJMlh; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CGM4Tlkx; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="KjFOJMlh";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CGM4Tlkx"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYH2K683664
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Oct 2026 12:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=YGcz
	I1vSHasliXD66Zjo2T9yKyc6ElYvYCgnRIuVKQY=; b=KjFOJMlhN1+3lGbf0LpR
	No0/4aMtdq6WbA9PKdTRS6CMrn4lWqPrvC1gWTjcPwgDef0/tKi+mSIaD2u6FKBk
	T77LqQcgz4L4VAoTaN+/A5QzTj9LiSAhoPFNAqfc20Rl17rRJKt/UzSkJOkpCBCx
	EMza0toduGjnEt+5u2FLIf8zuRmUgBaziKPWyIKnb9uuFmV0UavqGGtwnnqJyrOm
	DVyAzCGblDPduVqjQNzmnyhIIo+t/F33HJtPdv9ifFMzW+tLcEiJJQvMUsK4XQXw
	vIRGcd9Ka/4v+2JBYuc7nEOS68OxSRaQ/B3XzVOE0Vfo82ov9jp7HmcNOYpnDXoF
	4w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6wpyusqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 12:50:30 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5338c59f90dso44084781cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564630; x=1792169430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGczI1vSHasliXD66Zjo2T9yKyc6ElYvYCgnRIuVKQY=;
        b=CGM4Tlkx2j9os9joEuyGTQXgvVrYq+mU6PiOkIAOWt/YTk4w9amjaoUHmFj6TC2zlP
         ohYem+p7w1Ju3WJoAUPjZAcijzgRAQiLez0//kOwBFKd8gISJAfons9PWlt8o+qPYFYa
         Fi+5UyW30YQZi0qMEEaQeoaMyG/eZ+pBAT6JZL1LP646c7rmNSAu+VOOZ4/8TbUvX9VL
         l4ByKCTO5JFbwglm0eqgsXfpa3FWYhMPdQE3AgnHyIp7A0/tt5n+Qt475Es9MLgUfTHD
         F/tHpIIWotmK+/UteUhL8qw9UmPfkNt9CiXye0+kjaZt06zYmLVHlQDs9yNni0ghjK2g
         m4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564630; x=1792169430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGczI1vSHasliXD66Zjo2T9yKyc6ElYvYCgnRIuVKQY=;
        b=uKk9/Td0O5J8d+gG/ueBRGx4xfbQou9BPu0HJH60Jb2gpnmlIYLksdSQExtL5Bfobm
         2STzWeSy/CbpVd6oz7jCbkaFH9GAMja/3sGHDs/aBpcGCKWKMoZNV86Qvfuht1OElit1
         d4zt2/B5vqBLAq75/el9djB2JBh4s8eRiupXT3U3j16VzYIDN4gaOnGmaHdjfkE7D2Qw
         i/Ng6oUqSD7RquvzBG3ULh2U7oF1MD0d5spiQuIYAr5Fo1pt7bcKWFMNuSLU1f/tsexz
         hEVmu82aR1MfwNAa2VFKV64j608CoMNJKjV4nd9F4VD5z4qCznODszFOha8Z+Eq8p9Jq
         n1zQ==
X-Forwarded-Encrypted: i=1; AKwUvByeEWDdFflcwgdWS9J0ezjNWQumE9OA6GHS38pp61/MRNR7Ix4Mz+URAbMg/Dfc3zuTLNqxh7ASjet6JSbr@vger.kernel.org
X-Gm-Message-State: AFuF++mC/H9H+j1NIrTnj9erfNBn6C2Elzra0PQlMeejxVrwUEc+30F2
	H0KYcvALTYiqmkhD1h6u5PkJp7P6QetgElGLO3nXTg3D5UodxeyxT93CX+wswETvc8iw2ExWjBE
	tDTVDEHAV6h9TM95lJU7TyQHMw48JCCc5dfa9PgbCQUkICBEPSENQVJeh/OrA2KQ=
X-Gm-Gg: AYBFou1AaXba+s6pd7KPBGkrGfrvPenM7BuZCBRIXQ/W/hzQgyD/XWC8ljoBokRT9o4
	QN8kkFiAl1CVUIo79o3wMLsmRbWY0jjIHdgrOFmMNF8N7AxQYs09p0YR84606n5lV3CCTaZZu+x
	6P8hagi5QKh/PjlhkdCO6G/R9JBLeGL4Odyk7pr7ilbfXKUb261GEOPznQChdUJOQQzGsPuDu8O
	KdAF02s5ZSpEVcIIcr6UkZdzPPj0f5jA6WfRKvBCpGkvRliijQ0NPCut6nzxyDIxHKaA7WP+Gy2
	WSr6fZVw6BLJltMO6TlV+WdM5UA6atD2AVdl7e+9UjlFn0hjMqN1raaq47gx7SziQyY2aKTDkCj
	t2QIwo0yMapQrsR9vGP21YdfsrFggTDrnN6ovcMN+Sk4QLOU=
X-Received: by 2002:a05:622a:1b03:b0:533:3274:60c with SMTP id d75a77b69052e-5359dd26620mr40806171cf.29.1791564630471;
        Fri, 09 Oct 2026 09:50:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1b03:b0:533:3274:60c with SMTP id d75a77b69052e-5359dd26620mr40805501cf.29.1791564629868;
        Fri, 09 Oct 2026 09:50:29 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:29 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:17 -0400
Subject: [PATCH v6 9/9] block: remove dead metadata handling from the async
 direct I/O path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-9-307939c387df@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=1396;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=TjEmrIwoDfGD/tJl+VVnQl6XHOIQk68grd/DlzMzZsM=;
 b=kyR/6+0uUpySOm5+kLC7PnMLFfMvdbxJB3gn4ywQjE3A653IQAONvgDLa5uwCFOb8cb81Gxki
 mgjkL5Zh7XwBFha5mPhJAYuM10mgmerANhTN+Si/GE2JLVdD1jnvnyH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfXwTLpV1DPrHpm
 q88hs0imerrEBdzb3IeJmIoQ+A49UFf4+Pt+e8D8gBxkzHuCWSAxJ8OKb7ZZKd3G5DEQlrHM5y3
 PxUf5+1xBVU6RoP3BCILifaaXxDKv3x+3JjY0XQbrwAsaLFyT0uG
X-Authority-Analysis: v=2.4 cv=a42lZkSF c=1 sm=1 tr=0 ts=6ac91b57 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=-GSYpVTsbc7fiOcD5ogA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: Jp3Sqet7yXBWb1ihNmVH6WgdHYgiPREK
X-Proofpoint-GUID: Jp3Sqet7yXBWb1ihNmVH6WgdHYgiPREK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfXzPnWM7d3499e
 CAQP0IDPwNwONqyOhTS2v1LGqwi1HPamQDzQzyuXjDeDVl+0KMwh2aFG6o9Ak8NL35yd0CPikc8
 GPk6yFqye6IarNDJkqG52lBC531CLb53i2P+uBpro23u9jiKOtxAonQvXlS2QH2SGdrPcFZi4rZ
 Ts0o2OXa9jxfk0IEAcG/Z/O7yqwhTiw1YVnQqVUkWwQb5B1iecze2jFTIrdp+GsezBGUjGOCOnf
 YI8fComP1nn5gHJ5EpmCv3+JXFLypYGXzaljdURymphvB8ofOcZnqQBT1roHsxcPSf2wNGdWblv
 Ez6Ggx13ggxCxQAXDQ2Aj5Z9tzZfC/4q7K94HehkoOBwXIuZJAXjV5M7jMWJcnppfAcUpQEtSMQ
 aSRcVrwFn8yhJz99aFNEX9pHIiutAHSNqyXGJdau8V3G7463VHtBcGrV8v0z6Jsv/27U2xGj0ph
 cTu7zOKBBpR52jD2r2g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=10 impostorscore=10 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090067

Since commit 2729a60bbfb9 ("block: don't silently ignore metadata for
sync read/write"), blkdev_direct_IO() sends every IOCB_HAS_METADATA
request to __blkdev_direct_IO(). Remove the now unreachable metadata
mapping in __blkdev_direct_IO_async() and the unmap in its completion
handler.

No functional change.

Assisted-by: Claude:claude-fable-5
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 41fa0c663f77..f3ff4e62413b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -321,9 +321,6 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 		ret = blk_status_to_errno(bio->bi_status);
 	}
 
-	if (bio_integrity(bio))
-		bio_integrity_unmap_user(bio);
-
 	iocb->ki_complete(iocb, ret);
 
 	if (dio->flags & DIO_SHOULD_DIRTY) {
@@ -385,13 +382,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_HAS_METADATA) {
-		ret = bio_integrity_map_iter(bio, iocb->private);
-		WRITE_ONCE(iocb->private, NULL);
-		if (unlikely(ret))
-			goto out_bio_put;
-	}
-
 	if (iocb->ki_flags & IOCB_HIPRI) {
 		bio->bi_opf |= REQ_POLLED;
 		submit_bio(bio);

-- 
2.39.5


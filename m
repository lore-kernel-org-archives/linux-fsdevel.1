Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C03A8FE1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564623; cv=none; b=Xkq1Yhlb/eBX4W57UFlWwK5DQX9+UuVvqusBm9TlL1K1Q79/Rgnn4t3MAYDOeuLbEy5S7Aow2b536TQAPcfKl4BXdb9UTq2Dp+NXxOg6eM0NreAfWuZPI5IBPPXzlsgC+aV+r5JvI3C8j4MdK37Bf3ws684Y1rgiy2s5Fq5Ox6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564623; c=relaxed/simple;
	bh=QWCjvSArrnPRtD+0j04CDKUtmIxaPixLlth1E/uEyZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L8Famqv41gz0dnRQJALF/hFGR8jsTH2B2dk1e4oqjHJ385r+nsN7a+NzPEVAGEjBuAVzGurPF5VBBZRYbs++WSgtajtXHRXqu4mGoYuYRMcBAnrmL4zLJ2cch4UR7n62HtJp2U7qt7ItLJTKVtk7sRU6JzvuvVdGqYvUumhMhwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=OY9if/AI; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=4GULel6z; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="OY9if/AI";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="4GULel6z"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYIEX304291
	for <linux-fsdevel@vger.kernel.org>; Fri, 9 Oct 2026 12:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=l3JT
	rRt39SQipVSWvndi+FFbNSesn5q0JN18E/yrYeM=; b=OY9if/AIK6inCYoKOLPD
	UxP8kNZRCLIQfjKOH43P7bhel6CPP2ogbwArZ2HY8eoZGdjFAscN8I2fZJvEisMw
	ujJUe3L7FXpqNFbqDYRdWYk0gC9g91HgXjxtkSvXDoV+HhBVzojBa7P/KVjIgAFo
	MsnSO082PG9f/tpcsaPHQMkzqn0HxjWlH1Prue7ZXoyX8CYdgAJoQLqUgS4+Yddj
	htY7DzcRcW/1w492J/yQRJ8qiwXvvz/9TD8LHqLE3pQ8jcTgTOxnleL8v7QKA0Nk
	o7ZTaDYgFkrbuBZSx0wCVJ/ykDJS7h01v4uzWIOQYYFoXiA60k729nUJU8zkJnKj
	Cg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6y3guexp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 12:50:20 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5350ec54bf6so123725011cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564620; x=1792169420; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l3JTrRt39SQipVSWvndi+FFbNSesn5q0JN18E/yrYeM=;
        b=4GULel6zbKLdY+HeYJQjSr22UXc1Ivb3dJfZVvbOhAMR7VCiGt7lxlLtGj88AAXj/2
         IUTDvXTxOQa4wt+TD8wfNx/TRKeQnRQB0PS5kOrrzWZanyekE4GhVce212Wg1dZe5W57
         UC5I6EHC19/+aITDXb2Ab8Fe8PWR4yHjy5c9czhQnpM31yczL+/LAUD3+SwumiocgfKY
         pyDy/dLuVOm58PDDRyjpds02MKyxPwX9q184kZ4YEBhjtwZ6GBqRHklRvEQOjS01u2Xt
         oOc6E1I9yJLo0VT3gCnFNfdpSOnIbT/avVcxlK5dOLxv0iMsqcYi1FWLfRT1LIlbbIPW
         yWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564620; x=1792169420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3JTrRt39SQipVSWvndi+FFbNSesn5q0JN18E/yrYeM=;
        b=eeFqUb6XVWMjMWZ1I/p1DHE3kWbs5gLo//UmApi6l4jsAWhBzs2ob4hdNN7lmvtmnZ
         0u/c/J7tfHWW3LXGVbkg6kTWYAXFk8Tx71zKO+0JINXe+mqR98Hg/mXcz6dz/Oe0qFGT
         41hf+8q0rh6spa1bIlqtj0kDAhj7RkT8MgHOC9Q2uNNZkZes8B/50Pu8Gwz4WOQWaZ66
         lNtJmHnXaJP6ri5UGaRD+CYe0BArE97QcJL8hEQ20Ag8aTyg6ddrKx8Kza9r75EDYFNr
         1MkH4wKv0INfdbNu4b8iEvYZEcXgWqMvRnWd5NZ4kF7nxxdGa55nd112sz1+FBQ3fcCV
         48Hg==
X-Forwarded-Encrypted: i=1; AKwUvBzfD0RDQxO9XSO0h48g/Gpc9zbwYGPHZff3KWN+8rbXziy+c+5KtZv6vwdmKZxWJXsAPztDjHyTps9w/XYL@vger.kernel.org
X-Gm-Message-State: AFuF++nGwbBJUdOlSakCQb1+H23D2ZtmjEwnJwJsB22OLTJp0J7h1gtR
	vfv+Yat+dr1iQj/GSZxo3HD4U8vb5PtClLwrEPEJfnN3KUxSnvbwwAroK52Jn5ALLYvaPqYQ7gL
	e8w5quxZIrwHbibWCypmhbEW5BFhcRvLSLdHzaGCWJd64c63d/rxPOs0bABUOdXg=
X-Gm-Gg: AYBFou2zIt2+GQWobg2eBWDN66fiUo7jH5d6q4Sl4Tui6X5hrHmSjPPidbD/ycC0n5o
	2c0u+cGQ9Iyf+cShKvyGpwzAD/iHLwnVmUgNlfJWtEk4ZsVsAQntuUBwgBS8fMe1IR6krcbGOuH
	hXq67ezFRsK4caqDJN84Mx5WF8zgJFaJddkkKSCC9H3SNnuWA8/dy0yOmM71TAjV+THYEg4TzxH
	Pz5awjr0Nv2BfW2qgtYt4wYziEZlWTjQWz1LAlS2ZxqDx6F6pgF+Kg0dxfH3m6y1/rp6PUUhzsr
	Slmq2WsEDkz8ajDScLOq9CcljLFQ/ctVrRUnOchOS+Q1CpxXSZmJ1I+Dzs5G9JaDv4SAG/ieMu4
	TYbXuZiqoJDhykg5EdJlVlJuhCufAV4yj6vlTNDJlICW/RN0=
X-Received: by 2002:a05:622a:4005:b0:535:1463:ec27 with SMTP id d75a77b69052e-5359fb5a42emr38189891cf.48.1791564619461;
        Fri, 09 Oct 2026 09:50:19 -0700 (PDT)
X-Received: by 2002:a05:622a:4005:b0:535:1463:ec27 with SMTP id d75a77b69052e-5359fb5a42emr38189271cf.48.1791564618838;
        Fri, 09 Oct 2026 09:50:18 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:18 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:09 -0400
Subject: [PATCH v6 1/9] block: use iomap_dirty_folio for block devices
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-1-307939c387df@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=2128;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=QWCjvSArrnPRtD+0j04CDKUtmIxaPixLlth1E/uEyZQ=;
 b=qMLmvZeuSixOMS38x6EmKAp4mC0Z6ytGiXLIW869jZX/sxWmXGZmFtbD16FIcyMxeAhASjd36
 cYbRlGpBwoXDkw8TKIZpbqkBpJXceSkdRkCWwmS9nmmdt9xDp92Ohvj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX/PArCK4EoBK5
 8rq31sUaX85VCoW2pdw90pebsCmPT9IXFDeifnkoGsHtbmxw4/I62UqDlFxHwA1hJ5KSpTJxVnA
 LGIaApTiPr9prYiWTZBzeMMGcb7ZQSjP6JEdW1U1tK1n4xTWcKkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfXxpw6zThl5HwI
 ToZrx10r49PXsWB3iEbrgaIv6yuC/7JnZIStADK6PHgYFJuSjHwfo8QlQ7Ky41kOdtjD6BTWyMb
 rUi0VwpBno3co/8NMq8kwUrPOMB+OGat9La2UD2Uv1rDqLL5u2L08TxV8R6qiygVZoYF6kE9yrN
 VbzlLnMQwE88lej737jpR2zoCF3o6iee9evAEjKtNb3uXJzUuMw9Ky+xJb99twH+RpWgoXNuwNN
 XiN8F1T8u9larHRLZ6SnoJFqunN64jWdShDoMsMoNIgAcnf1k/rCWFFLQYhzN3UB4XtWSGgQcAK
 3VPC9aD/snpqyDcHwOd7aSj3GhaU+Tl4Gxe2I1SCdMcVh/Ij8IoVrULb6ZhQiAxb2l6ubpSdECg
 mTGxiwVWuncWuK38fpIMt6BBfXoDTnF7jDq8WZAG85SAsoXuR10S13KJ2zi062l5yt3O/BWYpqV
 QzAsOcPCRVqq7NSOCDg==
X-Proofpoint-GUID: oAmedlRmNkFav6-vRewo_A2nUR0aYFBO
X-Proofpoint-ORIG-GUID: oAmedlRmNkFav6-vRewo_A2nUR0aYFBO
X-Authority-Analysis: v=2.4 cv=bovZl0ai c=1 sm=1 tr=0 ts=6ac91b4c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=lHyHCDWJ2e6pF_oXpYUA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=10 priorityscore=1501 phishscore=0
 lowpriorityscore=10 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

With CONFIG_BUFFER_HEAD=n, block devices are written back through iomap,
but def_blk_aops uses filemap_dirty_folio, which only sets PG_dirty. It
does not set the per-block dirty bits in the folio's iomap_folio_state,
so iomap_writeback_folio() finds no dirty range, submits no I/O and
clears PG_dirty, resulting in data loss.

Other iomap users set .dirty_folio to iomap_dirty_folio, which marks the
folio's blocks dirty before calling filemap_dirty_folio().

This is only observable with block size < folio size. With a single
block there is no iomap_folio_state to get out of sync and
iomap_writeback_folio() marks the whole folio dirty itself. For a
page-aligned device, this may require using the BLKBSZSET ioctl to set
the block size, which requires CAP_SYS_ADMIN. A device whose size is not
page aligned already gets a sub-page block size from
set_init_blocksize(), so no ioctl and no privilege is needed.

To reproduce, on a device with a sub-page block size, write a known
pattern with O_DIRECT, mmap the same range, store to it, msync() and
fsync(), then read it back with O_DIRECT. A reproducer is available at
[1].

[1] https://gist.github.com/tzussman/18ab05cba4b3fdc79cce0a69d1fd05b4

Fixes: 925c86a19bac ("fs: add CONFIG_BUFFER_HEAD")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index b917bc0f6b44..5a559fcfadf9 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -575,7 +575,7 @@ static int blkdev_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations def_blk_aops = {
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.read_folio		= blkdev_read_folio,

-- 
2.39.5


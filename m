Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E236DA00;
	Wed,  7 Oct 2026 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791386465; cv=none; b=ZJAm3mCRhlt2p6eh9FhtwQAQgG6I8f6bvsTZ9209xEaQlmVu0XEPMocOgVDsKHYipSINm19CYjCWjrh1DxBh65cjoMWIEdqVyRu4lM7YUYMZePqgwzadWEpoCJ46k5oal7lkH+zqOVeH80Wh6Ek0N0t4/tsrwjCk/Tlo+MhmwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791386465; c=relaxed/simple;
	bh=YSU1Uc170I97wLgJWpNPEAiiib4C3pRfYBrt4nhlIDs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E9zSosvG8y8UrSmJiIeQ5ub+72VZ7+mnS+95JxtywsyYUQ6VsM3EwIXgf4gQGdoTQY2A+gaFO2Yxgbh/Y4ubFmEBtyxpPe2Xg2xUR54vUvEhaKkHeAC4U4dvxbrR2so+7pae/WSZDkByOt5GknW9fxKupaHLyqKVlBnjLvm9d3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rNjH85Vq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rNjH85Vq"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697DgPDZ2535153;
	Wed, 7 Oct 2026 15:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=J15Krwr7PkrCpA/3UAS4pe+iany4n
	qK7HeytUNSeMIA=; b=rNjH85Vq9Xm8KTs3tZHdyr6zvXsG/QyTTH5FeSNSfBziZ
	GOHyxCfV6gAuPHii05QidflYJWETQF5YW866HrqJbUq5vMX9sXXBj9bTE1BIKG7e
	xJMR/VA/bocQYCtcx4FVNjlQ8S6GfVAtg7O9m75xYqQ+QDQTA4IruYrOYUNrpeNj
	UeHpJU14ftxYlIbivj6xHgmUuxbyDRhmypeEpfyVDJvKXlIIGIGo+tj/Q3KVnaGK
	UXKoK+3rFIFy8kMA7eVWhzVjf6BxnyzFvYAi1N1sWoB/e1EQaqgqaggJ3vyXD6ES
	Cb3DxeWWtw6KQB0QDmb1D4+HP316Qw0ymSsMxWLRw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2sas67yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Oct 2026 15:20:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 697F6bTO024445;
	Wed, 7 Oct 2026 15:20:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h4d103vsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Oct 2026 15:20:53 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 697FDs08008268;
	Wed, 7 Oct 2026 15:20:52 GMT
Received: from pssatapa-ol8-test.osdevelopmeniad.oraclevcn.com (pssatapa-ol8-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4h4d103vr8-1;
	Wed, 07 Oct 2026 15:20:52 +0000 (GMT)
From: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
To: partha.satapathy@oracle.com, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] fsnotify: Check parent watches without child dentry flags
Date: Wed,  7 Oct 2026 15:20:50 +0000
Message-ID: <cover.1791373689.git.partha.satapathy@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=724 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610070060
X-Proofpoint-ORIG-GUID: eXKYfmbapFQXet04xJq3p9XiTAVSo0Pm
X-Authority-Analysis: v=2.4 cv=RIMmjIi+ c=1 sm=1 tr=0 ts=6ac66356 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=z1f5pVNkmC7sb7IGOIAA:9
X-Proofpoint-GUID: eXKYfmbapFQXet04xJq3p9XiTAVSo0Pm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA2MSBTYWx0ZWRfX81djbxAz411K
 KEnQ4FsEZMmPhRCQJOCBZXH8FskqXGXqKiYw85oH+YmoBhyvkl3F97oJJk0bVHHYkVO5+jJfKm+
 /H4sK6YiefR0gTu7YMlX5kIsr3KwBIw4fFkQ+viMO7EVIpCMxhdK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA2MSBTYWx0ZWRfX/bhxYP+KHZpT
 W1KJr+WONwk/j4DPMKwoas6uec/VxXPXUAwr4G8wRobLV6wOGNG8LNZJ/sEeobOG5KRy8GbegdW
 D9KkwpNw31RNTFHXoAAiUftsLK77wGwKdHfe8nvbtN3rvXJ+B232BuAB813bRrpFJwi4zZ5d6A9
 zEjw1tsM6cPNuRbPyi0lp36nP2v+yS4mRBBoo7LZH8jcPsuNQJzuxPdIta72k+mXD5BFdmug+UU
 AP4SUrD7MAN+ShqOVdEoogRh0scpTrZ3gbAJFTQnN10NwvbPZp8AOHgujVJv5kjtiZe54p2rfE5
 skfRaIssgxB18ZqMPWzT08uTWcx3xNXzeLp8oKQzcWiOi3Tq2WjVWYIczfBIzItWXTK1VAUVcoB
 +5m0mK5KrEHjGWlqEXRYzzKO9t+BGmfHeIiOpiG+hHaiFxOb+h4wlyg4VU/+XEL6koAJcMB5Tde
 vUtLTvR2ZkE9fyUUNBg==

This patch removes the cached-child dentry walk performed when a directory
first starts watching child events. Instead, the event path takes a reference
to the parent dentry and checks its child-watch mask. It also removes the
DCACHE_FSNOTIFY_PARENT_WATCHED flag and its update sites.

On the test host, 12 million files were populated and their positive dentries
were warmed before each run. With eight concurrent unlink/recreate workers
and 100 sole-watch add/close cycles, inotify_add_watch() measured:

                         Before                After
  run 1 average           107.420 ms            0.004 ms
  run 2 average           125.433 ms            0.004 ms
  run 1 maximum           122.811 ms            0.113 ms
  run 2 maximum           141.198 ms            0.095 ms

The displayed 0.004 ms averages are rounded to three decimal places.
Maximum unlink/recreate latency was 777.852 and 770.569 ms before, versus
8.525 and 15.624 ms after. Those mutation maxima are supporting observations:
workers ran only during the watch-add loops, so the pre-change and post-change
mutation measurement windows had very different lengths.

One 100,000-iteration, single-worker open/close event-path run per mode gave:

                         Before                After
  none:   p50/p99 ns      9564 / 15703          9684 / 15023
          throughput      102221 ops/s          101432 ops/s
  other:  p50/p99 ns      9554 / 15573          9684 / 14962
          throughput       99442 ops/s          101497 ops/s
  parent: p50/p99 ns     12529 / 19179         12499 / 17716
          throughput       78196 ops/s           78655 ops/s

The 'other' mode watches a different directory on the same filesystem, so it
exercises the superblock watcher path without target-file event delivery.
These are single runs; they do not establish a small event-path cost or its
absence. No open/close regression is apparent at this measurement resolution.
The test used worker CPU 2 and listener CPU 4 on kernels
6.19.0-rc8.V_fsn0.el9.omm0.x86_64 and 6.19.0-rc8.fsn3.el9.omm3.x86_64,
respectively. The test host reported XFS for its working directory.

The inotify correctness test and broader fsnotify functional test passed on
both kernels. The fanotify permission subtest skipped with EPERM in both runs,
so FAN_OPEN_PERM remains unvalidated by these results.

Partha Sarathi Satapathy (1):
  fsnotify: Check parent watches without child dentry flags

 fs/dcache.c                      |  4 --
 fs/notify/fsnotify.c             | 99 ++++++++------------------------
 fs/notify/fsnotify.h             |  6 --
 fs/notify/mark.c                 | 35 -----------
 include/linux/dcache.h           |  1 -
 include/linux/fsnotify.h         |  7 +--
 include/linux/fsnotify_backend.h | 29 ++--------
 7 files changed, 29 insertions(+), 152 deletions(-)

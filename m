Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76E3E0081;
	Fri,  3 Jul 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091324; cv=none; b=SiBB20Y3PM2UEhHNpADjhypcYfdN7zTz2L/A025w+gMJNI0wAgn6+KvFbt00HxQJpgnYiHVINAVYOCCrBKSFxauAyZ3sCckBIB/pJHyvysu2f60i5zaSPc0Tgm0rC+4or1yjUIgBEagMSFFanT1lpbL0sO1FdvFvdLJkA4tsgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091324; c=relaxed/simple;
	bh=EatkHwGiINJvh8y+G+TYGlWEAfX3X9SjxnXDjq5DWGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxMFwMI/7BxrBVW48SOO6Q9yMj/WzrYBgdzHYrTUOcO48iLtfXX7UnvcqgRZAGGCIHaO3Ajnqr9ObG6JaxXlWegPz9aWGe4dU8wm9g7OcUJ9mKByxbROzVzNWoWvx0PqzXplu4wCZmEzsR2JM8J+X54L4d0hLT0ZyiGo2oajAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W+yNG8Yo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W+yNG8Yo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636J59R1814320;
	Fri, 3 Jul 2026 15:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=m9vBeFOx9VmUPzIweBpa39fiiZs7qpA2wGQJ2FLtW
	OE=; b=W+yNG8YotbVqaqa1TggKGTNBl1CS8AIVvfrXir1pQhYuFonn/FqKAXk59
	E36UOumbwaZSQGYAk4xRATRcDSoGvrqHKJb60AyA1FFOX3iMVnGhNdYcSxTD48SJ
	mzsM9FlDnt4jmqx3/OXEqDzhhDY3KBtrzDuSRVszG1NMm1wml8m4GBEsyXtyJMOQ
	nCcw87Pj0PuT+x+AIY245AEh1muAj3d5S11oBaTdZd/H/pOopQpFYrepZuZ+8Hvd
	2pAB4+uIzU+Nl25//xqgTJaer0pAEVlvz/doh2XVlygEiuyEtxpiNTe1IgkS3REA
	dFG+r4gaWJmyAONBxFn2pBHHxdC6g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qafe91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 15:08:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663F4a5o023728;
	Fri, 3 Jul 2026 15:08:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhys5ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 15:08:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 663F8PON50528762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 15:08:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 388B020043;
	Fri,  3 Jul 2026 15:08:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3017220040;
	Fri,  3 Jul 2026 15:08:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.216])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 15:08:20 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: shuah@kernel.org
Cc: wenyang.linux@foxmail.com, akpm@linux-foundation.org, jlayton@kernel.org,
        brauner@kernel.org, jack@suse.cz, djwong@kernel.org,
        aleksa@amutable.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH] selftests/filesystems: fix missing and stale TARGETS entries
Date: Fri,  3 Jul 2026 20:37:42 +0530
Message-ID: <20260703150742.58991-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0NiBTYWx0ZWRfXzifltJwzJ5Gj
 NAaFzh02SZsFeVHot9l7XAXJNW5QKoc51bCvhK8hmxhGYHRY9ghda75dAHODPYzoocZU6+0JIrj
 Sy1sc6NrSQ4bU5A0wOVP/JQriYGoWurhb7U9rxZSlqHluZkWkODF5ApO41XG+n9PZgv/rpuuwG5
 tWxFfe7d3r/dhuUBJfPB6+yFu9MkHeMup8lnwAJyTV+eTIo+igXv6KV/uOb5d6QTUbp3Cb++vhv
 47nEa/Er9LDZlkAsilB5/kkOXDbLStIyY9EnOtKT4juWh+eHMtOK8+f4aJ26bJb+ChR+QMLfeU6
 LMBiBIVolrkShFjh7fgMDit8hTnQP4NFOy+xKkC9xQYzOkZno8EPlx8RODceL2DZmhEH4naRylA
 AtoTZZNksGBoCmKtTGa9uALdZE/jVuI2q5e6Y4LSZxBE/G/50bxDl4u64HbqiLMDKO4byMOTjq2
 ADiMV0J5Ze94lcbCIOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0NiBTYWx0ZWRfX7EmTt8t+MCVW
 dQZfslt7xQgAquj2OAEgCrJDYjAmOmMI6QxuntHIHrwlNBB1Ao4PyHJLWXBet1yKe8f9le35ERL
 QlUQttvGUPNxFZEkVudjdC6rOp/7YZ4=
X-Proofpoint-GUID: HTpnxO-XLNYvnb0nXnYrtUjWCKTuGZEc
X-Proofpoint-ORIG-GUID: V1UzGahCg_FONDGsUfdQ7lZUS475iEhJ
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a47d06c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2UpccJByY7zQxxB6lQIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030146

filesystems/eventfd, filesystems/open_tree_ns and filesystems/xattr
were never added to TARGETS when introduced. filesystems/openat2 was
moved from selftests/openat2/ but the TARGETS entry was never updated,
leaving a stale entry pointing at a directory that no longer exists.

Fix this by adding the four missing subdirectories to TARGETS and
removing the stale openat2 entry.

Fixes: 7c37857fc23a ("selftests: add eventfd selftests")
Fixes: b8f7622aa6e3 ("selftests/open_tree: add OPEN_TREE_NAMESPACE tests")
Fixes: 7e28fef5d4db ("selftests/xattr: path-based AF_UNIX socket xattr tests")
Fixes: fe087927046c ("selftests: move openat2 tests to selftests/filesystems/")
Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 tools/testing/selftests/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8d4db2241cc2..4c4df65a6f91 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -33,7 +33,10 @@ TARGETS += fchmodat2
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
+TARGETS += filesystems/eventfd
 TARGETS += filesystems/fat
+TARGETS += filesystems/openat2
+TARGETS += filesystems/open_tree_ns
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
@@ -42,6 +45,7 @@ TARGETS += filesystems/fuse
 TARGETS += filesystems/move_mount
 TARGETS += filesystems/empty_mntns
 TARGETS += filesystems/fsmount_ns
+TARGETS += filesystems/xattr
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
@@ -98,7 +102,6 @@ TARGETS += prctl
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
-TARGETS += openat2
 TARGETS += rdma
 TARGETS += resctrl
 TARGETS += riscv
-- 
2.45.1


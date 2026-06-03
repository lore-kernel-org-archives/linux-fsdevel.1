Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1813B3BF4;
	Wed,  3 Jun 2026 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484554; cv=none; b=gSMtJ8nQF1mZCs0HLxmBtV/yvHZZp5c5dxQKpzOQLjzcrHOzn4e5Rk79YTaztu1/wz9e80/5NILZ/glB9jc5g5eCaXH+hwyqpIwYPxfZXJuvcN4pFxjNa2L2hRufX2ouktR5/E+HUKzd+nZb8S8gE6OWKmziG4Z7VZxxS9AUVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484554; c=relaxed/simple;
	bh=Op4ACPRjaqg9oLNvvhM0/wfayJOU2I2KpzeW6QPK7GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fy7MDJuW258ku/cmPntvu/UoDd1l9DKAMP075x4K4zjivIiS4DTGqYwE6WdCrzWP/nHyu8sJloBDa0SAZYY6oMWArafhdVwFjfJ75mtFzKUWPqH3rk5Qsk2alPhhHMyY+ZgCofYTIhnoks1RzUT99HvYNlkbdCzKEJ4mILxsqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HErMaEFR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HErMaEFR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652JNCpN3001044;
	Wed, 3 Jun 2026 11:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J1srkxi/63O13pXhsJZVUq5FoJnp+hf98QMaB6fry
	OM=; b=HErMaEFRYW0BVln+0X4d4a2JtoQki+RarT1F+igMOlEd6ozfELhZpuB5X
	9aBpJCXvBygOsJvoYFnzYjmVSQV5uAJ5yVr59N4sFSCIjwZqsrZVYOKVjNyL1KUF
	srgXXFjHeDUdcVbd1W/Iy/+9KFeRFp4SXmasjlBnM2UnqMbsjnrpcwtJLQ0Ec5mB
	d1P6GStuOiR6n0pDp25z8QkxxQKogtqwQCampm5swQy/Z5FHDr6SOUCHfmYWbtk8
	eNieJxoY69zIn/hDq5+n/U2F/Mr7EpyYT09AwHYu63ps1+w4hgMC4qnXf9H5xlrD
	VUYLTYOekrk2Gt1CnRV9DTe25hT7w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaea1dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 11:02:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653AsCJd014438;
	Wed, 3 Jun 2026 11:02:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhfqkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 11:02:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653B2H2C47645132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 11:02:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0700A2005A;
	Wed,  3 Jun 2026 11:02:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3A872004B;
	Wed,  3 Jun 2026 11:02:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 11:02:16 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
        Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        japo@linux.ibm.com (Jan Polensky)
Subject: [REGRESSION] exfat: swapon(2) fails with EINVAL after iomap conversion
Date: Wed,  3 Jun 2026 13:02:12 +0200
Message-ID: <20260603110212.3020276-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a2009bb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=CfmqdEj8fnphjIFZbAgA:9
X-Proofpoint-GUID: 5h60-jHlynUaOHWDhHCQXth9Fs96fp28
X-Proofpoint-ORIG-GUID: 5h60-jHlynUaOHWDhHCQXth9Fs96fp28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwMiBTYWx0ZWRfX311xZlJaHM1A
 MPTQn4SeLBBLOP/lbSUnKSEEGWprG1adiJPSXqupLGUp/JmQMn71GNC0aJKgDuXIMAL5+hYBzNB
 0QxWqtfE7TUQMkoolZnea7LAAp6/ZD8hVDNi0K6T9Y6fL1EKdYTbofucNrWdhiGlGuZ6RDEPjzu
 fHn4zxmoSTtpTL7TwG9YwJbXcOjZFCT3b8+lG84nh0QkPTqZYgEzU+5qKJI0vZ9OAXIAerO8Zzl
 hDOvDPHgBCFe4sHozCa7uJVBZVZD76iLncqddPooTlDC08g2c1/Ijb0KmbGsUioQJsy1kAgbGhI
 9jIHe7TOh2OMi9jDqjasxDlmCD5PzTBgsFyjnef31Bw/PeF8STScdMhv02A1753qF1TBrSIJD8S
 KQvH3QBicKxEjneWLva5ShmRtLLwzGD8aKEF9yMV5hCO3U6wrd7oweptQtpKWnQN97K4JI4z18X
 Gt9k2wV868mvstao2CQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030102

Hi,

we are seeing a regression on linux-next after commit

  614f71ca1bdfaa2f25a6f147fe22f3ad031f8e2b
  ("exfat: add iomap buffered I/O support")

With this change, swapon(2) on an exfat swapfile fails with EINVAL.

Observed fallout in LTP:
  swapoff01
  swapoff02
  swapon01
  swapon02
  swapon03

Example failure:

  tst_test.c:1980: TINFO: === Testing on exfat ===
  tst_test.c:1291: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
  tst_test.c:1303: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaKmkGVo/mntpoint fstyp=exfat flags=0
  tse_swap.c:196: TINFO: create a swapfile size of 1 megabytes (MB)
  tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
  tse_swap.c:228: TFAIL: swapon() on exfat failed: EINVAL (22)

and from swapon02:

  swapon02.c:56: TWARN: swapon(alreadyused) failed: EINVAL (22)
  swapon02.c:73: TFAIL: swapon(2) fail with File already used expected EBUSY: EINVAL (22)

The iomap conversion changes exfat_aops to iomap based callbacks, but does not add a
.swap_activate handler. The VFS documentation says that ->swap_activate() should call
add_swap_extent(), or the helper iomap_swapfile_activate().

So this looks like an exfat swap activation regression triggered by the iomap buffered I/O conversion.

#regzbot introduced: 614f71ca1bdfaa2f25a6f147fe22f3ad031f8e2b
#regzbot monitor: https://lore.kernel.org/all/PUZPR04MB63168E8C2FB92B80F9F6476581002@PUZPR04MB6316.apcprd04.prod.outlook.com/

Thanks
Jan

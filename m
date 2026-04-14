Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC922A4E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192682; cv=none; b=YqRF44fk5NsRuvRlP4xiHx/zhfV0hqiKVbNumQ0oDM8cnApPvGy1ZOZfNANtyLya+dXsBxbo0AmsjpPPRVBNo4Gpy+7eoq8RRv36K2XyF4wLZJcsWnFWED+rsnEz3iboisv2TUgrQalVVn9VFSQ3cLgszVTKQfq2biodrR0sRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192682; c=relaxed/simple;
	bh=itu1B+XWD9KOP4A+BnzHNRb0U+l5OMnXcznFzcpi0NM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EkcLmVFARA+xgZmEed3dLG3M+nsIREh84ZjbHBTXt3YbK/XhSnBlzSQ5N/dEG0g40nD3EiaG/0eRbZQzsgCzJcE6pHR4zu6V3kBj1VCJCTCLtTrFBQ9EX3bNKrFXKyN45v7XPNUQofXaYECWVmJWTXWIUntWZCAFT6WZ8MFpwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Q6CQqqwh; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Q6CQqqwh"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EGKEZj3348021
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:51:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=QRLTCcEIFcFMR8Y61z
	/m2+GarfUiK8Nc4u3iM4iP/1o=; b=Q6CQqqwh1ZZvC5GNnysYYusj6cOJoa6XwL
	kBKv17Ogv0Ei4EJH8LtlrWkHQ40zmW6WyPKLKRTSt2fQgKeocOvjHYL22TX9WXyN
	YSRJC3TPJW5gc+QrBWGbCRjx3DF1SipmvknfabNHjugw8XxGaCAzrNVJ+JJjL41I
	BR8hXOHa68aCnY9pDzPzbfWddSjYh8+xBR2A/RpsoxaujNSlI2OxOHXllCY7b2eN
	nlUsmSJFeaXXU9uDEXsWt0d493EuO2oZQmxQkYGpz2xvjWyl0RW2L8Pd3Mz7W7ha
	3Al6JJdI4h+iZ4YIgw2uWuvv+TfW7s3nKawgRm08kcu3S1AqDinQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh86468ja-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:51:19 -0700 (PDT)
Received: from twshared38230.34.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 14 Apr 2026 18:51:17 +0000
Received: by devvm13301.ncg0.facebook.com (Postfix, from userid 202792)
	id A5D4329AE04E2; Tue, 14 Apr 2026 11:51:04 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v2 0/2] fanotify: support restartable permission events
Date: Tue, 14 Apr 2026 11:50:35 -0700
Message-ID: <20260414185037.3541089-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GKY41ONK c=1 sm=1 tr=0 ts=69de8ca8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=U_y8lYiYyhHBU5rMqhb2:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=VabnemYjAAAA:8
 a=v2PzhJrPNcqBnypOW0IA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: iu3RVPc7CvBeYibLIy2YpfPnZ4FLQX2V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3NCBTYWx0ZWRfXzCnCfUi43l7G
 cfsL3doQAoT85qhWUYckxD0eyzyJCky2UZiYo017tmpiDn7CWu7mwjdYeZbBjuelBnXGxw0SzyQ
 aEDLlacN3pyoUs6tq5GANh5hPtSRbjLyzma2UmFQbP4UWZvqfC2fOJUyfG/dTJNBoc0hGxclxLD
 IlXI6J+GchfUVJ3wYlP8HVA9fUWyq/C5rg77Ogsth03xT0jL3RxU40Ax4XMP4yM3+zZpy3UAYxz
 i7p+gBp/myRV3eMNUc0oA28mwCsqPzpS+4ODqjGMvVtfxuSeVvWdiRlGBmK6HswWFqjd2ueuIim
 B2ExO56Je7me4KffF0eYRg5fqHUkRnHzczXaRaKAxAgxx/9RL08V6GyBSaTPpMLcQwyBLSVVZlu
 wxWABU1sXh0T5LdLY7l1XPKpAVr5txXkPZfAgEC/EQLi/yuypTj1XWdr4XWJPuyHnpiCQU/OH39
 JXhoAnTXahdSwCfrizg==
X-Proofpoint-ORIG-GUID: iu3RVPc7CvBeYibLIy2YpfPnZ4FLQX2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01

These patches are in order to add support for restarting permission
events which is useful for HSM use cases which are backed by a daemon
to respond reliably [1].

In terms of testing, there is an additional LTP test attached which
exercises releasing queue via the new api [2]

[1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr/
[2] https://github.com/ibrahim-jirdeh/ltp/commit/9f193f09ba28947dd12a4969=
5de225bb19e29ce5

Ibrahim Jirdeh (2):
  fanotify: add restart infrastructure for pending permission events
  fanotify: introduce restartable permission events

 fs/notify/fanotify/fanotify.c       |   1 +
 fs/notify/fanotify/fanotify.h       |   4 +
 fs/notify/fanotify/fanotify_user.c  | 146 ++++++++++++++++++++++++++--
 fs/notify/notification.c            |  25 +++++
 include/linux/fanotify.h            |   1 +
 include/linux/fsnotify_backend.h    |   7 ++
 include/uapi/linux/fanotify.h       |   6 ++
 tools/include/uapi/linux/fanotify.h |   6 ++
 8 files changed, 190 insertions(+), 6 deletions(-)

--
2.52.0

v1: https://lore.kernel.org/linux-fsdevel/20250806220516.953114-1-ibrahim=
jirdeh@meta.com/

Changes v1 =3D> v2:
- Replace fsnotify_insert_event usage with dedicated fsnotify_restart_eve=
nt that inserts
at head of queue without merge or overflow handling
- Return -EBUSY instead of -EEXIST for duplicate queue open
- Separate fanotify_control_ioctl for control fd with only FAN_IOC_OPEN_Q=
UEUE_FD,
move FIONREAD to queue fops (Amir)
- Move queue_mutex/queue_opened to fanotify_data
- return EOF on read from queue fd after group shutdown

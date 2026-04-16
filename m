Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D373E6DCB
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368962; cv=none; b=ieeHVUYuFrOdcnPOmNgdzUVKCODQ/t5JZCqKacCLOT6/P6GaHx0HpMUINIAUe30e9apxgdYfhJnp0ZgfkyJckhLYvb1bHSqWSTxK7YAbZSTgUzuF6bIxippVZeM7JAyv0hWu0fmP6egN5QpzIU5pPVw94xaFWkAHMqZRTpayYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368962; c=relaxed/simple;
	bh=5Re/A2gpMff8+ge44D/ILOO/DUP/Y0KKJUsVx+GCXcg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PLHUF4td4KWu3/nq7M6jyMyr+vOYaEyfZPO01A4sqCcmDeFxB7Zu7pxBetCZUC2g5bGdbSRIo+Y9wlRHflB70LJ3obbEIJhzG424Kx1xKp55ESpqMbuV47s/DoqH49I9poa2UEuASmTaWtn6A5YNgTV4sNvsfqL50U6EDtwSp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=K7tnkAjj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="K7tnkAjj"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GIcUWf3734572
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=AxVjOp115IMZB8rohe
	9LOU+7uvWXETUlDUNo9tYsc9Q=; b=K7tnkAjj8zGW94PQw32qOLC7hDcbmn6PDC
	p3Z+v5Sk37AvQpl2/QASEkWOz8IPOqny+mUYSBwQVzZJ8tXWyo5wz7XlyJ29GW9q
	UGJJ2/V3pD0q9JvAkIkunJd4ndzKaTkq/stCXKRVHlSkCrGhJnQyuXrHg4ao99Uz
	HWoOYb5zcqS4cTY1z4C12kHKj5r7uKZ1A8A599byF9UFl9/dLChYQxBcImk5s4i9
	w1znJ9CwKO7yN0fT8WWBNDBKuNBOMVxNvxKIHv0/01Sh8IiaaNYWa2DDuKiThEdx
	9KAGhZBXxyZe0r/WMR6eJ8ZUfCMHJneBpmfb7LTZghW4AFIHe+WA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84tym29-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:49:14 -0700 (PDT)
Received: from twshared4770.04.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 16 Apr 2026 19:49:06 +0000
Received: by devvm13301.ncg0.facebook.com (Postfix, from userid 202792)
	id 4FDC22C51C168; Thu, 16 Apr 2026 12:48:54 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v3 0/2] fanotify: support restartable permission events
Date: Thu, 16 Apr 2026 12:48:42 -0700
Message-ID: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
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
X-Authority-Analysis: v=2.4 cv=DeknbPtW c=1 sm=1 tr=0 ts=69e13d3a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=VabnemYjAAAA:8
 a=pIyqZN7UcsZE1BgV3m4A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE4OCBTYWx0ZWRfXwEf3ts190QFn
 /Evsl37K45M0D962oxWTTnEaalC92eLM4pWjm9OizrPyjrUHeTp6shwdKGhzDdKOuEsbRqzQRXG
 DO37UGkeQTk9nnAlZ7JqtZYnNdth/MQtnTnlrJRo47JrCWUgI1OYxId26pGEOGBjlLGfePvDLUx
 /dN4muj5gf2u4H9Bp8ZiD54ZaSkjLROpT6u3K4XN1FXiX8GZQnfuQi5fubA0fuPnpa/Cdv12MSG
 0mpnNdbNhBtZPCP/qomq2zgFN69mUHetRJlNX+d/3PnohIW7UARuEAavQULgnUQLYw319Dzhvxy
 mvu6WTcOjKzvWcOSz5WwdKbfG6WI0PV4aym5Y3UTu8jr0GX+X380UO1Lf0oL8sQupmhzKSXr9KV
 yUT0ovC99pSIbiZ3Mx7AFzMegrYMd2CvQeEdL5F2kGvHSikqRdEUVKDhrByhDQnYDhPGMEg5lzY
 7B6nR54QmBa7EMAZN+A==
X-Proofpoint-GUID: g0uiTmyd3ikku9JBYA-cVE-a6PH4oXV0
X-Proofpoint-ORIG-GUID: g0uiTmyd3ikku9JBYA-cVE-a6PH4oXV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01

These patches are in order to add support for restarting permission
events which is useful for HSM use cases which are backed by a daemon
to respond reliably [1].

In terms of testing, there is an additional LTP test attached which
exercises releasing queue via the new api [2]

[1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr/
[2] https://github.com/ibrahim-jirdeh/ltp/commit/efa7aa88c866f3ba4d6a5c6c=
436ac27837bcdcc8

Ibrahim Jirdeh (2):
  fanotify: add restart infrastructure for pending permission events
  fanotify: introduce restartable permission events

 fs/notify/fanotify/fanotify.c       |   1 +
 fs/notify/fanotify/fanotify.h       |   4 +
 fs/notify/fanotify/fanotify_user.c  | 153 ++++++++++++++++++++++++++--
 include/linux/fanotify.h            |   1 +
 include/linux/fsnotify_backend.h    |   3 +
 include/uapi/linux/fanotify.h       |   7 ++
 tools/include/uapi/linux/fanotify.h |   7 ++
 7 files changed, 170 insertions(+), 6 deletions(-)

--
2.52.0

v2: https://lore.kernel.org/linux-fsdevel/20260414185037.3541089-1-ibrahi=
mjirdeh@meta.com/
v1: https://lore.kernel.org/linux-fsdevel/20250806220516.953114-1-ibrahim=
jirdeh@meta.com/

Changes v2 =3D> v3:
- Removed fsnotify_restart_event helper, instead inlined reinsert logic
  into fanotify_restart_pending_events
- guard(mutex) instead of goto in fanotify_open_queue_fd
- Fixed permission event mask check to allow FANOTIFY_EVENT_FLAGS bits
- FAN_RESTARTABLE_EVENTS nibble changed from 0x00008000 to 0x00010000
- Have queue fd keep a group reference via fsnotify_get_group

Changes v1 =3D> v2:
- Replace fsnotify_insert_event usage with dedicated
  fsnotify_restart_event that inserts at head of queue without
  merge or overflow handling
- Return -EBUSY instead of -EEXIST for duplicate queue open
- Separate fanotify_control_ioctl for control fd with only
  FAN_IOC_OPEN_QUEUE_FD, move FIONREAD to queue fops
- Move queue_mutex/queue_opened to fanotify_data
- return EOF on read from queue fd after group shutdown

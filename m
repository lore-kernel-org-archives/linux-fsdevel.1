Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5F35B634
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368966; cv=none; b=JzQdvJoVYdWBg1l9ex6fvuN1e4tYqBpITd1CQehnHQlnse8oyHSrW2D8VcTmiqZIBSlHvS2iOzy+j/fPoTpA38X3Gft5MTpFihgC65T4XQYxQ2bq8DshApecpf2WH+lGDhBg7GIlaxuMk1w71Juyzxl3xzrzignratYSqkkbMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368966; c=relaxed/simple;
	bh=S6ZEXnlwB+vTtZpZD2FKZk6lJ++XKSClv1c4eWnDcps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOTubG+5EPRvtticrjFB3zlBd2CnCQDW37JT0bQvDiU/ROzS+rgdSzbtiFUjaNHcVWxS8wRL/wmYR2r+7GEwS08fKRQNDblb1Jg7oEmmHTpzNSam2UMEnKmQkO+oPmHFU7lhrgkNVXZM7+6YCKAbMWeImN5QBTPXT4g8Mxa6QrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NYDyFlNg; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NYDyFlNg"
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GIcUWk3734572
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=UFfLpBhYJiNGIvJvzIjWpP6rmzmLkVYY3x8QS1S17RA=; b=NYDyFlNg0nkh
	HP2ODWl6HcFgQ2G73ehY5sZA8QHhlJFQVaDbdGHxkt1dx/lsHlpGKsaNZ2qxTEi9
	nXbv9WeysesjCGM8B9WZeuK/ic1fJw3K3TrwYEoJXwdHg7ZDSFo9ptd67JBgOgAt
	9DLxW6gl9lPZejLcKuNc0PchpA4B1dX/Ipm6SWbPXInfhCJt3rqALNJYiJFho56R
	v9El/gxcOxadehb5SOYBFDUlMw1j2itwoLkyOJWPYYTrWJp4mLAUhvVXItAqaYSb
	PB09I3O5YLPmga+SLXgzDvSM8UFeG32oucd9tfBSH3ZrIPQBqbmEQwC671uR5pE/
	u0kTSNBo0g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84tym29-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:49:17 -0700 (PDT)
Received: from twshared77462.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 16 Apr 2026 19:49:10 +0000
Received: by devvm13301.ncg0.facebook.com (Postfix, from userid 202792)
	id 9DA9E2C51C23C; Thu, 16 Apr 2026 12:48:58 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v3 1/2] fanotify: add restart infrastructure for pending permission events
Date: Thu, 16 Apr 2026 12:48:43 -0700
Message-ID: <20260416194844.3874004-2-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DeknbPtW c=1 sm=1 tr=0 ts=69e13d3d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=A5EZPCAw3_T4iZwEKtIA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE4OCBTYWx0ZWRfX/bs55EU1ZX7m
 cuuqSoJha0sVdZU0ZO3iIKHEbtb+S2OEHw6ui2fgMGTcdPY5NL5J3cXICV7RQcaCHWF9H/d1Erc
 6TL1YsQpI+HGumHQ8uVAyKhYIlfs9QcCiZPkiCS2bA9Uv/NuwPSZRMGHxR5gLldUKqZ8ow4EVgk
 Qxm/nScRKUoPCTfwdJ75q4C36+HtFFb64eUOLJxSRQ6+LgD7AKVkcs5lAloHUrV/ZBi+CbpsRTo
 YBV+DvyWAG8NFVrGpmSKRuggHq3QGgTOx1djqbI8jxucKPauVO+qmtOGTBcEzlH4Wla8LCLTewX
 q9VsikWKyW6nRIn2lJK5O5/AQoiqSl0XqcqwwYgAcBAVhstJbfpNbX4prjXU8GcmOJ9KU5or1+n
 Luehix5NjkqqqyNdZ0+HBBr2w+nXu8V98QshBBgquPwa4P44FrpAlnzddCL/bfxeukbgFow2Ylu
 p4VClymYx/o1ie/QApQ==
X-Proofpoint-GUID: 7A_UI7yGG6OQs_IyL2WR4mofcfUZd8Wr
X-Proofpoint-ORIG-GUID: 7A_UI7yGG6OQs_IyL2WR4mofcfUZd8Wr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01

Add fanotify_restart_pending_events() helper that walks the
access_list and reinserts each pending permission event back into
the notification queue for reprocessing. Events are reinserted at
the head of the notification queue without merge or overflow handling.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx4wua=
5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index d0b9b984002f..787e57a00466 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1095,6 +1095,36 @@ static ssize_t fanotify_write(struct file *file, c=
onst char __user *buf, size_t
 	return count;
 }
=20
+/*
+ * Reinsert pending permission events at the head of the notification
+ * queue for reprocessing. No merge or overflow handling.
+ */
+static void fanotify_restart_pending_events(struct fsnotify_group *group=
)
+{
+	spin_lock(&group->notification_lock);
+	while (!list_empty(&group->fanotify_data.access_list)) {
+		struct fanotify_perm_event *event;
+
+		event =3D list_first_entry(&group->fanotify_data.access_list,
+					 struct fanotify_perm_event,
+					 fae.fse.list);
+		list_del_init(&event->fae.fse.list);
+
+		if (group->shutdown) {
+			/* Group is being shut down. Reply ALLOW for the event. */
+			finish_permission_event(group, event, FAN_ALLOW, NULL);
+			spin_lock(&group->notification_lock);
+		} else {
+			group->q_len++;
+			list_add(&event->fae.fse.list,
+				 &group->notification_list);
+		}
+	}
+	spin_unlock(&group->notification_lock);
+
+	wake_up(&group->notification_waitq);
+}
+
 static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group =3D file->private_data;
--=20
2.52.0


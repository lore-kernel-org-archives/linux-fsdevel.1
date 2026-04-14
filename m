Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8322A4E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192685; cv=none; b=YCBW8XGim/IhI7D7beVSaS+4DTlqQOn+pQloTpk3bgAAJ8FZzljetMwTknE/EUft270Zwy0ELPqnV8jEbryrPD8N4r74NgJZOjZqyvjR2QlzUP7QM821BKdESyl7pfOTHhzVE+4kOo5xyRJbMam96QcH2B5zYzhScAIQb+9Xlp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192685; c=relaxed/simple;
	bh=QLxy27agztTH0VT+fbLJARBi9haXq/k21cIteKxve2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuTNqBcs3KSWuDcVQXb/iufC/3T/z+2fsm+LJ398yYSBoQz+rYr032PQ+mLgvlSsoScXu9Hti4gPcr8qHUWJu1OJjaU6YDE+achTbwED+wk63Msa3comxNupALk18Et2pMLxazWnuc6P7cLBwr8P6cEc3UDfbVbLHfpEE47iKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jnJqeUOI; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jnJqeUOI"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EGhtDZ2905288
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cNcDcCGBqB8A5kbfXVXTw7cLSj7M8+AnvNAK5CqELC0=; b=jnJqeUOIgSVB
	74OZDsyWzeqicfHJHj/338lWxj/whPAVjZeDdsw/5Q1ugPD/c+PD6nRaxP6g4Xj7
	UMA9R5DvRrsIkpYifVJT6LZyKFTDcT4jy+nxsi94bSzjh9BbZQcSfOGqIAgs/C9W
	trGdOEN8r6pyjNNmE521oxW/y1MqrM84f2QZZrLNTQPpAcsdna1+OK6ukn+thln1
	a8OnZXkOYPu9RIswSxwbQpwX7adyCt3VMR5vCaFBuYK2brDfw9aFoOo3qo7xGdS7
	tB4PnHsWLoPmEWUhBXbvxUvu60M8yK2zzXclBLnIfOlzQaQ+xJm2J2jYpeERggu5
	Zb8YTBewwA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh864p926-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 11:51:22 -0700 (PDT)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 14 Apr 2026 18:51:20 +0000
Received: by devvm13301.ncg0.facebook.com (Postfix, from userid 202792)
	id 8FCCE29AE052F; Tue, 14 Apr 2026 11:51:06 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH v2 1/2] fanotify: add restart infrastructure for pending permission events
Date: Tue, 14 Apr 2026 11:50:36 -0700
Message-ID: <20260414185037.3541089-2-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414185037.3541089-1-ibrahimjirdeh@meta.com>
References: <20260414185037.3541089-1-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PJ8/P/qC c=1 sm=1 tr=0 ts=69de8caa cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=T78WD0cvAtH84r6eq0gA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 6PQL2KbmZGg495PsZtN6gdj_4S7dsHhM
X-Proofpoint-ORIG-GUID: 6PQL2KbmZGg495PsZtN6gdj_4S7dsHhM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE3NSBTYWx0ZWRfX8Ed+7x0z0Jh2
 b+9g7soXMNo2wt/xHfHI1hCOkk2b2+/HF3OkiTFEFMgT/yKaLsz7m1O1zXYChR1lEoAecJc8mD0
 BQeJgantsdF+fq1GivayKFHbmtSJ38rcXgJz8bvjHawieP4OMpdxLcNtwdHeXmtrVIlbmJ/dCiL
 0LvMTQRyPR54QQ8ZCV5FZXbnqc8NeF/O8mWwl8NNRr1LKhJa3SM/Lxyi2XAPE68fso3jLWaDmHz
 mIF6U9MzuxMgPUGR0myBObjbDEWAoSs1doz2xHjbCN1IZYsryKRW7tzmqr5ZsNoheuAuP+LJ7Qb
 EOervZ77jvsm0rFVGea6QtkcGnvh+U9EizDoiTUYqyrEVQkzjOjzSqsqVAGTLCCJe51w5gryYQF
 A5v5ecb9eZmj7TN4vzN+QDhamu+nAcVPf84rxhALMnHpzHJltuCwCRgvCFUBKJlHs/ZvGwrFGOm
 xU8UF2APSi8bmG8gRVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01

Add fsnotify_restart_event() which reinserts an event at the head of
the notification queue for reprocessing, without merge, insert, or
overflow handling. This is used by fanotify to restart permission
events when a queue fd is released.

Add fanotify_restart_pending_events() helper that walks the
access_list and reinserts each pending permission event back into
the notification queue using fsnotify_restart_event().

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/linux-fsdevel/sx5g7pmkchjqucfbzi77xh7wx4wua=
5nteqi5bsa2hfqgxua2a2@v7x6ja3gsirn/
Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 fs/notify/fanotify/fanotify_user.c | 27 +++++++++++++++++++++++++++
 fs/notify/notification.c           | 25 +++++++++++++++++++++++++
 include/linux/fsnotify_backend.h   |  4 ++++
 3 files changed, 56 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
index d0b9b984002f..8203ecf5ea39 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1095,6 +1095,33 @@ static ssize_t fanotify_write(struct file *file, c=
onst char __user *buf, size_t
 	return count;
 }
=20
+static void fanotify_restart_pending_events(struct fsnotify_group *group=
)
+{
+	spin_lock(&group->notification_lock);
+	while (!list_empty(&group->fanotify_data.access_list)) {
+		struct fanotify_perm_event *event;
+		int ret;
+
+		event =3D list_first_entry(&group->fanotify_data.access_list,
+					 struct fanotify_perm_event,
+					 fae.fse.list);
+		list_del_init(&event->fae.fse.list);
+		spin_unlock(&group->notification_lock);
+
+		ret =3D fsnotify_restart_event(group, &event->fae.fse);
+		if (ret) {
+			/*
+			 * Group is being shut down. Reply ALLOW for the event.
+			 */
+			spin_lock(&group->notification_lock);
+			finish_permission_event(group, event, FAN_ALLOW, NULL);
+		}
+
+		spin_lock(&group->notification_lock);
+	}
+	spin_unlock(&group->notification_lock);
+}
+
 static int fanotify_release(struct inode *ignored, struct file *file)
 {
 	struct fsnotify_group *group =3D file->private_data;
diff --git a/fs/notify/notification.c b/fs/notify/notification.c
index 9022ae650cf8..2d377122c904 100644
--- a/fs/notify/notification.c
+++ b/fs/notify/notification.c
@@ -129,6 +129,31 @@ int fsnotify_insert_event(struct fsnotify_group *gro=
up,
 	return ret;
 }
=20
+/*
+ * Reinsert an event to the head of the notification queue for reprocess=
ing.
+ * No merge or overflow handling.
+ * The function returns:
+ * 0 if the event was added to a queue
+ * 2 if the event was not queued - the group is shutting down.
+ */
+int fsnotify_restart_event(struct fsnotify_group *group,
+			   struct fsnotify_event *event)
+{
+	spin_lock(&group->notification_lock);
+
+	if (group->shutdown) {
+		spin_unlock(&group->notification_lock);
+		return 2;
+	}
+
+	group->q_len++;
+	list_add(&event->list, &group->notification_list);
+	spin_unlock(&group->notification_lock);
+
+	wake_up(&group->notification_waitq);
+	return 0;
+}
+
 void fsnotify_remove_queued_event(struct fsnotify_group *group,
 				  struct fsnotify_event *event)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
index 0d954ea7b179..573c796513bf 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -736,6 +736,10 @@ static inline int fsnotify_add_event(struct fsnotify=
_group *group,
 	return fsnotify_insert_event(group, event, merge, NULL);
 }
=20
+/* Reinsert event at head of queue for reprocessing */
+extern int fsnotify_restart_event(struct fsnotify_group *group,
+				  struct fsnotify_event *event);
+
 /* Queue overflow event to a notification group */
 static inline void fsnotify_queue_overflow(struct fsnotify_group *group)
 {
--=20
2.52.0


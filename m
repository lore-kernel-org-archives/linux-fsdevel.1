Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8771D3BE62D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309921; cv=none; b=htRT+bvaUQXsU7336JtReLiwtSFsyyAi6q/M1mVvp0s9yyktes4697EydIRNgrGpokX9g16DdazRhJtcXM5auwzLCXUEv3B5WdBocJ2E8vHA1hyyjW7hWGh1+2wMUruUvVGn53oXGH1sZNK04CxzIa4xjIqimbG/D+CQiDwOnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309921; c=relaxed/simple;
	bh=uAt1SEEjlEw8NdttcqoSaWto6L2RFLgJ4V40lLbvCWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp7AS6U7J+IwvvphtV6EaYwyJzEIzho4PKaDe9OApmpQqs+eXQxml1ux2qtoTUNVuJfKxdw4oz230WR4M8C3MBJ3tn3JhSUq10u1NZkbYC3Fswb7cbRHjvMy+1RaYiRA3h8VAwTxxOju+VJfojHlgMAEIQAyox2dHZmZQ0O3Ums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kdk8WLzX; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kdk8WLzX"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjsg1644z1B44;
	Thu, 12 Mar 2026 11:05:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773309911;
	bh=NgNgRqo0jn8LY997ouAFmQMP4oRHoI4EfIOlgxtBdUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdk8WLzXsoNaChiBy/GWFnoBfvNWhWjNWWekwpbTWbRM+VTcwLatmmNd34N8ycXb1
	 9tH+w56ea3b0cAqOl8Fe5Ljpp4GNwFvqMAuaZ9btD6dX4H4oHv5XhQaTOZ36XntUiK
	 Njoi/GyAMOPN6e5vzDk7pXuFz3tlZFjyzDdnxNrs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjsf3c8hzJR;
	Thu, 12 Mar 2026 11:05:10 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 02/11] security: Add LSM_AUDIT_DATA_NS for namespace audit records
Date: Thu, 12 Mar 2026 11:04:35 +0100
Message-ID: <20260312100444.2609563-3-mic@digikod.net>
In-Reply-To: <20260312100444.2609563-1-mic@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
information in audit records.  Two fields are provided, matching the
field names of struct ns_common:

- ns_type: the CLONE_NEW* flag identifying the namespace type, logged in
  hexadecimal.

- inum: the proc inode number identifying a specific namespace instance.
  Namespace inode numbers are allocated by proc_alloc_inum() via
  ida_alloc_max() bounded to UINT_MAX, so the value always fits in 32
  bits.

A new audit data type is needed because no existing LSM_AUDIT_DATA_*
type carries namespace information.  The closest alternatives (e.g.
LSM_AUDIT_DATA_TASK or LSM_AUDIT_DATA_NONE with custom strings) would
either lose the namespace type or require ad-hoc formatting that
bypasses the structured audit data union.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/linux/lsm_audit.h | 5 +++++
 security/lsm_audit.c      | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 382c56a97bba..6e20a56b8c22 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -78,6 +78,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_NOTIFICATION 16
 #define LSM_AUDIT_DATA_ANONINODE	17
 #define LSM_AUDIT_DATA_NLMSGTYPE	18
+#define LSM_AUDIT_DATA_NS		19
 	union 	{
 		struct path path;
 		struct dentry *dentry;
@@ -100,6 +101,10 @@ struct common_audit_data {
 		int reason;
 		const char *anonclass;
 		u16 nlmsg_type;
+		struct {
+			u32 ns_type;
+			unsigned int inum;
+		} ns;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 7d623b00495c..7f71a77c1c12 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -403,6 +403,10 @@ void audit_log_lsm_data(struct audit_buffer *ab,
 	case LSM_AUDIT_DATA_NLMSGTYPE:
 		audit_log_format(ab, " nl-msgtype=%hu", a->u.nlmsg_type);
 		break;
+	case LSM_AUDIT_DATA_NS:
+		audit_log_format(ab, " namespace_type=0x%x namespace_inum=%u",
+				 a->u.ns.ns_type, a->u.ns.inum);
+		break;
 	} /* switch (a->type) */
 }
 
-- 
2.53.0


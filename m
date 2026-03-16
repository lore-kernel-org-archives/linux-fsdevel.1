Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C83CF68E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680016; cv=none; b=pAWegh24NkSeAJPBD79gxAArn8BokRm4PFQwM/tNfFlnil8ldGFKLJ04nMi9PiwQ44imzDL0jUKmlA5dBZvASPjFkNkiO7mbbxX9G66l+SumSByLX9td+xUGrY2Ukje09oF1lj+tB88h74mgizkEm5PiLytGGwYTErBbEhhWKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680016; c=relaxed/simple;
	bh=S29dYw7ZyCUdmj7qxdt8ojRkFpK4zU49DGbJRFVexMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvhMjx75Kp8+9MRXIfHJ5TkQcQ4jEY6DGXq4cTFvFgUmUq4VXL1GuhmPUJc6zVKjmcMVQmPpBYz41mNR2+ZIouUXjkZKloxjypjFhBHXL5hcjiBr2rGF02dvd2zThd0pp5v8snMDThN2oiOpk6uXgEsKAM9ojfSBq9HQQ9Fxfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rav+7kpn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nbWUqvqE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rav+7kpn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nbWUqvqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=US4QKEKpkMmfLfJR4Tl4ZnBK6iK4ED+eEV3WwKrxMZM=;
	b=Rav+7kpnZ2VU9QtGhKeQlljHIjbv+h344ZrbvmAgsHA+ZnbJWNzGOuGKkdDcetCeQQ6CDI
	Vm5FqrVag6gafgsC7zuSDnjWK5HumjXFY4uG4Q2pyw00tnn1PqwsBM7xhQinbK6SZlFpGg
	pJHwpU+SMoNU/o61Q9B/MrDEvgN3Rj4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-10dgiz4ROaaD97htKnBJ0w-1; Mon, 16 Mar 2026 12:53:32 -0400
X-MC-Unique: 10dgiz4ROaaD97htKnBJ0w-1
X-Mimecast-MFC-AGG-ID: 10dgiz4ROaaD97htKnBJ0w_1773680012
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48539bda3dcso53496085e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680011; x=1774284811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=US4QKEKpkMmfLfJR4Tl4ZnBK6iK4ED+eEV3WwKrxMZM=;
        b=nbWUqvqEFjR1KuyDhbsM/o95ftmpIHUv1RIpWyAMeRW0vQ9AgOtZ10Tl+WW9X3YLY9
         GMSQ+dQqb3oHXfDgXddkBSY7AQLkfSS5iVzWGjYYS05U3O7LhWePsH7puGHLoYNxJfX0
         WIwgPfYRMyWkxkw9ERE4Nq4jBo2nrcTCe9AiEsaTGN6bliJc6vTbd2FXkCnUQgL7o2jR
         wmWa508SMpowQYrw1/x3bQyi7IQ1sVj6C70HIrDZAGvKMEardOeHyl3uv6VTFEOoWYZr
         kC1RguAlhid7QeBPdtIiZqB9SW5SOmmym69giaC+nx4lUcF8UXdZbVGurnZ6tAVcJH38
         Gnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680011; x=1774284811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=US4QKEKpkMmfLfJR4Tl4ZnBK6iK4ED+eEV3WwKrxMZM=;
        b=b73bKAW2bmzXM2KDyvex8ApI+0PKMWB45pf3nyvtBgnODXThMRt6QCI/4/Lt7T+vOx
         vu8mqJX9j/MRHtekpS1jobG0nB3ZBXmzRlRXOlEZNATGfw5mG0kg0otHKCn4oDzisi1E
         kxl0NPQcAqlCWhEJq/ulN+ocq6cY5PSu6011U05RdXUm6qOdkpRHt/jANmFCRm+QPmHE
         R603LjARWhI/QWE0T9Kd/ZX73A0ArkBF5KQrPNyx8VEdqMVejQXA9XT/d9fuMKN1Qim0
         CFq2nlY1vfnHJCkSLJLrDeU876k91ZaLuaUyNA5m4TsiHy40dTSljtPTO7WdWWDZwwda
         0GwA==
X-Gm-Message-State: AOJu0Yxtf7qUnilryc69xkAQyL7PO4eFwovxwAb3Bzcv0+a7izc4gZBk
	fZ7a1WYF+EepC8a5wqukhjmHDSKUEayUegqsRykOoFvDx0YCqxYMuX6uxpqhBCXRZLNmjUCdFlr
	CbIs6wBGe/UIsT58mRTVXR9H3X3tne3TvL1eT9v3FpPAYbERz6xqHZtvBrZkt59L3j5K1zlAgOE
	Fe+LwlM+yY3HkHqf4znxpacvwUu31Xw5OlJ3nOcoE2oMik4ITS0Ac=
X-Gm-Gg: ATEYQzxwBnuivtip/LPbjzgNEzcOvurirDQUSKOewKLAe499m0N6NduWwsbE+7HpZ9h
	y+msDKQJhJrE/9nFMqUN9U6O2QincX9Vekvk/FM7CVMJb4RHEvIdQE2X/QQhXSLMFnry3MNi5iq
	pOZj/2H0noc0xm8gwdCtM0pB6+lsfCuh9+T0x/RGEaxP9UL8Nikaz6KTreVaH+QT/DPs9R130m+
	SkU6X8mg5QUzCHH+ZX8I4tMzsmx81nJ2iJ1UjLABLqAqXSLFvDqRImuKvvBCGD98Ksl1gZSWsyg
	UaHvuDz3NC91ZOAkxxRIbzJOfjGtDgqP+NZ9k1EkvcuwKxkG9YPoTmqoRrp2nEd9ypAREv0HOVJ
	VBa+lF2T1MUiK5XH4eYJb2ZQOxCogbm0uJZQEt4TeeaJFQtep/D0rslZlLQpOU0ZY1o/6iaE9eQ
	==
X-Received: by 2002:a05:600c:a09:b0:485:4453:401d with SMTP id 5b1f17b1804b1-485566e2d72mr219346855e9.2.1773680011360;
        Mon, 16 Mar 2026 09:53:31 -0700 (PDT)
X-Received: by 2002:a05:600c:a09:b0:485:4453:401d with SMTP id 5b1f17b1804b1-485566e2d72mr219346325e9.2.1773680010824;
        Mon, 16 Mar 2026 09:53:30 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:30 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3 7/7] fuse: support FSCONFIG_SET_FD for "fd" option
Date: Mon, 16 Mar 2026 17:53:18 +0100
Message-ID: <20260316165320.3245526-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316165320.3245526-1-mszeredi@redhat.com>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is not only cleaner to use in userspace (no need to sprintf the fd to
a string) but also allows userspace to detect that the devfd can be closed
after the fsconfig call.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/inode.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index f388d57fdd8f..e53153463e10 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -788,7 +788,7 @@ enum {
 
 static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	fsparam_string	("source",		OPT_SOURCE),
-	fsparam_u32	("fd",			OPT_FD),
+	fsparam_fd	("fd",			OPT_FD),
 	fsparam_u32oct	("rootmode",		OPT_ROOTMODE),
 	fsparam_uid	("user_id",		OPT_USER_ID),
 	fsparam_gid	("group_id",		OPT_GROUP_ID),
@@ -800,9 +800,8 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	{}
 };
 
-static int fuse_opt_fd(struct fs_context *fsc, int fd)
+static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
 {
-	struct file *file __free(fput) = fget(fd);
 	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	if (file->f_op != &fuse_dev_operations)
@@ -859,7 +858,12 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		return 0;
 
 	case OPT_FD:
-		return fuse_opt_fd(fsc, result.uint_32);
+		if (param->type == fs_value_is_file) {
+			return fuse_opt_fd(fsc, param->file);
+		} else {
+			struct file *file __free(fput) = fget(result.uint_32);
+			return fuse_opt_fd(fsc, file);
+		}
 
 	case OPT_ROOTMODE:
 		if (!fuse_valid_type(result.uint_32))
-- 
2.53.0


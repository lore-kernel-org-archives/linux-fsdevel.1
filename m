Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE535BDB2
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747359; cv=none; b=PMSiduOzo9cByPCeK0Noz+K63ju8hSIFVYOpQ0JbmYbC876eHKTgpx8KYJCvKvBSu8M5gcTrJqjVY5207Nsv/2VVbxCZloAL/GIKU3MWjvdwDdqmyoZ8i8CVoBXUzCvOlQq2bCDfu598maHGugi3Gp6dHxxR+m0uXReyruE8c5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747359; c=relaxed/simple;
	bh=XbHZOUCcwFIac1AHGDbM4pRZ7mFyuzgSW4JMlcGSZ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND7yfEK8RX+H6iNUuZpVbH43eZkhgYH4/aaKOfLCg0YUhmoS7lfUN1ardi5S+L5SIRViL7FXOvbK6XPOtzEFbSmOWa9Ek4R2PqiKHqaM4/F4d44gq1Zkfz3YNwgbiKoLiAixMl0OIHIft5zrGkWFS1RLyV5/d7CZ97ukSNIezzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=fbjl9tfm; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fbjl9tfm"
X-KPN-MessageId: 34f457dc-73d0-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 34f457dc-73d0-11f1-9e8e-005056999439;
	Mon, 29 Jun 2026 17:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=LIk9tKH2kYJmqKJ1NXyo/fa+KRvM7iZp3uHW3KoiQiU=;
	b=fbjl9tfmUois8JmAMlV5C49D+YZlEvf+E1vzw6w9/NG1HhToOaV5InxGFqrj4gMoG19bSssy/H+a1
	 MoxEIZtfCPEMrfw+mYPX6d9dee4HaRvPVxiaGS32snX2GbftPYs6pItvDrMyn+CUnZ0LIo1YIY4X6K
	 T3KM9r0wtjZ+lhn6YJQcMJSNMJjMD0DveTR8hxx4dW0o7HUb3Dhc7FqPV/RZuG1PuWpu9Aw+i2In/Q
	 rsi0N8LSpjx2ZeiNWOl7Rwx+RIbVO3hskdDqxGRh7helWl5k/DehIy1ByDt1sVw0aokT1DZJZgCtAh
	 TtSe6+pWnOWW69C7w0yRwAuAB4Fu3Wg==
X-KPN-MID: 33|waMaK33clpB04pn/LDhxpIdCaPVJ5gsRgo9zcfkR+wL14vGYdPMc0N4xbY8OWVq
 3OCFodEmF2Q11jZjc6rdhE0oYjZ3nNQNlHe1GtHsy2gg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LekDHqY7O7peX+BTsG7iCAj5M8maRngldb3iJ3L0tTciHvwQKRG+hL+BPOcSTZb
 T3i+KitdmRhUMUJK10lj+7w==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 34bbf766-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:50 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 11/14] vfs: refuse O_CREAT for directories through a dangling symlink
Date: Mon, 29 Jun 2026 17:36:27 +0200
Message-ID: <20260629153630.2158649-12-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
symlink target does not exist, creates it. Refuse to create through a
dangling symlink for directories.

In lookup_open() a negative target reached with nd->depth > 0 was
arrived at by following a trailing symlink; since the dentry is negative
the symlink is dangling. Set create_error to -ELOOP in that case.
Reusing the existing create_error path strips O_CREAT for both the
generic and ->atomic_open create paths and only reports the error when
the target is actually negative, so opening an existing target through a
symlink, interior symlinks, and O_EXCL (which never follows the trailing
link) are all unaffected.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index c4b242205707..fef826c04eb5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4535,6 +4535,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						    dentry, mode, create_dir);
 		else
 			create_error = -EROFS;
+		/* Refuse to create a directory through a dangling (trailing)
+		 * symlink. For regular files this has been allowed historically
+		 * on O_CREAT without O_EXCL. */
+		if (unlikely(nd->depth) && create_dir && !create_error)
+			create_error = -ELOOP;
 	}
 	if (create_error)
 		open_flag &= ~O_CREAT;
-- 
2.54.0


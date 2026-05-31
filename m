Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3662395AD7
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251597; cv=none; b=hPAWh+KUNzyK+JinWRH4JtBk0N5sb8tviZ6faQFxVW1+64FOgmsaqCp/826tP1xOLTN6M5XNWIEYER8Qvb2Rb5R27w1N2SyGT07kl7mjM+7jPUliaRezLK83parRFYFGDb9hO9d9jsH55UsGVW7hfbmV/RW/h5hdxcRwS/8hjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251597; c=relaxed/simple;
	bh=p61vhvva4xdYOwHX26DLHiTY4b88UTDKWJk0s61v/Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tl8F7m+BsjmBltyYcP3iJSnBE11QPJlJyhU1ipLAqGcZQLeyOAF6tM6pzxFy2WCnY0IPj7BeKPP/AC4/ceHgCbbSR84e0h734Exuzqmrfy1MWpi2Mp969vRsZPuL09GdkrePVzQOYFEmoRvIHbDtvtuaDXu7NenMqYKlA1fdrfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HrJqpDq/; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="HrJqpDq/"
X-KPN-MessageId: 4f23a6f1-5d1d-11f1-92b3-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4f23a6f1-5d1d-11f1-92b3-005056aba152;
	Sun, 31 May 2026 20:19:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=S/PcftfCfUTrWV5yABNt7y5wuIj0V4tgVvHpnpjZmfQ=;
	b=HrJqpDq/NHV0+0I5p3cepi3J8aXxEkG2/9ygCMhHzFCP7ESFr6GKpW5rhyA1c8GwXZBAOJlkLftnp
	 K4Re0YNYX+UiQK0OoSlHK5ScxmRTudBqMEP9EkM4ba/xaParw7P2pYNYJHEiowcyX9aouoTAFKrxlK
	 vJ/Z/gOQPQjBK8EypuKtm6ZW/gG7jCP7duqzR8ONKDNa4KasfdRrbJUps5Bajo92PloU/2A1WtoKLd
	 0xpsVFVd4avz1cA1KTntyeE0SS56uEfuKEpdjYcO9dq/cCogQFJ9vMXmiAjgY4+yxznPWMFG7a4CoY
	 LRZSV694mjD/+URDTcmfv+9golEnzJQ==
X-KPN-MID: 33|bU+JIveaSCmmjpRRMoCqXc9Rn2dhqiG9B2rXcuvvN6wJ2UsS/l3yfTZhqhspHbe
 HMKfTpiLzVmNMlX+Wuuf4YrN1TfXEowccHCETAYVgRlw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yfs3/GKz6NOsjg7nvEzO/EiSaWixgvnlg2tBc4L/CT1FSI+zF7yvqCyUcoiV7iA
 TZ1ccTeFSfwuTpbk/ekDhxw==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4ef12f7d-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 4/9] vfs: lookup_open(): move setting FMODE_CREATED up when calling create()
Date: Sun, 31 May 2026 20:20:40 +0200
Message-ID: <20260531182045.171711-5-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531182045.171711-1-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using vfs_create_no_perm() in lookup_open() we need
to move setting FMODE_CREATED on the file mode to either before or after
that call, as currently it is in the middle. If try_break_deleg() fails
it is currently not set, but vfs_create_no_perm() includes a
try_break_deleg().

Going up the call chain of lookup_open() we see that it is only used in
open_last_lookups() if no error is returned from lookup_open(), so we
can safely move it to after the filesystem create() call. This also
makes more sense when reading the code as you don't have to wonder what
the implications are of setting FMODE_CREATED before the create() call.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 2a35dd72ee96..16dcf537db87 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4531,7 +4531,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 
-		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
@@ -4544,6 +4543,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 
 		fsnotify_create(dir_inode, dentry);
+		file->f_mode |= FMODE_CREATED;
 	}
 
 	return dentry;
-- 
2.54.0

